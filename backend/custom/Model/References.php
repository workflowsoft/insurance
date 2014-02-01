<?php


class References {

    public static function get() {
//        var_dump($db);
//        die();
        $db = Frapi_Database::getInstance();
        $query = 'SELECT * FROM all_factors';
        $sth = $db->query($query);
        $results = $sth->fetchAll();
        return $results;
    }

} 