-- REPORTE AGREGADO DE VENTAS POR PRODUCTO

USE gas_licuado;
GO

DECLARE @FechaDesde DATE = '2026-01-01';
DECLARE @FechaHasta DATE = '2026-12-31';

SELECT
    P.Id_producto,
    P.Descripcion AS Producto,
    SUM(DV.Cantidad) AS Unidades_vendidas,
    COUNT(DISTINCT V.Id_venta) AS Cantidad_ventas,
    SUM(DV.Cantidad * DV.Precio_unitario) AS Total_vendido
FROM VENTA V
INNER JOIN DETALLE_VENTA DV
    ON V.Id_venta = DV.Id_venta
INNER JOIN PRODUCTO P
    ON DV.Id_producto = P.Id_producto
WHERE V.Fecha >= @FechaDesde
  AND V.Fecha < DATEADD(DAY, 1, @FechaHasta)
GROUP BY
    P.Id_producto,
    P.Descripcion
ORDER BY Total_vendido DESC;
GO