create database utecinforma
use utecinforma

describe utecinforma
create table edificio(idEdificio int primary key auto_increment, nombre varchar(200), descripcion varchar(300), otro varchar(256) )
create table estados( idestado int primary key auto_increment, nombre varchar(200))

select * from estados
select * from edificio

insert into edificio(nombre,descripcion) value('Francisco Morazan','en honor a francisco morazan');
insert into edificio(nombre,descripcion) value('Benito Juarez','en honor a Benito Juarez');
insert into edificio(nombre,descripcion) value('Simon Bolivar','en honor a Simon Bolivar');

insert into estados(nombre) value('pendiente')
insert into  estados(nombre) value('Proceso')
insert into  estados(nombre) value('Finalizada')

create table usuario(iduser int primary key auto_increment, 
					nombre varchar(128),
                    apellido varchar(128),
                    edad int,
                    genero char,
                    correo varchar(128),
                    pass varchar(256))
    

update reporte set idestado = 1 where idimeg =1
update reporte set idEdificio = 1 where idimeg =1

create table reporte(idimeg int primary key auto_increment,
				 titulo varchar(64),
                 descripcion varchar(64),
                 img_blob longblob,
                 tipo varchar(128),
				  idEdificio int ,
				  idestado int  ,
                 iduser int, foreign key (iduser) references usuario(iduser),
                 )
                 
alter table reporte add  idEdificio int  
alter table reporte add  idestado int  
alter table reporte add  fechaingreso datetime  DEFAULT CURRENT_TIMESTAMP
select * from reporte
               
  Drop procedure      reportes_usuario        
DELIMITER $$ 
create procedure reportes_usuario(iduser int)
begin 						 

select reporte.idimeg,titulo,reporte.descripcion,reporte.img_blob as imagen,tipo,edificio.nombre as edificio,estados.nombre as estado from reporte inner join edificio  on reporte.idEdificio=edificio.idEdificio
inner join estados on reporte.idestado= estados.idestado where reporte.iduser=iduser order by reporte.fechaingreso ;
end

$$ 

select * from reporte

call reportes_usuario (1)

DELIMITER $$ 
create procedure insertar_user(n varchar(128),  apell varchar(128),ed int ,gene char, co varchar(128),pa varchar(128))
begin 						 

insert into usuario(nombre,apellido,edad,genero,correo,pass) values(n,apell,ed,gene,co,md5(pa));
end

$$ 
	
DELIMITER $$
create procedure verificar_usuario(co varchar(128),pa varchar(128))
begin
select * from usuario where correo=co and pass=md5(pa);

end
$$

Drop procedure insertar_reporte

DELIMITER $$ 
create procedure insertar_reporte(titulo1 varchar(128),  foto1 longblob, descripcion1 varchar(128),tipo1 varchar(128), iduser1 int,idEdificior int)
begin 

insert into reporte(titulo,descripcion,img_blob,tipo,iduser,idEdificio,idestado) values(titulo1,descripcion1,foto1,tipo1,iduser1,idEdificior,1);
end
$$ 
call insertar_reporte('prueba',)

create table administrador(iduser int primary key auto_increment, 
					usuario varchar(128),
                    pass varchar(256),
                    roles varchar(256))
					
					
					                    DELIMITER $$
create procedure verificar_admin(co varchar(128),pa varchar(256))
begin
select * from administrador where usuario=co and pass=pa;

end
$$

$$ 

DELIMITER $$
create procedure verificar_Edificio(CodEdificio int)
begin
select * from Edificio where idEdificio=CodEdificio;

end
$$


DELIMITER $$ 
create procedure getimagen_reporte(codigo int)
begin 
select img_blob from reporte where idimeg= codigo;
end
$$ 

drop table ordenanza

create table ordenanza(
					iduserOrdenanza varchar(200) primary key ,
                    pass varchar(1000),
                    nombreordenanza varchar(200),
					idEdificio int, foreign key (idEdificio) references edificio(idEdificio)
                    )
  
  alter table ordenanza add nombreordenanza varchar(200)
  
  select * from ordenanza 
  
  update ordenanza set nombreordenanza="Rafael Pereira"  where iduserOrdenanza='ordenanzaprueba2'
  
  drop table historicoEstado
  update historicoEstado set idreporte=2 where idhistorico=3
  select * from historicoEstado
                    
create table historicoEstado(idhistorico int primary key auto_increment,
		fechaestado datetime  DEFAULT CURRENT_TIMESTAMP,
		 historicoEstado int, foreign key (historicoEstado) references estados(idestado),
         idreporte int, foreign key (idreporte) references reporte(idimeg),
		 iduserOrdenanza varchar(200), foreign key (iduserOrdenanza) references ordenanza(iduserOrdenanza)
         
 )

