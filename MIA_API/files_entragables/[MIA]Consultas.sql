/*<<<<<<<<<<<<<<<<<<<<<<<SEGUNDA INTENTO CON LAS CONUSLTAS>>>>>>>>>>>>>>>>>>>>>>>>>>><*/
#script con las consultas solicitadas

/*CONSULTA_1:
Mostrar el nombre del proveedor, número de teléfono, número de orden,
total de la orden por la cual se haya pagado la mayor cantidad de dinero.
*/
select nombre AS Proveedor,telefono,id_venta as Numero_venta,total as Total 
from VENTA,PROVEEDOR where total = (select max(total) from VENTA) and cod_proveedor = id_proveedor;
#Done_well


/*CONSULTA_2:
Mostrar el número de cliente, nombre, apellido y total del cliente que más
productos ha comprado.
*/
select cod_cliente,nombre,sum(cantidad),sum(total) 
from DETALLE_COMPRA,COMPRA,CLIENTE 
where id_cliente = cod_cliente 
and cod_compra = id_compra 
group by cod_cliente,nombre 
having sum(cantidad) = (
	select max(sumatoria) 
	from (select sum(cantidad) as sumatoria 
		from DETALLE_COMPRA,COMPRA,CLIENTE 
		where id_cliente = cod_cliente 
		and cod_compra = id_compra 
		group by cod_cliente
		)T
);
#Done_well

/*CONSULTA_3
Mostrar la dirección, región, ciudad y código postal hacia l a cual se han hecho
más solicitudes de pedidos y a cuál menos por parte de proveedores (en una sola consulta).
*/
(select direccion,region,ciudad,codigo_postal,count(cod_ubicacion) 
	from UBICACION,VENTA 
	where id_ubicacion = cod_ubicacion 
	group by cod_ubicacion 
	having count(cod_ubicacion) = (
		select max(sumatoria) 
		from (
			select count(cod_ubicacion) as sumatoria 
			from VENTA 
			group by cod_ubicacion)
		T)
)
union
(select direccion,region,ciudad,codigo_postal,count(cod_ubicacion) 
	from UBICACION,VENTA 
	where id_ubicacion = cod_ubicacion 
	group by cod_ubicacion 
	having count(cod_ubicacion) = (
		select min(sumatoria) 
		from (
			select count(cod_ubicacion) as sumatoria 
			from VENTA 
			group by cod_ubicacion)
		T
	)
);
#Done_well

/*CONSULTA_4
Mostrar el número de cliente, nombre, apellido, el número de órdenes que ha
realizado y el total de cada uno de los cinco clientes que más han comprado
productos de la categoría ‘Cheese’.
*/
select id_cliente as Numero_cliente,nombre as Nombre,count(cod_categoria_producto) as Numero_productos,sum(total) as Total_dinero 
from CLIENTE,COMPRA,DETALLE_COMPRA,PRODUCTO,CATEGORIA_PRODUCTO 
WHERE id_cliente = cod_cliente 
and cod_producto = id_producto 
and id_categoria_producto = (
	select id_categoria_producto 
	from CATEGORIA_PRODUCTO 
	WHERE categoria_producto = 'Cheese'
	) 
and id_compra = cod_compra 
group by id_cliente,nombre 
order by Numero_productos desc limit 5;
#Done

/*CONSULTA_5
Mostrar el número de mes de la fecha de registro, nombre y apellido de todos
los clientes que más han comprado y los que menos han comprado (en
dinero) utilizando una sola consulta.
cada select es un limit de 5, al final me mostras 10 filas
*/
(select month(fecha_registro) as Mes_Registro,nombre as Nombre,total as Total 
	from COMPRA,CLIENTE 
	where total = (select max(total) from COMPRA) and id_cliente = cod_cliente
	)
union
(select month(fecha_registro) as Mes_Registro,nombre as Nombre,total as Total 
	from COMPRA,CLIENTE 
	where total = (select min(total) from COMPRA) and id_cliente = cod_cliente
	);
#Done_well

