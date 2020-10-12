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
    password : 'root',
    database : 'P1MIA_2S2020',
    port : 3306

});

app.get('/',function(req,res){
    res.send('Hello, practica No.1 de Manejo e Implementacion de Archivos!');
});

/***
 * Crear tablas del modelo y cargarle los datos 
 */
app.get('/cargarModelo', async function(req,res){
    var sql = "CREATE TABLE UBICACION(\
        id_ubicacion int not null AUTO_INCREMENT,\
        direccion varchar(100),\
        codigo_postal int,\
        ciudad varchar(100),\
        region varchar(100),\
        CONSTRAINT PK_UBICACION PRIMARY KEY(id_ubicacion));";
        var consulta = connection.query(sql,async function(err,result){
            if(err) throw err;
            console.log('CREATE TABLE UBICACION exitosa!...');
        })
    sql = "CREATE TABLE CLIENTE(\
        id_cliente int not null AUTO_INCREMENT,\
        nombre varchar(100),\
        correo varchar(100),\
        telefono varchar(100),\
        fecha_registro date,\
        CONSTRAINT PK_CLIENTE PRIMARY KEY (id_cliente));";
        var consulta = connection.query(sql,async function(err,result){
            if(err) throw err;
            console.log('CREATE TABLE CLIENTE exitosa!...');
        })
    sql = "CREATE TABLE PROVEEDOR(\
        id_proveedor int not null AUTO_INCREMENT,\
        nombre varchar(100),\
        correo varchar(100),\
        telefono varchar(100),\
        fecha_registro date,\
        CONSTRAINT PK_PROVEEDOR PRIMARY KEY (id_proveedor));";
        var consulta = connection.query(sql,async function(err,result){
            if(err) throw err;
            console.log('CREATE TABLE PROVEEDOR exitosa!...');
        })
    sql = "CREATE TABLE CATEGORIA_PRODUCTO(\
        id_categoria_producto int not null AUTO_INCREMENT,\
        categoria_producto varchar(100),\
        CONSTRAINT PK_CATEGORIA PRIMARY KEY (id_categoria_producto));";
        var consulta = connection.query(sql,async function(err,result){
            if(err) throw err;
            console.log('CREATE TABLE CATEGORIA_PRODUCTO exitosa!...');
        })
    sql = "CREATE TABLE PRODUCTO(\
        id_producto int not null AUTO_INCREMENT,\
        producto varchar(100),\
        cod_categoria_producto int,\
        precio_unitario float,\
        CONSTRAINT PK_PRODUCTO PRIMARY KEY (id_producto),\
        CONSTRAINT FK_codcategoria_producto FOREIGN KEY (cod_categoria_producto) REFERENCES CATEGORIA_PRODUCTO(id_categoria_producto)\
    );";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('CREATE TABLE CATEGORIA_PRODUCTO exitosa!...');
    })
    sql = "CREATE TABLE COMPANIA(\
        id_compania int not null AUTO_INCREMENT,\
        nombre_compania varchar(100),\
        contacto_compania varchar(100),\
        correo_compania varchar(100),\
        telefono_compania varchar(100),\
        CONSTRAINT PK_COMPANIA PRIMARY KEY (id_compania));";
        var consulta = connection.query(sql,async function(err,result){
            if(err) throw err;
            console.log('CREATE TABLE COMPANIA exitosa!...');
        })
    sql = "CREATE TABLE COMPRA(\
        id_compra int not null AUTO_INCREMENT,\
        cod_cliente int,\
        cod_compania int,\
        cod_ubicacion int,\
        total float,\
        CONSTRAINT PK_COMPRA PRIMARY KEY(id_compra),\
        CONSTRAINT FK_codcliente_compra FOREIGN KEY (cod_cliente) REFERENCES CLIENTE(id_cliente),\
        CONSTRAINT FK_codcompania_compra FOREIGN KEY(cod_compania) REFERENCES COMPANIA(id_compania),\
        CONSTRAINT FK_codubicacion_compra FOREIGN KEY(cod_ubicacion) REFERENCES UBICACION(id_ubicacion)\
    );";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('CREATE TABLE COMPRA exitosa!...');
    });
    sql = "CREATE TABLE VENTA(\
        id_venta int not null AUTO_INCREMENT,\
        cod_proveedor int,\
        cod_compania int,\
        cod_ubicacion int,\
        total float,\
        CONSTRAINT PK_VENTA PRIMARY KEY (id_venta),\
        CONSTRAINT FK_codproveedor_venta FOREIGN KEY(cod_proveedor) REFERENCES PROVEEDOR(id_proveedor),\
        CONSTRAINT FK_cod_compania_venta FOREIGN KEY(cod_compania) REFERENCES COMPANIA(id_compania),\
        CONSTRAINT FK_codubicacion_venta FOREIGN key(cod_ubicacion) REFERENCES UBICACION(id_ubicacion)\
    );";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('CREATE TABLE VENTA exitosa!...');
    });
    
    sql = "CREATE TABLE DIRECTORIO_CL(\
        cod_cliente int not null,\
        cod_ubicacion int not null,\
        CONSTRAINT PK_DIRECTORIO_CL PRIMARY KEY(cod_cliente,cod_ubicacion),\
        CONSTRAINT FK_codpersona_directoriocl FOREIGN KEY (cod_cliente) REFERENCES CLIENTE(id_cliente),\
        CONSTRAINT PK_codubiacion_directoriocl FOREIGN KEY (cod_ubicacion) REFERENCES UBICACION(id_ubicacion)\
    );";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('CREATE TABLE DIRECTORIO_CL exitosa!...');
    })
    sql = "CREATE TABLE DIRECTORIO_PV(\
        cod_proveedor int not null,\
        cod_ubicacion int not null,\
        CONSTRAINT PK_DIRECTORIO_PV PRIMARY KEY(cod_proveedor,cod_ubicacion),\
        CONSTRAINT FK_codpersona_directoriopv FOREIGN KEY (cod_proveedor) REFERENCES PROVEEDOR(id_proveedor),\
        CONSTRAINT PK_codubiacion_directoriopv FOREIGN KEY (cod_ubicacion) REFERENCES UBICACION(id_ubicacion)\
    );";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('CREATE TABLE DIRECTORIO_PV exitosa!...');
    });
    
    sql = "CREATE TABLE DETALLE_COMPRA(\
        id_detallecompra int not null AUTO_INCREMENT,\
        cod_compra int not null,\
        cod_producto int not null,\
        cantidad int,\
        sub_total float,\
        CONSTRAINT PK_DETALLE_COMPRA PRIMARY KEY(id_detallecompra),\
        CONSTRAINT FK_codcompra_detallecompra FOREIGN KEY(cod_compra) REFERENCES COMPRA(id_compra),\
        CONSTRAINT FK_codproducto_detallecompra FOREIGN KEY(cod_producto) REFERENCES PRODUCTO(id_producto)\
    );";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('CREATE TABLE DETALLE_COMPRA exitosa!...');
    });
    
    sql = "CREATE TABLE DETALLE_VENTA(\
        id_detalleventa int not null AUTO_INCREMENT,\
        cod_venta int not null,\
        cod_producto int not null,\
        cantidad int,\
        sub_total float,\
        CONSTRAINT PK_DETALLEVENTA PRIMARY KEY(id_detalleventa),\
        CONSTRAINT FK_codventa_detalleventa FOREIGN KEY(cod_venta) REFERENCES VENTA(id_venta),\
        CONSTRAINT FK_codproducto_detalleventa FOREIGN KEY(cod_producto) REFERENCES PRODUCTO(id_producto)\
    );";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('CREATE TABLE DETALLE_VENTA exitosa!...');
    });
    sql = "INSERT INTO UBICACION (direccion,codigo_postal,ciudad,region) (SELECT DISTINCT direccion,codigo_postal,ciudad,region from TEMPORAL);";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('INSERT INTO UBICACION exitosa!...');
    });
    sql = "INSERT INTO CLIENTE(nombre,correo,telefono,fecha_registro) (SELECT DISTINCT nombre,correo,telefono,fecha_registro FROM TEMPORAL WHERE tipo = 'C');";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('INSERT INTO CLIENTE exitosa!...');
    });
    sql = "INSERT INTO PROVEEDOR(nombre,correo,telefono,fecha_registro) (SELECT DISTINCT nombre,correo,telefono,fecha_registro FROM TEMPORAL WHERE tipo = 'P');";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('INSERT INTO PROVEEDOR exitosa!...');
    });
    sql = "INSERT INTO CATEGORIA_PRODUCTO(categoria_producto) (SELECT DISTINCT categoria_producto FROM TEMPORAL);";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('INSERT INTO CATEGORIA_PRODUCTO exitosa!...');
    });
    sql = "INSERT INTO PRODUCTO(producto,cod_categoria_producto,precio_unitario) (SELECT DISTINCT producto,CATEGORIA_PRODUCTO.id_categoria_producto,precio_unitario FROM TEMPORAL,CATEGORIA_PRODUCTO WHERE CATEGORIA_PRODUCTO.categoria_producto = TEMPORAL.categoria_producto);";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('INSERT INTO PRODUCTO exitosa!...');
    });
    sql = "INSERT INTO COMPANIA(nombre_compania,contacto_compania,correo_compania,telefono_compania) (SELECT DISTINCT nombre_compania,contacto_compania,correo_compania,telefono_compania FROM TEMPORAL);";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('INSERT INTO COMPANIA exitosa!...');
    });
    sql = "INSERT INTO COMPRA(cod_cliente,cod_compania,cod_ubicacion,total) (SELECT DISTINCT id_cliente,id_compania,id_ubicacion,sum(cantidad*T.precio_unitario) from TEMPORAL AS T,CLIENTE AS CL,COMPANIA AS CO,UBICACION AS U WHERE CL.nombre = T.nombre AND CO.nombre_compania = T.nombre_compania AND U.direccion = T.direccion AND U.codigo_postal = T.codigo_postal and U.ciudad = T.ciudad AND U.region = T.region group by id_cliente,id_compania,id_ubicacion);";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('INSERT INTO COMPRA exitosa!...');
    });
    sql = "INSERT INTO VENTA(cod_proveedor,cod_compania,cod_ubicacion,total) (SELECT DISTINCT id_proveedor,id_compania,id_ubicacion,sum(cantidad*T.precio_unitario) from TEMPORAL AS T,PROVEEDOR AS PV,COMPANIA AS CO,UBICACION AS U WHERE PV.nombre = T.nombre AND CO.nombre_compania = T.nombre_compania AND U.direccion = T.direccion AND U.codigo_postal = T.codigo_postal and U.ciudad = T.ciudad AND U.region = T.region group by id_proveedor,id_compania,id_ubicacion);";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('INSERT INTO VENTA exitosa!...');
    });
    sql = "INSERT INTO DETALLE_COMPRA(cod_compra,cod_producto,cantidad,sub_total) (SELECT id_compra,id_producto,cantidad,(cantidad*T.precio_unitario) FROM TEMPORAL AS T,PRODUCTO AS PR,CLIENTE AS CL,COMPRA AS CP,COMPANIA AS C WHERE PR.producto = T.producto AND T.nombre = CL.nombre AND C.nombre_compania = T.nombre_compania AND CP.cod_cliente = CL.id_cliente AND CP.cod_compania = C.id_compania);";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('INSERT INTO DETALLE_COMPRA exitosa!...');
    });
    sql = "INSERT INTO DETALLE_VENTA(cod_venta,cod_producto,cantidad,sub_total) (SELECT id_venta,id_producto,cantidad,(cantidad*T.precio_unitario) FROM TEMPORAL AS T,PRODUCTO AS PR,PROVEEDOR AS PV,VENTA AS VN,COMPANIA AS C WHERE PR.producto = T.producto AND T.nombre = PV.nombre AND C.nombre_compania = T.nombre_compania AND VN.cod_proveedor = PV.id_proveedor AND VN.cod_compania = C.id_compania);";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('INSERT INTO DETALLE_VENTA exitosa!...');
    });
    sql = "INSERT INTO DIRECTORIO_CL(cod_ubicacion,cod_cliente) (SELECT distinct id_ubicacion,id_cliente FROM COMPRA,CLIENTE,UBICACION WHERE cod_cliente = id_cliente AND cod_ubicacion = id_ubicacion);";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('INSERT INTO DIRECTORIO_CL exitosa!...');
    });
    sql = "INSERT INTO DIRECTORIO_PV(cod_ubicacion,cod_proveedor) (SELECT distinct id_ubicacion,id_proveedor FROM VENTA,PROVEEDOR,UBICACION WHERE cod_proveedor = id_proveedor AND cod_ubicacion = id_ubicacion);";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('INSERT INTO DIRECTORIO_PV exitosa!...');
        console.log('Carga de Modelo Terminado!...');
    });


    
    res.send('Modelo de Base de Datos creado con Exito!');
});

