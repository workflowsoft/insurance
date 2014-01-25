<?php

/**
 * Action Calc 
 * 
 * Выполняет вычисление стоимости страховки
 * исходя из всех введенных пользователем
 * данных
 * 
 * @link http://getfrapi.com
 * @author Frapi <frapi@getfrapi.com>
 * @link /calc/v1
 */
class Action_Calc extends Frapi_Action implements Frapi_Action_Interface
{

    /**
     * Required parameters
     * 
     * @var An array of required parameters.
     */
    protected $requiredParams = array('title');

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
        $this->data['title'] = $this->getParam('title', self::TYPE_OUTPUT);
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
        
        return $this->toArray();

        //  $this->data['jopa'] = $_GET['jopa'];
        //  return $this->toArray();

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


    /*  Frontend    incoming   parameters    */






    /*  Frontend    incoming   parameters    */




    /* Считаем Поправочные коэф. */



    public $ksp = 1;           //  Ксп - коэф. страхового продукта
    public $kf = 1;            //  Кф  - коэф. франшизы
    public $kvs = 1;           //  Квс - коэф. возраста/стажа
    public $kl = 1;            //  Кл  - коэф. количества лиц, допущенных к управлению.
    public $ki =  11;          //  Ки  - коэф. использования ТС
    public $kbm = 11;          //  Кбм - коэф. Бонус-Малус
    public $kps = 1;           //  Кпс - коэф. использования противоугонной системы
    public $kuts = 0;          //  КУТС- коэф. УТС



    /** ---------------------------
    *   KUTS
    */

    public function kuts_values($risk){
        $kuts = 0;

        If (( $risk == $xx1 ) || ( $risk == $xx2 )){
            $kuts = 1.3;
        }
        return $kuts;
    }

    /* ---------------------------- */




    /** ---------------------------
     *   Kf
     */

    public function kf_values(){
        //
        if (($FranshizaFlag == 1) && ($FranshizaPercent == 2) && ($FranshizaFlagValue == 1)){
            //  Либо Эконом до 1 страхового случая, либо для ТС сдающихся в прокат. В таком случае Кф = 1
            $kf = 1;
        } else {
            if ($FranshizaFlagValue == True){
                if ($FranshizaTypeValue == "Безусловная"){ // $FTV
                    switch(True){
                        case (($FTV >= 0.1) && ($FTV <= 0.5)):
                            $kf = 0.95;
                            break;
                        case (($FTV >= 0.6) && ($FTV <= 1)):
                            $kf = 0.9;
                            break;
                        case (($FTV >= 1.1) && ($FTV <= 2)):
                            $kf = 0.85;
                            break;
                        case (($FTV >= 2.1) && ($FTV <= 3)):
                            $kf = 0.8;
                            break;
                        case (($FTV >= 3.1) && ($FTV <= 4)):
                            $kf = 0.75;
                            break;
                        case (($FTV >= 4.1) && ($FTV <= 5)):
                            $kf = 0.7;
                            break;
                        case (($FTV >= 5.1) && ($FTV <= 6)):
                            $kf = 0.65;
                            break;
                        case (($FTV >= 6.1) && ($FTV <= 7)):
                            $kf = 0.6;
                            break;
                        case (($FTV >= 7.1) && ($FTV <= 8)):
                            $kf = 0.55;
                            break;
                    }
                } else {
                    switch(True){
                        case (($FTV >= 0.1) && ($FTV <= 0.5)):
                            $kf = 0.93;
                            break;
                        case (($FTV >= 0.6) && ($FTV <= 1)):
                            $kf = 0.85;
                            break;
                        case (($FTV >= 1.1) && ($FTV <= 2)):
                            $kf = 0.75;
                            break;
                        case (($FTV >= 2.1) && ($FTV <= 3)):
                            $kf = 0.75;
                            break;
                        case (($FTV >= 3.1) && ($FTV <= 4)):
                            $kf = 0.7;
                            break;
                        case (($FTV >= 4.1) && ($FTV <= 5)):
                            $kf = 0.65;
                            break;
                        case (($FTV >= 5.1) && ($FTV <= 6)):
                            $kf = 0.6;
                            break;
                        case (($FTV >= 6.1) && ($FTV <= 7)):
                            $kf = 0.55;
                            break;
                        case (($FTV >= 7.1) && ($FTV <= 8)):
                            $kf = 0.5;
                            break;
                    }
                }
            }
        }
        return $kf;
    }
    /* ---------------------------- */



