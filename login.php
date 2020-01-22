<?php
require_once'conectar.php';
header('Content-Type: application/json');
header('Content-Type: text/html; charset=utf-8');


if((isset($_REQUEST['correo'])) & (isset($_REQUEST['pass']))){
	
$correo=$_REQUEST['correo'];
$pass=$_REQUEST['pass'];



$conectarnos=new conectar();
$respuesta=array();

$procedimiento=$conectarnos->prepare('call verificar_usuario(:correo,:pass)');
$procedimiento->bindParam(':correo',$correo);
$procedimiento->bindParam(':pass',$pass);
$procedimiento->execute();


$registro=$procedimiento->fetch();

$respuesta['data']=array("iduser"=>$registro['iduser'],"nombre"=>$registro['nombre'],"apellido"=>$registro['apellido'],"edad"=>$registro['edad'],"genero"=>$registro['genero'],"correo"=>$registro['correo']);


print json_encode($respuesta);

}
?>