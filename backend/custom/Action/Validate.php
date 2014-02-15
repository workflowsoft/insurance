<?php

/**
 * Action Validate
 *
 * Валидация входящих параметров
 *
 * @link http://getfrapi.com
 * @author Frapi <frapi@getfrapi.com>
 * @link /validate
 */
class Action_Validate extends Frapi_Action implements Frapi_Action_Interface
{

    /**
     * Required parameters
     *
     * @var An array of required parameters.
     */
    protected $requiredParams = array();

    private $_dependences = array(
        // kuts
        1 => array('amortisation',),
        // kf
        2 => array('tariff_program_id', 'franchise_type_id', 'franchise_percent_up', 'franchise_percent_down', 'commercial_carting_flag',),
        // kvs
        3 => array('driver_age_down', 'driver_age_up', 'driver_exp_down', 'driver_exp_up', 'is_legal_entity',),
        // kl
        4 => array('drivers_count_up', 'drivers_count_down', 'driver_age_down', 'is_legal_entity',),
        // kp
        5 => array('car_quantity_down', 'car_quantity_up',),
        // ksd  mandatory
        6 => array('tariff_program_id', 'contract_day_down', 'contract_day_up', 'contract_month_down', 'contract_month_up',),
        // kps  mandatory
        7 => array('ts_no_defend_flag', 'ts_satellite_flag', 'ts_have_electronic_alarm',),
        // kkv
        8 => array('commission_percent_up', 'commission_percent_down',),
        // ko
        9 => array('is_onetime_payment',),
        // klv
        10 => array('tariff_program_id', 'regres_limit_factor_id',),
        // kctoa
        11 => array('tariff_program_id', 'regres_limit_factor_id', 'tariff_def_damage_type_id',),
        // vbs mandatory
        12 => array('tariff_program_id', 'payments_without_references_id',),
        // ksp
        13 => array(),
        // ki
        14 => array(),
        // kbm
        15 => array(),
        // ka
        16 => array(),
    );



    private $_parameters = array(
        'ts_type_id' => self::TYPE_INT,
        'ts_make_id' => self::TYPE_INT,
        'ts_model_id' => self::TYPE_INT,
        'ts_modification_id' => self::TYPE_INT,
        'ts_group_id' => self::TYPE_INT,
        'tariff_def_damage_type_id' => self::TYPE_INT,
        'ts_age' => self::TYPE_INT,
        'ts_sum' => self::TYPE_DOUBLE,
        'tariff_program_id' => self::TYPE_INT,
        'risk_id' => self::TYPE_INT,
        'amortisation' => self::TYPE_INT,
    );


    private $_parameters_additional = array(
        /*is in basis*/
        'amortisation' => array('type' => self::TYPE_INT,),
        /*is basis*/
        'tariff_program_id' => array('type' => self::TYPE_INT,),
        'franchise_type_id' => array('type' => self::TYPE_INT,),
        'franchise_percent' => array('type' => self::TYPE_DOUBLE, 'fork' => true,),
        'commercial_carting_flag' => array('type' => self::TYPE_INT,),
        'driver_age' => array('type' => self::TYPE_INT, 'fork' => true,),
        'driver_exp' => array('type' => self::TYPE_INT, 'fork' => true,),
        'is_legal_entity' => array('type' => self::TYPE_INT,),
        'drivers_count' => array('type' => self::TYPE_INT, 'fork' => true,),
        'is_legal_entity' => array('type' => self::TYPE_INT,),
        'car_quantity' => array('type' => self::TYPE_INT, 'fork' => true,),
        'contract_day' => array('type' => self::TYPE_INT, 'fork' => true,),
        'contract_month' => array('type' => self::TYPE_INT, 'fork' => true,),
        'ts_no_defend_flag' => array('type' => self::TYPE_INT,),
        'ts_satellite_flag' => array('type' => self::TYPE_INT,),
        'ts_have_electronic_alarm' => array('type' => self::TYPE_INT,),
        'commission_percent' => array('type' => self::TYPE_INT, 'fork' => true,),
        'is_onetime_payment' => array('type' => self::TYPE_INT,),
        /*is in basis*/
        'tariff_def_damage_type_id' => array('type' => self::TYPE_INT,),
        'regres_limit_factor_type_id' => array('type' => self::TYPE_INT,),
        'payments_without_references_id' => array('type' => self::TYPE_INT,),
    );


