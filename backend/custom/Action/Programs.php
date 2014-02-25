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

        //Формируем окончательный запрос на получение программ

        $finalProgramQry = sprintf($programQry, join(' AND ', \Calculation\Calculation::getWhereParts($this->params)['tariff_coefficients']));
        $db = Frapi_Database::getInstance();
        $sth = $db->query($finalProgramQry);
        $results = $sth->fetchAll(PDO::FETCH_ASSOC);

        if ($results)
        {
            $defs = Calculation\Configuration::getFactorsDefinitions();
            $targetReferences = array();
            foreach($defs as $key => $def)
            {
                if ($def['program_specific'] == 1)
                    $targetReferences = array_merge($targetReferences, array($key => $def));
            }

            foreach ($results as &$program)
            {
                $references = array();
                $concrete_params = array('tariff_program_id'=>$program['id']);
                $concrete_params = array_merge($concrete_params, $this->params);
                //Получить корректировки для тарифа, если есть корректировка, соотв. справочник уже не нужен.
                $corrections = Calculation\Calculation::getCorrectedParameters($concrete_params);
                //Осуществляем корректировку параметров
                foreach ($corrections as $name => $value)
                {
                    $concrete_params[$name] =  $value;
                    if (array_key_exists($name, $targetReferences))
                    {
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
                }
                //Корректировка завершена. Осуществляем подбор значений справочников
                $contact_got = false; //TODO: Это костыль, пока нужен, для контракта
                foreach($targetReferences as $param=>$referenceDef)
                {
                    //Только если по параметру справочника не проходила корректировка
                    if (!array_key_exists($param, $corrections))
                    {
                        //TODO:Костыль для контракта
                        if ($referenceDef['type'] == 'complex_range')
                        {
                            if (!$contact_got)
                                $contact_got = true;
                            else
                                continue;
                        }
                        //TODO: Конец костыля для контракта
                        $referenceValues = References::getReferenceByRequestParams($param, $referenceDef, $concrete_params);
                        if (count($referenceValues))
                        {
                            $referenceName = $referenceDef['name'];
                            if (!array_key_exists($referenceName, $references))
                                $references[$referenceName] = array();
                            $references[$referenceName] = array_merge($references[$referenceName], $referenceValues);
                            //Добавляем параметры для рассчета
                            $paramSet = false;
                            foreach($referenceValues as $i => $refValue)
                            {
                                //Мы берем или значение по-умолчснию из справочника или первое из перечисленных, если среди них нет по-умолчанию
                                if ($refValue['is_default'] == 1)
                                {
                                    $concrete_params[$refValue['request_parameter']] = $refValue['value'];
                                    $paramSet = true;
                                }
                                if (!$paramSet && $i == count($referenceValues)-1)
                                {
                                    $concrete_params[$referenceValues[0]['request_parameter']] = $referenceValues[0]['value'];
                                }
                            }
                        }
                    }
                }

                $program['references'] = $references;
                //Рассчитываем с нужным набором параметров
                //TODO: Здесь нужна поправка на факторы, которые являются флажками и не являются справочниками, сейчас подпорка для амортизации
                $concrete_params['amortisation'] = 0; //TODO:По-умолчниаю амортизацию не считаем
                $program['cost'] = \Calculation\Calculation::calculateCost($concrete_params);
                $program['cost_params'] = $concrete_params;
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

