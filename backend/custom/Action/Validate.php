<?php

/**
 * Action Validate 
 * 
 * Валидация входящих параметров
 * 
 * @link http://getfrapi.com
 * @author Frapi <frapi@getfrapi.com>
 * @link /validate
 */
class Action_Validate extends Frapi_Action implements Frapi_Action_Interface
{

    /**
     * Required parameters
     * 
     * @var An array of required parameters.
     */
    protected $requiredParams = array();

    private $_parameters = array(
        'ts_make_id' => self::TYPE_INT,
        'ts_model_id' => self::TYPE_INT,
        'is_modification_id' => self::TYPE_INT,
        'ts_group_id' => self::TYPE_INT,
        'tariff_program_id' => self::TYPE_INT,
        'risk_id' => self::TYPE_INT,
        'damage_det_type_id' => self::TYPE_INT,
        'ts_age' => self::TYPE_INT,
//        'ts_sum' => self::TYPE_DOUBLE,
        'amortisation' => self::TYPE_INT,
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
//        $this->data[] = 'lal';
//        return $this->toArray();


        //Вытщим то, что пришло с фронта
        $parameters_known = array();
        $parameters_to_validate = array();
        foreach($this->_parameters as $key => $type) {
            $tmp = $this->getParam( $key, $type);
            if(empty($tmp)) {
                $parameters_to_validate[] = $key;
            } else {
                $parameters_known[$key] = $tmp;
            }
        }

        $validation = array();
        $db = Frapi_Database::getInstance();
        foreach ($parameters_to_validate as $param) {
			$sql_from = 'SELECT DISTINCT `' . $param . '` FROM `tariff_coefficients`';
			$sql_where = '';
			$first = true;
			foreach ($parameters_known as $key => $param_known) {
				$sql_where .=  ($first ? ' WHERE' : ' AND') . " `$key` = $param_known";
				$first = false;
			}
            $sql = $sql_from . $sql_where;

            $sth = $db->query($sql);
            if(!$sth) {
                $this->data['crashed_on'] = $param;
                return $this->toArray();
            }
            $results = $sth->fetchAll(PDO::FETCH_ASSOC);
            $this->data[] = $results;

            if (!$results) {
                throw new Frapi_Error('CANT_CALC_BASET');
            }
            foreach($results as $value) {
                $validation[$param][] = $value[$param];
            }

		}
        $this->data = $validation;
        return $this->toArray();

//        $whereStr =
//            sprintf(
//                'WHERE
//                        TS_Group_Id = %s
//                    AND Tariff_Program_Id = %s
//                    AND Risk_Id = %s
//                    AND Damage_Det_Type_Id = %s
//                    AND TS_Age = %s',
//                $this->getParam('ts_group_id', self::TYPE_INT),
//                $this->getParam('tariff_program_id', self::TYPE_INT),
//                $this->getParam('risks_id', self::TYPE_INT),
//                $this->getParam('tariff_def_damage_type_id', self::TYPE_INT),
//                $this->getParam('ts_age', self::TYPE_INT)
//            );
//        if (!empty($this->params['ts_sum'])) {
//            $sum = $this->getParam('ts_sum', self::TYPE_DOUBLE);
//            $whereStr = $whereStr . sprintf(
//                    ' AND (TS_Sum_Down IS NULL OR TS_Sum_Down<=%u)
//                      AND (TS_Sum_Up IS NULL OR TS_Sum_Up>=%u)',
//                    $sum, $sum);
//        }



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

