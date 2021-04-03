#CONSULTAS A DB
#P:pending
#DONE: hecho, pero no revisado
#R: hecho y revisado

#1-state:DONE
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

#2-state:DONE
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

#3-state:P
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

#4-state:P
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

#5-state:P
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

#6-state:DONE
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

#7-state:P
/*Mostrar nombre, apellido y dirección de las víctimas que tienen menos de 2
allegados los cuales hayan estado en un hospital y que se le hayan aplicado
únicamente dos tratamientos*/

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
GROUP BY nombre_v,apellido_v ORDER BY COUNT(id_victima) ASC limit 5)
;

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
GROUP BY hospital)
;

#10-state:P
/*Mostrar el porcentaje del contacto físico más común de cada hospital de la
siguiente manera: nombre de hospital, nombre del contacto físico, porcentaje
de víctimas*/

#-
/**/

#-
/**/
