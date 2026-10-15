# Pruebas y validación de la base de datos

## 1. Objetivo

Verificar que la base de datos `gas_licuado` se cree correctamente, que las tablas permitan almacenar datos válidos y que las restricciones de integridad impidan operaciones inválidas.

## 2. Prueba de creación de la base de datos

**Procedimiento:** ejecutar el script de creación de la base de datos y sus tablas.

**Resultado esperado:** se crea la base de datos `gas_licuado` y se generan las siete tablas sin errores.

## 3. Prueba de inserción de datos válidos

**Procedimiento:** insertar registros en las tablas respetando las claves primarias, las claves foráneas y los campos obligatorios.

**Resultado esperado:** los registros se insertan correctamente.

## 4. Prueba de clave primaria duplicada

**Procedimiento:** intentar insertar dos registros con el mismo identificador en una tabla cuya clave primaria sea manualmente asignable.

**Resultado esperado:** la segunda inserción es rechazada porque la clave primaria no admite duplicados.

En las tablas que utilizan `IDENTITY`, la prueba debe adaptarse para insertar explícitamente un identificador o utilizar otra tabla apropiada.

## 5. Prueba de clave foránea

**Procedimiento:** intentar insertar un cliente con un `Id_tipo_cliente` que no exista en TIPO_CLIENTE.

**Resultado esperado:** la inserción es rechazada por la restricción `fk_cliente_tipo`.

## 6. Prueba de campos obligatorios

**Procedimiento:** intentar insertar un cliente sin especificar el atributo `Nombre`.

**Resultado esperado:** la inserción es rechazada porque el atributo está definido como `NOT NULL`.

## 7. Prueba de valores únicos

**Procedimiento:** intentar registrar dos clientes con el mismo teléfono o CUIT.

**Resultado esperado:** la segunda operación es rechazada por las restricciones `UNIQUE`, siempre que el valor duplicado no sea NULL.

## 8. Prueba de relaciones entre ventas y productos

**Procedimiento:** intentar insertar un detalle de venta que haga referencia a un producto o una venta inexistente.

**Resultado esperado:** la inserción es rechazada por las claves foráneas `fk_detalle_producto` o `fk_detalle_venta`.

## 9. Prueba de consulta de datos

**Procedimiento:** ejecutar consultas `SELECT` sobre las siete tablas.

**Resultado esperado:** las consultas se ejecutan correctamente y permiten visualizar los registros almacenados.

## 10. Conclusión

Las pruebas permiten verificar la correcta creación de la estructura, la inserción de registros y el cumplimiento de las restricciones de integridad.

Los resultados definitivos deben registrarse después de ejecutar cada prueba en el gestor de base de datos utilizado.