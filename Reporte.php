<?php

require_once('conectar.php');
header('Content-type:bitmap; charset=utf-8');
header('Content-Type: image/jpg; charset=utf-8'); 

if(isset($_REQUEST['titulo']) && isset($_REQUEST['descripcion']) && isset($_REQUEST['imagen']) && isset($_REQUEST['tipo']) && isset($_REQUEST['idusuario']) && isset($_REQUEST['idedificio'])){
	
	
	
	
	$titulo=$_REQUEST['titulo'];
	$descripcion=$_REQUEST['descripcion'];
	$decode_imagen12=$_REQUEST['imagen'];
	$tipo=$_REQUEST['tipo'];
	$idusuario=$_REQUEST['idusuario'];
	$idedificio=$_REQUEST['idedificio'];
	
	$decode_imagen12 = str_replace(' ', '+', $decode_imagen12);	
	
	$conectado= new conectar();
		$sentencia=$conectado->prepare('call insertar_reporte(:titulo,:decode_imagen1,:descripcion,:tipo,:idusuario,:idedificio)');
		$sentencia->bindParam(':titulo',$titulo);
		$sentencia->bindParam(':descripcion',$descripcion);
		$sentencia->bindParam(':decode_imagen1',$decode_imagen12);
		$sentencia->bindParam(':tipo',$tipo);
		$sentencia->bindParam(':idusuario',$idusuario);
	   $sentencia->bindParam(':idedificio',$idedificio);
		
		$insert=$sentencia->execute();
		
		if($insert==1){
			
			
			echo'Reporte Registrado Correctamente';
			
		}else{
			
			echo'Error al Registrar Reporte';
			
			
		}
		
		
		
		
	
	
	
	
	
	
	
	
	
	
	
}
else{
	
	
	echo'Error al Enviar el Reporte';
}












?>


