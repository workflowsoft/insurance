<?php


class References
{

    private static $_tables = array(
        'ts_type',
        'ts_make',
        'ts_model',
        'ts_modification',
        'ts_group',
        'tariff_def_damage_type',
        'tariff_program',
        'risks',
        'payments_without_references',
        'franchise_type',
        'front_contract_duration',
        'regres_limit',
        'all_factors',
    );

    /**
     * @return array
     */
    public static function get()
    {
        $results = array();
        foreach (self::$_tables as $table) {
            $results[$table] = self::getByTable($table);
        }
        return $results;
    }

    /**
     * @param string $table
     * @return array
     */
    public static function getByTable($table)
    {
        $db = Frapi_Database::getInstance();
        $query = 'SELECT * FROM `' . $table . '`';
        $result = $db->query($query);
        return $result->fetchAll(PDO::FETCH_ASSOC);
    }


} 