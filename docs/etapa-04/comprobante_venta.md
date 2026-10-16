# Comprobante de venta

## 1. Objetivo

El comprobante de venta tiene como objetivo registrar y presentar de manera clara la información correspondiente a una operación de venta de garrafas de GLP (Gas Licuado de Petróleo). Permite consultar los datos del cliente, la fecha de la operación, la modalidad de venta, el método de pago, los productos vendidos, sus cantidades, los precios unitarios y el importe total de la operación.

Este comprobante se genera a partir de la información almacenada en la base de datos `gas_licuado`, utilizando principalmente las tablas `VENTA`, `CLIENTE`, `METODO_PAGO`, `DETALLE_VENTA` y `PRODUCTO`.

## 2. Datos del comprobante

El comprobante se divide en dos secciones principales: el encabezado y el detalle de la venta.

### 2.1. Encabezado

El encabezado contiene la información general de la operación:

- **Número de venta:** identificador único de la operación (`Id_venta`).
- **Fecha:** fecha y hora en que se realizó la venta (`Fecha`).
- **Cliente:** nombre del cliente asociado a la operación.
- **CUIT:** identificación tributaria del cliente, cuando corresponda.
- **Datos de contacto:** teléfono y domicilio del cliente.
- **Modalidad de venta:** indica si la operación se realiza en mostrador o mediante entrega a domicilio, según las modalidades definidas en el sistema.
- **Método de pago:** medio utilizado para abonar la operación.

### 2.2. Detalle de la venta

El detalle contiene los productos comercializados en la operación. Para cada producto se presentan los siguientes datos:

- Identificador y descripción del producto.
- Capacidad de la garrafa.
- Cantidad de unidades vendidas.
- Precio unitario aplicado a la operación.
- Subtotal correspondiente al renglón.

El subtotal de cada renglón se obtiene multiplicando la cantidad vendida por el precio unitario registrado en el detalle.

**Fórmula:**

Subtotal = Cantidad × Precio unitario

El total de la venta se calcula sumando los subtotales de todos los productos incluidos en la operación.

**Fórmula:**

Total de la venta = Σ Subtotales de los productos


## 3. Ejemplo de comprobante

A continuación, se presenta un ejemplo ilustrativo de cómo se visualizaría el resultado de una operación.

### COMPROBANTE DE VENTA

**Número de venta:** 1

**Fecha:** 15/10/2026

**Cliente:** Juan Pérez

**CUIT:** 20-12345678-9

**Modalidad:** Mostrador

**Método de pago:** Efectivo

| Producto | Cantidad | Precio unitario | Subtotal |
|---|---:|---:|---:|
| Garrafa de 10 kg | 2 | $15.000,00 | $30.000,00 |
| Garrafa de 45 kg | 1 | $28.000,00 | $28.000,00 |
| **Total de la venta** | | | **$58.000,00** |

Los datos y valores del ejemplo son ficticios y tienen únicamente fines ilustrativos. En el funcionamiento real, la información se obtiene de los registros existentes en la base de datos.


## 4. Relación con el modelo de datos

La generación del comprobante utiliza las relaciones entre las tablas del modelo relacional:

- `VENTA` contiene los datos generales de la operación.
- `CLIENTE` proporciona los datos identificatorios y de contacto del comprador.
- `METODO_PAGO` identifica el medio de pago utilizado.
- `DETALLE_VENTA` registra los productos, las cantidades y los precios unitarios aplicados.
- `PRODUCTO` proporciona la descripción y la capacidad de las garrafas comercializadas.

Estas relaciones se establecen mediante las claves primarias y foráneas definidas en el esquema de la base de datos.

## 5. Consideraciones finales

La consulta desarrollada permite obtener una representación consolidada de cada venta, facilitando la consulta de operaciones realizadas y la verificación de los importes facturados. Asimismo, contribuye a la trazabilidad de las transacciones y al control de la información comercial del sistema.

El comprobante aquí descrito corresponde a una representación interna de la operación. Para que constituya una factura fiscal válida en Argentina, sería necesario incorporar los requisitos tributarios correspondientes y la integración con los mecanismos de autorización fiscal aplicables.