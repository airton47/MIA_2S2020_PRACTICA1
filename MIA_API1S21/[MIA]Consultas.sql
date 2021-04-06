#CONSULTAS A DB
#P:pending
#DONE: hecho, pero no revisado
#R: hecho y revisado

#1-state:R**
/*Mostrar el nombre del hospital, su dirección y el número de fallecidos por
cada hospital registrado*/
SELECT hospital,ubicacion,count(id_victima) as Numero_fallecidos 
FROM HOSPITAL,UBICACION,VICTIMA,DIRECC_HOSPITAL
WHERE id_ubicacion = DIRECC_HOSPITAL.cod_ubicacion
AND id_hospital = DIRECC_HOSPITAL.cod_hospital
AND id_hospital = VICTIMA.cod_hospital
AND DATE_FORMAT(fecha_muerte,'%Y-%m-%d %H:%i:%s') IS NOT NULL
GROUP BY hospital,ubicacion
ORDER BY hospital
;

#2-state:R*
/*Mostrar el nombre, apellido de todas las víctimas en cuarentena que
presentaron una efectividad mayor a 5 en el tratamiento “Transfusiones de
sangre”*/
SELECT nombre_v as NOMBRE,apellido_v AS APELLIDO
FROM VICTIMA,ESTADO_VICTIMA,TRATAMIENTO,TRATAMIENTO_VICTIMA
WHERE cod_estado = id_estadoVictima
AND id_tratamiento = cod_tratamiento
AND cod_victima = id_victima
AND efectividad_victima > 5
AND tratamiento LIKE 'Transfusiones de sangre'
AND estadoVictima LIKE 'en cuarentena'
ORDER BY nombre_v
;

#3-state:R*
/*Mostrar el nombre, apellido y dirección de las víctimas fallecidas con más de
tres personas asociadas.*/
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

#4-state:R*
/*Mostrar el nombre y apellido de todas las víctimas en estado Sospecha
que tuvieron contacto físico de tipo “Beso” con más de 2 de sus asociados*/
#V1(INCORRECT?)
SELECT DISTINCT nombre_v as NOMBRE,apellido_v AS APELLIDO
,count(cod_asociado) as total
FROM VICTIMA,CONOCIDO,ESTADO_VICTIMA,TIPO_CONTACTO,CONTACTO_VICTIMA
WHERE estadoVictima LIKE 'Sospecha'
AND tipoContacto LIKE 'Beso'
AND cod_tipoContacto = id_tipoContacto
AND id_victima = cod_victima
AND cod_victima = cod_victima_cv
AND cod_asociado = cod_asociado_cv
AND cod_estado = id_estadoVictima
GROUP BY nombre_v,apellido_v
HAVING count(cod_victima_cv) > 2
ORDER BY nombre_v
;
#V2
SELECT nombre_v AS NOMBRE,apellido_v AS APELLIDO
,estadoVictima,tipoContacto 
FROM TIPO_CONTACTO,PERSONA_ASOCIADA,VICTIMA,ESTADO_VICTIMA,CONOCIDO,
    (SELECT cod_victima_cv as victim,cod_asociado_cv as asociated,cod_tipoContacto as contact
    FROM CONTACTO_VICTIMA
    GROUP BY cod_victima_cv,cod_asociado_cv,cod_tipoContacto)T
WHERE estadoVictima LIKE 'Sospecha'
AND contact = 6
AND victim = cod_victima
AND id_tipoContacto = contact
AND asociated = cod_asociado
AND cod_victima = id_victima
AND cod_asociado = id_personaAsociada
AND cod_estado = id_estadoVictima
group by nombre_v,apellido_v,estadoVictima,tipoContacto
HAVING count(id_victima) > 2
;

#5-state:R*
/*Top 5 de víctimas que más tratamientos se han aplicado del tratamiento
“Oxígeno”*/
SELECT nombre_v as NOMBRE,apellido_v AS APELLIDO
,count(id_victima) as total
FROM VICTIMA,TRATAMIENTO,TRATAMIENTO_VICTIMA
WHERE tratamiento LIKE 'Oxígeno'
AND id_victima = cod_victima
AND id_tratamiento = cod_tratamiento
GROUP BY nombre_v,apellido_v
ORDER BY count(id_victima) DESC
LIMIT 5 
;

#6-state:R**
/*Mostrar el nombre, el apellido y la fecha de fallecimiento de todas las
víctimas que se movieron por la dirección “1987 Delphine Well” a los cuales
se les aplicó "Manejo de la presión arterial" como tratamiento*/
SELECT DISTINCT nombre_v as NOMBRE,apellido_v AS APELLIDO,fecha_muerte
FROM VICTIMA,TRATAMIENTO,TRATAMIENTO_VICTIMA,UBICACION_VICTIMA,UBICACION
WHERE UBICACION_VICTIMA.cod_victima = id_victima
AND UBICACION_VICTIMA.cod_ubicacion = id_ubicacion
AND TRATAMIENTO_VICTIMA.cod_victima = id_victima
AND TRATAMIENTO_VICTIMA.cod_tratamiento = id_tratamiento
AND ubicacion LIKE '1987 Delphine Well'
AND tratamiento LIKE 'Manejo de la presión arterial'
#AND DATE_FORMAT(fecha_muerte,'%Y-%m-%d %H:%i:%s') IS NOT NULL
ORDER BY nombre_v
;


#7-state:P
/*Mostrar nombre, apellido y dirección de las víctimas que tienen menos de 2
allegados los cuales hayan estado en un hospital y que se le hayan aplicado
únicamente dos tratamientos*/

#8-state:DONE
/*Mostrar el número de mes ,de la fecha de la primera sospecha, nombre y
apellido de las víctimas que más tratamientos se han aplicado y las que
menos. (Todo en una sola consulta)*/
(SELECT MONTHNAME(fecha_registro) AS MES, nombre_v as NOMBRE,apellido_v AS APELLIDO
,COUNT(id_victima) as TOTAL
FROM VICTIMA,TRATAMIENTO_VICTIMA
WHERE id_victima = cod_victima
GROUP BY fecha_registro,nombre_v,apellido_v ORDER BY COUNT(id_victima) DESC limit 5)
UNION
(SELECT MONTHNAME(fecha_registro) AS MES,nombre_v as NOMBRE,apellido_v AS APELLIDO
,COUNT(id_victima) as TOTAL
FROM VICTIMA,TRATAMIENTO_VICTIMA
WHERE id_victima = cod_victima
GROUP BY fecha_registro,nombre_v,apellido_v ORDER BY COUNT(id_victima) ASC limit 5)
;

#9-state:R*
/*Mostrar el porcentaje de víctimas que le corresponden a cada hospital*/
#V1-TOMANDO EN CUENTA A LAS VICTIMAS SIN HOSPITAL
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
GROUP BY hospital)
;
#V2-SIN TOMAR EN CUENTA LAS VICTIMAS SIN HOSPITAL
(SELECT hospital AS HOSPITAL,
((COUNT(id_victima))/(SELECT COUNT(id_victima) FROM VICTIMA WHERE cod_hospital is not null))*100  as PORCENTAJE
FROM HOSPITAL,VICTIMA
WHERE cod_hospital = id_hospital
GROUP BY hospital);

#10-state:P
/*Mostrar el porcentaje del contacto físico más común de cada hospital de la
siguiente manera: nombre de hospital, nombre del contacto físico, porcentaje
de víctimas*/

#-
/**/

#-
/**/
