#script de instrucciones DDL para crear el modelo r elacional

CREATE DATABASE P1_MIA_2S2020;

USE DATABASE P1_MIA_2S2020;



CREATE TABLE CLIENTE();

CREATE TABLE COMPANIA();

CREATE TABLE RESION();

CREATE TABLE PRODUCTO();

CREATE TABLE TEMPORAL(
	nombre_compania varchar(100),
	contacto_compania varchar(100),
	correo_compania varchar(100),
	telefono_compania varchar(100),
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

