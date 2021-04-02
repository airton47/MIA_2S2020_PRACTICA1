#script con instrucciones para la carga de datos

LOAD DATA
LOCAL INFILE '/home/yelstin/Escritorio/USAC_REPOSITORIOS/MIA_2S2020_PRACTICA1/MIA_API1S21/GRAND_VIRUS_EPICENTER.csv'
INTO TABLE TEMPORAL
CHARACTER SET latin1
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(NOMBRE_VICTIMA,APELLIDO_VICTIMA,DIRECCION_VICTIMA,FECHA_PRIMERA_SOSPECHA,
FECHA_CONFIRMACION,FECHA_MUERTE,ESTADO_VICTIMA,NOMBRE_ASOCIADO,APELLIDO_ASOCIADO,
FECHA_CONOCIO,CONTACTO_FISICO,FECHA_INICIO_CONTACTO,FECHA_FIN_CONTACTO,
NOMBRE_HOSPITAL,DIRECCION_HOSPITAL,UBICACION_VICTIMA,FECHA_LLEGADA,FECHA_RETIRO,
TRATAMIENTO,EFECTIVIDAD,FECHA_INICIO_TRATAMIENTO,FECHA_FIN_TRATAMIENTO,
EFECTIVIDAD_EN_VICTIMA
);
/*V2 LOADATA*/
LOAD DATA
LOCAL INFILE '/home/yelstin/Escritorio/USAC_REPOSITORIOS/MIA_2S2020_PRACTICA1/MIA_API1S21/GRAND_VIRUS_EPICENTER.csv'
INTO TABLE TEMPORAL
CHARACTER SET latin1
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(NOMBRE_VICTIMA,APELLIDO_VICTIMA,DIRECCION_VICTIMA,@var1,
@var2,@var3,ESTADO_VICTIMA,NOMBRE_ASOCIADO,APELLIDO_ASOCIADO,
@var4,CONTACTO_FISICO,@var5,@var6,
NOMBRE_HOSPITAL,DIRECCION_HOSPITAL,UBICACION_VICTIMA,@var7,@var8,
TRATAMIENTO,EFECTIVIDAD,@var9,@var10,
EFECTIVIDAD_EN_VICTIMA
)
set FECHA_PRIMERA_SOSPECHA = STR_TO_DATE (@var1, '%Y-%m-%d %H:%i:%s'),
	FECHA_CONFIRMACION = STR_TO_DATE (@var2, '%Y-%m-%d %H:%i:%s'),
	FECHA_MUERTE = STR_TO_DATE (@var3, '%Y-%m-%d %H:%i:%s'),
	FECHA_CONOCIO = STR_TO_DATE (@var4, '%Y-%m-%d %H:%i:%s'),
	FECHA_INICIO_CONTACTO = STR_TO_DATE (@var5, '%Y-%m-%d %H:%i:%s'),
	FECHA_FIN_CONTACTO = STR_TO_DATE (@var6, '%Y-%m-%d %H:%i:%s'),
	FECHA_LLEGADA = STR_TO_DATE (@var7, '%Y-%m-%d %H:%i:%s'),
	FECHA_RETIRO = STR_TO_DATE (@var8, '%Y-%m-%d %H:%i:%s'),
	FECHA_INICIO_TRATAMIENTO = STR_TO_DATE (@var9, '%Y-%m-%d %H:%i:%s'),
	FECHA_FIN_TRATAMIENTO  = STR_TO_DATE (@var10, '%Y-%m-%d %H:%i:%s');

/*UNA ARREGLO PARA FECHAS INVALIDAS*/
SET @@time_zone = 'SYSTEM';#Para setear los el formato de fecha hora
UPDATE TEMPORAL SET FECHA_MUERTE = NULL WHERE CAST(FECHA_MUERTE AS CHAR(20)) = '0000-00-00 00:00:00';


/*DEFINICION DE DATOS TABLA UBICACION*/# **
INSERT INTO UBICACION (ubicacion) 
    SELECT DISTINCT DIRECCION_VICTIMA FROM TEMPORAL WHERE DIRECCION_VICTIMA NOT LIKE ''
    UNION
    SELECT DISTINCT DIRECCION_HOSPITAL FROM TEMPORAL WHERE DIRECCION_HOSPITAL NOT LIKE ''
    UNION 
    SELECT DISTINCT UBICACION_VICTIMA FROM TEMPORAL WHERE UBICACION_VICTIMA NOT LIKE '';

