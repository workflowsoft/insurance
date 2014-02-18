<?php

/**
 * Action Tsgroup 
 * 
 * Получение соответствия группы ТС
 * (задаваемых страховой компанией) для
 * выбранной комбинации "Тип ТC"->
 * "Производитель ТС"->"Модель ТС"-> "Модификация
 * ТС"
 * 
 * @link http://getfrapi.com
 * @author Frapi <frapi@getfrapi.com>
 * @link /ts/group
 */
class Action_Tsgroup extends Frapi_Action implements Frapi_Action_Interface
{

    /**
     * Required parameters
     * 
     * @var An array of required parameters.
     */
    protected $requiredParams = array('ts_type_id');

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
        $this->hasRequiredParameters($this->requiredParams);
        $ts_type_id = $this->getParam('ts_type_id', self::TYPE_INT);
        $ts_make_id = $this->getParam('ts_make_id', self::TYPE_INT);
        $ts_model_id = $this->getParam('ts_model_id', self::TYPE_INT);
        $ts_modification_id = $this->getParam('ts_modification_id', self::TYPE_INT);

        $sqlWhereParts = array();
        $sqlCaseParts = array('0');

        if (!empty($ts_type_id))
        {
            array_push($sqlWhereParts, '(ts_type_id = '.$ts_type_id.' OR ts_type_id IS NULL)');
            array_push($sqlCaseParts, '(CASE WHEN ts_type_id IS NULL THEN 0 ELSE 1 END)');
        }
        else
        {
            array_push($sqlWhereParts, 'ts_type_id IS NULL');
        }
        if (!empty($ts_make_id))
        {
            array_push($sqlWhereParts, '(ts_make_id = '.$ts_make_id.' OR ts_make_id IS NULL)');
            array_push($sqlCaseParts, '(CASE WHEN ts_make_id IS NULL THEN 0 ELSE 10 END)');
        }
        else
        {
            array_push($sqlWhereParts, 'ts_make_id IS NULL');
        }
        if (!empty($ts_model_id))
        {
            array_push($sqlWhereParts, '(ts_model_id = '.$ts_model_id.' OR ts_model_id IS NULL)');
            array_push($sqlCaseParts, '(CASE WHEN ts_model_id IS NULL THEN 0 ELSE 100 END)');
        }
        else
        {
            array_push($sqlWhereParts, 'ts_model_id IS NULL');
        }
        if (!empty($ts_modification_id))
        {
            array_push($sqlWhereParts, '(ts_modification_id = '.$ts_modification_id.' OR ts_modification_id IS NULL)');
            array_push($sqlCaseParts,  '(CASE WHEN ts_modification_id IS NULL THEN 0 ELSE 1 END)');
        }
        else
        {
            array_push($sqlWhereParts, 'ts_modification_id IS NULL');
        }

        $sqlSelect = 'SELECT `ts_group_id` FROM (
                        SELECT `ts_group_id`,'.join(' + ', $sqlCaseParts).' as `priority`
                        FROM `ts_group_match` WHERE'.join(' AND ', $sqlWhereParts).') T
				ORDER BY `priority` DESC LIMIT 1';

        $ts_group_id = Frapi_Database::getInstance()->query($sqlSelect)->fetchColumn();
        if (!$ts_group_id) $ts_group_id = null;
        $this->data['ts_group_id'] = $ts_group_id;
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
        return $this->toArray();
    }


}

