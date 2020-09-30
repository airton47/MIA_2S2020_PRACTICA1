#script de instrucciones DDL para crear el modelo r elacional

CREATE DATABASE P1_MIA_2S2020;

USE DATABASE P1_MIA_2S2020;


CREATE TABLE REGION(
	id_region int not null AUTO_INCREMENT,
	region varchar(100),
	PRIMARY KEY (id_region)
);

CREATE TABLE CIUDAD(
	id_ciudad int not null AUTO_INCREMENT,
	ciudad varchar(100),
	id_region int,
	CONSTRAINT PK_CIUDAD PRIMARY KEY (id_ciudad),
	CONSTRAINT FK_idregion_ciudad FOREIGN KEY (id_region) REFERENCES REGION(id_region)
);

CREATE TABLE PERSONA(
	id_persona int not null AUTO_INCREMENT,
	tipo char,
	nombre varchar(100),
	correo varchar(100),
	telefono varchar(100),
	fecha_registro date,
	direccion varchar(100),
	id_ciudad int,
	codigo_postal int,
	CONSTRAINT PK_PERSONA PRIMARY KEY (id_persona),
	CONSTRAINT FK_idciudad_persona FOREIGN KEY (id_ciudad) REFERENCES CIUDAD(id_ciudad)
);

CREATE TABLE CATEGORIA_PRODUCTO(
	id_categoria_producto int not null AUTO_INCREMENT,
	categoria_producto varchar(100),
	CONSTRAINT PK_CATEGORIA PRIMARY KEY (id_categoria_producto)
);

CREATE TABLE PRODUCTO(
	id_producto int not null AUTO_INCREMENT,
	producto varchar(100),
	id_categoria_producto int,
	precio_unitario float,
	CONSTRAINT PK_PRODUCTO PRIMARY KEY (id_producto),
	CONSTRAINT FK_idcategoria_producto FOREIGN KEY (id_categoria_producto) REFERENCES CATEGORIA_PRODUCTO(id_categoria_producto)
);

CREATE TABLE COMPANIA(
	id_compania int not null AUTO_INCREMENT,
	nombre_compania varchar(100),
	contacto_compania varchar(100),
	correo_compania varchar(100),
	telefono_compania varchar(100),
	CONSTRAINT PK_COMPANIA PRIMARY KEY (id_compania)
);

CREATE TABLE PEDIDO(
	id_pedido int not null AUTO_INCREMENT,
	id_producto int not null,
	id_persona int not null,
	id_compania int not null,
	cantidad int,
	CONSTRAINT PK_PEDIDO PRIMARY KEY (id_pedido),
	CONSTRAINT FK_idprocuto_pedido FOREIGN KEY (id_producto) REFERENCES PRODUCTO(id_producto),
	CONSTRAINT FK_idcliente_pedico FOREIGN KEY (id_persona) REFERENCES PERSONA(id_persona),
	CONSTRAINT FK_idcompania_pedico FOREIGN KEY (id_compania) REFERENCES COMPANIA(id_compania)
);

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
	direccion varchar,
	ciudad varchar(100),
	codigo_postal int,
	region varchar(100),
	producto varchar(100),
	categoria_producto (100),
	cantidad int,
	precio_unitario float
);


