//Contenido practica uno NodeJS y MYSQL
const express = require('express');
const app = express();

//settings
app.set('port',process.env.PORT || 3000);

//middle
app.use(express.json());

var mysql = require('mysql');
var connection = mysql.createConnection({
    host : 'localhost',
    user : 'root',
    password : 'password',
    database : 'p1mia',
    port : 3306

});

app.get('/',function(req,res){
    res.send('Hello, practica No.1 de Manejo e Implementacion de Archivos!');
});

//END_POINTS

/* Eliminar datos de la tabla temporal */
app.get('/eliminarTemporal',async function(req,res){
    var sql = "DROP TABLE TEMPORAL;";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('Eliminar Temporal exitosa!...');
    })
    res.send('Table "TEMPORAL" eliminada!...');
});

/* Elimina las tablas del modelo de datos  */
app.get('/eliminarModelo',async function(req,res){

    var sql = "DROP TABLE CONTACTO_VICTIMA ;";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('Eliminando modelo..., CONTACTO_VICTIMA eliminado con exito!');
    });

    var sql = "DROP TABLE CONOCIDO ;";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('Eliminando modelo..., CONOCIDO eliminado con exito!');
    });

    var sql = "DROP TABLE TRATAMIENTO_VICTIMA ;";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('Eliminando modelo..., TRATAMIENTO_VICTIMA eliminado con exito!');
    });

    var sql = "DROP TABLE UBICACION_VICTIMA ;";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('Eliminando modelo..., UBICACION_VICTIMA eliminado con exito!');
    });

    var sql = "DROP TABLE VICTIMA ;";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('Eliminando modelo..., VICTIMA eliminado con exito!');
    });

    var sql = "DROP TABLE PERSONA_ASOCIADA ;";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('Eliminando modelo..., PERSONA_ASOCIADA eliminado con exito!');
    });

    var sql = "DROP TABLE ESTADO_VICTIMA ;";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('Eliminando modelo..., ESTADO_VICTIMA eliminado con exito!');
    });

    var sql = "DROP TABLE TIPO_CONTACTO ;";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('Eliminando modelo..., TIPO_CONTACTO eliminado con exito!');
    });

    var sql = "DROP TABLE TRATAMIENTO ;";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('Eliminando modelo..., TRATAMIENTO eliminado con exito!');
    });

    var sql = "DROP TABLE DIRECC_HOSPITAL ;";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('Eliminando modelo..., DIRECC_HOSPITAL eliminado con exito!');
    });

    var sql = "DROP TABLE HOSPITAL ;";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('Eliminando modelo..., HOSPITAL eliminado con exito!');
    });

    var sql = "DROP TABLE UBICACION ;";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('Eliminando modelo..., UBICACION eliminado con exito!');
    });

    res.send('DB "p1mia" eliminada!...');
});

