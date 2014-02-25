<?php
/**
 * Created by PhpStorm.
 * User: PavelTropin
 * Date: 21.02.14
 * Time: 16:53
 */

namespace Calculation;

class Calculation {

    public static function getWhereParts($parameters, $is_strict = false)
    {
        $simpleFormat = '(%s = %u OR %s IS NULL)';
        $simpleFormatEmpty = '%s IS NULL';
        $rangeFormat = '(%s IS NULL OR %s<=%u) AND (%s IS NULL OR %s>=%u)';
        $rangeFormatEmpty = '%s IS NULL AND %s IS NULL';

        $factors = Configuration::getFactorsDefinitions();

        $whereParts = array();

        foreach($factors as $key=>$factor_def)
        {
            $currentPart = null;
            $column = $factor_def['columns'][0];
            switch ($factor_def['type'])
            {
                case 'simple':
                    if (array_key_exists($key, $parameters))
                    {
                        $value = $parameters[$key];
                        $currentPart = sprintf($simpleFormat, $column, $value, $column);
                    }
                    elseif ($is_strict)
                        $currentPart = sprintf($simpleFormatEmpty, $column);
                    break;
                case 'range':
                case 'complex_range':
                    $column_up = $factor_def['columns'][1];
                    if (array_key_exists($key, $parameters))
                    {
                        $value = $parameters[$key];
                        $currentPart = sprintf($rangeFormat,  $column, $column, $value, $column_up, $column_up, $value);
                    }
                    elseif ($is_strict)
                        $currentPart = sprintf($rangeFormatEmpty, $column, $column_up);
                    break;
                default:
                    break;
            }
            foreach($factor_def['tables'] as $tableName)
            {
                if (!array_key_exists($tableName, $whereParts))
                    $whereParts = array_merge($whereParts, array($tableName => array()));
                if (!is_null($currentPart))
                    array_push($whereParts[$tableName], $currentPart);
            }
        }
        return $whereParts;
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

        $db = \Frapi_Database::getInstance();

        $sth = $db->query($correctionQuery);
        if (!$sth) {
            throw new \Frapi_Action_Exception($correctionQuery, 'CANT_CORRECT');
        }

        $corrections = $sth->fetchAll(\PDO::FETCH_ASSOC);
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
            throw new \Frapi_Exception(join(', ', $correct_errors), 'CANT_CORRECT');

        return $correcting_params;
    }
} 