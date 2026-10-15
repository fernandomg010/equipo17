# Implementación de la base de datos

## 1. Descripción general

Se implementó la base de datos `gas_licuado`, destinada a gestionar las ventas de gas licuado, los clientes, los productos, los métodos de pago y el inventario de garrafas.

La base de datos está compuesta por siete tablas:

- **TIPO_CLIENTE:** almacena los tipos de clientes.
- **CLIENTE:** almacena los datos personales y de contacto de los clientes.
- **METODO_PAGO:** registra los métodos de pago disponibles.
- **VENTA:** almacena la información de cada venta realizada.
- **PRODUCTO:** contiene los productos disponibles, su capacidad y su precio de lista.
- **DETALLE_VENTA:** registra los productos incluidos en cada venta, su cantidad y su precio unitario.
- **INVENTARIO:** registra las cantidades de garrafas vacías y llenas asociadas a cada producto.

## 2. Creación de la base de datos

Se utilizó la instrucción `CREATE DATABASE` para crear la base de datos `gas_licuado` y `USE` para seleccionarla antes de crear las tablas.

## 3. Creación de tablas y relaciones

Las tablas se crearon mediante la instrucción `CREATE TABLE`.

Se utilizaron claves primarias para identificar los registros de cada tabla. En las tablas principales, los identificadores se generan automáticamente mediante `IDENTITY(1,1)`.

Las relaciones se implementaron mediante claves foráneas:

- CLIENTE se relaciona con TIPO_CLIENTE.
- VENTA se relaciona con CLIENTE.
- VENTA se relaciona con METODO_PAGO.
- DETALLE_VENTA se relaciona con PRODUCTO.
- DETALLE_VENTA se relaciona con VENTA.
- INVENTARIO se relaciona con PRODUCTO.

La tabla DETALLE_VENTA utiliza una clave primaria compuesta por `Id_producto` e `Id_venta`, que permite identificar cada producto dentro de una venta.

## 4. Tipos de datos utilizados

Se utilizaron los siguientes tipos de datos:

- `INT`: para identificadores y cantidades enteras.
- `VARCHAR`: para nombres, descripciones, teléfonos, CUIT y otros datos de texto.
- `DATETIME`: para almacenar la fecha y hora de las ventas.
- `DECIMAL(10,2)`: para importes monetarios.
- `IDENTITY(1,1)`: para generar identificadores numéricos automáticamente.

## 5. Archivo SQL

El script de creación de la base de datos se encuentra en `sql/ddl/crear_bd.sql`.