/* Crear tablas del modelo y cargarle los datos  */
app.get('/cargarModelo', async function(req,res){

    /*>>>>>>>>>INICIO DE CREACION DE TABLAS DEL MODELO */
    var sql = "CREATE TABLE UBICACION (\
        id_ubicacion int not null AUTO_INCREMENT,\
        ubicacion varchar(50),\
        CONSTRAINT pk_ubicacion PRIMARY KEY (cod_ubicacion)\
        );";
        var consulta = connection.query(sql,async function(err,result){
            if(err) throw err;
            console.log('CREATE TABLE UBICACION, exitosa!...');
        });

    sql = "CREATE TABLE HOSPITAL(\
        id_hospital int not null AUTO_INCREMENT,\
        hospital varchar(45),\
        CONSTRAINT pk_hospital PRIMARY KEY (id_hospital)\
        );";
        var consulta = connection.query(sql,async function(err,result){
            if(err) throw err;
            console.log('CREATE TABLE HOSPITAL, exitosa!...');
        });

    sql = "CREATE TABLE DIRECC_HOSPITAL (\
        cod_hospital int not null,\
        cod_ubicacion int not null,\
        CONSTRAINT pk_direccHospital PRIMARY KEY (cod_hospital,cod_ubicacion),\
        CONSTRAINT fk_hospital_direcchos FOREIGN KEY (cod_hospital) REFERENCES HOSPITAL (id_hospital),\
        CONSTRAINT fk_ubicacion_direcchos FOREIGN KEY (cod_ubicacion) REFERENCES UBICACION (id_ubicacion)\
        );";
        var consulta = connection.query(sql,async function(err,result){
            if(err) throw err;
            console.log('CREATE TABLE DIRECC_HOSPITAL, exitosa!...');
        });

    sql = "CREATE TABLE TRATAMIENTO(\
        id_tratamiento int not null AUTO_INCREMENT,\
        tratamiento varchar(100),\
        efectividad int,\
        CONSTRAINT pk_tratamiento PRIMARY KEY (id_tratamiento)\
        );";
        var consulta = connection.query(sql,async function(err,result){
            if(err) throw err;
            console.log('CREATE TABLE TRATAMIENTO, exitosa!...');
        });

    sql = "CREATE TABLE TIPO_CONTACTO (\
        id_tipoContacto int not null AUTO_INCREMENT,\
        tipoContacto varchar(45),\
        CONSTRAINT pk_tipoContacto PRIMARY KEY (id_tipoContacto)\
        );";
        var consulta = connection.query(sql,async function(err,result){
            if(err) throw err;
            console.log('CREATE TABLE TIPO_CONTACTO, exitosa!...');
        });

    sql = "CREATE TABLE ESTADO_VICTIMA (\
        id_estadoVictima int not null AUTO_INCREMENT,\
        estadoVictima varchar(45),\
        CONSTRAINT pk_estado PRIMARY KEY (id_estadoVictima)\
        );";
        var consulta = connection.query(sql,async function(err,result){
            if(err) throw err;
            console.log('CREATE TABLE ESTADO_VICTIMA, exitosa!...');
        });

    sql = "CREATE TABLE PERSONA_ASOCIADA (\
        id_personaAsociada int not null AUTO_INCREMENT,\
        nombreAsociado varchar(45),\
        apellidoAsociado varchar(45),\
        CONSTRAINT pk_personaAsociada PRIMARY KEY (id_personaAsociada)\
        );";
        var consulta = connection.query(sql,async function(err,result){
            if(err) throw err;
            console.log('CREATE TABLE PERSONA_ASOCIADA, exitosa!...');
        });

    sql = "CREATE TABLE VICTIMA (\
        id_victima int not null AUTO_INCREMENT,\
        nombre_v varchar(45),\
        apellido_v varchar(45),    \
        fecha_registro datetime,\
        fecha_confirmacion datetime,\
        fecha_muerte datetime,\
        cod_hospital int,\
        cod_direccion int,\
        cod_estado int,\
        CONSTRAINT pk_victima PRIMARY KEY (id_victima),\
        CONSTRAINT fk_estado_victima FOREIGN KEY (cod_estado) REFERENCES ESTADO_VICTIMA (id_estadoVictima),\
        CONSTRAINT fk_hospital_victima FOREIGN KEY (cod_hospital) REFERENCES HOSPITAL (id_hospital),\
        CONSTRAINT fk_ubicacion_victima FOREIGN KEY (cod_direccion) REFERENCES UBICACION (id_ubicacion) \
        );";
        var consulta = connection.query(sql,async function(err,result){
            if(err) throw err;
            console.log('CREATE TABLE VICTIMA, exitosa!...');
        });

    sql = "CREATE TABLE UBICACION_VICTIMA (\
        id_regVicUbi int not null AUTO_INCREMENT,\
        cod_victima int,\
        cod_ubicacion int,\
        fecha_llegada datetime,\
        fecha_retiro datetime,\
        CONSTRAINT pk_ubicacion PRIMARY KEY (id_regVicUbi),\
        CONSTRAINT fk_victima_ubicVictima FOREIGN KEY (cod_victima) REFERENCES VICTIMA (id_victima),\
        CONSTRAINT fk_ubicacion_ubicVictima FOREIGN KEY (cod_ubicacion) REFERENCES UBICACION (id_ubicacion)\
        );";
        var consulta = connection.query(sql,async function(err,result){
            if(err) throw err;
            console.log('CREATE TABLE UBICACION_VICTIMA, exitosa!...');
        });

    sql = "CREATE TABLE TRATAMIENTO_VICTIMA (\
        reg_tratVictima int not null AUTO_INCREMENT,\
        cod_victima int,\
        cod_tratamiento int,\
        efectividad_victima int,\
        fecha_inicio_tratamiento datetime,\
        fecha_fin_tratamiento datetime,\
        CONSTRAINT pk_tratamientoVictima PRIMARY KEY (reg_tratVictima),\
        CONSTRAINT fk_victima_tratVictim FOREIGN KEY (cod_victima) REFERENCES VICTIMA (id_victima),\
        CONSTRAINT fl_tratamiento_tratVitim FOREIGN KEY (cod_tratamiento) REFERENCES TRATAMIENTO (id_tratamiento)\
        );";
        var consulta = connection.query(sql,async function(err,result){
            if(err) throw err;
            console.log('CREATE TABLE TRATAMIENTO_VICTIMA, exitosa!...');
        });

    sql = "CREATE TABLE CONOCIDO (\
        cod_victima int not null,\
        cod_asociado int not null,\
        CONSTRAINT pk_contacto PRIMARY KEY (cod_victima,cod_asociado),\
        CONSTRAINT fk_victima_contacto FOREIGN KEY (cod_victima) REFERENCES VICTIMA (id_victima),\
        CONSTRAINT fk_personaAsociada_contacto FOREIGN KEY (cod_asociado) REFERENCES PERSONA_ASOCIADA (id_personaAsociada)\
        );";
        var consulta = connection.query(sql,async function(err,result){
            if(err) throw err;
            console.log('CREATE TABLE CONOCIDO, exitosa!...');
        });

    sql = "CREATE TABLE CONTACTO_VICTIMA (\
        cod_contactoVic int not null AUTO_INCREMENT,\
        cod_victima_cv int,\
        cod_asociado_cv int,\
        cod_tipoContacto int,\
        fecha_inicio_contacto datetime,\
        fecha_fin_contacto datetime,\
        CONSTRAINT pk_detalle_personaAsociada PRIMARY KEY (cod_contactoVic),\
        CONSTRAINT fk_conocido_contactoVict1 FOREIGN KEY (cod_victima_cv) REFERENCES CONOCIDO (cod_victima),\
        CONSTRAINT fk_conocido_contactoVict2 FOREIGN KEY (cod_asociado_cv) REFERENCES CONOCIDO (cod_asociado),\
        CONSTRAINT fk_tipoContacto_contactoVict FOREIGN KEY (cod_tipoContacto) REFERENCES TIPO_CONTACTO (id_tipoContacto)\
        );";
        var consulta = connection.query(sql,async function(err,result){
            if(err) throw err;
            console.log('CREATE TABLE CONTACTO_VICTIMA, exitosa!...');
        });
    /* FIN DE CREACION DE TABLAS DEL MODELO>>>>>>>>>*/  
    
    /*>>>>>>>>> INICIO DE CARGA DE DATOS A MODELO A PARTIR DE TABLA TEMPORAL */
    sql = "INSERT INTO UBICACION (ubicacion) \
        SELECT DISTINCT DIRECCION_VICTIMA FROM TEMPORAL WHERE DIRECCION_VICTIMA NOT LIKE ''\
        UNION\
        SELECT DISTINCT DIRECCION_HOSPITAL FROM TEMPORAL WHERE DIRECCION_HOSPITAL NOT LIKE ''\
        UNION \
        SELECT DISTINCT UBICACION_VICTIMA FROM TEMPORAL WHERE UBICACION_VICTIMA NOT LIKE '';\
        ";
        var consulta = connection.query(sql,async function(err,result){
            if(err) throw err;
            console.log('INSERT INTO UBICACION exitosa!...');
        });
    
    sql = "INSERT INTO HOSPITAL (hospital) (\
        SELECT DISTINCT NOMBRE_HOSPITAL FROM TEMPORAL \
        WHERE NOMBRE_HOSPITAL NOT LIKE ''\
        );";
        var consulta = connection.query(sql,async function(err,result){
            if(err) throw err;
            console.log('INSERT INTO HOSPITAL, exitosa!...');
        });

    sql = "INSERT INTO DIRECC_HOSPITAL(cod_hospital,cod_ubicacion) (\
        SELECT DISTINCT id_hospital,id_ubicacion FROM HOSPITAL,TEMPORAL,UBICACION\
        WHERE hospital = NOMBRE_HOSPITAL\
        AND DIRECCION_HOSPITAL = ubicacion\
        AND NOMBRE_HOSPITAL != '' AND DIRECCION_HOSPITAL != ''\
        );";
        var consulta = connection.query(sql,async function(err,result){
            if(err) throw err;
            console.log('INSERT INTO DIRECC_HOSPITAL, exitosa!...');
        });

    sql = "INSERT INTO TRATAMIENTO (tratamiento,efectividad) (\
        SELECT DISTINCT TRATAMIENTO, EFECTIVIDAD FROM TEMPORAL WHERE TRATAMIENTO NOT LIKE '' \
        );";
        var consulta = connection.query(sql,async function(err,result){
            if(err) throw err;
            console.log('INSERT INTO TRATAMIENTO, exitosa!...');
        });
        
    sql = "INSERT INTO TIPO_CONTACTO(tipoContacto) (\
        SELECT DISTINCT CONTACTO_FISICO FROM TEMPORAL WHERE CONTACTO_FISICO NOT LIKE ''\
        );";
        var consulta = connection.query(sql,async function(err,result){
            if(err) throw err;
            console.log('INSERT INTO TIPO_CONTACTO, exitosa!...');
        });

    sql = "INSERT INTO PERSONA_ASOCIADA (nombreAsociado, apellidoAsociado) (\
        SELECT DISTINCT NOMBRE_ASOCIADO, APELLIDO_ASOCIADO FROM TEMPORAL \
        WHERE NOMBRE_ASOCIADO NOT LIKE '' AND APELLIDO_ASOCIADO NOT LIKE ''\
        );";
        var consulta = connection.query(sql,async function(err,result){
            if(err) throw err;
            console.log('INSERT INTO PERSONA_ASOCIADA, exitosa!...');
        });

    sql = "INSERT INTO ESTADO_VICTIMA (estadoVictima) (\
        SELECT DISTINCT ESTADO_VICTIMA FROM TEMPORAL WHERE ESTADO_VICTIMA NOT LIKE ''\
        );";
        var consulta = connection.query(sql,async function(err,result){
            if(err) throw err;
            console.log('INSERT INTO ESTADO_VICTIMA, exitosa!...');
        });

    sql = "INSERT INTO VICTIMA (nombre_v,apellido_v,fecha_registro,fecha_confirmacion,\
        fecha_muerte,cod_hospital,cod_direccion,cod_estado)\
            SELECT DISTINCT NOMBRE_VICTIMA,APELLIDO_VICTIMA,\
            DATE_FORMAT(FECHA_PRIMERA_SOSPECHA,'%Y-%m-%d %H:%i:%s'),\
            DATE_FORMAT(FECHA_CONFIRMACION,'%Y-%m-%d %H:%i:%s'),\
            DATE_FORMAT(FECHA_MUERTE,'%Y-%m-%d %H:%i:%s'),\
            id_hospital,id_ubicacion,id_estadoVictima\
            FROM TEMPORAL,UBICACION,ESTADO_VICTIMA,HOSPITAL \
            WHERE NOMBRE_VICTIMA <> '' AND APELLIDO_VICTIMA <> ''\
            AND ubicacion = DIRECCION_VICTIMA\
            AND estadoVictima = TEMPORAL.ESTADO_VICTIMA\
            AND hospital = NOMBRE_HOSPITAL\
            ;";
        var consulta = connection.query(sql,async function(err,result){
            if(err) throw err;
            console.log('INSERT VICTIMA (CON HOSPITAL), exitosa!...');
        });

    sql = "INSERT INTO VICTIMA (nombre_v,apellido_v,fecha_registro,fecha_confirmacion,\
        fecha_muerte,cod_direccion,cod_estado) (\
            SELECT DISTINCT NOMBRE_VICTIMA,APELLIDO_VICTIMA,\
            DATE_FORMAT(FECHA_PRIMERA_SOSPECHA,'%Y-%m-%d %H:%i:%s'),\
            DATE_FORMAT(FECHA_CONFIRMACION,'%Y-%m-%d %H:%i:%s'),\
            DATE_FORMAT(FECHA_MUERTE,'%Y-%m-%d %H:%i:%s'),\
            id_ubicacion,id_estadoVictima\
            FROM TEMPORAL,UBICACION,ESTADO_VICTIMA \
            WHERE NOMBRE_VICTIMA <> '' AND APELLIDO_VICTIMA <> ''\
            AND ubicacion = DIRECCION_VICTIMA\
            AND estadoVictima = TEMPORAL.ESTADO_VICTIMA \
            AND NOMBRE_HOSPITAL = ''\
            );";
        var consulta = connection.query(sql,async function(err,result){
            if(err) throw err;
            console.log('INSERT INTO VICTIMA (SIN HOSPITAL), exitosa!...');
        });

    sql = "INSERT INTO UBICACION_VICTIMA (cod_victima,cod_ubicacion,fecha_llegada,fecha_retiro) (\
        SELECT DISTINCT id_victima,id_ubicacion,\
        STR_TO_DATE(FECHA_LLEGADA,'%Y-%m-%d %H:%i:%s'),\
        STR_TO_DATE(FECHA_RETIRO,'%Y-%m-%d %H:%i:%s')\
        FROM TEMPORAL,UBICACION,VICTIMA\
        WHERE nombre_v = NOMBRE_VICTIMA\
        AND apellido_v = APELLIDO_VICTIMA\
        AND DIRECCION_VICTIMA = ubicacion\
        AND DIRECCION_VICTIMA != ''\
        AND NOMBRE_VICTIMA != ''\
        AND APELLIDO_VICTIMA != ''\
        AND STR_TO_DATE(FECHA_LLEGADA,'%Y-%m-%d %H:%i:%s') is not null AND STR_TO_DATE(FECHA_RETIRO,'%Y-%m-%d %H:%i:%s') is not null\
        );";
        var consulta = connection.query(sql,async function(err,result){
            if(err) throw err;
            console.log('INSERT INTO UBICACION_VICTIMA, exitosa!...');
        });

    sql = "INSERT INTO TRATAMIENTO_VICTIMA (cod_victima,cod_tratamiento,efectividad_victima,\
        fecha_inicio_tratamiento, fecha_fin_tratamiento) (\
            SELECT DISTINCT id_victima, id_tratamiento,EFECTIVIDAD_EN_VICTIMA,\
            DATE_FORMAT(FECHA_INICIO_TRATAMIENTO,'%Y-%m-%d %H:%i:%s'),\
            DATE_FORMAT(FECHA_FIN_TRATAMIENTO,'%Y-%m-%d %H:%i:%s') \
            FROM VICTIMA,TRATAMIENTO,TEMPORAL\
            WHERE NOMBRE_VICTIMA = nombre_v\
            AND APELLIDO_VICTIMA = apellido_v\
            AND TEMPORAL.TRATAMIENTO = TRATAMIENTO.tratamiento\
            AND NOMBRE_VICTIMA != ''\
            AND APELLIDO_VICTIMA != ''\
            AND STR_TO_DATE(FECHA_INICIO_TRATAMIENTO,'%Y-%m-%d %H:%i:%s') is not null \
            AND STR_TO_DATE(FECHA_FIN_TRATAMIENTO,'%Y-%m-%d %H:%i:%s') is not null\
            );";
        var consulta = connection.query(sql,async function(err,result){
            if(err) throw err;
            console.log('INSERT INTO TRATAMIENTO_VICTIMA, exitosa!...');
        });

    sql = "INSERT INTO CONOCIDO (cod_victima,cod_asociado) (\
        SELECT DISTINCT id_victima,id_personaAsociada\
        FROM VICTIMA,PERSONA_ASOCIADA,TEMPORAL\
        WHERE NOMBRE_VICTIMA = nombre_v\
        AND APELLIDO_VICTIMA = apellido_v\
        AND NOMBRE_ASOCIADO = nombreAsociado\
        AND APELLIDO_ASOCIADO = apellidoAsociado\
        AND NOMBRE_VICTIMA != ''\
        AND APELLIDO_VICTIMA != ''\
        AND NOMBRE_ASOCIADO != ''\
        AND APELLIDO_ASOCIADO != ''\
        GROUP BY id_victima,id_personaAsociada\
        );";
        var consulta = connection.query(sql,async function(err,result){
            if(err) throw err;
            console.log('INSERT INTO CONOCIDO, exitosa!...');
        });

    sql = "INSERT INTO CONTACTO_VICTIMA (cod_victima_cv,cod_asociado_cv,cod_tipoContacto,\
        fecha_inicio_contacto,fecha_fin_contacto) (\
        SELECT DISTINCT cod_victima,cod_asociado,id_tipoContacto,\
        DATE_FORMAT(FECHA_INICIO_CONTACTO,'%Y-%m-%d %H:%i:%s'),\
        DATE_FORMAT(FECHA_FIN_CONTACTO,'%Y-%m-%d %H:%i:%s')\
        FROM TEMPORAL,CONOCIDO,VICTIMA,PERSONA_ASOCIADA,TIPO_CONTACTO\
        WHERE NOMBRE_VICTIMA = nombre_v\
            AND APELLIDO_VICTIMA = apellido_v\
            AND NOMBRE_ASOCIADO = nombreAsociado\
            AND APELLIDO_ASOCIADO = apellidoAsociado\
            AND NOMBRE_VICTIMA != ''\
            AND APELLIDO_VICTIMA != ''\
            AND NOMBRE_ASOCIADO != ''\
            AND APELLIDO_ASOCIADO != ''\
            AND TEMPORAL.CONTACTO_FISICO != ''\
            AND cod_victima = id_victima\
            AND cod_asociado = id_personaAsociada\
            AND TIPO_CONTACTO.tipoContacto = TEMPORAL.CONTACTO_FISICO\
            AND STR_TO_DATE(FECHA_INICIO_CONTACTO,'%Y-%m-%d %H:%i:%s') is not null \
            AND STR_TO_DATE(FECHA_FIN_CONTACTO,'%Y-%m-%d %H:%i:%s') is not null\
            );";
        var consulta = connection.query(sql,async function(err,result){
            if(err) throw err;
            console.log('INSERT INTO CONTACTO_VICTIMA, exitosa!...');
        });
    /* FIN DE CARGA DE DATOS A TABLA TEMPORAL>>>>>>>>> */

    res.send('Modelo de Base de Datos creado con Exito!');
    
});

