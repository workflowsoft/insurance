<?php

/**
 * Action Calculate
 *
 * Выполняет вычисление стоимости страховки
 * исходя из всех введенных пользователем
 * данных
 *
 * @link http://getfrapi.com
 * @author Frapi <frapi@getfrapi.com>
 * @link /calc/web/v1
 */
class Action_Calculate extends Frapi_Action implements Frapi_Action_Interface
{
    protected $requiredParams = array(
        'tariff_program_id',
        'risk_id',
        'tariff_def_damage_type_id',
        'ts_age',
        'payments_without_references_id',
        'ts_sum',
        'ts_antitheft_id',
    );

    /**
     * @var array
     */
    private $_calcErrors = array();

    /**
     * The data container to use in toArray()
     *
     * @var A container of data to fill and return in toArray()
     */
    private $data = array();

    private function array_group_by(array $arr, Closure $key_selector, Closure $value_selector)
    {
        $result = array();
        foreach ($arr as $i) {
            $key = call_user_func($key_selector, $i);
            $result[$key][] = $value_selector($i);
        }
        return $result;
    }

    /**
     * To Array
     *
     * This method returns the value found in the database
     * into an associative array.
     *
     * @return array
     */
    public function toArray()
    {
        $this->data['inputParams'] = array(
            'ts_make_id' => $this->getParam('ts_make_id', self::TYPE_OUTPUT),
            'ts_model_id' => $this->getParam('ts_model_id', self::TYPE_OUTPUT),
            'ts_type_id' => $this->getParam('ts_model_id', self::TYPE_OUTPUT),
            'ts_modification_id' => $this->getParam('ts_modification_id', self::TYPE_OUTPUT),
            'ts_group_id' => $this->getParam('ts_group_id', self::TYPE_OUTPUT),
            'tariff_program_id' => $this->getParam('tariff_program_id', self::TYPE_OUTPUT),
            'risk_id' => $this->getParam('risk_id', self::TYPE_OUTPUT),
            'tariff_def_damage_type_id' => $this->getParam('tariff_def_damage_type_id', self::TYPE_OUTPUT),
            'ts_age' => $this->getParam('ts_age', self::TYPE_OUTPUT),
            'ts_sum' => $this->getParam('ts_sum', self::TYPE_OUTPUT),
            'amortisation' => $this->getParam('amortisation', self::TYPE_OUTPUT),
            'payments_without_references_id' => $this->getParam('payments_without_references_id', self::TYPE_OUTPUT),
            'franchise_type_id' => $this->getParam('franchise_type_id', self::TYPE_OUTPUT),
            'regres_limit_factor_id' => $this->getParam('regres_limit_factor_id', self::TYPE_OUTPUT),
            'contract_day' => $this->getParam('contract_day', self::TYPE_OUTPUT),
            'contract_month' => $this->getParam('contract_month', self::TYPE_OUTPUT),
            'contract_year' => $this->getParam('contract_year', self::TYPE_OUTPUT),
            'drivers_count' => $this->getParam('drivers_count', self::TYPE_OUTPUT),
            'driver_age' => $this->getParam('driver_age', self::TYPE_OUTPUT),
            'driver_exp' => $this->getParam('driver_exp', self::TYPE_OUTPUT),
            'ts_antitheft_id' => $this->getParam('ts_antitheft_id', self::TYPE_OUTPUT),
            'franchise_percent' => $this->getParam('franchise_percent', self::TYPE_OUTPUT),
            'commercial_carting_flag' => $this->getParam('commercial_carting_flag', self::TYPE_OUTPUT),
            'additional_sum' => $this->getParam('additional_sum', self::TYPE_OUTPUT),
        );
        return $this->data;
    }

    /**
     * Default Call Method
     *
     * This method is called when no specific request handler has been found
     *
     * @return array
     */
    public function executeAction()
    {
        $valid = $this->hasRequiredParameters($this->requiredParams);
        if ($valid instanceof Frapi_Error) {
            throw $valid;
        }
        return $this->toArray();
    }

