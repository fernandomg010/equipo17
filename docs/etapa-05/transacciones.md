Las transacciones son un conjunto de operaciones SQL que se ejecutan como una única unidad de trabajo. Su principal objetivo es garantizar la integridad y consistencia de los datos, evitando que una operación quede incompleta cuando ocurre algún error.

En el sistema de comercialización de garrafas GLP, las transacciones se aplican principalmente al proceso de venta. Cuando un cliente compra uno o varios productos, el sistema debe realizar tres operaciones relacionadas:

* Registrar el encabezado de la venta en la tabla VENTA.  
* Registrar los productos, cantidades y precios en DETALLE\_VENTA.  
* Descontar las cantidades vendidas del stock de garrafas llenas en INVENTARIO.

Estas operaciones deben ejecutarse de manera conjunta. Si no existe stock suficiente de alguno de los productos solicitados, o se produce un error durante el registro, la transacción debe cancelarse y revertir todos los cambios.

