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
    private $data = array( /* 'CalculationResult' => 23000 */ );

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

        // $this->data = $this -> getParams();



        /** ---------------------------------------
        $mas = array();
        $mas = $this -> getParams();


        foreach ($mas as $key => $value){
            $mas[$key] = $value;
        }

        foreach ($mas as $key => $value){
            if ($mas['id'] == 1){
                if (strpos($key,'a') !== False){
                    $this -> data[$key] = $value;
                }
            } else {
                if (strpos($key,'b') !== False){
                    $this -> data[$key] = $value;
                }
            }
        }
        */



        /*****
        if ($mas['id'] == 1){
            if (strpos($key,'a') !== False){
                foreach ($mas as $key => $value){
                    $this -> data[$key] = $value;
                }
            }
        } else {
            if (strpos($key,'b') !== False){
                foreach ($mas as $key => $value){
                    $this -> data[$key] = $value;
                }
            }
        }
        */




        /*
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
        */



        //$db = /* Frapi_Database */ ubercalc::getInstance();
        //$sqlStmt = 'SELECT * FROM risks'. ($id > 0 ? ' WHERE risk_id = ' . $id : '');
        //$stm = $db->prepare($sqlStmt);
        //$stm->execute();

        //$this->data = $stm->fetchAll(PDO::FETCH_ASSOC);

/*
        $this->$db = $this->db_connect();
        $this->db_disconnect();

        //$this->data += $this -> $DBH->query("SELECT name FROM kp_description");
        $this->$db->query("SELECT name FROM kp_description WHERE id = '1'");
*/
/*
        try {
            # MySQL через PDO_MYSQL
            $DBH = new PDO("mysql:host='localhost'; dbname='ubercalc'", 'root', '');
        }
        catch(PDOException $e) {
            echo $e->getMessage();
        }
*/
        //$stmt = array();
        $db = new PDO('mysql:host=localhost; dbname=test', 'root', '');
/*
        $stmt = $db->query('SELECT * from kp_description');
        //Установка fetch mode
        //$stmt->setFetchMode(PDO::FETCH_ASSOC);
        $data = $stmt->fetchAll();
*/


        $stmt = $db->prepare("SELECT * FROM kp_description WHERE id=?");

        //$stmt->bindValue(1, $id, PDO::PARAM_INT);
        $stmt->execute(array(1));
        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);






        //$stmt = $DBH->prepare("SELECT * FROM kp_description");
        //$stmt->execute();
        //echo $this->data = $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);



        $this->data = $rows;






        return $this->toArray();



    }

/*
    public function db_connect(){

        $host = 'localhost';
        $database = 'ubercalc';
        $user = 'root';
        $pass = '';

        try {
            # MySQL через PDO_MYSQL
            $DBH = new PDO("mysql:host=$host; dbname=$database", $user, $pass);
        }
        catch(PDOException $e) {
            echo $e->getMessage();
        }
        return $this->$DBH;
    }


    public function db_disconnect(){
        $DBH = null;
    }

*/






}

