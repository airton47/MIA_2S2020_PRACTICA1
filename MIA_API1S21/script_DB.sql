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
    CONSTRAINT pk_hospital PRIMARY KEY (id_hospital)
);

CREATE TABLE DIRECC_HOSPITAL (
    cod_hospital int not null,
    cod_ubicacion int not null,
    CONSTRAINT pk_direccHospital PRIMARY KEY (cod_hospital,cod_ubicacion),
    CONSTRAINT fk_hospital_direcchos FOREIGN KEY (cod_hospital) REFERENCES HOSPITAL (id_hospital),
    CONSTRAINT fk_ubicacion_direcchos FOREIGN KEY (cod_ubicacion) REFERENCES UBICACION (id_ubicacion)
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

CREATE TABLE VICTIMA (
    id_victima int not null AUTO_INCREMENT,
    nombre_v varchar(45),
    apellido_v varchar(45),    
    fecha_registro datetime,
    fecha_confirmacion datetime,
    fecha_muerte datetime,
    cod_hospital int,
    cod_direccion int,
    cod_estado int,
    CONSTRAINT pk_victima PRIMARY KEY (id_victima),
    CONSTRAINT fk_estado_victima FOREIGN KEY (cod_estado) REFERENCES ESTADO_VICTIMA (id_estadoVictima),
    CONSTRAINT fk_hospital_victima FOREIGN KEY (cod_hospital) REFERENCES HOSPITAL (id_hospital),
    CONSTRAINT fk_ubicacion_victima FOREIGN KEY (cod_direccion) REFERENCES UBICACION (id_ubicacion) 
);

/*TABLA QUE CONTIENE LOS REGISTRO DE LOS LUGARES EN DODNDE LA VICTIMA HA ESTADO*/
CREATE TABLE UBICACION_VICTIMA (
    id_regVicUbi int not null AUTO_INCREMENT,
    cod_victima int,
    cod_ubicacion int,
    fecha_llegada datetime,
    fecha_retiro datetime,
    CONSTRAINT pk_ubicacion PRIMARY KEY (id_regVicUbi),
    CONSTRAINT fk_victima_ubicVictima FOREIGN KEY (cod_victima) REFERENCES VICTIMA (id_victima),
    CONSTRAINT fk_ubicacion_ubicVictima FOREIGN KEY (cod_ubicacion) REFERENCES UBICACION (id_ubicacion)
);

/*TABLA CON REGISTOR DE TRATAMIENTOS QUE HAN SIDOS APLICADOS A LA FICTIMA*/
CREATE TABLE TRATAMIENTO_VICTIMA (
    reg_tratVictima int not null AUTO_INCREMENT,
    cod_victima int,
    cod_tratamiento int,
    efectividad_victima int,
    fecha_inicio_tratamiento datetime,
    fecha_fin_tratamiento datetime,
    CONSTRAINT pk_tratamientoVictima PRIMARY KEY (reg_tratVictima),
    CONSTRAINT fk_victima_tratVictim FOREIGN KEY (cod_victima) REFERENCES VICTIMA (id_victima),
    CONSTRAINT fl_tratamiento_tratVitim FOREIGN KEY (cod_tratamiento) REFERENCES TRATAMIENTO (id_tratamiento)
);

#TABLA CON REGISTRO DE CONOCIDO ENTRE ASOCIADO Y VICTIMA
CREATE TABLE CONOCIDO (
    cod_victima int not null,
    cod_asociado int not null,
    CONSTRAINT pk_contacto PRIMARY KEY (cod_victima,cod_asociado),
    CONSTRAINT fk_victima_contacto FOREIGN KEY (cod_victima) REFERENCES VICTIMA (id_victima),
    CONSTRAINT fk_personaAsociada_contacto FOREIGN KEY (cod_asociado) REFERENCES PERSONA_ASOCIADA (id_personaAsociada)
);

#TABLA CON REGISTRO DE CONTACTO FISICO ENTRE VICTIMA Y SUS CONOCIDOS
CREATE TABLE CONTACTO_VICTIMA (
    cod_contactoVic int not null AUTO_INCREMENT,
    cod_victima_cv int,
    cod_asociado_cv int,
    cod_tipoContacto int,
    fecha_inicio_contacto datetime,
    fecha_fin_contacto datetime,
    CONSTRAINT pk_detalle_personaAsociada PRIMARY KEY (cod_contactoVic),
    CONSTRAINT fk_conocido_contactoVict1 FOREIGN KEY (cod_victima_cv) REFERENCES CONOCIDO (cod_victima),
    CONSTRAINT fk_conocido_contactoVict2 FOREIGN KEY (cod_asociado_cv) REFERENCES CONOCIDO (cod_asociado),
    CONSTRAINT fk_tipoContacto_contactoVict FOREIGN KEY (cod_tipoContacto) REFERENCES TIPO_CONTACTO (id_tipoContacto)
);





