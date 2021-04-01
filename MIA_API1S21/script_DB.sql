create database p1mia;

use p1mia;

CREATE TABLE TEMPORAL (
    NOMBRE_VICTIMA varchar(75),
    APELLIDO_VICTIMA varchar(75),
    DIRECCION_VICTIMA varchar(75),
    FECHA_PRIMERA_SOSPECHA datetime,
    FECHA_CONFIRMACION datetime,
    FECHA_MUERTE datetime,
    ESTADO_VICTIMA varchar(75),
    NOMBRE_ASOCIADO varchar(75),
    APELLIDO_ASOCIADO varchar(75),
    FECHA_CONOCIO datetime,
    CONTACTO_FISICO varchar(75),
    FECHA_INICIO_CONTACTO datetime,
    FECHA_FIN_CONTACTO datetime,
    NOMBRE_HOSPITAL varchar(75),
    DIRECCION_HOSPITAL varchar(75),
    UBICACION_VICTIMA varchar(75),
    FECHA_LLEGADA datetime,
    FECHA_RETIRO datetime,
    TRATAMIENTO varchar(75),
    EFECTIVIDAD int,
    FECHA_INICIO_TRATAMIENTO datetime,
    FECHA_FIN_TRATAMIENTO datetime,
    EFECTIVIDAD_EN_VICTIMA int
);

CREATE TABLE UBICACION (
    id_ubicacion int not null AUTO_INCREMENT,
    ubicacion varchar(50),
    CONSTRAINT pk_ubicacion PRIMARY KEY (cod_ubicacion)
);

CREATE TABLE HOSPITAL(
    id_hospital int not null AUTO_INCREMENT,
    hospital varchar(45),
    cod_ubicacion int,
    CONSTRAINT pk_hospital PRIMARY KEY (id_hospital),
    CONSTRAINT fk_ubicacion_hospital FOREIGN KEY (cod_ubicacion) REFERENCES UBICACION (id_ubicacion)
);

CREATE TABLE TRATAMIENTO(
    id_tratamiento int not null AUTO_INCREMENT,
    tratamiento varchar(100),
    efectividad int,
    CONSTRAINT pk_tratamiento PRIMARY KEY (id_tratamiento)
);

CREATE TABLE TIPO_CONTACTO (
    id_tipoContacto int not null AUTO_INCREMENT,
    tipoContacto varchar(45),
    CONSTRAINT pk_tipoContacto PRIMARY KEY (id_tipoContacto)
);

CREATE TABLE ESTADO_VICTIMA (
    id_estadoVictima int not null AUTO_INCREMENT,
    estadoVictima varchar(45),
    CONSTRAINT pk_estado PRIMARY KEY (id_estadoVictima)
);

CREATE TABLE PERSONA_ASOCIADA (
    id_personaAsociada int not null AUTO_INCREMENT,
    nombreAsociado varchar(45),
    apellidoAsociado varchar(45),
    CONSTRAINT pk_personaAsociada PRIMARY KEY (id_personaAsociada)
);

#TABLA CON REGISTRO DE CONTACTO ENTRE ASOCIACO Y VICTIMA
CREATE TABLE CONTACTO (
    cod_victima int not null,
    cod_asociado int not null,
    fecha_contacto datetime,
    CONSTRAINT pk_contacto PRIMARY KEY (cod_victima,cod_asociado)
    CONSTRAINT fk_victima_contacto FOREIGN KEY (cod_victima) REFERENCES VICTIMA (id_victima),
    CONSTRAINT fk_personaAsociada_contacto FOREIGN KEY (cod_asociado) REFERENCES ASOCIACO (id_personaAsociada)
);

CREATE TABLE VICTIMA (
    id_victima int not null AUTO_INCREMENT,
    nombre varchar(45),
    apellido varchar(45),
    cod_estado int,
    fecha_registro datetime,
    facha_muerte datetime,
    cod_hospital int,
    CONSTRAINT pk_victima PRIMARY KEY (id_victima),
    CONSTRAINT fk_estado_victima FOREIGN KEY (cod_estado) REFERENCES ESTADO_VICTIMA (id_estadoVictima)
     CONSTRAINT fk_hospital_victaima FOREIGN KEY (cod_hospital) REFERENCES HOSPITAL (id_hospital)
);

CREATE TABLE DETALLE_VICTIMA_ASOCIADO (
    cod_personaAsociada int not null,
    cod_victima int not null
    inicio_contacto datetime,
    fin_contacto datetime,
    cod_tipoContacto int,
    CONSTRAINT pk_detalle_personaAsociada PRIMARY KEY (cod_personaAsociada,cod_victima),
    CONSTRAINT fk_personaAsociada_detalleVictimaAsociado FOREIGN KEY (cod_personaAsociada),
    CONSTRAINT fk_victima_detalleVictimaAsociada FOREIGN KEY (cod_victima),
    CONSTRAINT fk_tipoContacto_detalleVictimaAsociada FOREIGN KEY (cod_tipoContacto) REFERENCES TIPO_CONTACTO (id_tipoContacto)
);




CREATE TABLE REGISTRO (
    id_registro int not null AUTO_INCREMENT,
    cod_victima int,
    entrada datetime,
    salida datetime
);