/*DEFINICION DE DATOS TABLA HOSPITAL*/# **
INSERT INTO HOSPITAL (hospital) (
    SELECT DISTINCT NOMBRE_HOSPITAL FROM TEMPORAL 
    WHERE NOMBRE_HOSPITAL NOT LIKE ''
);

/*DEFINICION DE DATOS TABLA DIRECC_HOSPITAL*/
INSERT INTO DIRECC_HOSPITAL(cod_hospital,cod_ubicacion) (
    SELECT DISTINCT id_hospital,id_ubicacion FROM HOSPITAL,TEMPORAL,UBICACION
    WHERE hospital = NOMBRE_HOSPITAL
    AND DIRECCION_HOSPITAL = ubicacion
    AND NOMBRE_HOSPITAL != '' AND DIRECCION_HOSPITAL != ''
);

/*DEFINICION DE DATOS EN TABLA TRATAMIENTO*/#**
INSERT INTO TRATAMIENTO (tratamiento,efectividad) (
    SELECT DISTINCT TRATAMIENTO, EFECTIVIDAD FROM TEMPORAL WHERE TRATAMIENTO NOT LIKE '' 
);

/*DEFINICION DE DATOS EN TABLA TIPO_CONTACTO*/#**
INSERT INTO TIPO_CONTACTO(tipoContacto) (
    SELECT DISTINCT CONTACTO_FISICO FROM TEMPORAL WHERE CONTACTO_FISICO NOT LIKE ''
);

/*DEFINICION DE DATOS EN ESTADO PERSONA_ASOCIADA*/#**
INSERT INTO PERSONA_ASOCIADA (nombreAsociado, apellidoAsociado) (
    SELECT DISTINCT NOMBRE_ASOCIADO, APELLIDO_ASOCIADO FROM TEMPORAL 
    WHERE NOMBRE_ASOCIADO NOT LIKE '' AND APELLIDO_ASOCIADO NOT LIKE ''
);

/*DEFINICION DE DATOS EN ESTADO VICTIMA*/
INSERT INTO ESTADO_VICTIMA (estadoVictima) (
    SELECT DISTINCT ESTADO_VICTIMA FROM TEMPORAL WHERE ESTADO_VICTIMA NOT LIKE ''
);

/*DEFINICION DE DATOS EN VICTIMA*/#**
#para aquellos que  'SI' fueron internados en hospital
INSERT INTO VICTIMA (nombre_v,apellido_v,fecha_registro,fecha_confirmacion,
fecha_muerte,cod_hospital,cod_direccion,cod_estado)
    SELECT DISTINCT NOMBRE_VICTIMA,APELLIDO_VICTIMA,
    DATE_FORMAT(FECHA_PRIMERA_SOSPECHA,'%Y-%m-%d %H:%i:%s'),
    DATE_FORMAT(FECHA_CONFIRMACION,'%Y-%m-%d %H:%i:%s'),
    DATE_FORMAT(FECHA_MUERTE,'%Y-%m-%d %H:%i:%s'),
    id_hospital,id_ubicacion,id_estadoVictima
    FROM TEMPORAL,UBICACION,ESTADO_VICTIMA,HOSPITAL 
    WHERE NOMBRE_VICTIMA <> '' AND APELLIDO_VICTIMA <> ''
    AND ubicacion = DIRECCION_VICTIMA
    AND estadoVictima = TEMPORAL.ESTADO_VICTIMA
    AND hospital = NOMBRE_HOSPITAL
;
#para aquellos que 'NO' fueron internados en hospital
INSERT INTO VICTIMA (nombre_v,apellido_v,fecha_registro,fecha_confirmacion,
fecha_muerte,cod_direccion,cod_estado) (
	SELECT DISTINCT NOMBRE_VICTIMA,APELLIDO_VICTIMA,
    DATE_FORMAT(FECHA_PRIMERA_SOSPECHA,'%Y-%m-%d %H:%i:%s'),
    DATE_FORMAT(FECHA_CONFIRMACION,'%Y-%m-%d %H:%i:%s'),
    DATE_FORMAT(FECHA_MUERTE,'%Y-%m-%d %H:%i:%s'),
    id_ubicacion,id_estadoVictima
    FROM TEMPORAL,UBICACION,ESTADO_VICTIMA 
    WHERE NOMBRE_VICTIMA <> '' AND APELLIDO_VICTIMA <> ''
    AND ubicacion = DIRECCION_VICTIMA
    AND estadoVictima = TEMPORAL.ESTADO_VICTIMA 
    AND NOMBRE_HOSPITAL = ''
);

