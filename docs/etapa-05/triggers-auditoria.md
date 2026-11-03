1. ¿Qué es y para qué se implementa?
La auditoría permite mantener un registro histórico de las modificaciones realizadas sobre los precios de los productos comercializados.

En el sistema de gestión de ventas de GLP, los precios de las garrafas pueden modificarse con el tiempo. Por eso, resulta importante conservar información sobre los cambios realizados, identificando cuándo se modificó un precio, qué producto fue afectado y qué usuario realizó la operación.

Para resolver esta necesidad se implementa un trigger que registra automáticamente las modificaciones del campo Precio_lista de la tabla PRODUCTO.

2. ¿Cómo funciona la implementación?

El funcionamiento se divide en dos partes:

A. Tabla AUDITORIA_PRODUCTO

Se crea una tabla independiente destinada a almacenar el historial de modificaciones.

En ella se registra:
- Identificador de la auditoría.
- Fecha y hora de la modificación.
- Usuario responsable.
- Producto modificado.
- Precio anterior.
- Precio nuevo.
- Tipo de operación realizada.
Esta tabla permite conservar los valores anteriores incluso después de que el precio original del producto haya sido actualizado.

B. Trigger trg_auditoria_precio_producto

Se crea un trigger asociado a la tabla PRODUCTO, que se ejecuta automáticamente después de una operación UPDATE.

Su funcionamiento es el siguiente:
1. Detecta si la actualización involucra el campo Precio_lista.
2. Recupera los valores anteriores mediante la tabla temporal deleted.
3. Recupera los valores nuevos mediante la tabla temporal inserted.
4. Identifica al usuario que realizó la operación mediante SYSTEM_USER.
5. Registra toda la información en AUDITORIA_PRODUCTO.
De esta manera, el registro se genera automáticamente sin necesidad de realizar una inserción manual en la tabla de auditoría.
3. Ejemplo aplicado al negocio
Supongamos que el precio de una garrafa de 10 kg es de $15.000 y un usuario decide actualizarlo a $18.000.

Al ejecutar la modificación:

UPDATE PRODUCTO
SET Precio_lista = 18000
WHERE Id_producto = 1;

El trigger se activa automáticamente y almacena el cambio:
Campo	Valor registrado
Producto	Garrafa de 10 kg
Precio anterior	15000
Precio nuevo	18000
Operación	UPDATE
Usuario	Usuario que realizó el cambio
Fecha	Fecha y hora de modificación

Así, el sistema conserva evidencia de la modificación realizada.

4. Importancia para el proyecto

La implementación de este mecanismo aporta diferentes beneficios:
- Trazabilidad: permite conocer el historial de modificaciones de los precios.
- Control: facilita identificar qué usuario realizó cada cambio.
- Transparencia: permite consultar los valores anteriores y actuales de los productos.
- Integridad histórica: ayuda a evitar la pérdida de información sobre los precios anteriores.