    /**
     * The data container to use in toArray()
     *
     * @var A container of data to fill and return in toArray()
     */
    private $data = array();

    /**
     * To Array
     *
     * This method returns the value found in the database
     * into an associative array.
     *
     * @return array
     */
    public function toArray()
    {
        return $this->data;
    }

    /**
     * Default Call Method
     *
     * This method is called when no specific request handler has been found
     *
     * @return array
     */
    public function executeAction()
    {
        return $this->toArray();
    }


    /**
     * Get Request Handler
     *
     * This method is called when a request is a GET
     *
     * @return array
     */
    public function executeGet()
    {
        $this->_validate();

        return $this->toArray();
    }

    private function _validate() {
        $base_validation = $this->_validateBase();
        if(empty($this->data['crashed_on'])) {
            $this->data = $this->_validateAdditional($base_validation);
        }


//        foreach($additional_validation as $k => $v){
//            if(!empty($base_validation[$k])){
//
//            }
//        }

    }

    private function _validateBase()
    {
        //Вытщим то, что пришло с фронта
        $parameters_known = array();
        $parameters_to_validate = array();
        foreach ($this->_parameters as $key => $type) {
            $tmp = $this->getParam($key, $type);
            if (empty($tmp)) {
                $parameters_to_validate[] = $key;
            } else {
                $parameters_known[$key] = $tmp;
            }
        }

        $validation = array();
        $db = Frapi_Database::getInstance();
        foreach ($parameters_to_validate as $param) {
            if ($param === 'ts_sum') continue;
            $sql_from = 'SELECT DISTINCT `' . $param . '` FROM `tariff_coefficients`';
            $sql_where = '';
            $first = true;
            foreach ($parameters_known as $key => $param_known) {
                //dirt for sum
                if ($key === 'ts_sum') {
                    $sql_where .= ($first ? ' WHERE' : ' AND') . " `ts_sum_up` >= $param_known AND ts_sum_down <= $param_known";
                } else {
                    $sql_where .= ($first ? ' WHERE' : ' AND') . " `$key` = $param_known";
                }
                $first = false;
            }
            $sql = $sql_from . $sql_where;

            $sth = $db->query($sql);
            if (!$sth) {
                $this->data = array();
                $this->data['crashed_on'] = array(
                    'param' => $param,
                    'query' => $sql,
                );
                return $this->toArray();
            }
            $results = $sth->fetchAll(PDO::FETCH_ASSOC);
            $this->data[] = $results;

            if (!$results) {
                throw new Frapi_Error('CANT_CALC_BASET', 'Wrong ' . implode(', ', array_keys($parameters_known)));
            }
            foreach ($results as $value) {
                $param_to_front = preg_replace('/_id$/u', '', $param);
                if (empty($value[$param])) {
                    $validation[$param_to_front] = array();
                } else {
                    $validation[$param_to_front][] = $value[$param];
                };
            }

        }
//        $this->data = $validation;
        return $validation;

    }