/* Carga masiva de datos a tabla temporal  */
app.get('/cargarTemporal', async function(req,res){

    var sql = "CREATE TABLE TEMPORAL (\
        NOMBRE_VICTIMA varchar(75),\
        APELLIDO_VICTIMA varchar(75),\
        DIRECCION_VICTIMA varchar(75),\
        FECHA_PRIMERA_SOSPECHA datetime,\
        FECHA_CONFIRMACION datetime,\
        FECHA_MUERTE datetime,\
        ESTADO_VICTIMA varchar(75),\
        NOMBRE_ASOCIADO varchar(75),\
        APELLIDO_ASOCIADO varchar(75),\
        FECHA_CONOCIO datetime,\
        CONTACTO_FISICO varchar(75),\
        FECHA_INICIO_CONTACTO datetime,\
        FECHA_FIN_CONTACTO datetime,\
        NOMBRE_HOSPITAL varchar(75),\
        DIRECCION_HOSPITAL varchar(75),\
        UBICACION_VICTIMA varchar(75),\
        FECHA_LLEGADA datetime,\
        FECHA_RETIRO datetime,\
        TRATAMIENTO varchar(75),\
        EFECTIVIDAD int,    \
        FECHA_INICIO_TRATAMIENTO datetime,\
        FECHA_FIN_TRATAMIENTO datetime,\
        EFECTIVIDAD_EN_VICTIMA int);";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
            console.log('Temporary table successfully created!');
    });

    sql = "LOAD DATA\
        LOCAL INFILE '/home/yelstin/Escritorio/USAC_REPOSITORIOS/MIA_2S2020_PRACTICA1/MIA_API1S21/GRAND_VIRUS_EPICENTER.csv'\
        INTO TABLE TEMPORAL\
        CHARACTER SET latin1\
        FIELDS TERMINATED BY ';'\
        LINES TERMINATED BY '\n'\
        IGNORE 1 LINES\
        (NOMBRE_VICTIMA,APELLIDO_VICTIMA,DIRECCION_VICTIMA,@var1,\
        @var2,@var3,ESTADO_VICTIMA,NOMBRE_ASOCIADO,APELLIDO_ASOCIADO,\
        @var4,CONTACTO_FISICO,@var5,@var6,\
        NOMBRE_HOSPITAL,DIRECCION_HOSPITAL,UBICACION_VICTIMA,@var7,@var8,\
        TRATAMIENTO,EFECTIVIDAD,@var9,@var10,\
        EFECTIVIDAD_EN_VICTIMA\
        )\
        set FECHA_PRIMERA_SOSPECHA = STR_TO_DATE (@var1, '%Y-%m-%d %H:%i:%s'),\
            FECHA_CONFIRMACION = STR_TO_DATE (@var2, '%Y-%m-%d %H:%i:%s'),\
            FECHA_MUERTE = STR_TO_DATE (@var3, '%Y-%m-%d %H:%i:%s'),\
            FECHA_CONOCIO = STR_TO_DATE (@var4, '%Y-%m-%d %H:%i:%s'),\
            FECHA_INICIO_CONTACTO = STR_TO_DATE (@var5, '%Y-%m-%d %H:%i:%s'),\
            FECHA_FIN_CONTACTO = STR_TO_DATE (@var6, '%Y-%m-%d %H:%i:%s'),\
            FECHA_LLEGADA = STR_TO_DATE (@var7, '%Y-%m-%d %H:%i:%s'),\
            FECHA_RETIRO = STR_TO_DATE (@var8, '%Y-%m-%d %H:%i:%s'),\
            FECHA_INICIO_TRATAMIENTO = STR_TO_DATE (@var9, '%Y-%m-%d %H:%i:%s'),\
            FECHA_FIN_TRATAMIENTO  = STR_TO_DATE (@var10, '%Y-%m-%d %H:%i:%s');";
    
    var consulta = connection.query(sql,async function(err,result){
        if(err){
            console.log('Error durante la operacion!...');
            res.end('Error, Try again...');
            throw err;
        }else{
            console.log('Carga_de_Temporal exitosa!...');
            res.send('Tabla temporal creada, carga masiva de datos con exito! ');
        }       
    });

});


