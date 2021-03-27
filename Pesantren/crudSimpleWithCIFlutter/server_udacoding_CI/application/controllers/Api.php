<?php

class Api extends CI_Controller{

    function __construct(){
        parent::__construct();
        date_default_timezone_set('Asia/Jakarta');
    }

    function getData(){
        $query = $this->db->get('tb_user');
        if($query->num_rows()>0 ){
            $data = array(
                "status" => true,
                "message" => "Success get data",
                "user"=> $query->result()
            );
        } else {
            $data = array(
                "status"=>false,
                "message"=> "Failed get data",
                "user"=>array()
            );
        }
        echo json_encode ($data);
    }

    function getDataUserByAge(){
        $age = $this->input->get('age');
        $query = $this->db->select('*')->from('tb_user')->where('age', $age)->get();


        if($query->num_rows()>0){
            $data = array (
                "status"=>true,
                "message"=>"Success get data",
                "user"=>$query->result(),
            );
        } else {
            $data = array(
                "status"=>false,
                "message"=>"Failed get data",
                "user"=>array(),
            );
        }
        echo json_encode($data);
    }
    
}


?>