    private function _validateAdditional(array $base_validation)
    {
        $db = Frapi_Database::getInstance();
        $parameters_known = array();
        foreach ($this->_parameters_additional as $key => $item) {
            $tmp = $this->getParam($key, $item['type']);
            if (!empty($tmp)) {
                $parameters_known[$key]['value'] = $tmp;
                if (!empty($item['fork'])) $parameters_known[$key]['fork'] = true;
            }
        }
        $results = $base_validation;
        foreach ($this->_dependences as $factor_id => $dependences) {
            if (!empty($dependences)) {
                $sqls = $this->_generateSQL($dependences, $parameters_known);
                foreach ($sqls as $column => $sql) {
                    $sth = $db->query($sql);
                    if (!$sth) {
                        $this->data['crashed_on'] = array(
                            'param' => $factor_id,
                            'query' => $sql,
                        );
                        return $this->toArray();
                    }
                    $result = $sth->fetchAll(PDO::FETCH_COLUMN);

                    if (empty($results[$column])) {
                        $results[$column] = $result;
                    } elseif(empty($base_validation[$column]) || in_array($factor_id, array(6,7,12))) {
                        // мержим базовую валидацию только в случае обязательных коэф
                        //TODO если мы изменяем базовую валидацию надо бы все перевалидировать нахуй
                        $results[$column] = array_values(array_intersect($results[$column], $result));
                    }
                }


            }
        }

        //Приведем в порядок вилки, оставим только максимальное и минимальные значения в соотв ключах
        foreach ($results as $k => $v) {
            if (strpos($k, '_down')) {
                $new_k = preg_replace('/_down$/u','', $k );
                $results[$new_k]['down'] = min($v);
                unset($results[$k]);
            } elseif (strpos($k, '_up')) {
                $new_k = preg_replace('/_up$/u','', $k );
                //null - бесконечность, он всегда больше
                if(in_array(null, $v)){
                    $results[$new_k]['up'] = null;
                } else {
                    $results[$new_k]['up'] = max($v);

                }
                unset($results[$k]);
            }
        }

        return $results;


    }

    /**
     * @param array $columns_to_get
     * @param array (fork, value) $known_columns
     * @return array
     */
    private function _generateSQL($columns_to_get, $known_columns)
    {
        $columns_to_get_initial = $columns_to_get;
        // Исключим из искомых уже данные. На всякий пожарный
        foreach ($columns_to_get as $k => $column) {
            foreach ($known_columns as $kk => $known_column) {
                if (
                    $column == $kk
                    || (!empty($known_column['fork']) && $column == $kk . '_down')
                    || (!empty($known_column['fork']) && $column == $kk . '_up')
                ) {
                    unset($columns_to_get[$k]);
                }
            }

        }

        $first = true;
        $where = '';
        foreach ($known_columns as $column => $item) {
            //Если данный коэффициент не зависит от переданных параметров, просто не добавляем его в where
            //Но стоит проверять на up down значения!
            if (!in_array($column, $columns_to_get_initial) and !in_array($column . '_down', $columns_to_get_initial)) {
                continue;
            }
            $where .= $first ? ' WHERE ' : ' AND ';
            $first = false;
            if (empty($item['fork'])) {
                $where .= $column . ' = ' . $item['value'];
            } else {
                $down = sprintf('`%s_down`', $column);
                $up = sprintf('`%s_up`', $column);
                $val = $item['value'];
                $where .= "(($down IS NULL OR $down <= $val) AND ($up IS NULL OR $up >= $val))";
            }
        }

        foreach ($columns_to_get as $k => $column) {
            $sql [$column] = 'SELECT distinct `' . $column . "` as '$column' FROM `additional_coefficients` " . $where;
        }

        return $sql;
    }


    /**
     * Post Request Handler
     *
     * This method is called when a request is a POST
     *
     * @return array
     */
    public function executePost()
    {
        return $this->toArray();
    }

    /**
     * Put Request Handler
     *
     * This method is called when a request is a PUT
     *
     * @return array
     */
    public function executePut()
    {
        return $this->toArray();
    }

    /**
     * Delete Request Handler
     *
     * This method is called when a request is a DELETE
     *
     * @return array
     */
    public function executeDelete()
    {
        return $this->toArray();
    }

    /**
     * Head Request Handler
     *
     * This method is called when a request is a HEAD
     *
     * @return array
     */
    public function executeHead()
    {
        return $this->toArray();
    }


}