/* Mostrar consulta 1 */
app.get('/consulta1',async function(req,res){
    var sql = "SELECT hospital,ubicacion,count(id_victima) as Numero_fallecidos \
        FROM HOSPITAL,UBICACION,VICTIMA,DIRECC_HOSPITAL\
        WHERE id_ubicacion = DIRECC_HOSPITAL.cod_ubicacion\
        AND id_hospital = DIRECC_HOSPITAL.cod_hospital\
        AND id_hospital = VICTIMA.cod_hospital\
        AND DATE_FORMAT(fecha_muerte,'%Y-%m-%d %H:%i:%s') IS NOT NULL\
        GROUP BY hospital,ubicacion\
        ORDER BY hospital\
        ;";
    var consulta = connection.query(sql,async function(error,result){
        if(error){
            console.log("Error al conectar sql, exist?...");
            res.end("Error al conectar sql, exist?...");
        }else{
            console.log(JSON.stringify(result));
            res.send(result);
        }
    });
});

/* Mostrar consulta 2 */
app.get('/consulta2',async function(req,res){
    var sql = "SELECT nombre_v as NOMBRE,apellido_v AS APELLIDO\
        FROM VICTIMA,ESTADO_VICTIMA,TRATAMIENTO,TRATAMIENTO_VICTIMA\
        WHERE cod_estado = id_estadoVictima\
        AND id_tratamiento = cod_tratamiento\
        AND cod_victima = id_victima\
        AND efectividad_victima > 5\
        AND tratamiento LIKE 'Transfusiones de sangre'\
        AND estadoVictima LIKE 'en cuarentena'\
        ORDER BY nombre_v\
        ;";
    var consulta = connection.query(sql,async function(error,result){
        if(error){
            console.log("Error al conectar sql, exist?...");
            res.end("Error al conectar sql, exist?...");
        }else{
            console.log(JSON.stringify(result));
            res.send(result);
        }
    });
});

