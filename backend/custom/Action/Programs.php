<?php

/**
 * Action Programs 
 * 
 * Возвращает доступные при заданых
 * параметрах программы страхования
 * 
 * @link http://getfrapi.com
 * @author Frapi <frapi@getfrapi.com>
 * @link /programs
 */
class Action_Programs extends Frapi_Action implements Frapi_Action_Interface
{

    /**
     * Required parameters
     * 
     * @var An array of required parameters.
     */
    protected $requiredParams = array(
        'ts_age',
        'ts_sum',
        'ts_antitheft_id',
        'commercial_carting_flag',
        'drivers_count',
        'driver_age',
        'driver_exp'
        );

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
            'ts_age' => $this->getParam('ts_age', self::TYPE_OUTPUT),
            'ts_sum' => $this->getParam('ts_sum', self::TYPE_OUTPUT),
            'ts_antitheft_id' => $this->getParam('ts_antitheft', self::TYPE_OUTPUT),
            'commercial_carting_flag' => $this->getParam('commercial_carting_flag', self::TYPE_OUTPUT),
            'drivers_count' => $this->getParam('drivers_count', self::TYPE_OUTPUT),
            'driver_age' => $this->getParam('driver_age', self::TYPE_OUTPUT),
            'driver_exp' => $this->getParam('driver_exp', self::TYPE_OUTPUT),
            'ts_type_id' => $this->getParam('ts_type_id', self::TYPE_OUTPUT),
            'ts_make_id' => $this->getParam('ts_make_id', self::TYPE_OUTPUT),
            'ts_model_id' => $this->getParam('ts_model_id', self::TYPE_OUTPUT),
            'ts_modification_id' => $this->getParam('ts_modification_id', self::TYPE_OUTPUT),
            'ts_group_id' => $this->getParam('ts_group_id', self::TYPE_OUTPUT),
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
     * Get Request Handler
     * 
     * This method is called when a request is a GET
     * 
     * @return array
     */
    public function executeGet()
    {
        $valid = $this->hasRequiredParameters($this->requiredParams);
        if ($valid instanceof Frapi_Error) {
            throw $valid;
        }
        /* Получить доступные программы страхования изначально
         TODO: Пока сделаем дубово. Мы знаем, что ни один из обязательных для рассчета доп. коэфициентов не влияет на список страховых программ
         TODO: Сделаем еще дубовее, мы знаем, что  все оставшиеся справочники (относящиеся к тарифной программе не влияют друг на друга). В дальнейшем это может быть не так
         TODO: Еще мы знаем, что корректировка осущетсвляется только в зависимости от программы страхования и на это тоже жестко забъемся
        */
        $programQry = 'SELECT DISTINCT TP.id, TP.name FROM
                        (
                          SELECT TC.tariff_program_id FROM tariff_coefficients TC WHERE %s GROUP BY TC.tariff_program_id
                        ) RC
                        INNER JOIN tariff_program TP ON TP.id = RC.tariff_program_id';

        $baseWhereParts = array(
            sprintf('(ts_age = %u OR ts_age IS NULL)', $this->getParam('ts_age', self::TYPE_INT)),
            sprintf('(ts_sum_down IS NULL OR ts_sum_down<=%F) AND (ts_sum_up IS NULL OR ts_sum_up>=%F)', $this->getParam('ts_sum', self::TYPE_DOUBLE), $this->getParam('ts_sum', self::TYPE_DOUBLE)),
        );

        $ts_type_id = $this->getParam('ts_type_id', self::TYPE_INT);
        if (!empty($ts_type_id))
        {
            $part = sprintf('(ts_type_id = %u OR ts_type_id IS NULL)', $this->getParam('ts_type_id', self::TYPE_INT));
            array_push($baseWhereParts, $part);
        }

        $ts_make_id = $this->getParam('ts_make_id', self::TYPE_INT);
        if (!empty($ts_make_id))
        {
            $part = sprintf('(ts_make_id = %u OR ts_make_id IS NULL)', $this->getParam('ts_make_id', self::TYPE_INT));
            array_push($baseWhereParts, $part);
        }

        $ts_model_id = $this->getParam('ts_model_id', self::TYPE_INT);
        if (!empty($ts_model_id))
        {
            $part = sprintf('(ts_model_id = %u OR ts_model_id IS NULL)', $this->getParam('ts_model_id', self::TYPE_INT));
            array_push($baseWhereParts, $part);
        }

        $ts_modification_id = $this->getParam('ts_modification_id', self::TYPE_INT);
        if (!empty($ts_modification_id))
        {
            $part = sprintf('(ts_modification_id = %u OR ts_modification_id IS NULL)', $this->getParam('ts_modification_id', self::TYPE_INT));
            array_push($baseWhereParts, $part);
        }

        $ts_group_id = $this->getParam('ts_group_id', self::TYPE_INT);
        if (!empty($ts_group_id))
        {
            $part = sprintf('(ts_group_id = %u OR ts_group_id IS NULL)', $this->getParam('ts_group_id', self::TYPE_INT));
            array_push($baseWhereParts, $part);
        }

        //Формируем окончательный запрос на получение программ

        $finalProgramQry = sprintf($programQry, join(' AND ',$baseWhereParts));
        $db = Frapi_Database::getInstance();
        $sth = $db->query($finalProgramQry);
        $results = $sth->fetchAll(PDO::FETCH_ASSOC);

        if ($results)
        {
            /* Для каждого тарифа нужно определить:
                     "Покрываемые риски" (risk_id) additional_coefficients, tariff_coefficients
                     "Сопосб определения размера ущерба" (tariff_def_damage_type_id) additional_coefficients, tariff_coefficients
                     "Срок действия договора" (contract_day_down, contract_day_up, contract_month_down, contract_month_up, contract_year_down, contract_year_up) additional_coefficients
                     "Тип возмещения" (regres_limit_factor_id) additional_coefficients
                     "Выплата без справок" (payments_without_references_id) additional_coefficients
                     "Тип франшизы" (franchise_type_id) additional_coefficients
                     "Размер франшизы" (franchise_percent_down, franchise_percent_up)
                */

            $targetReferences = array(
                'risk_id' => array(
                    'name' => 'risks',
                    'type'=>'simple',
                    'columns'=> array('risk_id'),
                    'tables'=>array('additional_coefficients','tariff_coefficients'),
                 ),
                'tariff_def_damage_type_id' => array(
                        'name' => 'tariff_def_damage_type',
                        'type'=>'simple',
                        'columns'=> array('tariff_def_damage_type_id'),
                        'tables'=>array('additional_coefficients','tariff_coefficients'),
                 ),
                'contract_day' => array(
                    'name' => 'contract',
                    'type'=>'complex_range',
                    'columns'=> array('contract_day_down', 'contract_day_up'),
                    'tables'=>array('additional_coefficients'),
                ),
                'contract_month' => array(
                    'name' => 'contract',
                    'type'=>'complex_range',
                    'columns'=> array('contract_month_down', 'contract_month_up'),
                    'tables'=>array('additional_coefficients'),
                ),
                'contract_year' => array(
                    'name' => 'contract',
                    'type'=>'complex_range',
                    'columns'=> array('contract_year_down', 'contract_year_up'),
                    'tables'=>array('additional_coefficients'),
                ),
                'regres_limit_factor_id' => array(
                    'name' => 'regres_limit',
                    'type'=>'simple',
                    'columns'=> array('regres_limit_factor_id'),
                    'tables'=>array('additional_coefficients'),
                ),
                'payments_without_references_id' => array(
                    'name' => 'payments_without_references',
                    'type'=>'simple',
                    'columns'=> array('payments_without_references_id'),
                    'tables'=>array('additional_coefficients'),
                ),
                'franchise_type_id' => array(
                    'name' => 'franchise_type',
                    'type'=>'simple',
                    'columns'=> array('franchise_type_id'),
                    'tables'=>array('additional_coefficients'),
                ),
                'franchise_percent' => array(
                    'name' => 'franchise_percent',
                    'type'=>'range',
                    'columns'=> array('franchise_percent_down', 'franchise_percent_up'),
                    'tables'=>array('additional_coefficients'),
                ),
            );

            foreach ($results as &$program)
            {
                $references = array();
                $concrete_params = array('tariff_program_id'=>$program['id']);
                $concrete_params = array_merge($concrete_params, $this->params);
                //Получить корректировки для тарифа, если есть корректировка, соотв. справочник уже не нужен.
                $corrections = Calculation::getCorrectedParameters($concrete_params);
                //Осуществляем корректировку параметров
                foreach ($corrections as $name => $value)
                {
                    $concrete_params[$name] =  $value;

                    $referenceDef =  $targetReferences[$name];

                    if ($referenceDef)
                    {
                        $referenceName = $referenceDef['name'];
                        if (!array_key_exists($referenceName, $references))
                            $references[$referenceName] = array();
                        $references[$referenceName] =
                            array_merge($references[$referenceName],
                                array(
                                    'request_parameter' => $name,
                                    'name' => References::getNameByValue($referenceDef, $value),
                                    'value' => $value,
                                    'is_default'=> 1
                                )
                            );
                    }
                }
                //Корректировка завершена. Осуществляем подбор значений справочников
                foreach($targetReferences as $param=>$referenceDef)
                {
                    //Только если по параметру справочника не проходила корректировка
                    if (!array_key_exists($param, $corrections))
                    {
                        $referenceValues = References::getReferenceByRequestParams($param, $referenceDef, $concrete_params);
                        if (count($referenceValues))
                        {
                            $referenceName = $referenceDef['name'];
                            if (!array_key_exists($referenceName, $references))
                                $references[$referenceName] = array();
                            $references[$referenceName] = array_merge($references[$referenceName], $referenceValues);
                        }
                    }
                }

                $program['references'] = $references;
            }
        }

        $this->data['Result'] = $results;

        /* Рассчет допобуродования отдельно
        additional_sum
        */


        //Получить диапазоны допустимых значений для справочников каждого из тарифов. Если только null этот справочник для него не нужен
        //Рассчитать суммы для значений по-умолчанию

        return $this->toArray();
    }

