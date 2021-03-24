#script con instrucciones para la carga de datos

LOAD DATA
LOCAL INFILE '/home/yelstin/Escritorio/USAC_REPS/MIA_2S2020_PRACTICA1/DataCenterData.csv'
INTO TABLE TEMPORAL
CHARACTER SET latin1
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(nombre_compania,contacto_compania,correo_compania,telefono_compania,
	tipo,nombre,correo,telefono,@var1,direccion,ciudad,codigo_postal,region,
	producto,categoria_producto,cantidad,precio_unitario)
set fecha_registro = STR_TO_DATE (@var1, '%d/%m/%Y');

/*DEFINICION DE DATOS TABLA UBICACION*/
INSERT INTO UBICACION (direccion,codigo_postal,ciudad,region) (SELECT DISTINCT direccion,codigo_postal,ciudad,region from TEMPORAL);

/*DEFINICION DE DATOS EN TABLA VICTIMA*/
INSERT INTO VICTINA(nombre,correo,telefono,fecha_registro) (SELECT DISTINCT nombre,correo,telefono,fecha_registro FROM TEMPORAL WHERE tipo = 'C');
