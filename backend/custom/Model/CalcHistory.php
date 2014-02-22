<?php

class CalcHistory
{

    private $_parameters = array(
        'ts_age',
        'ts_sum',
        'tariff_program_id',
        'risk_id',
        'ts_type_id',
        'ts_group_id',
        'ts_make',
        'ts_model',
        'ts_modification_id',
        'regres_limit_factor_id',
        'tariff_def_damage_type_id',
        'payments_without_references_id',
        'franchise_type_id',
        'contract_day',
        'contract_month',
        'contract_year',
        'drivers_count',
        'driver_age',
        'driver_exp',
        'ts_antitheft_id',
        'is_onetime_payment',
        'car_quantity',
        'franchise_percent',
        'commercial_carting_flag',
        'commission_percent',
        'is_legal_entity',
        'amortisation',

        'base',
        'kuts',
        'kf',
        'kvs',
        'kl',
        'kp',
        'ksd',
        'kps',
        'kkv',
        'ko',
        'klv',
        'kctoa',
        'vbs',
        'ksp',
        'ki',
        'kbm',
        'ka',

        'sum',
        'sum_additional',
        'errors',
    );

    private $_data = array();

    function __construct()
    {

    }

    public function __set($name, $value)
    {
        if (in_array($name, $this->_parameters)) {
            $this->_data[$name] = $value;
        } else {
            throw new InvalidArgumentException('No such class property');
        }

    }

    public function __get($name)
    {
        if (in_array($name, $this->_parameters)) {
            return $this->_data[$name];
        }
        throw new InvalidArgumentException('No such class property');

    }

    public function fillByArray(array $parameters)
    {
        foreach($parameters as $k => $v) {
            if (in_array($k, $this->_parameters)) {
                $this->_data[$k] = $v;
            }
        }
    }

    public function save()
    {
        $into = 'INSERT INTO `calc_history`(';
        $values = 'VALUES (';
        foreach ($this->_data as $k => $v) {
            $into .= "`$k`, ";
            //Строковым значениям - кавычки
            if(in_array($k, array('ts_make', 'ts_model', 'errors'))) {
                $values .= "'$v', ";
            } else {
                $values .= (int) $v . ", ";
            }
        }
        $into = rtrim($into, ', ') . ') ';
        $values = rtrim($values, ', ') . ')';

        $query = $into . $values;
        $db = Frapi_Database::getInstance();
        $sth = $db->prepare($query);
        $result = $sth->execute();
        return $result;
    }


}