app.get('/cargarTemporal', async function(req,res){
    var sql = "CREATE TABLE TEMPORAL(\
        nombre_compania varchar(100),\
        contacto_compania varchar(100),\
        correo_compania varchar(100),\
        telefono_compania varchar(100),\
        tipo char,\
        nombre varchar(100),\
        correo varchar(100),\
        telefono varchar(100),\
        fecha_registro date,\
        direccion varchar(100),\
        ciudad varchar(100),\
        codigo_postal int,\
        region varchar(100),\
        producto varchar(100),\
        categoria_producto varchar(100),\
        cantidad int,\
        precio_unitario float);";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('Creacion_de_Temporal exitosa!...');
    })
    sql = "LOAD DATA\
    LOCAL INFILE '/home/yelstin/Escritorio/USAC_REPS/MIA_2S2020_PRACTICA1/DataCenterData.csv'\
    INTO TABLE TEMPORAL\
    CHARACTER SET latin1\
    FIELDS TERMINATED BY ';'\
    LINES TERMINATED BY '\n'\
    IGNORE 1 LINES\
    (nombre_compania,contacto_compania,correo_compania,telefono_compania,\
        tipo,nombre,correo,telefono,@var1,direccion,ciudad,codigo_postal,region,\
        producto,categoria_producto,cantidad,precio_unitario)\
    set fecha_registro = STR_TO_DATE (@var1, '%d/%m/%Y');";
    var consulta = connection.query(sql,async function(err,result){
        if(err){
            console.log('Error durante la operacion!...');
            res.end('Error, Try again...');
            throw err;
        }else{
            console.log('Carga_de_Temporal exitosa!...');
            res.send('Tabla temporal creada, carga masiva de datos con exito! ');
        }
       
    })
    
});

