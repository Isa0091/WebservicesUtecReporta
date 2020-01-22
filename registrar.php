<?php
 
 error_reporting(0);
 require_once('conectar.php');
 
 
 
 $nombre=$_REQUEST["nombre"];
 $apellido=$_REQUEST["apellido"];
 $edad=$_REQUEST["edad"];
 $genero=$_REQUEST["genero"];
 $correo=$_REQUEST["correo"];
 $pass=$_REQUEST["pass"];
 
 
 $conectarnos = new conectar(); 
 $procedimiento =$conectarnos->prepare('Call insertar_user(:nombre,:apellido,:edad,:genero,:correo,:pass)');
 $procedimiento->bindParam(':nombre',$nombre);
 $procedimiento->bindParam(':apellido',$apellido);
 $procedimiento->bindParam(':edad',$edad);
 $procedimiento->bindParam(':genero',$genero);
 $procedimiento->bindParam(':correo',$correo);
 $procedimiento->bindParam(':pass',$pass);
 
 
 $insertado=$procedimiento->execute();
 if($insertado==1){
	 
	 echo'mensaje":"Registrado Correctamente';
	 
	 
 }else{
	 
	echo'mensaje":"Error al registar';
	 
	 
	 
 }



?>