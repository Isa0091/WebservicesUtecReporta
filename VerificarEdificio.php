<?php
require_once'conectar.php';


if((isset($_REQUEST['idEdificio']))){
	
$idEdificio=$_REQUEST['idEdificio'];

$conectarnos=new conectar();
$respuesta=array();

$procedimiento=$conectarnos->prepare('call verificar_Edificio(:idEdificio)');
$procedimiento->bindParam(':idEdificio',$idEdificio);
$procedimiento->execute();


$registro=$procedimiento->fetch();

$respuesta['Edificiodatos'][]=array("idEdificio"=>$registro['idEdificio'],"nombre"=>$registro['nombre'],"descripcion"=>$registro['descripcion'],"otro"=>$registro['otro']);

print json_encode($respuesta);

}
?>