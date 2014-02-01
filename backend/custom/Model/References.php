<?php


class References
{

    private static $_tables = array(
        'franchise_type',
        'front_contract_duration',
        'payments_without_references',
        'regres_limit',
        'risks',
        'tariff_def_damage_type',
        'tariff_program',
        'ts_group',
        'all_factors',
    );

    public static function get()
    {
        $results = array();
        foreach (self::$_tables as $table) {
            $results[$table] = self::getByTable($table);
        }
        return $results;
    }

    public static function getByTable($table)
    {
        $db = Frapi_Database::getInstance();
        $query = 'SELECT * FROM `' . $table . '`';
        $result = $db->query($query);
        return $result->fetchAll(PDO::FETCH_ASSOC);
    }


} 