/*CONSULTA_6
Mostrar el nombre de la categoría más y menos vendida y el total vendido en
dinero (en una sola consulta).
clientes
*/
(select categoria_producto,sum(sub_total),sum(cantidad) 
	from CATEGORIA_PRODUCTO,DETALLE_COMPRA,PRODUCTO 
	where cod_producto = id_producto 
	AND cod_categoria_producto = id_categoria_producto 
	group by cod_categoria_producto having sum(cantidad) = (
		select max(sumatoria) 
		from (select sum(cantidad) as sumatoria 
			from DETALLE_COMPRA,PRODUCTO,CATEGORIA_PRODUCTO 
			where cod_producto = id_producto 
			and id_categoria_producto = cod_categoria_producto 
			group by cod_categoria_producto
		)T
	)
)
union
(select categoria_producto,sum(sub_total),sum(cantidad) 
	from CATEGORIA_PRODUCTO,DETALLE_COMPRA,PRODUCTO 
	where cod_producto = id_producto 
	AND cod_categoria_producto = id_categoria_producto 
	group by cod_categoria_producto having sum(cantidad) = (
		select min(sumatoria) 
		from (
			select sum(cantidad) as sumatoria 
			from DETALLE_COMPRA,PRODUCTO,CATEGORIA_PRODUCTO 
			where cod_producto = id_producto 
			and id_categoria_producto = cod_categoria_producto 
			group by cod_categoria_producto
		)T
	)
);
#Done_well

/*CONSULTA_7
Mostrar el top 5 de proveedores que más productos han vendido (en dinero)
de la categoría de productos ‘Fresh Vegetables’.
*/
select nombre as Top_Proveedores,sum(sub_total) as Total_dinero 
from PROVEEDOR,VENTA,DETALLE_VENTA,PRODUCTO 
WHERE cod_venta = id_venta 
and cod_proveedor = id_proveedor 
and cod_producto = id_producto 
and cod_categoria_producto = (
	select id_categoria_producto 
	from CATEGORIA_PRODUCTO 
	WHERE categoria_producto = 'Fresh Vegetables'
	) 
group by nombre order by sum(sub_total) desc limit 5;
#Done_well++

/*CONSULTA_8
Mostrar la dirección, región, ciudad y código postal de los clientes que más
han comprado y de los que menos (en dinero) en una sola consulta.
*/
(select direccion,region,ciudad,codigo_postal,sum(total) as Total 
	from UBICACION,COMPRA 
	where COMPRA.cod_ubicacion = id_ubicacion 
	group by direccion,region,ciudad,codigo_postal,cod_cliente 
	having sum(total) = (
		select max(sumatoria) 
		from (
			select sum(total) as sumatoria 
			from COMPRA group by cod_cliente)T
		)
)
union
(select direccion,region,ciudad,codigo_postal,sum(total) as Total 
	from UBICACION,COMPRA 
	where COMPRA.cod_ubicacion = id_ubicacion 
	group by direccion,region,ciudad,codigo_postal,cod_cliente 
	having sum(total) = (
		select min(sumatoria) 
		from (
			select sum(total) as sumatoria 
			from COMPRA group by cod_cliente)T
		)
);
#Done_well++

/*CONSULTA_9
Mostrar el nombre del proveedor, número de teléfono, número de orden,
total de la orden por la cual se haya obtenido la menor cantidad de producto.
*/
select cod_venta,nombre as Nombre_proveedor,telefono,total as Suma_total,sum(cantidad) as total 
FROM VENTA,PROVEEDOR,DETALLE_VENTA 
where id_proveedor = cod_proveedor and cod_venta = id_venta 
group by cod_venta 
having total = (
	select min(sumatoria) 
	from (
		select sum(cantidad) as sumatoria 
		from DETALLE_VENTA group by cod_venta
		) T
);
#Done_well

/*CONSULTA_10
Mostrar el top 10 de los clientes que más productos han comprado de la
categoría ‘Seafood’.
*/
select nombre as Top_Cliente,sum(cantidad) as cantidad 
from CLIENTE,COMPRA,DETALLE_COMPRA,PRODUCTO 
WHERE cod_compra = id_compra 
and cod_cliente = id_cliente 
and cod_producto = id_producto 
and cod_categoria_producto = (
	select id_categoria_producto 
	from CATEGORIA_PRODUCTO 
	WHERE categoria_producto = 'Seafood'
	) 
group by nombre 
order by sum(cantidad) desc limit 10;
#Done_well