DELIMITER $$
create procedure verificar_ordenanza(co varchar(128),pa varchar(128))
begin
select * from ordenanza where iduserOrdenanza=co and pass=md5(pa);

end
$$

insert into ordenanza(iduserOrdenanza,pass,idEdificio) values('ordenanzaprueba2',md5('123'),1);
insert into historicoEstado(historicoEstado,idreporte,iduserOrdenanza) values(2,1,'ordenanzaprueba')
update reporte set idestado=2 where idimeg=1

drop procedure reportes_edificio

DELIMITER $$ 
create procedure reportes_edificio(idEdificio int)
begin 						 

select reporte.idimeg,estados.idestado,titulo,reporte.descripcion,reporte.img_blob as imagen,tipo,edificio.nombre as edificio, estados.nombre as estado,case  when estados.idestado= 1 then '' else   case  when estados.idestado= 2 then ordenanza.iduserOrdenanza else ordenanza.iduserOrdenanza end  end  as ordenanza, case  when estados.idestado= 1 then '' else   case  when estados.idestado= 2 then ordenanza.nombreordenanza else ordenanza.nombreordenanza end  end  as nombreordenanza from reporte inner join edificio  on reporte.idEdificio=edificio.idEdificio
inner join estados on reporte.idestado= estados.idestado left outer join historicoEstado on historicoEstado.idreporte=reporte.idimeg  left outer join estados as est on historicoEstado.historicoEstado= est.idestado left outer join ordenanza on historicoEstado.iduserOrdenanza =ordenanza.iduserOrdenanza  where reporte.idEdificio=1 group by  reporte.idimeg,titulo,reporte.descripcion,imagen,tipo,edificio order by reporte.fechaingreso;
end

$$ 


DELIMITER $$ 
create procedure reportes_ProcesoUsuario(iduserordenanza varchar(200))
begin 						 
select reporte.idimeg,estados.idestado,titulo,reporte.descripcion,reporte.img_blob as imagen,tipo,edificio.nombre as edificio, estados.nombre as estado,case  when estados.idestado= 1 then '' else   case  when estados.idestado= 2 then ordenanza.iduserOrdenanza else ordenanza.iduserOrdenanza end  end  as ordenanza, case  when estados.idestado= 1 then '' else   case  when estados.idestado= 2 then ordenanza.nombreordenanza else ordenanza.nombreordenanza end  end  as nombreordenanza from reporte inner join edificio  on reporte.idEdificio=edificio.idEdificio
inner join estados on reporte.idestado= estados.idestado inner  join historicoEstado on historicoEstado.idreporte=reporte.idimeg  inner  join estados as est on historicoEstado.historicoEstado= est.idestado left outer join ordenanza on historicoEstado.iduserOrdenanza =ordenanza.iduserOrdenanza  where ordenanza.iduserOrdenanza ='ordenanzaprueba' group by  reporte.idimeg,titulo,reporte.descripcion,imagen,tipo,edificio order by historicoEstado.fechaestado;
end

$$ 



update reporte set idestado = 1
update reporte set idestado=1 where idimeg 

delete from  historicoEstado where idhistorico in (1,2,3,4,5,6,7,8,9)
select * from historicoEstado

update historicoEstado set idreporte=2 where idhistorico=4

select * from ordenanza

call CambiarEstado(3,'ordenanzaprueba',1)
drop procedure CambiarEstado

DELIMITER $$ 
create procedure CambiarEstado(idreported int , ordenanza varchar(200) , idestadoActual int)
begin 		

declare respuesta int default 0;

CASE  idestadoActual
   WHEN 1 THEN 
     insert into historicoEstado(historicoEstado,idreporte,iduserOrdenanza) values(2,idreported,ordenanza);
	 update reporte set idestado=2 where idimeg=idreported;
     set respuesta=1;
     
   WHEN 2 THEN 
   
    if(exists(select idimeg from reporte inner join historicoEstado on historicoEstado.idreporte=reporte.idimeg  where reporte.idimeg =idreported and historicoEstado.iduserOrdenanza=ordenanza))then
	
      insert into historicoEstado(historicoEstado,idreporte,iduserOrdenanza) values(3,idreported,ordenanza);
	  update reporte set idestado=3 where idimeg=idreported;
      set respuesta=1;
	else 
     set respuesta = 2;
     
	 END IF;
     
END CASE;				 

select respuesta as respuesta ;

end

$$ 


http://192.168.1.11:8080/UtecReporta/Webservices/Reporte.php
select * from usuario
update usuario set correo='j@mail.com' where iduser=1