<?php




/**
 * Action Test1 
 * 
 * test_description
 * 
 * @link http://getfrapi.com
 * @author Frapi <frapi@getfrapi.com>
 * @link /test_url_1
 */
class Action_Test1 extends Frapi_Action implements Frapi_Action_Interface
{


    //$link = mysql_connect('localhost','root','');
    //mysql_select_db('bd_name');


    /**
     * Required parameters
     * 
     * @var An array of required parameters.
     */
    protected $requiredParams = array('id');

    /**
     * The data container to use in toArray()
     * 
     * @var A container of data to fill and return in toArray()
     */
    private $data = array( 'CalculationResult' => 23000  );

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
        //$this->data['test_x_1'] = $this->getParam('test_x_1', self::TYPE_OUTPUT);
        //$this->data['test_x_2'] = $this->getParam('test_x_2', self::TYPE_OUTPUT);

        //if ( $data['test_x_1'] == 'hui'){
        //    $data['test_x_2'] = 'pizdec tovarishi!';
        //}

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
        //$reg_data = array();
        //$req_data = $this->getParams();

        //$nameNoCast   = $this->getParam('name');

        //$req_data = $this->getParams();

        //if

        //$this->data['ttt'] = $_GET['ttt'];
        //$this->data['test_x_1'] = $_GET['test_x_1'];
        //$this->data['test_x_2'] = $_GET['test_x_2'];
        //return $this->toArray();

        $id = $this->getParam('id', self::TYPE_INT);
        if ( is_int($id) ){
            if ($id > 10){
                $this->data += array("zzz" => "ccc17");
            } else {
                // $data['ppp'] = 'kis-kis-kis';
                //$data["vv"] = "qqq";
                $this->data += array("zzz" => "ccc17", "45434t43t" => "jdhdfgudfbfg");
            }
            $this->data["id="]=$id;
        }




        //$db = /* Frapi_Database */ ubercalc::getInstance();
        //$sqlStmt = 'SELECT * FROM risks'. ($id > 0 ? ' WHERE risk_id = ' . $id : '');
        //$stm = $db->prepare($sqlStmt);
        //$stm->execute();

        //$this->data = $stm->fetchAll(PDO::FETCH_ASSOC);


        return $this->toArray();



    }











}

