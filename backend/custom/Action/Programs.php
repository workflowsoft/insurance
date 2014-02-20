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
        //Получить доступные программы страхования изначально
        $programQry = 'SELECT DISTINCT TP.id, TP.name FROM
                        (
                          (SELECT TC.tariff_program_id FROM tariff_coefficients TC WHERE %s GROUP BY TC.tariff_program_id) RC
		                   INNER JOIN
                              (SELECT AC.tariff_program_id FROM additional_coefficients AC
				                INNER JOIN coefficients AF ON AF.id = AC.coefficient_id
				               WHERE AF.is_mandatory = 1 AND %s
			               GROUP BY AC.tariff_program_id) ACF
	                       ON RC.tariff_program_id = ACF.tariff_program_id OR ACF.tariff_program_id IS NULL
                        )
                        INNER JOIN tariff_program TP ON TP.id = RC.tariff_program_id';

        $baseWhereParts = array(
            sprintf('(ts_age = %u OR ts_age IS NULL)', $this->getParam('ts_age', self::TYPE_INT)),
            sprintf('(ts_sum_down IS NULL OR ts_sum_down<=%F) AND (ts_sum_up IS NULL OR ts_sum_up>=%F)', $this->getParam('ts_sum', self::TYPE_DOUBLE), $this->getParam('ts_sum', self::TYPE_DOUBLE)),
        );

        $additionalWhereParts = array(
            sprintf('(ts_age = %u OR ts_age IS NULL)', $this->getParam('ts_age', self::TYPE_INT)),
            sprintf('(ts_antitheft_id = %u OR ts_antitheft_id IS NULL)', $this->getParam('ts_antitheft_id', self::TYPE_INT)),
            sprintf('(commercial_carting_flag = %u OR commercial_carting_flag IS NULL)', $this->getParam('commercial_carting_flag', self::TYPE_INT)),
            sprintf('(drivers_count_down IS NULL OR drivers_count_down<=%F) AND (drivers_count_up IS NULL OR drivers_count_up>=%F)', $this->getParam('drivers_count', self::TYPE_INT), $this->getParam('drivers_count', self::TYPE_INT)),
            sprintf('(driver_age_down IS NULL OR driver_age_down<=%F) AND (driver_age_up IS NULL OR driver_age_up>=%F)', $this->getParam('driver_age', self::TYPE_INT), $this->getParam('driver_age', self::TYPE_INT)),
            sprintf('(driver_exp_down IS NULL OR driver_exp_down<=%F) AND (driver_exp_up IS NULL OR driver_exp_up>=%F)', $this->getParam('driver_exp', self::TYPE_INT), $this->getParam('driver_exp', self::TYPE_INT)),
        );

        $ts_type_id = $this->getParam('ts_type_id', self::TYPE_INT);
        if (!empty($ts_type_id))
        {
            $part = sprintf('(ts_type_id = %u OR ts_type_id IS NULL)', $this->getParam('ts_type_id', self::TYPE_INT));
            array_push($baseWhereParts, $part);
            array_push($additionalWhereParts, $part);
        }

        $ts_make_id = $this->getParam('ts_make_id', self::TYPE_INT);
        if (!empty($ts_make_id))
        {
            $part = sprintf('(ts_make_id = %u OR ts_make_id IS NULL)', $this->getParam('ts_make_id', self::TYPE_INT));
            array_push($baseWhereParts, $part);
            array_push($additionalWhereParts, $part);
        }

        $ts_model_id = $this->getParam('ts_model_id', self::TYPE_INT);
        if (!empty($ts_model_id))
        {
            $part = sprintf('(ts_model_id = %u OR ts_model_id IS NULL)', $this->getParam('ts_model_id', self::TYPE_INT));
            array_push($baseWhereParts, $part);
            array_push($additionalWhereParts, $part);
        }

        $ts_modification_id = $this->getParam('ts_modification_id', self::TYPE_INT);
        if (!empty($ts_modification_id))
        {
            $part = sprintf('(ts_modification_id = %u OR ts_modification_id IS NULL)', $this->getParam('ts_modification_id', self::TYPE_INT));
            array_push($baseWhereParts, $part);
            array_push($additionalWhereParts, $part);
        }

        $ts_group_id = $this->getParam('ts_group_id', self::TYPE_INT);
        if (!empty($ts_group_id))
        {
            $part = sprintf('(ts_group_id = %u OR ts_group_id IS NULL)', $this->getParam('ts_group_id', self::TYPE_INT));
            array_push($baseWhereParts, $part);
            array_push($additionalWhereParts, $part);
        }

        //Формируем окончательный запрос на получение программ

        $finalProgramQry = sprintf($programQry, join(' AND ',$baseWhereParts), join(' AND ', $additionalWhereParts));
        $db = Frapi_Database::getInstance();
        $sth = $db->query($finalProgramQry);
        $results = $sth->fetchAll(PDO::FETCH_ASSOC);
        $this->data['Result'] = $results;
        /* Рассчет допобуродования отдельно
        additional_sum
        */

        //Получить корректировки для тарифа, если есть корректировка, соотв. справочник уже не нужен.
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

