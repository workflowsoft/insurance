<?php


class References
{

    /*
     * array(
     *  'id',
     *  'name',
     *  'request_parameter'
     *  'value',
     *  'is_default'
     * )
     */

    private static $_tables = array(
        'ts_type',
        'ts_modification',
        'ts_group',
        'tariff_def_damage_type',
        'tariff_program',
        'risks',
        'payments_without_references',
        'franchise_type',
        'regres_limit',
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
        if ($referenceDef['type'] == 'simple')
        {
            $db = Frapi_Database::getInstance();
            $sth = $db->query(sprintf('SELECT name FROM %s WHERE id = %u', $referenceDef['name'], $value));
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
        if ($referenceDef)
        {
            $db = Frapi_Database::getInstance();
            if ($referenceDef['type'] == 'simple')
            {
                foreach($referenceDef['tables'] as $tableName)
                {
                    /*name, columns[0], $tableName, columns[0],columns[0],columns[0],columns[0]*/
                    $simpleQuery = 'SELECT GF.name,GF.id as value, CASE WHEN F.`default` IS NULL THEN 0 ELSE 1 END AS is_default FROM
                                      (SELECT distinct T.id, T.name FROM %s T INNER  JOIN
                                          (SELECT %s FROM %s AC GROUP BY AC.%s) G
                                           ON T.id = G.%s OR G.%s IS NULL) GF
                                           LEFT JOIN factors F ON F.`default` = GF.id AND F.name = \'%s\'
                    ';
                    $column = $referenceDef['columns'][0];
                    $sth = $db->query(sprintf($simpleQuery, $referenceDef['name'], $column, $tableName, $column, $column, $column, $column));
                    $res = $sth->fetchAll(PDO::FETCH_ASSOC);
                    if (is_null($reference))
                        $reference = $res;
                    else
                        $reference = array_udiff($reference, $res, function ($first, $second)
                        {
                            if ($first['value'] == $second['value'])
                                return 0;
                            else if ($first['value'] > $second['value'])
                                return 1;
                            else
                                return -1;
                        });
                }
            }
            if (!is_null($reference))
            {
                foreach($reference as $item)
                {
                    array_push($referenceOut,
                    array(
                        'request_parameter' => $paramName,
                        'name' => $item['name'],
                        'value' => $item['value'],
                        'is_default'=> $item['is_default'])
                    );
                }
            }
        }
        return $referenceOut;
    }

    private static function _getSynthetic()
    {
        //driver count
        $db = Frapi_Database::getInstance();

        $query = 'SELECT max(`drivers_count_up`) FROM `additional_coefficients`';
        $result = $db->query($query);
        $result = $result->fetch();
        $max = $result[0];

        $query = 'SELECT min(`drivers_count_down`) FROM `additional_coefficients`';
        $result = $db->query($query);
        $result = $result->fetch();
        $min = $result[0];

        self::$_results['drivers_count']['request_parameter'] = 'drivers_count';
        $first = true;
        for ($i = $min; $i <= $max; $i++) {
            self::$_results['drivers_count']['values'][$i]['id'] = $i;
            self::$_results['drivers_count']['values'][$i]['name'] = $i;
            if ($first) {
                self::$_results['drivers_count']['values'][$i]['is_default'] = 1;
                $first = false;
            } else {
                self::$_results['drivers_count']['values'][$i]['is_default'] = 0;
            }


        }


        //ts sum
        //driver exp
        //driver age
        //used years
        // time
        // alarm to separate table

    }


} 