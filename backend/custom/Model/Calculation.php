<?php
/**
 * Created by PhpStorm.
 * User: PavelTropin
 * Date: 21.02.14
 * Time: 16:53
 */

class Calculation {

    private static $usingTables = array('additional_coefficients','tariff_coefficients');

    public static function getWherePart($tableName, $parameters, $calculation)
    {
        $simpleFormat = '(%s = %u OR %s IS NULL)';
        $simpleFormatEmpty = '%s IS NULL';
        $rangeFormat = '(%s IS NULL OR %s<=%u) AND (%s IS NULL OR %s>=%u)';
        $rangeFormatEmpty = '%s IS NULL AND %s IS NULL';
        $additionalWhereParts = array();
        $baseWhereParts = array();

        Frapi_Internal::getCachedDbConfig()['db_database'];


        if (array_key_exists('tariff_program_id', $parameters))
        {
            array_push($baseWhereParts, sprintf($simpleFormat, 'tariff_program_id', $parameters['tariff_program_id'], 'tariff_program_id'));
            array_push($additionalWhereParts, sprintf($simpleFormat, 'tariff_program_id', $parameters['tariff_program_id'], 'tariff_program_id'));
        }
        elseif ($calculation)
        {
            array_push($baseWhereParts, sprintf($simpleFormatEmpty, 'tariff_program_id'));
            array_push($additionalWhereParts, sprintf($simpleFormatEmpty, 'tariff_program_id'));
        }

        if (array_key_exists('risk_id', $parameters))
        {
            array_push($baseWhereParts, sprintf($simpleFormat, 'risk_id', $parameters['risk_id'], 'risk_id'));
            array_push($additionalWhereParts, sprintf($simpleFormat, 'risk_id', $parameters['risk_id'], 'risk_id'));
        }
        elseif ($calculation)
        {
            array_push($baseWhereParts, sprintf($simpleFormatEmpty, 'risk_id'));
            array_push($additionalWhereParts, sprintf($simpleFormatEmpty, 'risk_id'));
        }

        if (array_key_exists('tariff_def_damage_type_id', $parameters))
        {
            array_push($baseWhereParts, sprintf($simpleFormat, 'tariff_def_damage_type_id', $parameters['tariff_def_damage_type_id'], 'tariff_def_damage_type_id'));
            array_push($additionalWhereParts, sprintf($simpleFormat, 'tariff_def_damage_type_id', $parameters['tariff_def_damage_type_id'], 'tariff_def_damage_type_id'));
        }
        elseif ($calculation)
        {
            array_push($baseWhereParts, sprintf($simpleFormatEmpty, 'tariff_def_damage_type_id'));
            array_push($additionalWhereParts, sprintf($simpleFormatEmpty, 'tariff_def_damage_type_id'));
        }

        if (array_key_exists('ts_age', $parameters))
        {
            array_push($baseWhereParts, sprintf($simpleFormat, 'ts_age', $parameters['ts_age'], 'ts_age'));
            array_push($additionalWhereParts, sprintf($simpleFormat, 'ts_age', $parameters['ts_age'], 'ts_age'));
        }
        elseif ($calculation)
        {
            array_push($baseWhereParts, sprintf($simpleFormatEmpty, 'ts_age'));
            array_push($additionalWhereParts, sprintf($simpleFormatEmpty, 'ts_age'));
        }

        if (array_key_exists('ts_sum', $parameters))
        {
            array_push($baseWhereParts, sprintf($rangeFormat, 'ts_sum_down', 'ts_sum_down', $parameters['ts_sum'], 'ts_sum_up', 'ts_sum_up', $parameters['ts_sum']));
        }
        elseif ($calculation)
        {
            array_push($baseWhereParts, sprintf($rangeFormatEmpty, 'ts_sum_down', 'ts_sum_up'));
        }

        if (array_key_exists('ts_group_id', $parameters))
        {
            array_push($baseWhereParts, sprintf($simpleFormat, 'ts_group_id', $parameters['ts_group_id'], 'ts_group_id'));
            array_push($additionalWhereParts, sprintf($simpleFormat, 'ts_group_id', $parameters['ts_group_id'], 'ts_group_id'));
        }
        elseif ($calculation)
        {
            array_push($baseWhereParts, sprintf($simpleFormatEmpty, 'ts_group_id'));
            array_push($additionalWhereParts, sprintf($simpleFormatEmpty, 'ts_group_id'));
        }

        if (array_key_exists('ts_type_id', $parameters))
        {
            array_push($baseWhereParts, sprintf($simpleFormat, 'ts_type_id', $parameters['ts_type_id'], 'ts_type_id'));
            array_push($additionalWhereParts, sprintf($simpleFormat, 'ts_type_id', $parameters['ts_type_id'], 'ts_type_id'));
        }
        elseif ($calculation)
        {
            array_push($baseWhereParts, sprintf($simpleFormatEmpty, 'ts_type_id'));
            array_push($additionalWhereParts, sprintf($simpleFormatEmpty, 'ts_type_id'));
        }

    }

    public static function  getCorrectedParameters($params)
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