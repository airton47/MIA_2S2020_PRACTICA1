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

/*DEFINICION DE DATOS EN TABLA CLIENTE*/
INSERT INTO CLIENTE(nombre,correo,telefono,fecha_registro) (SELECT DISTINCT nombre,correo,telefono,fecha_registro FROM TEMPORAL WHERE tipo = 'C');

/*DEFINICION DE DATOS EN TABLA PROVEEDOR*/
INSERT INTO PROVEEDOR(nombre,correo,telefono,fecha_registro) (SELECT DISTINCT nombre,correo,telefono,fecha_registro FROM TEMPORAL WHERE tipo = 'P');

/*DEFINICION DE CATEGORIAS DE PRODUCTOS*/
INSERT INTO CATEGORIA_PRODUCTO(categoria_producto) (SELECT DISTINCT categoria_producto FROM TEMPORAL);

/*DEFINICION DE LOS PRODUCTOS*/
INSERT INTO PRODUCTO(producto,cod_categoria_producto,precio_unitario) (SELECT DISTINCT producto,CATEGORIA_PRODUCTO.id_categoria_producto,precio_unitario FROM TEMPORAL,CATEGORIA_PRODUCTO WHERE CATEGORIA_PRODUCTO.categoria_producto = TEMPORAL.categoria_producto);

/*DEFINICINO DE COMPANIAS*/
INSERT INTO COMPANIA(nombre_compania,contacto_compania,correo_compania,telefono_compania) (SELECT DISTINCT nombre_compania,contacto_compania,correo_compania,telefono_compania FROM TEMPORAL);

/*DEFINICION DE DATOS EN TABLA COMPRA(CLIENTES)*/
INSERT INTO COMPRA(cod_cliente,cod_compania,cod_ubicacion,total) (SELECT DISTINCT id_cliente,id_compania,id_ubicacion,sum(cantidad*T.precio_unitario) from TEMPORAL AS T,CLIENTE AS CL,COMPANIA AS CO,UBICACION AS U WHERE CL.nombre = T.nombre AND CO.nombre_compania = T.nombre_compania AND U.direccion = T.direccion AND U.codigo_postal = T.codigo_postal and U.ciudad = T.ciudad AND U.region = T.region group by id_cliente,id_compania,id_ubicacion);

/*DEFINICION DE DATOS EN TABLA VENTA(PROVEEDORES)*/
#INSERT INTO VENTA(cod_proveedor,cod_compania,cod_ubicacion) (SELECT DISTINCT id_proveedor,id_compania,id_ubicacion from TEMPORAL AS T,PROVEEDOR AS PV,COMPANIA AS CO,UBICACION AS U WHERE PV.nombre = T.nombre AND CO.nombre_compania = T.nombre_compania AND U.direccion = T.direccion AND U.codigo_postal = T.codigo_postal and U.ciudad = T.ciudad AND U.region = T.region);
INSERT INTO VENTA(cod_proveedor,cod_compania,cod_ubicacion,total) (SELECT DISTINCT id_proveedor,id_compania,id_ubicacion,sum(cantidad*T.precio_unitario) from TEMPORAL AS T,PROVEEDOR AS PV,COMPANIA AS CO,UBICACION AS U WHERE PV.nombre = T.nombre AND CO.nombre_compania = T.nombre_compania AND U.direccion = T.direccion AND U.codigo_postal = T.codigo_postal and U.ciudad = T.ciudad AND U.region = T.region group by id_proveedor,id_compania,id_ubicacion);

/*DEFINICION DE DATOS EN TABLA DETALL_COMPRA(CLIENTES)*/
INSERT INTO DETALLE_COMPRA(cod_compra,cod_producto,cantidad,sub_total) (SELECT id_compra,id_producto,cantidad,(cantidad*T.precio_unitario) FROM TEMPORAL AS T,PRODUCTO AS PR,CLIENTE AS CL,COMPRA AS CP,COMPANIA AS C WHERE PR.producto = T.producto AND T.nombre = CL.nombre AND C.nombre_compania = T.nombre_compania AND CP.cod_cliente = CL.id_cliente AND CP.cod_compania = C.id_compania);

/*DEFINICION DE DATSO EN TABLA DETALLE_VENTA(PROVEEDORES)*/
INSERT INTO DETALLE_VENTA(cod_venta,cod_producto,cantidad,sub_total) (SELECT id_venta,id_producto,cantidad,(cantidad*T.precio_unitario) FROM TEMPORAL AS T,PRODUCTO AS PR,PROVEEDOR AS PV,VENTA AS VN,COMPANIA AS C WHERE PR.producto = T.producto AND T.nombre = PV.nombre AND C.nombre_compania = T.nombre_compania AND VN.cod_proveedor = PV.id_proveedor AND VN.cod_compania = C.id_compania);

/*DEFINICION DE DATOS PARA TABLA DIRECTORIO_CL*/
INSERT INTO DIRECTORIO_CL(cod_ubicacion,cod_cliente) (SELECT distinct id_ubicacion,id_cliente FROM COMPRA,CLIENTE,UBICACION WHERE cod_cliente = id_cliente AND cod_ubicacion = id_ubicacion);

/*DEFINICION DE DATOS PARA TABLA DIRECTORIO_PV*/
INSERT INTO DIRECTORIO_PV(cod_ubicacion,cod_proveedor) (SELECT distinct id_ubicacion,id_proveedor FROM VENTA,PROVEEDOR,UBICACION WHERE cod_proveedor = id_proveedor AND cod_ubicacion = id_ubicacion);