/*DEFINICION DE DATOS EN TABLA QUE CONTIENE LAS UBICACION EN LAS QUE LA VICTIMA HA ESTADO*/#**
INSERT INTO UBICACION_VICTIMA (cod_victima,cod_ubicacion,fecha_llegada,fecha_retiro) (
	SELECT DISTINCT id_victima,id_ubicacion,
    STR_TO_DATE(FECHA_LLEGADA,'%Y-%m-%d %H:%i:%s'),
    STR_TO_DATE(FECHA_RETIRO,'%Y-%m-%d %H:%i:%s')
	FROM TEMPORAL,UBICACION,VICTIMA
	WHERE nombre_v = NOMBRE_VICTIMA
	AND apellido_v = APELLIDO_VICTIMA
	AND DIRECCION_VICTIMA = ubicacion
    AND DIRECCION_VICTIMA != ''
	AND NOMBRE_VICTIMA != ''
	AND APELLIDO_VICTIMA != ''
	AND STR_TO_DATE(FECHA_LLEGADA,'%Y-%m-%d %H:%i:%s') is not null AND STR_TO_DATE(FECHA_RETIRO,'%Y-%m-%d %H:%i:%s') is not null

);

/*DEFINICION DE DATOS EN TRATAMIENTO_VICTIMA*/
INSERT INTO TRATAMIENTO_VICTIMA (cod_victima,cod_tratamiento,efectividad_victima,
fecha_inicio_tratamiento, fecha_fin_tratamiento) (
	SELECT DISTINCT id_victima, id_tratamiento,EFECTIVIDAD_EN_VICTIMA,
	DATE_FORMAT(FECHA_INICIO_TRATAMIENTO,'%Y-%m-%d %H:%i:%s'),
	DATE_FORMAT(FECHA_FIN_TRATAMIENTO,'%Y-%m-%d %H:%i:%s') 
	FROM VICTIMA,TRATAMIENTO,TEMPORAL
	WHERE NOMBRE_VICTIMA = nombre_v
	AND APELLIDO_VICTIMA = apellido_v
	AND TEMPORAL.TRATAMIENTO = TRATAMIENTO.tratamiento
	AND NOMBRE_VICTIMA != ''
	AND APELLIDO_VICTIMA != ''
	AND STR_TO_DATE(FECHA_INICIO_TRATAMIENTO,'%Y-%m-%d %H:%i:%s') is not null 
    AND STR_TO_DATE(FECHA_FIN_TRATAMIENTO,'%Y-%m-%d %H:%i:%s') is not null

);

/**/
INSERT INTO CONOCIDO (cod_victima,cod_asociado,fecha_conocido) (
SELECT DISTINCT id_victima,id_personaAsociada,
DATE_FORMAT(FECHA_CONOCIO,'%Y-%m-%d %H:%i:%s')
FROM VICTIMA,PERSONA_ASOCIADA,TEMPORAL
	WHERE NOMBRE_VICTIMA = nombre_v
	AND APELLIDO_VICTIMA = apellido_v
    AND NOMBRE_ASOCIADO = nombreAsociado
    AND APELLIDO_ASOCIADO = apellidoAsociado
	AND NOMBRE_VICTIMA != ''
	AND APELLIDO_VICTIMA != ''
    AND NOMBRE_ASOCIADO != ''
    AND APELLIDO_ASOCIADO != ''
    AND STR_TO_DATE(FECHA_CONOCIO,'%Y-%m-%d %H:%i:%s') is not null
GROUP BY id_victima,id_personaAsociada,DATE_FORMAT(FECHA_CONOCIO,'%Y-%m-%d %H:%i:%s')
    ORDER BY id_victima
);

#PRUEBA DE ERROR EN TABLA DE HOSPITAL CON UBICACION
SELECT DISTINCT NOMBRE_HOSPITAL FROM TEMPORAL WHERE NOMBRE_HOSPITAL NOT LIKE '' ORDER BY NOMBRE_HOSPITAL ASC;
SELECT DISTINCT NOMBRE_HOSPITAL,COUNT(NOMBRE_HOSPITAL), ubicacion FROM UBICACION,TEMPORAL WHERE ubicacion = DIRECCION_HOSPITAL AND NOMBRE_HOSPITAL NOT LIKE '' group by NOMBRE_HOSPITAL, ubicacion having COUNT(NOMBRE_HOSPITAL) ORDER BY NOMBRE_HOSPITAL ASC;
SELECT NOMBRE_HOSPITAL,COUNT(NOMBRE_HOSPITAL) AS TOT FROM TEMPORAL WHERE NOMBRE_HOSPITAL NOT LIKE '' group by NOMBRE_HOSPITAL having COUNT(NOMBRE_HOSPITAL);