    /**
     *
     * Возврат результатов рассчета
     *
     * @return array
     */
    public function executeGet()
    {
        $this->hasRequiredParameters($this->requiredParams);
        $calc_history = new CalcHistory;
        $db = Frapi_Database::getInstance();

        //Сначала надо установить поправки на входные параметры и поругаться, если корректировка не проходит
        /* При заполнении корректирующих параметров надо учитывать множественное назначение от разных источников
         * Также стоит учитываеть циклические выставления значений. Пока все тупо.
         * В цикле просто будут ставиться новые значения, если отрабает условие срабатывания
         */
        try {
            $correctedParams = Calculation\Calculation::GetCorrectedParameters($this->params);
        } catch (Exception $e) {
            $calc_history->fillByArray($this->params);
            $calc_history->errors = 'CANT_CORRECT ' . $e->getMessage();
            $calc_history->save();

            throw new Frapi_Action_Exception($e->getMessage(), 'CANT_CORRECT');
        }

        foreach ($correctedParams as $name => $value) {
            $this->params[$name] = $value;
        }

        $this->_calcErrors = array();
        $result = array();

        $this->data['Result'] = array(
            'Coefficients' => array()
        );

        //Сначала заберем обязательные факторы и основную часть WHERE

        $bquery = 'SELECT `value` as base_tariff FROM `tariff_coefficients` WHERE' . join(' AND ', \Calculation\Calculation::getWhereParts($this->params, true)['tariff_coefficients']);
        $aquery = 'SELECT f.`code`, f.`is_mandatory`, f.`default_value`, c.`value` FROM `coefficients` f
                      LEFT OUTER JOIN
   	                    (SELECT `coefficient_id`, `value` FROM `additional_coefficients` ' . join(' AND ', \Calculation\Calculation::getWhereParts($this->params, true)['additional_coefficients']) .
            ' ORDER BY `priority` DESC) AS c ON f.`id` = c.`factor_id`';
        $sth = $db->query($bquery);
        $results = $sth->fetch(PDO::FETCH_ASSOC);
        if (!$results || $sth->rowCount() > 1)
            array_push($this->_calcErrors, 'base');
        else
            $result = $results;

        $sth = $db->query($aquery);
        $results = $sth->fetchAll(PDO::FETCH_ASSOC);

        //Группируем по поправочным коэфициентам
        $grouped = $this->array_group_by($results,
            function ($coef) {
                return $coef['code'];
            },
            function ($coef) {
                $value = null;
                if (is_null($coef['value'])) {
                    if ($coef['is_mandatory'] == 0 && !is_null($coef['default_value']))
                        $value = $coef['default_value'];
                    else
                        array_push($this->_calcErrors, $coef['code']);
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
            if ($key == 'ki' && isset($this->params['ki_ts']))
                $actual_value = $this->getParam('ki_ts', self::TYPE_DOUBLE);
            else
                $actual_value = $value[0]; //Стоит обратить внимание, что из базы коэфициенты приходят сразу посортированне по приоритету
            $results[$key] = $actual_value;
        }


        $result = array_merge($result, $results);
        //Добавим коэффициенты в историю
        $calc_history->fillByArray($result);


        if (count($this->_calcErrors)) {
            $error_string = join(', ', $this->_calcErrors);
            $calc_history->errors = 'CANT_CALC_COEF ' . $error_string;
            $calc_history->save();

            throw new Frapi_Exception($error_string, 'CANT_CALC_COEF');
        }

        //Выбираем все значения коэфициентов проходящие по выбранным факторам
        $this->data['Result']['Coefficients'] = $result;

        //Ну раз не вывалились с концами, то считаем сумму уже
        if (!empty($this->params['additional_sum'])) {
            //Допоборудование
            $additional_sum = $this->getParam('additional_sum', self::TYPE_DOUBLE);
            $tariff = 10 * $result['ksd'] * $result['ka'] * $result['kkv'];
            $sum = Round($additional_sum * $tariff / 100, 2);
            $dbg = $tariff . ': Тариф по доп. оборудованию = 10%. Ксд =' . $result['ksd'] . '. Ка=' . $result['ka'] . '. Ккв=' . $result['kkv'] . '. Премия по доп. оборудованию = ' . $sum;
            $calc_history->sum_additional = $sum;
            $this->data['Result']['Additional'] = array(
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
            $base_tariff = $base_tariff * $multiplier;
        }
        $sum = $this->getParam('ts_sum', self::TYPE_DOUBLE);
        $this->data['Result']['Contract'] = array(
            'Tariff' => $base_tariff,
            'Sum' => Round($sum * $base_tariff / 100, 2)
        );
        $calc_history->sum = $this->data['Result']['Contract']['Sum'];
        return $this->toArray();
    }

    public function executeDocs()
    {
        return new Frapi_Response(array(
            'code' => 200,
            'data' => array(
                'GET' => 'Возвращает результаты рассчета стоимости страховой премии' .
                    'по введенным пользователем факторам'
            )
        ));
    }
}

