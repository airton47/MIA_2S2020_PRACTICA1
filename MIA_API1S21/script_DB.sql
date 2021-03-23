use p1mia;

CREATE TABLE HOSPITAL(
    id_hospital int not null,
    nombre varchar(45),
    PRIMARY KEY id_hospital
);

CREATE TABLE VICTIMA (
    id_victima int not null,
    nombre varchar(45),
    apellido varhar(45),
    PRIMARY KEY id_victima
);

CREATE TABLE TRATAMIENTO(
    id_tratamiento int not null,
    tratamiento varchar(100),
    PRIMARY KEY id_tratamiento
);