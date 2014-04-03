<?php


class References
{

    /*
     * 'request_parameter'
     * array(
     *  'name',
     *  'value',
     *  'is_default',
     * )
     */

    private static $_tables = array(
        'ts_type',
        'ts_modification',
        'ts_group',
        'ts_antitheft',
    );

    private static $_results = array();

    /**
     * @return array
     */
    public static function get()
    {
        foreach (self::$_tables as $table) {
            self::$_results[$table]['request_parameter'] = $table . '_id';
            self::$_results[$table]['values'] = self::getByTable($table);
        }

        self::_getSynthetic();

        return self::$_results;
    }

    /**
     * @param string $table
     * @return array
     */
    public static function getByTable($table)
    {
        $db = Frapi_Database::getInstance();
        $query = 'SELECT `id`, `name` FROM `' . $table . '`';
        $result = $db->query($query);
        $results = $result->fetchAll(PDO::FETCH_ASSOC);
        $first = true;
        foreach ($results as $k => $v) {
            $results[$k]['value'] = $v['id'];
            unset($results[$k]['id']);
            if ($first) {
                $results[$k]['is_default'] = 1;
                $first = false;
            } else {
                $results[$k]['is_default'] = 0;
            }
        }

        return $results;

    }

    public static function getNameByValue($referenceDef, $value)
    {
        $result = $value;
        if ($referenceDef['type'] == 'simple' && array_key_exists('reference_table', $referenceDef)) {
            $db = Frapi_Database::getInstance();
            $sth = $db->query(sprintf('SELECT name FROM %s WHERE id = %u', $referenceDef['reference_table'], $value));
            $result = $sth->fetchColumn();
            if (!$result)
                $result = $value;
        }
        return $result;
    }

