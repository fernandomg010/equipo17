
SELECT
    V.Id_venta,
    V.Fecha,
    V.Modalidad,
    C.Id_cliente,
    C.Nombre AS Cliente,
    C.Cuit,
    C.Telefono,
    C.Calle,
    C.Altura,
    C.Localidad,
    MP.Descripcion AS Metodo_pago,
    P.Id_producto,
    P.Descripcion AS Producto,
    P.Capacidad,
    DV.Cantidad,
    DV.Precio_unitario,
    DV.Cantidad * DV.Precio_unitario AS Subtotal_renglon,
    SUM(DV.Cantidad * DV.Precio_unitario)
        OVER (PARTITION BY V.Id_venta) AS Total_calculado
FROM VENTA V
INNER JOIN CLIENTE C
    ON V.Id_cliente = C.Id_cliente
INNER JOIN METODO_PAGO MP
    ON V.Id_metodo_pago = MP.Id_metodo_pago
INNER JOIN DETALLE_VENTA DV
    ON V.Id_venta = DV.Id_venta
INNER JOIN PRODUCTO P
    ON DV.Id_producto = P.Id_producto
ORDER BY P.Descripcion;
