## **1\. Objetivo**

La consulta tiene como objetivo obtener un reporte de los productos vendidos durante el año 2026 en el sistema de gestión de ventas de garrafas de GLP (Gas Licuado de Petróleo). Permite conocer la cantidad total de unidades vendidas de cada producto, la cantidad de ventas en las que participó y el importe total generado por sus ventas.

Este reporte facilita el análisis del comportamiento comercial de los productos, permitiendo identificar cuáles registraron mayores ingresos durante el período seleccionado.

La información se obtiene a partir de los datos almacenados en la base de datos `gas_licuado`, utilizando principalmente las tablas `VENTA`, `DETALLE_VENTA` y `PRODUCTO`.

## **2\. Datos del reporte**

El reporte presenta información agrupada por producto y se compone de los siguientes campos:

### **2.1. Identificación del producto**

Esta sección permite identificar cada producto incluido en el reporte:

* **Identificador del producto:** código único que identifica al producto en el sistema (`Id_producto`).  
* **Producto:** descripción del producto comercializado (`Descripcion`).

### **2.2. Información de ventas**

Esta sección contiene los datos calculados a partir de las operaciones registradas:

* **Unidades vendidas:** cantidad total de unidades comercializadas del producto durante el período consultado.  
* **Cantidad de ventas:** número de operaciones de venta diferentes en las que aparece el producto.  
* **Total vendido:** importe acumulado generado por la venta del producto.

El total vendido se obtiene multiplicando la cantidad de unidades vendidas por su precio unitario correspondiente y sumando los importes de todos los registros asociados al producto.

**Fórmula:**

Total vendido \= Σ (Cantidad × Precio unitario)

La cantidad de ventas se calcula contando los identificadores de venta diferentes en los que aparece cada producto.

## **3\. Período de consulta**

La consulta establece como período de análisis el año 2026, comprendido entre el 1 de enero y el 31 de diciembre.

Para definir este intervalo se utilizan dos variables:

* `@FechaDesde`: establece la fecha inicial del período, correspondiente al 01/01/2026.  
* `@FechaHasta`: establece la fecha final del período, correspondiente al 31/12/2026.

La condición de filtrado utiliza la fecha de la venta y la función `DATEADD` para incluir todas las operaciones del último día, incluso cuando el campo `Fecha` almacena información horaria.

De esta manera, el reporte contempla las ventas realizadas durante todo el año seleccionado.

## **4\. Ejemplo de reporte**

A continuación, se presenta un ejemplo ilustrativo de cómo se visualizarían los resultados de la consulta.

### **REPORTE DE PRODUCTOS VENDIDOS — AÑO 2026**

| ID del producto | Producto | Unidades vendidas | Cantidad de ventas | Total vendido |
| ----: | ----- | ----: | ----: | ----: |
| 3 | Garrafa de 10 kg | 120 | 65 | \$1.800.000,00 |
| 5 | Garrafa de 15 kg | 80 | 42 | \$1.600.000,00 |
| 8 | Garrafa de 45 kg | 35 | 20 | \$980.000,00 |

Los datos y valores de la tabla son ficticios y tienen únicamente fines ilustrativos. En el funcionamiento real, los resultados dependerán de los registros existentes en la base de datos.

El reporte se ordena de mayor a menor según el campo `Total_vendido`, de modo que los productos que generan mayores ingresos aparecen primero.

## **5\. Relación con el modelo de datos**

La generación del reporte utiliza las relaciones entre las siguientes tablas del modelo relacional:

* `VENTA`: contiene la información general de las operaciones, incluyendo el identificador y la fecha de cada venta.  
* `DETALLE_VENTA`: registra los productos incluidos en cada operación, sus cantidades y los precios unitarios aplicados.  
* `PRODUCTO`: proporciona la información identificatoria y descriptiva de los productos comercializados.

Las relaciones entre estas tablas se establecen mediante las claves primarias y foráneas correspondientes:

* `VENTA.Id_venta` se relaciona con `DETALLE_VENTA.Id_venta`.  
* `PRODUCTO.Id_producto` se relaciona con `DETALLE_VENTA.Id_producto`.

La consulta utiliza `INNER JOIN` para vincular los registros relacionados, `SUM` para calcular las cantidades e importes acumulados, `COUNT(DISTINCT ...)` para contar las ventas diferentes y `GROUP BY` para agrupar los resultados por producto.

## **6\. Consideraciones finales**

La consulta desarrollada permite obtener una visión general del desempeño comercial de cada producto durante el período seleccionado. La información resultante facilita la identificación de los productos con mayores ingresos, el análisis de las cantidades comercializadas y el seguimiento de su participación en las operaciones de venta.

Asimismo, el ordenamiento descendente por importe total permite priorizar el análisis de los productos que generan una mayor facturación.

Este reporte constituye una herramienta de consulta y análisis interno para la administración del negocio. Los importes obtenidos representan las ventas calculadas a partir de las cantidades y los precios unitarios registrados en `DETALLE_VENTA`; no deben interpretarse automáticamente como ganancias netas, ya que no contemplan costos, gastos ni otros ajustes comerciales.