    /**
     * Post Request Handler
     * 
     * This method is called when a request is a POST
     * 
     * @return array
     */
    public function executePost()
    {
        $valid = $this->hasRequiredParameters($this->requiredParams);
        if ($valid instanceof Frapi_Error) {
            throw $valid;
        }
        
        return $this->toArray();
    }

    /**
     * Put Request Handler
     * 
     * This method is called when a request is a PUT
     * 
     * @return array
     */
    public function executePut()
    {
        $valid = $this->hasRequiredParameters($this->requiredParams);
        if ($valid instanceof Frapi_Error) {
            throw $valid;
        }
        
        return $this->toArray();
    }

    /**
     * Delete Request Handler
     * 
     * This method is called when a request is a DELETE
     * 
     * @return array
     */
    public function executeDelete()
    {
        $valid = $this->hasRequiredParameters($this->requiredParams);
        if ($valid instanceof Frapi_Error) {
            throw $valid;
        }
        
        return $this->toArray();
    }

    /**
     * Head Request Handler
     * 
     * This method is called when a request is a HEAD
     * 
     * @return array
     */
    public function executeHead()
    {
        $valid = $this->hasRequiredParameters($this->requiredParams);
        if ($valid instanceof Frapi_Error) {
            throw $valid;
        }
        
        return $this->toArray();
    }


}

