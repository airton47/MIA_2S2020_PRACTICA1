create view CANTIDAD_CONTACTO as
	select distinct HOSPITAL.idHOSPITAL as ID, HOSPITAL.NOMBRE as NOMBRE, HOSPITAL.DIRECCION as DIRECCION, CONT.NOM
			, CONT.CONT as CONTACTO, sum(CONT.CANTIDAD) as CANTIDAD from
			(select VICTIMA.idVICTIMA as ID, VICTIMA.HOSPITAL_idHOSPITAL as HID, CONOCIDO.idCONOCIDO
			, VICTIMA.NOMBRE as NOM, VICTIMA.APELLIDO, 
				CONTACTO.NOMBRE as CONT, sum(CONT.CANT) as CANTIDAD from 
			(
			select DETALLE_CONTACTO.CONOCIDO_idCONOCIDO as ID, DETALLE_CONTACTO.CONTACTO_idCONTACTO as CONT
			, count(DETALLE_CONTACTO.CONTACTO_idCONTACTO)  as CANT
			from DETALLE_CONTACTO group by CONOCIDO_idCONOCIDO, CONTACTO_idCONTACTO
			) as CONT, VICTIMA, CONOCIDO, CONTACTO 
			where CONOCIDO.idCONOCIDO = CONT.ID and VICTIMA.idVICTIMA = CONOCIDO.VICTIMA_idVICTIMA
			and CONTACTO.idCONTACTO = CONT.CONT
			group by VICTIMA.NOMBRE, VICTIMA.APELLIDO, CONTACTO.NOMBRE) as CONT, HOSPITAL
			where HOSPITAL.idHOSPITAL = CONT.HID
			group by HOSPITAL.NOMBRE, HOSPITAL.DIRECCION, CONT.CONT;

select distinct res.ID ,res.NOMBRE, res.DIRECCION,cont.CONTACTO as CONT, (res.CANT/tot.CANT)*100 as CANTIDAD from
		(select distinct res.ID as ID, res.NOMBRE as NOMBRE, res.DIRECCION as DIRECCION, max(res.CANTIDAD) as CANT from
		(select * from CANTIDAD_CONTACTO) as res group by res.NOMBRE)as res,
		(select distinct res.NOMBRE, res.CONTACTO as CONTACTO, res.CANTIDAD as CANT from
		(select * from CANTIDAD_CONTACTO) as res group by res.NOMBRE, res.CONTACTO) as CONT,
		(select distinct NOMBRE as NOMBRE, CONTACTO as CONTACTO, sum(CANTIDAD) as CANT from CANTIDAD_CONTACTO group by NOMBRE, DIRECCION) as tot
		where res.NOMBRE = CONT.NOMBRE and res.CANT = CONT.CANT and tot.NOMBRE = res.NOMBRE group by res.NOMBRE, res.DIRECCION

/*
use p1mia;
show tables;
DROP TABLE CONTACTO_VICTIMA ;
DROP TABLE CONOCIDO ;
DROP TABLE TRATAMIENTO_VICTIMA ;
DROP TABLE UBICACION_VICTIMA ;
DROP TABLE VICTIMA ;
DROP TABLE PERSONA_ASOCIADA ;
DROP TABLE ESTADO_VICTIMA ;
DROP TABLE TIPO_CONTACTO ;
DROP TABLE TRATAMIENTO ;
DROP TABLE DIRECC_HOSPITAL ;
DROP TABLE HOSPITAL ;
DROP TABLE UBICACION ;
DROP TABLE TEMPORAL ;

*/