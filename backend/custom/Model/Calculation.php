<?php
/**
 * Created by PhpStorm.
 * User: PavelTropin
 * Date: 21.02.14
 * Time: 16:53
 */

class Calculation {

    public static function  GetCorrectedParameters($params)
    {
        $correctionQuery = 'SELECT `factor_name` as `source`, `dependent_factor_name` as `name`, `dependent_factor_value` as `value`, `conditional` FROM `factor_restricions` WHERE ';
        $predicateArray = array();
        foreach ($params as $key => $value) {
            if (is_bool($value)) {
                $params[$key] = (int)$value;
            }
            if (!empty($value)) {
                array_push($predicateArray,
                    '(`factor_name` = \'' . $key . '\' AND
                 (`factor_value` IS NULL OR `factor_value` = ' . $value . ') AND
                 (`factor_value_down` IS NULL OR `factor_value_down`<=' . $value . ') AND
                 (`factor_value_up` IS NULL OR `factor_value_up`>=' . $value . ')
                )'
                );
            }
        }
        $correctionQuery = $correctionQuery . join(' OR ', $predicateArray);

        $db = Frapi_Database::getInstance();

        $sth = $db->query($correctionQuery);
        if (!$sth) {
            throw new Frapi_Action_Exception($correctionQuery, 'CANT_CORRECT');
        }

        $corrections = $sth->fetchAll(PDO::FETCH_ASSOC);
        $correct_errors = array();

        $correcting_params = array();
        foreach ($corrections as $correction) {
            $cor_value = $correction['value'];
            if (!is_null($cor_value)) {
                //Осущестляем корректировку
                $correcting_params = array_merge($correcting_params, array($correction['name'] => $cor_value));
            } else {
                //Ругаемся, что не можем осуществить корректировку
                array_push($correct_errors, $correction['source'] . '=>' . $correction['name']);
            }
        }

        if (count($correct_errors))
            throw new Frapi_Exception(join(', ', $correct_errors), 'CANT_CORRECT');

        return $correcting_params;
    }
} 