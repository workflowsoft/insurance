<?php

/**
 * Action Referencesmodel 
 * 
 * Список марок ТС
 * 
 * @link http://getfrapi.com
 * @author Frapi <frapi@getfrapi.com>
 * @link /references/make/:ts_type_id/:ts_make_id
 */
class Action_Referencesmodel extends Frapi_Action implements Frapi_Action_Interface
{

    /**
     * Required parameters
     * 
     * @var An array of required parameters.
     */
    protected $requiredParams = array(
        'ts_type_id',
        'ts_make_id'
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
    public function executeGet()
    {
        $this->hasRequiredParameters($this->requiredParams);
        $ts_type_id = $this->getParam('ts_type_id', self::TYPE_INT);
        $ts_make_id = $this->getParam('ts_make_id', self::TYPE_INT);
        $name_pfx = $this->getParam('name_pfx', self::TYPE_STRING);
        $selectStr = 'SELECT * FROM ts_model where ts_type_id = '.$ts_type_id.' AND ts_make_id = '.$ts_make_id;
        if (!empty($name_pfx))
            $selectStr =  $selectStr.' AND name LIKE \''.$name_pfx.'%\'';

        $groupMatchSql = 'SELECT ts_group_id FROM ts_group_match WHERE (ts_type_id = '.$ts_type_id.' OR ts_type_id IS NULL)
                            AND ts_make_id = '.$ts_make_id.' AND ts_model_id IS NULL AND ts_modification_id IS NULL';

        $ts_group_id = Frapi_Database::getInstance()->query($groupMatchSql)->fetchColumn();
        if (!$ts_group_id) $ts_group_id = null;
        $this->data['ts_group_id'] = $ts_group_id;
        $this->data['reference'] = Frapi_Database::getInstance()->query($selectStr)->fetchAll(PDO::FETCH_ASSOC);

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

