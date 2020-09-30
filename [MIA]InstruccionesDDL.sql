#script de instrucciones DDL para crear el modelo r elacional

CREATE DATABASE P1_MIA_2S2020;

USE DATABASE P1_MIA_2S2020;



CREATE TABLE PERSONA(
	id_persona int not null,
	nombre varchar(100),
	telefono varchar(100),
	PRIMARY KEY (id_)
);


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

CREATE TABLE COMPANIA();

CREATE TABLE CATEGORIA(
	id_categoria not null AUTO_INCREMENT,
	categoria varchar(100),
	CONSTRAINT PK_CATEGORIA PRIMARY KEY (id_categoria)
);

CREATE TABLE PRODUCTO(
	id_producto int not null,
	producto varchar(100),
	id_categoria varchar(100),
	precio_unitario float,
	CONSTRAINT PK_PRODUCTO PRIMARY KEY (id_producto),
	CONSTRAINT FK_idcategoria_producto FOREIGN KEY (id_categoria) REFERENCES CATEGORIA(id_categoria)
);

CREATE TABLE PEDIDO(
	id_pedido int not null,
	id_producto int not null,
	id_persona int not null,
	id_compania int not null,
	cantidad int not null
	CONSTRAINT PK_PEDIDO PRIMARY KEY (id_pedido),
	CONSTRAINT FK_idprocuto FOREIGN KEY (id_producto) REFERENCES PRODUCTO(id_producto),
	CONSTRAINT FK_idcliente FOREIGN KEY (id_persona) REFERENCES CLIENTE(id_persona),
	CONSTRAINT FK_idcompania FOREIGN KEY (id_compania) REFERENCES COMPANIA(id_compania)
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


