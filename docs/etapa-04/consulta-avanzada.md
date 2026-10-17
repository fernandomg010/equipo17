# Consulta avanzada: Ranking de productos por facturación

## 1. Objetivo

Desarrollar una consulta SQL que permita identificar los productos que generan mayores ingresos en la empresa de venta de gas licuado, calculando las unidades vendidas, la facturación acumulada y la participación porcentual de cada producto.

La consulta incorpora relaciones entre tres tablas y un filtro condicional sobre los resultados agrupados.

## 2. Descripción del caso de uso

El responsable comercial necesita identificar los productos cuya facturación supera los $50.000, con el propósito de analizar su importancia dentro de las ventas realizadas.

Para satisfacer esta necesidad, el sistema consulta los registros de ventas y sus correspondientes detalles, agrupa la información por producto y calcula los ingresos generados.

El resultado presenta un ranking ordenado de mayor a menor facturación.

## 3. Tablas utilizadas

La consulta utiliza tres tablas de la base de datos `gas_licuado`:

- **PRODUCTO:** contiene el identificador y la descripción de cada producto.
- **DETALLE_VENTA:** registra los productos vendidos, sus cantidades y sus precios unitarios.
- **VENTA:** almacena las operaciones comerciales realizadas.

Las relaciones se establecen mediante las claves foráneas `Id_producto` e `Id_venta`.

## 4. Consulta SQL

```sql
USE gas_licuado;
GO

SELECT
    P.Id_producto,
    P.Descripcion AS Producto,
    SUM(D.Cantidad) AS Unidades_vendidas,
    SUM(D.Cantidad * D.Precio_unitario) AS Facturacion_total,
    CAST(
        100.0 * SUM(D.Cantidad * D.Precio_unitario)
        / SUM(SUM(D.Cantidad * D.Precio_unitario)) OVER ()
        AS DECIMAL(10,2)
    ) AS Porcentaje_facturacion
FROM PRODUCTO P
INNER JOIN DETALLE_VENTA D
    ON P.Id_producto = D.Id_producto
INNER JOIN VENTA V
    ON D.Id_venta = V.Id_venta
GROUP BY
    P.Id_producto,
    P.Descripcion
HAVING SUM(D.Cantidad * D.Precio_unitario) > 50000
ORDER BY Facturacion_total DESC;
```

El script se encuentra en `sql/consultas/consulta_avanzada.sql`.

## 5. Operaciones SQL utilizadas

**INNER JOIN:** relaciona las tablas PRODUCTO, DETALLE_VENTA y VENTA mediante sus identificadores.

**SUM():** calcula la cantidad de unidades vendidas y la facturación acumulada de cada producto.

**GROUP BY:** agrupa los registros por producto para realizar los cálculos correspondientes.

**HAVING:** filtra los grupos y permite mostrar únicamente aquellos productos cuya facturación supera los $50.000.

**OVER():** permite calcular la facturación total de los productos incluidos en el resultado mediante una función de ventana.

**CAST():** presenta los porcentajes con dos posiciones decimales.

**ORDER BY DESC:** ordena los productos desde el de mayor facturación hasta el de menor facturación.

## 6. Resultados obtenidos

La consulta fue ejecutada correctamente en SQL Server Management Studio, utilizando los datos de prueba de la base de datos `gas_licuado`.

| Producto | Unidades vendidas | Facturación total | Participación |
|---|---:|---:|---:|
| Cilindro de Gas 45kg | 16 | $832.000,00 | 66,45 % |
| Cilindro Propano Industrial 45kg | 6 | $348.000,00 | 27,80 % |
| Garrafa de Gas 10kg | 6 | $72.000,00 | 5,75 % |
| **Total** | **28** | **$1.252.000,00** | **100 %** |

La Garrafa de Gas 15kg no aparece en el resultado porque su facturación acumulada es de $18.000, importe que no supera el límite establecido mediante `HAVING`.

## 7. Interpretación de resultados

El Cilindro de Gas 45kg representa el 66,45 % de la facturación correspondiente a los productos seleccionados, siendo el producto que genera mayores ingresos.

En segundo lugar, el Cilindro Propano Industrial 45kg representa el 27,80 %.

Ambos productos concentran conjuntamente el 94,25 % de la facturación de los productos incluidos en la consulta.

Los resultados permiten identificar una concentración significativa de los ingresos en los cilindros de 45 kg.

## 8. Utilidad para el negocio

Esta consulta permite identificar los productos con mayor facturación, conocer las cantidades vendidas y evaluar la participación de cada producto en los ingresos comerciales.

La información puede utilizarse para apoyar decisiones de abastecimiento, planificación de inventario y seguimiento del desempeño de las ventas.

## 9. Conclusión

La consulta avanzada permite aplicar los conocimientos adquiridos sobre relaciones entre tablas, funciones de agregación, agrupamiento de registros, filtros condicionales y funciones de ventana.

Se cumplen los requisitos de la etapa IV al combinar tres tablas mediante INNER JOIN y utilizar HAVING para establecer una condición sobre los resultados agrupados.

La ejecución permitió obtener un ranking de productos por facturación a partir de los registros de prueba almacenados en la base de datos.