/* Mostrar consulta 3 */
app.get('/consulta3',async function(req,res){
    var sql = "SELECT nombre_v as NOMBRE,apellido_v AS APELLIDO,ubicacion AS UBICACION\
        ,count(cod_asociado) as total\
        FROM VICTIMA,CONOCIDO,PERSONA_ASOCIADA,UBICACION\
        WHERE id_victima = cod_victima\
        AND id_personaAsociada = cod_asociado\
        AND id_ubicacion = cod_direccion\
        AND DATE_FORMAT(fecha_muerte,'%Y-%m-%d %H:%i:%s') IS NOT NULL\
        GROUP BY nombre_v,apellido_v,ubicacion\
        HAVING count(cod_asociado) > 3\
        ORDER BY nombre_v\
        ;";
    var consulta = connection.query(sql,async function(error,result){
        if(error){
            console.log("Error al conectar sql, exist?...");
            res.end("Error al conectar sql, exist?...");
        }else{
            console.log(JSON.stringify(result));
            res.send(result);
        }
    });
});

/* Mostrar consulta 4 */
app.get('/consulta4',async function(req,res){
    var sql = "SELECT nombre_v AS NOMBRE,apellido_v AS APELLIDO\
        ,estadoVictima,tipoContacto \
        FROM TIPO_CONTACTO,PERSONA_ASOCIADA,VICTIMA,ESTADO_VICTIMA,CONOCIDO,\
            (SELECT cod_victima_cv as victim,cod_asociado_cv as asociated,cod_tipoContacto as contact\
            FROM CONTACTO_VICTIMA\
            GROUP BY cod_victima_cv,cod_asociado_cv,cod_tipoContacto)T\
        WHERE estadoVictima LIKE 'Sospecha'\
        AND contact = 6\
        AND victim = cod_victima\
        AND id_tipoContacto = contact\
        AND asociated = cod_asociado\
        AND cod_victima = id_victima\
        AND cod_asociado = id_personaAsociada\
        AND cod_estado = id_estadoVictima\
        group by nombre_v,apellido_v,estadoVictima,tipoContacto\
        HAVING count(id_victima) > 2\
        ;";
    var consulta = connection.query(sql,async function(error,result){
        if(error){
            console.log("Error al conectar sql, exist?...");
            res.end("Error al conectar sql, exist?...");
        }else{
            console.log(JSON.stringify(result));
            res.send(result);
        }
    });
});

