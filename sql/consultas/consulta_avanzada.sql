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
GROUP BY
    P.Id_producto,
    P.Descripcion
ORDER BY Facturacion_total DESC;