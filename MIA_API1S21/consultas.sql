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
#2-state:P
/*Mostrar el nombre, apellido de todas las víctimas en cuarentena que
presentaron una efectividad mayor a 5 en el tratamiento “Transfusiones de
sangre”*/

#3-state:P
/*Mostrar el nombre, apellido y dirección de las víctimas fallecidas con más de
tres personas asociadas.*/

#4-state:P
/*Mostrar el nombre y apellido de todas las víctimas en estado “Suspendida”
que tuvieron contacto físico de tipo “Beso” con más de 2 de sus asociados*/

#5-state:P
/*Top 5 de víctimas que más tratamientos se han aplicado del tratamiento
“Oxígeno”*/

#6-state:P
/*Mostrar el nombre, el apellido y la fecha de fallecimiento de todas las
víctimas que se movieron por la dirección “1987 Delphine Well” a los cuales
se les aplicó "Manejo de la presión arterial" como tratamiento*/

#7-state:P
/*Mostrar nombre, apellido y dirección de las víctimas que tienen menos de 2
allegados los cuales hayan estado en un hospital y que se le hayan aplicado
únicamente dos tratamientos*/

#8-state:P
/*Mostrar el número de mes ,de la fecha de la primera sospecha, nombre y
apellido de las víctimas que más tratamientos se han aplicado y las que
menos. (Todo en una sola consulta)*/

#9-state:P
/*Mostrar el porcentaje de víctimas que le corresponden a cada hospital*/

#10-state:P
/*Mostrar el porcentaje del contacto físico más común de cada hospital de la
siguiente manera: nombre de hospital, nombre del contacto físico, porcentaje
de víctimas*/

#-
/**/

#-
/**/