/* Mostrar consulta 5 */
app.get('/consulta5',async function(req,res){
    var sql = "SELECT nombre_v as NOMBRE,apellido_v AS APELLIDO\
        ,count(id_victima) as total\
        FROM VICTIMA,TRATAMIENTO,TRATAMIENTO_VICTIMA\
        WHERE tratamiento LIKE 'Oxígeno'\
        AND id_victima = cod_victima\
        AND id_tratamiento = cod_tratamiento\
        GROUP BY nombre_v,apellido_v\
        ORDER BY count(id_victima) DESC\
        LIMIT 5 \
        ;";
    var consulta = connection.query(sql,async function(error,result){
        if(error){
            console.log("Error al conectar sql, exist?...");
            res.end("Error al conectar sql, exist?...");
        }else{
            console.log(JSON.stringify(result));
            res.send(result);
        }
    });
});

/* Mostrar consulta 6 */
app.get('/consulta6',async function(req,res){
    /*Mostrar el nombre, el apellido y la fecha de fallecimiento de todas las
    víctimas que se movieron por la dirección “1987 Delphine Well” a los cuales
    se les aplicó "Manejo de la presión arterial" como tratamiento*/

    var sql = "SELECT DISTINCT nombre_v as NOMBRE,apellido_v AS APELLIDO,fecha_muerte\
        FROM VICTIMA,TRATAMIENTO,TRATAMIENTO_VICTIMA,UBICACION_VICTIMA,UBICACION\
        WHERE UBICACION_VICTIMA.cod_victima = id_victima\
        AND UBICACION_VICTIMA.cod_ubicacion = id_ubicacion\
        AND TRATAMIENTO_VICTIMA.cod_victima = id_victima\
        AND TRATAMIENTO_VICTIMA.cod_tratamiento = id_tratamiento\
        AND tratamiento LIKE 'Manejo de la presión arterial'\
        AND DATE_FORMAT(fecha_muerte,'%Y-%m-%d %H:%i:%s') IS NOT NULL\
        ORDER BY nombre_v\
        ;";
    var consulta = connection.query(sql,async function(error,result){
        if(error){
            console.log("Error al conectar sql, exist?...");
            res.end("Error al conectar sql, exist?...");
        }else{
            console.log(JSON.stringify(result));
            res.send(result);
        }
    });
});

