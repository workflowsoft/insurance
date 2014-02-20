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