app.get('/eliminarModelo',async function(req,res){
    var sql = "DROP TABLE DIRECTORIO_PV;";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('EliminarModelo exitosa!...');
    });
    sql = "DROP TABLE DIRECTORIO_CL;";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('EliminarModelo exitosa!...');
    });
    sql = "DROP TABLE DETALLE_VENTA;";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('EliminarModelo exitosa!...');
    });
    sql = "DROP TABLE DETALLE_COMPRA;";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('EliminarModelo exitosa!...');
    });
    sql = "DROP TABLE COMPRA;";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('EliminarModelo exitosa!...');
    });
    sql = "DROP TABLE VENTA;";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('EliminarModelo exitosa!...');
    });
    sql = "DROP TABLE COMPANIA;";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('EliminarModelo exitosa!...');
    });
    sql = "DROP TABLE PRODUCTO;";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('EliminarModelo exitosa!...');
    });
    sql = "DROP TABLE CATEGORIA_PRODUCTO;";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('EliminarModelo exitosa!...');
    });
    sql = "DROP TABLE PROVEEDOR;";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('EliminarModelo exitosa!...');
    });
    sql = "DROP TABLE CLIENTE;";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('EliminarModelo exitosa!...');
    });
    sql = "DROP TABLE UBICACION;";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('EliminarModelo exitosa!...');
    });
    res.send('DB "P1MIA_2S2020" eliminada!...');
});

