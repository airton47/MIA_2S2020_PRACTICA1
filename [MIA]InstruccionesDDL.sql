#script de instrucciones DDL para crear el modelo r elacional

CREATE DATABASE P1_MIA_2S2020;

USE DATABASE P1_MIA_2S2020;



CREATE TABLE CLIENTE(
	id_cliente int not null,
	nombre varchar(100),
	telefono varchar(100),
);

CREATE TABLE COMPANIA();

CREATE TABLE REGION();

CREATE TABLE CATEGORIA();

CREATE TABLE PRODUCTO(
	id_producto int not null,
	producto varchar(100),
	precio_unitario float,
	CONSTRAINT PK_PRODUCTO PRIMARY KEY (id_producto)

);

CREATE TABLE PEDIDO(
	id_pedido int not null,
	id_producto int not null,
	id_cliente int not null,
	id_compania int not null,
	cantidad int not null
	CONSTRAINT PK_PEDIDO PRIMARY KEY (id_pedido),
	CONSTRAINT FK_idprocuto FOREIGN KEY (id_producto) REFERENCES PRODUCTO(id_producto),
	CONSTRAINT FK_idcliente FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente),
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

