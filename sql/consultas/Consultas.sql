-- Ver todos los clientes registrados
SELECT * FROM CLIENTE;

SELECT NOMBRE
FROM CLIENTE;

-- Ver todas las ventas registradas
SELECT * FROM VENTA;

SELECT Id_venta, Fecha, Total, Id_cliente
FROM VENTA
WHERE Total > 50000.00;



-- Ver el detalle de productos de cada venta
SELECT * FROM DETALLE_VENTA;

SELECT Precio_unitario
FROM DETALLE_VENTA
WHERE Precio_unitario > 12000.00;

-- Ver el stock disponible en inventario
SELECT * FROM INVENTARIO;

SELECT Garrafas_llenas
FROM INVENTARIO
WHERE Garrafas_llenas < 120

UPDATE INVENTARIO
SET Garrafas_llenas = 40,
    Garrafas_vacias = 45
WHERE Id_inventario = 10;