    /** ---------------------------
     *   Kvs
     */

    public function kvs_values(){
        if ($ldu_num == "Без ограничений"){
            $kvs = 1;
        } elseif ($ldu_num == "Любые лица от 33 лет"){
            $kvs = 1;
        } else {
            if ($TS_OrganisationFlag = False){
                if ($Driver_Age <= 23){
                    switch (True){ // $DriverExp - стаж вождения
                        case (($DriverExp >= 0) && ($FTV <= 2)):
                            $kvs = 1.4;
                            break;
                        case (($DriverExp >= 3) && ($FTV <= 5)):
                            $kvs = 1.3;
                            break;
                    }
                } elseif ($Driver_Age <= 27){
                    switch (True){ // $DriverExp - стаж вождения
                        case (($DriverExp >= 0) && ($FTV <= 2)):
                            $kvs = 1.3;
                            break;
                        case (($DriverExp >= 3) && ($FTV <= 5)):
                            $kvs = 1.1;
                            break;
                        case (($DriverExp >= 6) && ($FTV <= 9)):
                            $kvs = 0.95;
                            break;
                    }

                } elseif ($Driver_Age <= 32){
                    switch (True){ // $DriverExp - стаж вождения
                        case (($DriverExp >= 0) && ($FTV <= 2)):
                            $kvs = 1.2;
                            break;
                        case (($DriverExp >= 3) && ($FTV <= 5)):
                            $kvs = 1.05;
                            break;
                        case (($DriverExp >= 6) && ($FTV <= 9)):
                            $kvs = 0.95;
                            break;
                        case ($DriverExp >= 10):
                            $kvs = 0.8;
                            break;
                    }
                } elseif ($Driver_Age <= 40){
                    switch (True){ // $DriverExp - стаж вождения
                        case (($DriverExp >= 0) && ($FTV <= 2)):
                            $kvs = 1.1;
                            break;
                        case (($DriverExp >= 3) && ($FTV <= 5)):
                            $kvs = 1;
                            break;
                        case (($DriverExp >= 6) && ($FTV <= 9)):
                            $kvs = 0.85;
                            break;
                        case ($DriverExp >= 10):
                            $kvs = 0.8;
                            break;
                    }
                } elseif ($Driver_Age > 40){
                    switch (True){ // $DriverExp - стаж вождения
                        case (($DriverExp >= 0) && ($FTV <= 2)):
                            $kvs = 1.15;
                            break;
                        case (($DriverExp >= 3) && ($FTV <= 5)):
                            $kvs = 1;
                            break;
                        case (($DriverExp >= 6) && ($FTV <= 9)):
                            $kvs = 0.85;
                            break;
                        case ($DriverExp >= 10):
                            $kvs = 0.8;
                            break;
                    }
                }
            }
        }
        return $kvs;
    }

    /* ---------------------------- */


    /** ---------------------------
     *   Kl
     */

    public function kl_values(){
        if ($TS_OrganisationFlag = True){
            $kl = 1;
        } elseif ($ldu_num = "Любые лица от 33 лет"){
            $kl = 1.25
        } else {
            switch ($ldu_num){
                case ("Без ограничений"):
                    $kl = 1.4;
                    break;
                case ("Не более 3-х водителей"):
                    $kl = 1;
                    break;
                case ("4 водителя"):
                    $kl = 1.1;
                    break;
                case ("5 водителей"):
                    $kl = 1.2;
                    break;
            }
        }
    }




   /* ---------------------------- */



'Коэффициент парковости
If TransportForm.CheckBox3.Value = True Then
   If TransportForm.parck.Value = "2-5 ТС" Then
   kp = 0.98
   ElseIf TransportForm.parck.Value = "6-9 ТС" Then
   kp = 0.95
   ElseIf TransportForm.parck.Value = "10 и выше" Then
   kp = 0.9
   End If
Else
kp = 1
End If










/* ---------------------------- */











// EoF

}

