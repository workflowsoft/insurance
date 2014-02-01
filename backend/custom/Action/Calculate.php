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


    /**
     * Поправочные коэффициенты

     */
    public
    $ksd, //
    $kkv, //
    $ka,  //
    $dop_salary_value, //
    $ts_additional_flag, //
    $tariff; //









    /**
     * Required parameters
     * 
     * @var An array of required parameters.
     */
    protected $requiredParams = array();

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

    // тариф по доп. оборудованию
    if ($ts_additional_flag == true){
        $do_tariff = 10 * $ksd * $ka * $kkv;
        $do_sum = round($dop_salary_value * $do_tariff / 100, 2);
        $tariff = $do_sum;
    }

        return $this->toArray();
    }





}

