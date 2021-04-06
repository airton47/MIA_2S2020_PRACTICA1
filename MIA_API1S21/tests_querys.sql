show databases;
use p1mia;
show tables;
select count(*) from TEMPORAL;
select * from TEMPORAL order by NOMBRE_VICTIMA ASC;
#
SELECT * FROM UBICACION;
SELECT * FROM HOSPITAL;
SELECT * FROM DIRECC_HOSPITAL;
SELECT * FROM TRATAMIENTO;
SELECT * FROM TIPO_CONTACTO;
SELECT * FROM ESTADO_VICTIMA;
SELECT * FROM PERSONA_ASOCIADA;
SELECT * FROM VICTIMA;
SELECT * FROM UBICACION_VICTIMA;
SELECT * FROM TRATAMIENTO_VICTIMA;
SELECT * FROM CONOCIDO;
SELECT * FROM CONTACTO_VICTIMA;

#TRUNCATE VICTIMA;

#
#SET @@time_zone = 'SYSTEM';
#UPDATE TEMPORAL SET FECHA_MUERTE = NULL WHERE DATE_FORMAT('0000-00-00 00:00:00','%d-%m-%Y %H:%i:%s') ;
#UPDATE TEMPORAL SET FECHA_MUERTE = NULL WHERE CAST(FECHA_MUERTE AS CHAR(20)) = '0000-00-00 00:00:00';

SELECT DISTINCT FECHA_PRIMERA_SOSPECHA, CAST(FECHA_PRIMERA_SOSPECHA as DATETIME)
FROM TEMPORAL
WHERE
CAST(FECHA_PRIMERA_SOSPECHA as DATETIME) IS NOT NULL
AND
FECHA_PRIMERA_SOSPECHA = CAST(FECHA_PRIMERA_SOSPECHA as DATETIME);

#CONSULTAS



#1
SELECT hospital,ubicacion,count(id_victima) as Numero_fallecidos 
FROM HOSPITAL,UBICACION,VICTIMA,DIRECC_HOSPITAL
WHERE id_ubicacion = DIRECC_HOSPITAL.cod_ubicacion
AND id_hospital = DIRECC_HOSPITAL.cod_hospital
AND id_hospital = VICTIMA.cod_hospital
AND DATE_FORMAT(fecha_muerte,'%Y-%m-%d %H:%i:%s') IS NOT NULL
GROUP BY hospital,ubicacion
ORDER BY hospital
;

SELECT COUNT(fecha_muerte) FROM VICTIMA
WHERE DATE_FORMAT(fecha_muerte,'%Y-%m-%d %H:%i:%s') IS NOT NULL
;


#3
SELECT nombre_v as NOMBRE,apellido_v AS APELLIDO,ubicacion AS UBICACION
,count(cod_asociado) as total
FROM VICTIMA,CONOCIDO,PERSONA_ASOCIADA,UBICACION
WHERE id_victima = cod_victima
AND id_personaAsociada = cod_asociado
AND id_ubicacion = cod_direccion
AND DATE_FORMAT(fecha_muerte,'%Y-%m-%d %H:%i:%s') IS NOT NULL
GROUP BY nombre_v,apellido_v,ubicacion
HAVING count(cod_asociado) > 3
ORDER BY nombre_v
;
#4
/*Mostrar el nombre y apellido de todas las víctimas en estado “Suspendida”
que tuvieron contacto físico de tipo “Beso” con más de 2 de sus asociados*/

SELECT nombre_v as NOMBRE,apellido_v AS APELLIDO
,count(cod_asociado) as total
FROM VICTIMA,CONOCIDO,ESTADO_VICTIMA,TIPO_CONTACTO,CONTACTO_VICTIMA
WHERE estadoVictima LIKE 'Sospecha'
AND tipoContacto LIKE 'Beso'
AND cod_tipoContacto = id_tipoContacto
AND id_victima = cod_victima
AND cod_victima = cod_victima_cv
AND cod_asociado = cod_asociado_cv
GROUP BY nombre_v,apellido_v
HAVING count(cod_asociado) > 2
ORDER BY nombre_v
;
SELECT * FROM ESTADO_VICTIMA;
SELECT * FROM TIPO_CONTACTO;
#5
/*Top 5 de víctimas que más tratamientos se han aplicado del tratamiento
“Oxígeno”*/
SELECT nombre_v as NOMBRE,apellido_v AS APELLIDO
,count(id_victima) as total
FROM VICTIMA,TRATAMIENTO,TRATAMIENTO_VICTIMA
WHERE tratamiento LIKE 'Manejo de la presion arterial'
AND id_victima = cod_victima
AND id_tratamiento = cod_tratamiento
GROUP BY nombre_v,apellido_v
ORDER BY count(id_victima) DESC
LIMIT 5 
;
SELECT * FROM TRATAMIENTO;
SELECT * FROM TRATAMIENTO_VICTIMA order by cod_victima ;

