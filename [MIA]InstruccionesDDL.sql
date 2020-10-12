#script de instrucciones DDL para crear el modelo r elacional

CREATE DATABASE P1MIA_2S2020;

USE P1MIA_2S2020;

CREATE TABLE TEMPORAL(
	nombre_compania varchar(100),
	contacto_compania varchar(100),
	correo_compania varchar(100),
	telefono_compania varchar(100),
	tipo char,
	nombre varchar(100),
	correo varchar(100),
	telefono varchar(100),
	fecha_registro date,
	direccion varchar(100),
	ciudad varchar(100),
	codigo_postal int,
	region varchar(100),
	producto varchar(100),
	categoria_producto varchar(100),
	cantidad int,
	precio_unitario float
);

CREATE TABLE UBICACION(
	id_ubicacion int not null AUTO_INCREMENT,
	direccion varchar(100),
	codigo_postal int,
	ciudad varchar(100),
	region varchar(100),	
	CONSTRAINT PK_UBICACION PRIMARY KEY(id_ubicacion)
);

CREATE TABLE CLIENTE(
	id_cliente int not null AUTO_INCREMENT,
	nombre varchar(100),
	correo varchar(100),
	telefono varchar(100),
	fecha_registro date,
	CONSTRAINT PK_CLIENTE PRIMARY KEY (id_cliente)
);

CREATE TABLE PROVEEDOR(
	id_proveedor int not null AUTO_INCREMENT,
	nombre varchar(100),
	correo varchar(100),
	telefono varchar(100),
	fecha_registro date,
	CONSTRAINT PK_PROVEEDOR PRIMARY KEY (id_proveedor)
);

CREATE TABLE CATEGORIA_PRODUCTO(
	id_categoria_producto int not null AUTO_INCREMENT,
	categoria_producto varchar(100),
	CONSTRAINT PK_CATEGORIA PRIMARY KEY (id_categoria_producto)
);

CREATE TABLE PRODUCTO(
	id_producto int not null AUTO_INCREMENT,
	producto varchar(100),
	cod_categoria_producto int,
	precio_unitario float,
	CONSTRAINT PK_PRODUCTO PRIMARY KEY (id_producto),
	CONSTRAINT FK_codcategoria_producto FOREIGN KEY (cod_categoria_producto) REFERENCES CATEGORIA_PRODUCTO(id_categoria_producto)
);

CREATE TABLE COMPANIA(
	id_compania int not null AUTO_INCREMENT,
	nombre_compania varchar(100),
	contacto_compania varchar(100),
	correo_compania varchar(100),
	telefono_compania varchar(100),
	CONSTRAINT PK_COMPANIA PRIMARY KEY (id_compania)
);

CREATE TABLE COMPRA(
	id_compra int not null AUTO_INCREMENT,
	cod_cliente int,
	cod_compania int,	
	cod_ubicacion int,
    total float,
	CONSTRAINT PK_COMPRA PRIMARY KEY(id_compra),
	CONSTRAINT FK_codcliente_compra FOREIGN KEY (cod_cliente) REFERENCES CLIENTE(id_cliente),
	CONSTRAINT FK_codcompania_compra FOREIGN KEY(cod_compania) REFERENCES COMPANIA(id_compania),
	CONSTRAINT FK_codubicacion_compra FOREIGN KEY(cod_ubicacion) REFERENCES UBICACION(id_ubicacion)
);

CREATE TABLE DETALLE_COMPRA(
	id_detallecompra int not null AUTO_INCREMENT,
	cod_compra int not null,
	cod_producto int not null,
	cantidad int,
	sub_total float,
	CONSTRAINT PK_DETALLE_COMPRA PRIMARY KEY(id_detallecompra),
	CONSTRAINT FK_codcompra_detallecompra FOREIGN KEY(cod_compra) REFERENCES COMPRA(id_compra),
	CONSTRAINT FK_codproducto_detallecompra FOREIGN KEY(cod_producto) REFERENCES PRODUCTO(id_producto)
);

CREATE TABLE VENTA(
	id_venta int not null AUTO_INCREMENT,
	cod_proveedor int,
	cod_compania int,
	cod_ubicacion int,
	total float,	
	CONSTRAINT PK_VENTA PRIMARY KEY (id_venta),
	CONSTRAINT FK_codproveedor_venta FOREIGN KEY(cod_proveedor) REFERENCES PROVEEDOR(id_proveedor),
	CONSTRAINT FK_cod_compania_venta FOREIGN KEY(cod_compania) REFERENCES COMPANIA(id_compania),
	CONSTRAINT FK_codubicacion_venta FOREIGN key(cod_ubicacion) REFERENCES UBICACION(id_ubicacion)
);

CREATE TABLE DETALLE_VENTA(
	id_detalleventa int not null AUTO_INCREMENT,
	cod_venta int not null,
	cod_producto int not null,
	cantidad int,
	sub_total float,
	CONSTRAINT PK_DETALLEVENTA PRIMARY KEY(id_detalleventa),
	CONSTRAINT FK_codventa_detalleventa FOREIGN KEY(cod_venta) REFERENCES VENTA(id_venta),
	CONSTRAINT FK_codproducto_detalleventa FOREIGN KEY(cod_producto) REFERENCES PRODUCTO(id_producto)

);

CREATE TABLE DIRECTORIO_CL(
	cod_cliente int not null,
	cod_ubicacion int not null,
	CONSTRAINT PK_DIRECTORIO_CL PRIMARY KEY(cod_cliente,cod_ubicacion),
	CONSTRAINT FK_codpersona_directoriocl FOREIGN KEY (cod_cliente) REFERENCES CLIENTE(id_cliente),
	CONSTRAINT PK_codubiacion_directoriocl FOREIGN KEY (cod_ubicacion) REFERENCES UBICACION(id_ubicacion)
);

CREATE TABLE DIRECTORIO_PV(
	cod_proveedor int not null,
	cod_ubicacion int not null,
	CONSTRAINT PK_DIRECTORIO_PV PRIMARY KEY(cod_proveedor,cod_ubicacion),
	CONSTRAINT FK_codpersona_directoriopv FOREIGN KEY (cod_proveedor) REFERENCES PROVEEDOR(id_proveedor),
	CONSTRAINT PK_codubiacion_directoriopv FOREIGN KEY (cod_ubicacion) REFERENCES UBICACION(id_ubicacion)
);


