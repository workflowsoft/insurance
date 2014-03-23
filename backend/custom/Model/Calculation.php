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
                    if (array_key_exists($key, $parameters))
                    {
                        $value = $parameters[$key];
                        $currentPart = sprintf($simpleFormat, $column, $value, $column);
                    }
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

    private static function array_group_by(array $arr, \Closure $key_selector, \Closure $value_selector)
    {
        $result = array();
        foreach ($arr as $i) {
            $key = call_user_func($key_selector, $i);
            $result[$key][] = $value_selector($i);
        }
        return $result;
    }

    public static function calculateCost($params, &$calcErrors = array())
    {
        //TODO: Убрать костыль, когда фронт начнет всегда слать amortisation и is_legal_entity
        if (!isset($params['amortisation']))
        {
            $params['amortisation'] = 0;
        }
        if (!isset($params['is_legal_entity']))
        {
            $params['is_legal_entity'] = 0;
        }

        $data = array();
        $calc_history = new \CalcHistory;
        $db = \Frapi_Database::getInstance();

        //Сначала надо установить поправки на входные параметры и поругаться, если корректировка не проходит
        /* При заполнении корректирующих параметров надо учитывать множественное назначение от разных источников
         * Также стоит учитываеть циклические выставления значений. Пока все тупо.
         * В цикле просто будут ставиться новые значения, если отрабает условие срабатывания
         */
        try {
            $correctedParams = Calculation::GetCorrectedParameters($params);
        } catch (\Exception $e) {
            $calc_history->fillByArray($params);
            $calc_history->errors = 'CANT_CORRECT ' . $e->getMessage();
            $calc_history->save();
            throw new \Frapi_Action_Exception($e->getMessage(), 'CANT_CORRECT');
        }

        foreach ($correctedParams as $name => $value) {
            $params[$name] = $value;
        }

        $calcErrors = array();
        $result = array();

        $data['Result'] = array(
            'Coefficients' => array()
        );

        $wh = Calculation::getWhereParts($params, true);
        $bquery = 'SELECT `value` as base_tariff FROM `tariff_coefficients` WHERE ' . join(' AND ', $wh['tariff_coefficients']);
        $aquery = 'SELECT f.`code`, f.`is_mandatory`, f.`default_value`, c.`value` FROM `coefficients` f
                      LEFT OUTER JOIN
   	                    (SELECT `coefficient_id`, `value` FROM `additional_coefficients` WHERE ' . join(' AND ', $wh['additional_coefficients']) .
            ' ORDER BY `priority` DESC) AS c ON f.`id` = c.`coefficient_id`';

        $sth = $db->query($bquery);

        $results = $sth->fetch(\PDO::FETCH_ASSOC);
        if (!$results || $sth->rowCount() > 1)
            array_push($calcErrors, 'base');
        else
            $result = $results;

        $sth = $db->query($aquery);
        $results = $sth->fetchAll(\PDO::FETCH_ASSOC);

        //Группируем по поправочным коэфициентам
        $grouped = Calculation::array_group_by($results,
            function ($coef) {
                return $coef['code'];
            },
            function ($coef) use (&$calcErrors) {
                $value = null;
                if (is_null($coef['value'])) {
                    if ($coef['is_mandatory'] == 0 && !is_null($coef['default_value']))
                        $value = $coef['default_value'];
                    else
                        array_push($calcErrors, $coef['code']);
                } else
                    $value = $coef['value'];
                return $value;
            }
        );

        $results = array();

        //$result = array_merge($result ,$grouped); //Для отладки по выдаче нескольких значений коэфициентов одновременно (отладка приоритета)

        foreach ($grouped as $key => $value) {
            $actual_value = null;
            //Нужен небольшой ручной костыль для коэфициента использования ТС. Может вводиться поправками по исходным данным
            if ($key == 'ki' && isset($params['ki_ts']))
                $actual_value = $params['ki_ts'];
            else
                $actual_value = $value[0]; //Стоит обратить внимание, что из базы коэфициенты приходят сразу посортированне по приоритету
            $results[$key] = $actual_value;
        }


        $result = array_merge($result, $results);
        //Добавим коэффициенты в историю
        $calc_history->fillByArray($result);


        if (count($calcErrors)) {
            $error_string = join(', ', $calcErrors);
            $calc_history->errors = 'CANT_CALC_COEF ' . $error_string;
            $calc_history->save();

            throw new \Frapi_Exception($error_string, 'CANT_CALC_COEF');
        }

        //Выбираем все значения коэфициентов проходящие по выбранным факторам
        $data['Result']['Coefficients'] = $result;

        //Ну раз не вывалились с концами, то считаем сумму уже
        if (!empty($params['additional_sum'])) {
            //Допоборудование
            $additional_sum = $params['additional_sum'];
            $tariff = 10 * $result['ksd'] * $result['ka'] * $result['kkv'];
            $sum = Round($additional_sum * $tariff / 100, 2);
            $dbg = $tariff . ': Тариф по доп. оборудованию = 10%. Ксд =' . $result['ksd'] . '. Ка=' . $result['ka'] . '. Ккв=' . $result['kkv'] . '. Премия по доп. оборудованию = ' . $sum;
            $calc_history->sum_additional = $sum;
            $data['Result']['Additional'] = array(
                'Sum' => $sum,
                'Dbg' => $dbg
            );
        }
        //Основной рассчет. Надо тупо перемножить все коэфициенты :) Получить тариф, умножить на страховую сумму и разделить на 100, магия, чо
        $base_tariff = 1;
        foreach ($result as $key => $multiplier) {
            //А если это коэф. утраты товарной стоимости, то он почему-то прибавляется. С этим надо бы разобрваться
            if ($key == 'kuts' && $multiplier > 1)
                $base_tariff = $base_tariff + $multiplier;
            else
                $base_tariff = $base_tariff * $multiplier;
        }
        $sum = $params['ts_sum'];
        $data['Result']['Contract'] = array(
            'Tariff' => $base_tariff,
            'Sum' => Round($sum * $base_tariff / 100, 2)
        );
        //Если есть франшиза, её тоже надо отобразить нормально
        if (isset($params['franchise_percent']))
        {
            $fran = $params['franchise_percent'];
            if ($fran>0)
            {
                $data['Result']['Contract']['Franchise'] = $sum * ($fran/100);
            }
        }

        $calc_history->sum = $data['Result']['Contract']['Sum'];
        return $data;
    }

    public static function getCorrectedParameters($params)
    {
        $correctionQuery = "
            SELECT
                `factor_name` as `source`,
                `dependent_factor_name` as `name`,
                `dependent_factor_value` as `value`,
                `conditional`
            FROM
                `factor_restricions`
            WHERE ";
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