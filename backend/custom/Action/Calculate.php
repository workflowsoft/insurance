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
    protected $requiredParams = array('ts_group_id', 'tariff_program_id', 'risks_id', 'tariff_def_damage_type_id', 'ts_age');

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
            'ts_modification_id' => $this->getParam('ts_modification_id', self::TYPE_OUTPUT),
            'ts_group_id' => $this->getParam('ts_group_id', self::TYPE_OUTPUT),
            'tariff_program_id' => $this->getParam('tariff_program_id', self::TYPE_OUTPUT),
            'risks_id' => $this->getParam('risks_id', self::TYPE_OUTPUT),
            'tariff_def_damage_type_id' => $this->getParam('tariff_def_damage_type_id', self::TYPE_OUTPUT),
            'ts_age' => $this->getParam('ts_age', self::TYPE_OUTPUT),
            'ts_sum' => $this->getParam('ts_sum', self::TYPE_OUTPUT),
            'amortisation' => $this->getParam('amortisation', self::TYPE_OUTPUT),
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
        $valid = $this->hasRequiredParameters($this->requiredParams);
        if ($valid instanceof Frapi_Error) {
            throw $valid;
        }

        $db = Frapi_Database::getInstance();
        $query = 'SELECT * FROM all_factors';
        $sth = $db->query($query);
        $results = $sth->fetchAll(PDO::FETCH_ASSOC);
        $this->data['Result'] = $results;
        return $this->toArray();
    }
    public function executeDocs()
    {
        return new Frapi_Response(array(
            'code' => 200,
            'data' => array(
                'GET'    => 'Возвращает результаты рассчета стоимости страховой премии' .
                    'по введенным пользователем факторам'
            )
        ));
    }
}

