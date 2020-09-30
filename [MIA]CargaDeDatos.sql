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

/*DEFINICION DE REGIONES*/
INSERT INTO REGION (region) (SELECT DISTINCT region FROM TEMPORAL);

/*DEFINICION DE CIUDADES*/
INSERT INTO CIUDAD (ciudad,id_region) (SELECT DISTINCT ciudad,REGION.id_region FROM TEMPORAL,REGION WHERE TEMPORAL.region = REGION.region);

/*DEFINICION DE PERSONAS QUE PUEDEN SER CLIENTES O PROVEEDORES*/
INSERT INTO PERSONA (tipo,nombre,correo,telefono,fecha_registro,direccion,id_ciudad,codigo_postal) (SELECT DISTINCT tipo,nombre,correo,telefono,fecha_registro,direccion,CIUDAD.id_ciudad,codigo_postal FROM TEMPORAL, CIUDAD WHERE CIUDAD.ciudad = TEMPORAL.ciudad);

/*DEFINICION DE CATEGORIAS DE PRODUCTOS*/
INSERT INTO CATEGORIA_PRODUCTO(categoria_producto) (SELECT DISTINCT categoria_producto FROM TEMPORAL);


/*DEFINICION DE LOS PRODUCTOS*/
INSERT INTO PRODUCTO(producto,id_categoria_producto,precio_unitario) (SELECT DISTINCT producto,CATEGORIA_PRODUCTO.id_categoria_producto,precio_unitario FROM TEMPORAL,CATEGORIA_PRODUCTO WHERE CATEGORIA_PRODUCTO.categoria_producto = TEMPORAL.categoria_producto);

/*DEFINICINO DE COMPANIAS*/
INSERT INTO COMPANIA(nombre_compania,contacto_compania,correo_compania,telefono_compania) (SELECT DISTINCT nombre_compania,contacto_compania,correo_compania,telefono_compania FROM TEMPORAL);

/*DEFINICION DE PEDIDOS*/
INSERT INTO PEDIDO(id_producto,id_persona,id_compania,cantidad) (SELECT id_producto,id_persona,id_compania,cantidad FROM TEMPORAL,PERSONA,PRODUCTO,COMPANIA WHERE TEMPORAL.nombre = PERSONA.nombre AND PRODUCTO.producto = TEMPORAL.producto AND COMPANIA.nombre_compania = TEMPORAL.nombre_compania);

