<?php

/**
 * Action Referencesmake 
 * 
 * Список производителей ТС
 * 
 * @link http://getfrapi.com
 * @author Frapi <frapi@getfrapi.com>
 * @link /references/make/:ts_type_id
 */
class Action_Referencesmake extends Frapi_Action implements Frapi_Action_Interface
{

    /**
     * Required parameters
     * 
     * @var An array of required parameters.
     */
    protected $requiredParams = array(
        'ts_type_id'
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

    private  $_db = null;

    private function getDb()
    {
        if (is_null($this->_db))
        {
            $this->_db = Frapi_Database::getInstance();
        }
        return $this->_db;
    }


    public function executeGet()
    {
        $this->hasRequiredParameters($this->requiredParams);
        $type_id = $this->getParam('ts_type_id', self::TYPE_INT);
        $name_pfx = $this->getParam('name_pfx', self::TYPE_STRING);
        $selectStr = 'SELECT M.* from `ts_make` M
                        INNER JOIN `ts_type2ts_make` T2M
	                      ON T2M.ts_make_id = M.id ';
        $whereElements = array();
        $ts_group_id = null;
        $db = null;
        if (!empty($type_id))
        {
            $groupMatchSql = 'SELECT ts_group_id FROM ts_group_match WHERE ts_type_id = '.$type_id.'
                            AND ts_make_id IS NULL AND ts_model_id IS NULL AND ts_modification_id IS NULL';
            $ts_group_id = $this->getDb()->query($groupMatchSql)->fetchColumn();
            if(!$ts_group_id)
                $ts_group_id = null;

            array_push($whereElements, 'T2M.ts_type_id = '.$type_id);
        }
        if (!empty($name_pfx))
           array_push($whereElements, 'M.name LIKE \''.$name_pfx.'%\'');
        if (count($whereElements))
            $selectStr = $selectStr.' WHERE '.join(' AND ',$whereElements);
        $selectStr = $selectStr.' GROUP BY M.Id';

        $result = $this->getDb()->query($selectStr);

        $this->data['ts_group_id'] = $ts_group_id;
        $this->data['reference'] = $result->fetchAll(PDO::FETCH_ASSOC);

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