    public static function getReferenceByRequestParams($paramName, $referenceDef, $params)
    {
        $reference = null;
        $referenceOut = array();
        $res = array();
        if ($referenceDef) {
            $db = Frapi_Database::getInstance();
            foreach ($referenceDef['tables'] as $tableName) {
                $wh = Calculation\Calculation::getWhereParts($params);
                $wherePart = join(' AND ', $wh[$tableName]);
                switch ($referenceDef['type']) {
                    case 'simple':
                        if (array_key_exists('reference_table', $referenceDef)) {
                            /*column, ref_table, column, table, where, column, column, column, name */
                            //TODO: Запрос будет сложнее, нужно еще учитывать разрешимость конечного рассчета
                            $simpleQuery = 'SELECT GF.name,GF.id as value, CASE WHEN F.`default` IS NULL THEN 0 ELSE 1 END AS is_default, GF.is_any FROM
                                                  (SELECT  GF1.id, GF1.name, MIN(GF1.is_any) AS is_any FROM
                                                      (SELECT T.id, T.name, CASE WHEN G.%s IS NULL THEN 1 ELSE 0 END AS is_any FROM %s T
                                                        INNER JOIN (SELECT %s FROM %s AC WHERE %s GROUP BY AC.%s) G
                                                          ON T.id = G.%s OR G.%s IS NULL
                                                      ) GF1
                                                   GROUP BY GF1.id, GF1.name
                                                  )GF LEFT JOIN factors F
                                                    ON F.`default` = GF.id AND F.name = \'%s\'';
                            $column = $referenceDef['columns'][0];
                            $sth = $db->query(sprintf($simpleQuery, $column, $referenceDef['reference_table'], $column, $tableName, $wherePart, $column, $column, $column, $paramName));
                            $res = $sth->fetchAll(PDO::FETCH_ASSOC);
                        }
                        break;
                    case 'range':
                        // $col_down, $col_up, $col_down, $col_up, $col_down, $col_up, $col_up, $col_down, $col_down, $col_up, $tableName, $wherePart, $col_down, $col_up, $col_down, $name, $col_down, $col_up, $col_down, $col_down, $col_up, $col_up, $col_down, $col_up
                        $col_down = $referenceDef['columns'][0];
                        $col_up = $referenceDef['columns'][1];
                        //TODO: Запрос будет сложнее, нужно еще учитывать разрешимость конечного рассчета
                        $rangeQuery = 'SELECT VAL.`name`,
                                        CASE WHEN F.id IS NULL THEN VAL.`value` ELSE F.`default` END AS `value`,
                                          CASE WHEN VAL.%s IS NULL AND VAL.%s IS NULL THEN 1 ELSE 0 END AS is_any,
                                          CASE WHEN F.id IS NULL THEN 0 ELSE 1 END AS is_default
                                            FROM
                                              (SELECT
                                                CASE WHEN AC.%s IS NULL AND AC.%s IS NULL
                                                THEN \'Отсутствует\'
                                                ELSE
                                                  CONCAT(\'от \',IFNULL(AC.%s, 0),
                                                         CASE WHEN %s IS NULL
                                                         THEN \' и более\'
                                                         ELSE CONCAT(\' до \', AC.%s)
                                                         END
                                                        )
                                              END AS `name`,
                                              IFNULL(AC.%s, 0) AS `value`,
                                              AC.%s,
                                              AC.%s
                                        FROM %s AC WHERE %s
                                          GROUP BY AC.%s, AC.%s
                                            ORDER BY AC.%s) VAL
                                        LEFT JOIN factors F
                                          ON F.name = \'%s\'
                                              AND F.`default` IS NOT NULL
                                              AND (
                                                    (
                                                      NOT (VAL.%s IS NULL AND VAL.%s IS NULL) AND
                                                          (VAL.%s IS NULL OR VAL.%s<=F.`default`) AND
                                                          (VAL.%s IS NULL OR F.`default`<=VAL.%s)
                                                    ) OR
                                                    (VAL.%s IS NULL AND VAL.%s IS NULL AND F.`default` = 0)
                                              )';
                        $sth = $db->query(sprintf($rangeQuery, $col_down, $col_up, $col_down, $col_up, $col_down, $col_up, $col_up, $col_down,
                            $col_down, $col_up, $tableName, $wherePart, $col_down, $col_up, $col_down, $paramName, $col_down, $col_up,
                            $col_down, $col_down, $col_up, $col_up, $col_down, $col_up));
                        $res = $sth->fetchAll(PDO::FETCH_ASSOC);
                        break;
                    case 'complex_range':
                        //TODO: Здесь костыль специально для contract. Генерализировать запрос будет непросто, но это прямо сейчас и не нужно
                        //TODO: Запрос будет сложнее, нужно еще учитывать разрешимость конечного рассчета
                        $complexRange = 'SELECT VAL.*, CASE WHEN F.id IS NULL THEN 0 ELSE 1 END AS is_default FROM
                                          (
                                            SELECT
                                               MAX(AC.priority) AS `priority`,
                                               CASE WHEN AC.contract_day_down IS NULL AND
                                                        AC.contract_day_up IS NULL AND
                                                        AC.contract_month_down IS NULL AND
                                                        AC.contract_month_up IS NULL AND
                                                        AC.contract_year_down IS NULL AND
                                                        AC.contract_year_up IS NULL THEN 1
                                               ELSE 0 END AS is_any,
                                              CASE WHEN AC.contract_day_down IS NULL AND
                                                        AC.contract_day_up IS NULL AND
                                                        AC.contract_month_down IS NULL AND
                                                        AC.contract_month_up IS NULL AND
                                                        AC.contract_year_down IS NULL AND
                                                        AC.contract_year_up IS NULL THEN \'Отсутствует\'
                                              ELSE
                                                CONCAT(
                                                    CASE WHEN
                                                      AC.contract_day_down IS NULL THEN
                                                      CASE WHEN AC.contract_month_down IS NULL THEN
                                                        CASE WHEN AC.contract_year_down IS NULL THEN
                                                          \'\'
                                                        ELSE
                                                          CASE WHEN AC.contract_year_down = AC.contract_year_up THEN
                                                            CONCAT(AC.contract_year_down, \' лет\')
                                                          ELSE
                                                            CONCAT(\'от \', AC.contract_year_down, \' лет\')
                                                          END
                                                        END
                                                      ELSE
                                                        CASE WHEN AC.contract_month_down = AC.contract_month_up THEN
                                                          CONCAT(AC.contract_month_down, \' мес.\')
                                                        ELSE
                                                          CONCAT(\'от \', AC.contract_month_down, \' мес.\')
                                                        END
                                                      END
                                                    ELSE
                                                      CASE WHEN AC.contract_day_down = AC.contract_day_up THEN
                                                        CONCAT(AC.contract_day_down, \' дн.\')
                                                      ELSE
                                                        CONCAT(\'от \', AC.contract_day_down, \' дн.\')
                                                      END
                                                    END,
                                                    CASE WHEN
                                                      AC.contract_day_up IS NULL THEN
                                                      CASE WHEN AC.contract_month_up IS NULL THEN
                                                        CASE WHEN AC.contract_year_up IS NULL THEN
                                                          \' и более\'
                                                        WHEN IFNULL(AC.contract_year_down,-1) <> IFNULL(AC.contract_year_up, -1) THEN
                                                          CONCAT(\' до \', AC.contract_year_up, \' лет\')
                                                        ELSE \'\'
                                                        END
                                                      WHEN IFNULL(AC.contract_month_down,-1) <> IFNULL(AC.contract_month_up, -1) THEN
                                                        CONCAT(\' до \', AC.contract_month_up, \' мес.\')
                                                      ELSE \'\'
                                                      END
                                                    WHEN IFNULL(AC.contract_day_down,-1)  <> IFNULL(AC.contract_day_up,-1) THEN
                                                      CONCAT(\' до \', AC.contract_day_up, \' дн.\')
                                                    ELSE \'\'
                                                    END)
                                              END AS `name`,
                                              CASE WHEN AC.contract_day_down IS NULL AND
                                                        AC.contract_day_up IS NULL AND
                                                        AC.contract_month_down IS NULL AND
                                                        AC.contract_month_up IS NULL AND
                                                        AC.contract_year_down IS NULL AND
                                                        AC.contract_year_up IS NULL THEN 0
                                              ELSE
                                                CASE WHEN
                                                  AC.contract_day_up IS NULL THEN
                                                  CASE WHEN AC.contract_month_up IS NULL THEN
                                                    CASE WHEN AC.contract_year_up IS NULL THEN
                                                      0
                                                    ELSE
                                                      AC.contract_year_up
                                                    END
                                                  ELSE
                                                    AC.contract_month_up
                                                  END
                                                ELSE
                                                  AC.contract_day_up
                                                END
                                              END AS `value`,
                                              CASE WHEN AC.contract_day_down IS NULL AND
                                                        AC.contract_day_up IS NULL AND
                                                        AC.contract_month_down IS NULL AND
                                                        AC.contract_month_up IS NULL AND
                                                        AC.contract_year_down IS NULL AND
                                                        AC.contract_year_up IS NULL THEN \'contract_day\'
                                              ELSE
                                                CASE WHEN
                                                  AC.contract_day_up IS NULL THEN
                                                  CASE WHEN AC.contract_month_up IS NULL THEN
                                                    CASE WHEN AC.contract_year_up IS NULL THEN
                                                      0
                                                    ELSE
                                                      \'contract_year\'
                                                    END
                                                  ELSE
                                                    \'contract_month\'
                                                  END
                                                ELSE
                                                  \'contract_day\'
                                                END
                                              END AS `request_parameter`
                                        FROM additional_coefficients AC WHERE AC.coefficient_id IN (%s) AND %s
                                        GROUP BY
                                          AC.contract_day_down, AC.contract_day_up,
                                          AC.contract_month_down, contract_month_up,
                                          AC.contract_year_down, AC.contract_year_up
                                        ORDER BY
										   AC.contract_year_down, AC.contract_year_up,
                                           AC.contract_month_down, AC.contract_month_up,
 										   AC.contract_day_down, AC.contract_day_up,
 										   MAX(AC.priority) DESC
                                          ) VAL
                                          LEFT JOIN factors F ON F.name = VAL.request_parameter AND F.`default` = VAL.value';
                        $deps = \Calculation\Configuration::getCoefficientDependencies();
                        $dependentCoef = array_merge(
                            array_key_exists('contract_year', $deps) ? $deps['contract_year'] : array(),
                            array_key_exists('contract_month', $deps) ? $deps['contract_month'] : array(),
                            array_key_exists('contract_day', $deps) ? $deps['contract_day'] : array());
                        $inPart = join(' , ', array_unique($dependentCoef));
                        $qry = sprintf($complexRange, $inPart, $wherePart);
                        $sth = $db->query($qry);
                        $res = $sth->fetchAll(PDO::FETCH_ASSOC);
                        break;
                }

                //Подчищаем по приоритету
                $cleaned = array();
                $priority = 0;
                foreach ($res as $item) {
                    if (array_key_exists('priority', $item)) {
                        if ($item['priority'] > $priority)
                            $priority = $item['priority'];
                        if ($item['priority'] == $priority)
                            array_push($cleaned, $item);
                    } else {
                        array_push($cleaned, $item);
                    }
                }
                $res = $cleaned;

                if (is_null($reference))
                    $reference = $res;
                else {
                    $newReference = array();
                    foreach ($reference as $old) {
                        foreach ($res as $new) {
                            if ($old['value'] == $new['value']) {
                                $old['is_any'] = min($old['is_any'], $new['is_any']);
                                array_push($newReference, $old);
                                break;
                            }
                        }
                    }
                    $reference = $newReference;
                }
            }
            if (!is_null($reference)) {
                //Зафеячим заголовок справочника
                $referenceOut['title'] = self::getTitleByReferenceName($referenceDef['name']);
                $referenceOut['values'] = array();

                $independentCount = 0; //Этой штукой мы будем скипать справочники от значений которых в данном контексте вообще ничего не зависит
                foreach ($reference as $item) {
                    if ($item['is_any'] == 1)
                        $independentCount++;
                    array_push($referenceOut['values'],
                        array(
                            'request_parameter' =>
                                array_key_exists('request_parameter', $item) ? $item['request_parameter'] : $paramName,
                            'name' => $item['name'],
                            'value' => $item['value'],
                            'is_default' => intval($item['is_default']),
                            'is_price_changing' => $item['is_any'] == 1 ? false : true
                        )
                    );
                }
                if ($independentCount == count($reference)) {
                    $referenceOut['values'] = array();
                }
            }
        }
        return $referenceOut;
    }

    private static function _getSynthetic()
    {
        self::_getDriversCount();
        self::_getDriversAge();
        self::_getDriversExp();
        self::_getTsAge();
        self::_getPrograms();
    }

    private static function _getDriversCount()
    {
        $db = Frapi_Database::getInstance();
        $ref_key = 'drivers_count';

        //TODO you can use just one query
        $query = 'SELECT max(`drivers_count_up`) FROM `additional_coefficients`';
        $result = $db->query($query);
        $result = $result->fetch();
        $max = $result[0];

        $query = 'SELECT min(`drivers_count_down`) FROM `additional_coefficients`';
        $result = $db->query($query);
        $result = $result->fetch();
        $min = $result[0];

        self::$_results[$ref_key]['request_parameter'] = $ref_key;
        $first = true;
        for ($i = (int)$min; $i <= $max; $i++) {
            self::$_results[$ref_key]['values'][$i]['name'] = $i;
            self::$_results[$ref_key]['values'][$i]['value'] = $i;
            if ($first) {
                self::$_results[$ref_key]['values'][$i]['is_default'] = 1;
                $first = false;
            } else {
                self::$_results[$ref_key]['values'][$i]['is_default'] = 0;
            }
        }

        // последний до бесконечности
        $max++;
        self::$_results[$ref_key]['values'][$i]['name'] = $max . ' и больше';
        self::$_results[$ref_key]['values'][$i]['value'] = $max;
        self::$_results[$ref_key]['values'][$i]['is_default'] = 0;
    }

    private static function _getDriversAge()
    {
        $db = Frapi_Database::getInstance();
        $ref_key = 'driver_age';
        //Минимальный возраст водителя 18 лет
        $min = 18;

        $query = 'SELECT GREATEST(max(`driver_age_down`), max(`driver_age_up`)) FROM `additional_coefficients`';
        $result = $db->query($query);
        $result = $result->fetch();
        $max = $result[0];

        self::$_results[$ref_key]['request_parameter'] = $ref_key;
        $first = true;
        for ($i = $min; $i <= $max; $i++) {
            self::$_results[$ref_key]['values'][$i]['name'] = $i;
            self::$_results[$ref_key]['values'][$i]['value'] = $i;
            if ($first) {
                self::$_results[$ref_key]['values'][$i]['is_default'] = 1;
                $first = false;
            } else {
                self::$_results[$ref_key]['values'][$i]['is_default'] = 0;
            }
        }
        // последний до бесконечности
        $max++;
        self::$_results[$ref_key]['values'][$i]['name'] = $max . ' и старше';
        self::$_results[$ref_key]['values'][$i]['value'] = $max;
        self::$_results[$ref_key]['values'][$i]['is_default'] = 0;
    }

    private static function _getDriversExp()
    {
        $db = Frapi_Database::getInstance();
        $ref_key = 'driver_exp';
        //Минимальный стаж 0
        $min = 0;

        $query = 'SELECT GREATEST(max(`driver_exp_down`), max(`driver_exp_up`)) FROM `additional_coefficients`';
        $result = $db->query($query);
        $result = $result->fetch();
        $max = $result[0];

        self::$_results[$ref_key]['request_parameter'] = $ref_key;
        $first = true;
        for ($i = $min; $i <= $max; $i++) {
            self::$_results[$ref_key]['values'][$i]['name'] = $i;
            self::$_results[$ref_key]['values'][$i]['value'] = $i;
            if ($first) {
                self::$_results[$ref_key]['values'][$i]['is_default'] = 1;
                $first = false;
            } else {
                self::$_results[$ref_key]['values'][$i]['is_default'] = 0;
            }
        }
        // последний до бесконечности
        $max++;
        self::$_results[$ref_key]['values'][$i]['name'] = $max . ' и больше';
        self::$_results[$ref_key]['values'][$i]['value'] = $max;
        self::$_results[$ref_key]['values'][$i]['is_default'] = 0;

    }

    private static function _getTsAge()
    {
        $db = Frapi_Database::getInstance();
        $ref_key = 'ts_age';

        $query = 'SELECT distinct `ts_age` FROM `tariff_coefficients`';
        $result = $db->query($query);
        $result = $result->fetchAll(PDO::FETCH_COLUMN, 0);

        // get it from db
        self::$_results[$ref_key]['request_parameter'] = $ref_key;
        $i = 0;
        foreach ($result as $age) {
            self::$_results[$ref_key]['values'][$i]['name'] = $age;
            self::$_results[$ref_key]['values'][$i]['value'] = (int)$age;
            self::$_results[$ref_key]['values'][$i]['is_default'] = 0;
            $i++;
        }
    }

    private static function _getPrograms()
    {
        $db = Frapi_Database::getInstance();
        $ref_key = 'programs';

        $query = 'SELECT * FROM `tariff_program`';
        $result = $db->query($query);
        $result = $result->fetchAll(PDO::FETCH_ASSOC);
        self::$_results[$ref_key] = $result;
    }


    public static function getTitleByReferenceName($name)
    {
        $titleQuery = "
                   SELECT distinct F.title
                      FROM factors F
                        LEFT JOIN factor2references FR ON F.id = FR.factor_id
                        LEFT JOIN factor_references R ON R.id = FR.reference_id
                WHERE R.name IS NOT NULL AND R.name = '" . $name . "'";

        $db = Frapi_Database::getInstance();
        $sth = $db->query($titleQuery);
        $res = $sth->fetch();
        return $res[0];

    }

} 
