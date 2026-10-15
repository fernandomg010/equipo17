# Restricciones de integridad

## 1. Claves primarias (PRIMARY KEY)

Las claves primarias identifican de manera única cada registro de una tabla.

- TIPO_CLIENTE: `Id_tipo_cliente`.
- CLIENTE: `Id_cliente`.
- METODO_PAGO: `Id_metodo_pago`.
- VENTA: `Id_venta`.
- PRODUCTO: `Id_producto`.
- DETALLE_VENTA: clave compuesta por `Id_producto` e `Id_venta`.
- INVENTARIO: `Id_inventario`.

Estas claves no admiten valores duplicados ni valores nulos.

## 2. Claves foráneas (FOREIGN KEY)

Las claves foráneas garantizan que las relaciones entre las tablas hagan referencia a registros existentes.

- CLIENTE.`Id_tipo_cliente` referencia a TIPO_CLIENTE.`Id_tipo_cliente`.
- VENTA.`Id_cliente` referencia a CLIENTE.`Id_cliente`.
- VENTA.`Id_metodo_pago` referencia a METODO_PAGO.`Id_metodo_pago`.
- DETALLE_VENTA.`Id_producto` referencia a PRODUCTO.`Id_producto`.
- DETALLE_VENTA.`Id_venta` referencia a VENTA.`Id_venta`.
- INVENTARIO.`Id_producto` referencia a PRODUCTO.`Id_producto`.

Estas restricciones impiden insertar registros que hagan referencia a identificadores inexistentes.

## 3. Restricciones NOT NULL

Se utilizó `NOT NULL` para establecer que determinados atributos son obligatorios.

Entre ellos se encuentran:

- TIPO_CLIENTE.`Descripcion`.
- CLIENTE.`Nombre` e `Id_tipo_cliente`.
- METODO_PAGO.`Descripcion`.
- VENTA.`Fecha`, `Total`, `Id_cliente` e `Id_metodo_pago`.
- PRODUCTO.`Descripcion` y `Precio_lista`.
- DETALLE_VENTA.`Id_producto`, `Id_venta`, `Cantidad` y `Precio_unitario`.
- INVENTARIO.`Garrafas_vacias`, `Garrafas_llenas` e `Id_producto`.

## 4. Restricciones UNIQUE

Se utilizaron restricciones `UNIQUE` para evitar valores duplicados en los siguientes atributos:

- CLIENTE.`Telefono`.
- CLIENTE.`Cuit`.

Estas restricciones permiten que no existan dos clientes con el mismo teléfono o CUIT. En SQL Server, al no especificarse otra configuración, una columna UNIQUE admite como máximo un valor NULL.

## 5. Generación automática de identificadores

Se utilizó `IDENTITY(1,1)` en las claves primarias de las tablas TIPO_CLIENTE, CLIENTE, METODO_PAGO, VENTA, PRODUCTO e INVENTARIO.

Esto permite generar identificadores automáticamente, comenzando en 1 e incrementándose de a 1.

## 6. Clave primaria compuesta

La tabla DETALLE_VENTA posee una clave primaria compuesta por `Id_producto` e `Id_venta`.

Esta combinación evita registrar más de una fila para el mismo producto dentro de una misma venta.

## 7. Observaciones

El script original no establece restricciones `CHECK` para validar que los importes y las cantidades sean positivos. Tampoco establece que los identificadores de producto sean únicos en INVENTARIO.

Estas reglas podrían incorporarse si los requisitos del negocio lo necesitan.