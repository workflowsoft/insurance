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

    private $dependences = array(
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
        // ksd
        6 => array('tariff_program_id', 'contract_from_day', 'contract_to_day', 'contract_from_month', 'contract_to_month',),
        // kps
        7 => array('ts_no_defend_flag', 'ts_satellite_flag', 'ts_have_electronic_alarm',),
        // kkv
        8 => array('commission_percent_up', 'commission_percent_down',),
        // ko
        9 => array('is_onetime_payment',),
        // klv
        10 => array('tariff_program_id', 'regres_limit_factor_id',),
        // kctoa
        11 => array('tariff_program_id', 'regres_limit_factor_id', 'tariff_def_damage_type_id',),
        // vbs
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


    /* all parameters
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

        'payments_without_references_id' => self::TYPE_INT,
        'franchise_type_id' => self::TYPE_INT,
        'contract_day' => self::TYPE_INT,
        'contract_month' => self::TYPE_INT,
        'contract_year' => self::TYPE_INT,
        'drivers_count' => self::TYPE_INT,
        'driver_age' => self::TYPE_INT,
        'driver_exp' => self::TYPE_INT,
        'ts_no_defend_flag' => self::TYPE_INT,
        'ts_satellite_flag' => self::TYPE_INT,
        'ts_have_electronic_alarm' => self::TYPE_INT,
        'is_onetime_payment' => self::TYPE_INT,
        'car_quantity' => self::TYPE_INT,
        'franchise_percent' => self::TYPE_INT,
        'commercial_carting_flag' => self::TYPE_INT,
        'commission_percent' => self::TYPE_INT,
        'is_legal_entity' => self::TYPE_INT,
     */


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
        $this->data = $this->_validateBase();
        return $this->toArray();

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
                $this->data['crashed_on'] = array(
                    'param' => $param,
                    'query' => $sql,
                );
                return $this->toArray();
            }
            $results = $sth->fetchAll(PDO::FETCH_ASSOC);
            $this->data[] = $results;

            if (!$results) {
                throw new Frapi_Error('CANT_CALC_BASET');
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

    private function _validateAdditional()
    {
        $parameters_known = array();
        $parameters_to_validate = array();
        foreach ($this->_parameters_additional as $key => $type) {
            $tmp = $this->getParam($key, $type);
            if (empty($tmp)) {
                $parameters_to_validate[] = $key;
            } else {
                $parameters_known[$key] = $tmp;
            }
        }


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