app.get('/eliminarTemporal',async function(req,res){
    var sql = "DROP TABLE TEMPORAL;";
    var consulta = connection.query(sql,async function(err,result){
        if(err) throw err;
        console.log('EminiarTemporal exitosa!...');
    })
    res.send('Table "TEMPORAL" eliminada!...');
});

app.get('/consulta1',async function(req,res){
    var sql = "select nombre AS Proveedor,telefono,id_venta as Numero_venta,total as Total from VENTA,PROVEEDOR where total = (select max(total) from VENTA) and cod_proveedor = id_proveedor;";
    var consulta = connection.query(sql,async function(error,result){
        if(error){
            console.log("Error al conectar sql, exit?...");
            res.end("Error al conectar sql, exist?...");
        }else{
            console.log(JSON.stringify(result));
            res.send(result);
        }
    })
    
});

app.get('/consulta2',async function(req,res){
    var sql = "select cod_cliente,nombre,sum(cantidad),sum(total) from DETALLE_COMPRA,COMPRA,CLIENTE where id_cliente = cod_cliente and cod_compra = id_compra group by cod_cliente,nombre having sum(cantidad) =(select max(sumatoria) from (select sum(cantidad) as sumatoria from DETALLE_COMPRA,COMPRA,CLIENTE where id_cliente = cod_cliente and cod_compra = id_compra group by cod_cliente)T);";
    var consulta = connection.query(sql,async function(error,result){
        if(error){
            console.log("Error al conectar sql, exit?...");
            res.end("Error al conectar sql, exist?...");
        }else{
            console.log(JSON.stringify(result));
            res.send(result);
        }
    })
});

