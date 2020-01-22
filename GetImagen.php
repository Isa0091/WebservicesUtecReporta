<?php
require_once'conectar.php';


if((isset($_REQUEST['idimagen']))){
	
$idimagen=$_REQUEST['idimagen'];

$conectarnos=new conectar();
$respuesta=array();

$procedimiento=$conectarnos->prepare('call getimagen_reporte(:idimagen)');
$procedimiento->bindParam(':idimagen',$idimagen);
$procedimiento->execute();

$registro=$procedimiento->fetch();
$respuesta['imagendata'][]=array("imagenbase64"=>$registro['img_blob']);

print json_encode($respuesta);

}
?>


