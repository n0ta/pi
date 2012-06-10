<?php

/**
* Clase principal de Login
*/
class Login extends CI_Controller
{
	
	function index() {
		
	}

	function entrar(){
		$this->load->model('acceso');
		$acceso=$this->acceso->validate();
		if ($acceso) {
			$data=array(				
				'is_logged_in' => true
			);			
			$this->session->set_userdata($data);
			redirect('privado/inicio');
		}
		else {
			$this->index();
		}
	}
}

?>