app.get('/consulta3',async function(req,res){
    var sql = "(select direccion,region,ciudad,codigo_postal,count(cod_ubicacion) from UBICACION,VENTA where id_ubicacion = cod_ubicacion group by cod_ubicacion having count(cod_ubicacion) = (select max(sumatoria) from (select count(cod_ubicacion) as sumatoria from VENTA group by cod_ubicacion)T))\
    union\
    (select direccion,region,ciudad,codigo_postal,count(cod_ubicacion) from UBICACION,VENTA where id_ubicacion = cod_ubicacion group by cod_ubicacion having count(cod_ubicacion) = (select min(sumatoria) from (select count(cod_ubicacion) as sumatoria from VENTA group by cod_ubicacion)T));";
    var consulta = connection.query(sql,async function(error,result){
        if(error){
            console.log("Error al conectar sql, exit?...");
            res.end("Error al conectar sql, exist?...");
        }else{
            console.log(JSON.stringify(result));
            res.send(result);
        }
    })
});

app.get('/consulta4',async function(req,res){
    var sql = "select id_cliente as Numero_cliente,nombre as Nombre,count(cod_categoria_producto) as Numero_productos,sum(total) as Total_dinero from CLIENTE,COMPRA,DETALLE_COMPRA,PRODUCTO,CATEGORIA_PRODUCTO WHERE id_cliente = cod_cliente and cod_producto = id_producto and id_categoria_producto = (select id_categoria_producto from CATEGORIA_PRODUCTO WHERE categoria_producto = 'Cheese') and id_compra = cod_compra group by id_cliente,nombre order by Numero_productos desc limit 5;";
    var consulta = connection.query(sql,async function(error,result){
        if(error){
            console.log("Error al conectar sql, exit?...");
            res.end("Error al conectar sql, exist?...");
        }else{
            console.log(JSON.stringify(result));
            res.send(result);
        }
    })
});

app.get('/consulta5',async function(req,res){
    var sql = "(select month(fecha_registro) as Mes_Registro,nombre as Nombre,total as Total from COMPRA,CLIENTE where total = (select max(total) from COMPRA) and id_cliente = cod_cliente)\
    union\
    (select month(fecha_registro) as Mes_Registro,nombre as Nombre,total as Total from COMPRA,CLIENTE where total = (select min(total) from COMPRA) and id_cliente = cod_cliente);";
    var consulta = connection.query(sql,async function(error,result){
        if(error){
            console.log("Error al conectar sql, exit?...");
            res.end("Error al conectar sql, exist?...");
        }else{
            console.log(JSON.stringify(result));
            res.send(result);
        }
    })
});

