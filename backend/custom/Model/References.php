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

    private static function _getSynthetic()
    {
        self::_getDriversCount();
        self::_getDriversAge();
        self::_getDriversExp();
        self::_getTsAge();


        //ts_age
        //drivers age exp


    }

    private static function _getDriversCount()
    {

        $db = Frapi_Database::getInstance();
        $ref_key = 'drivers_count';


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
            self::$_results[$ref_key]['values'][$i]['value'] = $age;
            self::$_results[$ref_key]['values'][$i]['is_default'] = 0;
            $i++;
        }
        // последний до бесконечности
        $max = $i;
        self::$_results[$ref_key]['values'][$i]['name'] = $max . ' и больше';
        self::$_results[$ref_key]['values'][$i]['value'] = $max;
        self::$_results[$ref_key]['values'][$i]['is_default'] = 0;

    }


} 