/* Mostrar consulta 7 */
app.get('/consulta7',async function(req,res){
    /*Mostrar nombre, apellido y dirección de las víctimas que tienen menos de 2
    allegados los cuales hayan estado en un hospital y que se le hayan aplicado
    únicamente dos tratamientos*/
    var sql = "";
    var consulta = connection.query(sql,async function(error,result){
        if(error){
            console.log("Error al conectar sql, exist?...");
            res.end("Error al conectar sql, exist?...");
        }else{
            console.log(JSON.stringify(result));
            res.send(result);
        }
    });
});

/* Mostrar consulta 8 */
app.get('/consulta8',async function(req,res){
    /*Mostrar el número de mes ,de la fecha de la primera sospecha, nombre y
    apellido de las víctimas que más tratamientos se han aplicado y las que
    menos. (Todo en una sola consulta)*/
    var sql = "(SELECT nombre_v as NOMBRE,apellido_v AS APELLIDO\
        ,COUNT(id_victima) as TOTAL\
        FROM VICTIMA,TRATAMIENTO_VICTIMA\
        WHERE id_victima = cod_victima\
        GROUP BY nombre_v,apellido_v ORDER BY COUNT(id_victima) DESC limit 5)\
        UNION\
        (SELECT nombre_v as NOMBRE,apellido_v AS APELLIDO\
        ,COUNT(id_victima) as TOTAL\
        FROM VICTIMA,TRATAMIENTO_VICTIMA\
        WHERE id_victima = cod_victima\
        GROUP BY nombre_v,apellido_v ORDER BY COUNT(id_victima) ASC limit 5)\
        ;";
    var consulta = connection.query(sql,async function(error,result){
        if(error){
            console.log("Error al conectar sql, exist?...");
            res.end("Error al conectar sql, exist?...");
        }else{
            console.log(JSON.stringify(result));
            res.send(result);
        }
    });
});

