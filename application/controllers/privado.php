<?php

/**
* Clase principal de Login
*/
class Privado extends CI_Controller
{	
	function index() {
		$this->inicio();
	}

	function inicio() {
		$data['contenido']='bienvenido';
		$this->load->view('tpl/base',$data);
	}	
}
?>