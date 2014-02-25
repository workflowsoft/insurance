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
        $this->data = \Calculation\Calculation::calculateCost($this->params, $this->_calcErrors);
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

