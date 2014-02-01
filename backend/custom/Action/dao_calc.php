<?php
/**
 * Created by PhpStorm.
 * User: revinberg
 * Date: 29.01.14
 * Time: 18:16
 */

class dao_calc {

/*
public $host = 'localhost';
public $database = 'ubercalc';
public $user = 'root';
public $pass = '';
*/


public function db_connect(){

    $host = 'localhost';
    $database = 'ubercalc';
    $user = 'root';
    $pass = '';

    try {
        # MySQL через PDO_MYSQL
        $DBH = new PDO("mysql:host=$host; dbname=$database", $user, $pass);
    }
    catch(PDOException $e) {
        echo $e->getMessage();
    }
}


public function db_disconnect(){
    $DBH = null;
}









} 