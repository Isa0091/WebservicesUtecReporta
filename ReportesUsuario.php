<?php

require_once('conectar.php');
if(isset($_REQUEST['idusuario'])){
	

	$idusuario=$_REQUEST['idusuario'];
	$json=array();
	
	$conectado= new conectar();
		$sentencia=$conectado->prepare('call reportes_usuario(:idusuario)');
		$sentencia->bindParam(':idusuario',$idusuario);
		
		$insert=$sentencia->execute();

		while($rep=$sentencia->fetch()){
			
			$result['idreporte']=$rep['idimeg'];
			$result['titulo']=$rep['titulo'];
			$result['descripcion']=$rep['descripcion'];
			
			$decode_imagen12 = str_replace('\n', '', $rep['imagen']);	
			
			$result['imagen']=$rep['imagen'];
			$result['tipo']=$rep['tipo'];
			$result['edificio']=$rep['edificio'];
			$result['estado']=$rep['estado'];
			$json['reportes'][]=$result;
		}
		
		echo json_encode($json);
}
else{
	
	
	echo'Error al Enviar el Reporte';
}












?>