#6-state:P
/*Mostrar el nombre, el apellido y la fecha de fallecimiento de todas las
víctimas que se movieron por la dirección “1987 Delphine Well” a los cuales
se les aplicó "Manejo de la presión arterial" como tratamiento*/
SELECT DISTINCT nombre_v as NOMBRE,apellido_v AS APELLIDO,fecha_muerte
FROM VICTIMA,TRATAMIENTO,TRATAMIENTO_VICTIMA,UBICACION_VICTIMA,UBICACION
WHERE UBICACION_VICTIMA.cod_victima = id_victima
AND UBICACION_VICTIMA.cod_ubicacion = id_ubicacion
AND TRATAMIENTO_VICTIMA.cod_victima = id_victima
AND TRATAMIENTO_VICTIMA.cod_tratamiento = id_tratamiento
AND tratamiento LIKE 'Manejo de la presión arterial'
AND DATE_FORMAT(fecha_muerte,'%Y-%m-%d %H:%i:%s') IS NOT NULL
ORDER BY nombre_v
;

#8-state:P
/*Mostrar el número de mes ,de la fecha de la primera sospecha, nombre y
apellido de las víctimas que más tratamientos se han aplicado y las que
menos. (Todo en una sola consulta)*/
(SELECT nombre_v as NOMBRE,apellido_v AS APELLIDO
,COUNT(id_victima) as TOTAL
FROM VICTIMA,TRATAMIENTO_VICTIMA
WHERE id_victima = cod_victima
GROUP BY nombre_v,apellido_v ORDER BY COUNT(id_victima) DESC limit 5)
UNION
(SELECT nombre_v as NOMBRE,apellido_v AS APELLIDO
,COUNT(id_victima) as TOTAL
FROM VICTIMA,TRATAMIENTO_VICTIMA
WHERE id_victima = cod_victima
GROUP BY nombre_v,apellido_v ORDER BY COUNT(id_victima) ASC limit 5);

#9-state:P
/*Mostrar el porcentaje de víctimas que le corresponden a cada hospital*/
(SELECT cod_hospital AS HOSPITAL,
(count(id_victima)/(SELECT COUNT(id_victima) FROM VICTIMA))*100 as PORCENTAJE
FROM VICTIMA
WHERE cod_hospital is null
GROUP BY cod_hospital
ORDER BY PORCENTAJE DESC)
union
(SELECT hospital AS HOSPITAL,
((COUNT(id_victima))/(SELECT COUNT(id_victima) FROM VICTIMA))*100  as PORCENTAJE
FROM HOSPITAL,VICTIMA
WHERE cod_hospital = id_hospital
GROUP BY hospital);

#7
/*Mostrar nombre, apellido y dirección de las víctimas que tienen menos de 2
allegados los cuales hayan estado en un hospital y que se le hayan aplicado
únicamente dos tratamientos*/
SELECT NOMBRE,APELLIDO,DIRECCION
FROM (
	SELECT nombre_v as NOMBRE,
    apellido_v as APELLIDO,
    ubicacion as DIRECCION,
    cod_tratamiento as cod
	FROM VICTIMA,UBICACION,TRATAMIENTO_VICTIMA,CONOCIDO
	WHERE id_ubicacion = cod_direccion
	AND id_victima = TRATAMIENTO_VICTIMA.cod_victima
	AND CONOCIDO.cod_victima = id_victima
	GROUP BY nombre_v,apellido_v,ubicacion,cod_tratamiento
	HAVING count(cod_asociado) < 2
)T
GROUP BY NOMBRE,APELLIDO,DIRECCION
HAVING count(cod) = 2
;

#10
SELECT hos2 AS HOSPITAL,ty1 AS TIPO,(maximo2) AS TOTAL FROM
(
	SELECT hos AS hos1,tipo AS ty1,(cuenta) AS cuenta1
	from (
		SELECT hospital AS hos,tipoContacto tipo,COUNT(id_victima) AS cuenta
		FROM HOSPITAL,VICTIMA,CONOCIDO,CONTACTO_VICTIMA,TIPO_CONTACTO
		WHERE id_hospital = cod_hospital
		AND id_victima = cod_victima
		AND cod_victima = cod_victima_cv
		AND cod_asociado = cod_asociado_cv
		AND cod_tipoContacto = id_tipoContacto
		GROUP BY hospital,tipoContacto
	)T
)C1,
(
	SELECT hos AS hos2,MAX(cuenta) AS maximo2
	FROM (
		SELECT hospital AS hos,tipoContacto tipo,COUNT(id_victima) AS cuenta
		FROM HOSPITAL,VICTIMA,CONOCIDO,CONTACTO_VICTIMA,TIPO_CONTACTO
		WHERE id_hospital = cod_hospital
		AND id_victima = cod_victima
		AND cod_victima = cod_victima_cv
		AND cod_asociado = cod_asociado_cv
		AND cod_tipoContacto = id_tipoContacto
		GROUP BY hospital,tipoContacto
	)T
	GROUP BY hos
)C2
WHERE hos1 = hos2 AND cuenta1 = maximo2
GROUP BY hos1,maximo2,ty1
HAVING maximo2 = MAX(maximo2)
;

