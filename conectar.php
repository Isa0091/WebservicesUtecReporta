<?php

class conectar Extends PDO{
	
	
	private $tipo_base='mysql';
	private $host='localhost';
	private $base='utecinforma';
	private $usuario='root';
	private $contrasena='';
	
	
	public function __construct(){
		
		try{
			
			
			parent::__construct($this->tipo_base.':host='.$this->host.';dbname='.$this->base,$this->usuario,$this->contrasena);
			
			
			
		}catch(PDOException $e){
			
			
			echo'érror al conectar la base';
			exit;
			
			
			
			
		}
		
		
		
	}
	
	
	
	
}




?>