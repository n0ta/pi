<?php
/**
* 
*/
class Acceso extends CI_Model
{
	
	function validate()
	{
		$this->db->where('EMAIL_CONTACTO',$this->input->post('email'));
		$this->db->where('PWD',sha1($this->input->post('pwd')));
		$c=$this->db->get('vista_login');
		if ($c->num_rows==1) {
			return true;
		}
	}
}
?>