/* Mostrar consulta 9 */
app.get('/consulta9',async function(req,res){
    /*Mostrar el porcentaje de víctimas que le corresponden a cada hospital*/
    var sql = "(SELECT hospital AS HOSPITAL,\
        ((COUNT(id_victima))/(SELECT COUNT(id_victima) FROM VICTIMA WHERE cod_hospital is not null))*100  as PORCENTAJE\
        FROM HOSPITAL,VICTIMA\
        WHERE cod_hospital = id_hospital\
        GROUP BY hospital);";
    var consulta = connection.query(sql,async function(error,result){
        if(error){
            console.log("Error al conectar sql, exist?...");
            res.end("Error al conectar sql, exist?...");
        }else{
            console.log(JSON.stringify(result));
            res.send(result);
        }
    });
});

/* Mostrar consulta 10 */
app.get('/consulta10',async function(req,res){
    /*Mostrar el porcentaje del contacto físico más común de cada hospital de la
    siguiente manera: nombre de hospital, nombre del contacto físico, porcentaje
    de víctimas*/
    var sql = "";
    var consulta = connection.query(sql,async function(error,result){
        if(error){
            console.log("Error al conectar sql, exist?...");
            res.end("Error al conectar sql, exist?...");
        }else{
            console.log(JSON.stringify(result));
            res.send(result);
        }
    });
});

app.listen(app.get('port'),()=>{
    console.log('Server en puerto '+app.get('port'));
});