app.get('/consulta6',async function(req,res){
    var sql = "(select categoria_producto,sum(sub_total),sum(cantidad) from CATEGORIA_PRODUCTO,DETALLE_COMPRA,PRODUCTO where cod_producto = id_producto AND cod_categoria_producto = id_categoria_producto group by cod_categoria_producto having sum(cantidad) = (select max(sumatoria) from (select sum(cantidad) as sumatoria from DETALLE_COMPRA,PRODUCTO,CATEGORIA_PRODUCTO where cod_producto = id_producto and id_categoria_producto = cod_categoria_producto group by cod_categoria_producto)T))\
    union\
    (select categoria_producto,sum(sub_total),sum(cantidad) from CATEGORIA_PRODUCTO,DETALLE_COMPRA,PRODUCTO where cod_producto = id_producto AND cod_categoria_producto = id_categoria_producto group by cod_categoria_producto having sum(cantidad) = (select min(sumatoria) from (select sum(cantidad) as sumatoria from DETALLE_COMPRA,PRODUCTO,CATEGORIA_PRODUCTO where cod_producto = id_producto and id_categoria_producto = cod_categoria_producto group by cod_categoria_producto)T));";
    var consulta = connection.query(sql,async function(error,result){
        if(error){
            console.log("Error al conectar sql, exit?...");
            res.end("Error al conectar sql, exist?...");
        }else{
            console.log(JSON.stringify(result));
            res.send(result);
        }
    })
});

app.get('/consulta7',async function(req,res){
    var sql = "select nombre as Top_Proveedores,sum(sub_total) as Total_dinero from PROVEEDOR,VENTA,DETALLE_VENTA,PRODUCTO WHERE cod_venta = id_venta and cod_proveedor = id_proveedor and cod_producto = id_producto and cod_categoria_producto = (select id_categoria_producto from CATEGORIA_PRODUCTO WHERE categoria_producto = 'Fresh Vegetables') group by nombre order by sum(sub_total) desc limit 5;";
    var consulta = connection.query(sql,async function(error,result){
        if(error){
            console.log("Error al conectar sql, exit?...");
            res.end("Error al conectar sql, exist?...");
        }else{
            console.log(JSON.stringify(result));
            res.send(result);
        }
    })
});

app.get('/consulta8',async function(req,res){
    var sql = "(select direccion,region,ciudad,codigo_postal,sum(total) as Total from UBICACION,COMPRA where COMPRA.cod_ubicacion = id_ubicacion group by direccion,region,ciudad,codigo_postal,cod_cliente having sum(total) = (select max(sumatoria) from (select sum(total) as sumatoria from COMPRA group by cod_cliente)T))\
    union\
    (select direccion,region,ciudad,codigo_postal,sum(total) as Total from UBICACION,COMPRA where COMPRA.cod_ubicacion = id_ubicacion group by direccion,region,ciudad,codigo_postal,cod_cliente having sum(total) = (select min(sumatoria) from (select sum(total) as sumatoria from COMPRA group by cod_cliente)T));";
    var consulta = connection.query(sql,async function(error,result){
        if(error){
            console.log("Error al conectar sql, exit?...");
            res.end("Error al conectar sql, exist?...");
        }else{
            console.log(JSON.stringify(result));
            res.send(result);
        }
    })
});

app.get('/consulta9',async function(req,res){
    var sql = "select cod_venta,nombre as Nombre_proveedor,telefono,total as Suma_total,sum(cantidad) as total FROM VENTA,PROVEEDOR,DETALLE_VENTA where id_proveedor = cod_proveedor and cod_venta = id_venta group by cod_venta having total = (select min(sumatoria) from (select sum(cantidad) as sumatoria from DETALLE_VENTA group by cod_venta) T);";
    var consulta = connection.query(sql,async function(error,result){
        if(error){
            console.log("Error al conectar sql, exit?...");
            res.end("Error al conectar sql, exist?...");
        }else{
            console.log(JSON.stringify(result));
            res.send(result);
        }
    })
});

app.get('/consulta10',async function(req,res){
    var sql = "select nombre as Top_Cliente,sum(cantidad) as cantidad from CLIENTE,COMPRA,DETALLE_COMPRA,PRODUCTO WHERE cod_compra = id_compra and cod_cliente = id_cliente and cod_producto = id_producto and cod_categoria_producto = (select id_categoria_producto from CATEGORIA_PRODUCTO WHERE categoria_producto = 'Seafood') group by nombre order by sum(cantidad) desc limit 10;";
    var consulta = connection.query(sql,async function(error,result){
        if(error){
            console.log("Error al conectar sql, exit?...");
            res.end("Error al conectar sql, exist?...");
        }else{
            console.log(JSON.stringify(result));
            res.send(result);
        }
    })
});

app.listen(app.get('port'),()=>{
    console.log('Server en puerto '+app.get('port'));
});