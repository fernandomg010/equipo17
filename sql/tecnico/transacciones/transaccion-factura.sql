
USE gas_licuado;
GO

BEGIN TRY
    BEGIN TRANSACTION;

    -- 1. Cargar los productos de la venta
    DECLARE @Detalle TABLE (
        Id_producto INT,
        Cantidad INT,
        Precio_unitario DECIMAL(10,2)
    );

    INSERT INTO @Detalle
        (Id_producto, Cantidad, Precio_unitario)
    VALUES
        (1, 2, 15000.00),
        (2, 1, 28000.00);

    -- Datos generales de la venta
    DECLARE @Id_cliente INT = 1;
    DECLARE @Id_metodo_pago INT = 1;
    DECLARE @Modalidad VARCHAR(50) = 'Mostrador';
    DECLARE @Id_venta INT;
    DECLARE @Total DECIMAL(10,2);

    -- 2. Validar cantidades y precios
    IF EXISTS (
        SELECT 1
        FROM @Detalle
        WHERE Cantidad <= 0 OR Precio_unitario < 0
    )
        THROW 50001, 'Cantidad o precio invalido.', 1;

    -- 3. Calcular el total de la venta
    SELECT @Total =
        SUM(Cantidad * Precio_unitario)
    FROM @Detalle;

    -- 4. Descontar el stock con bloqueo de las filas
    ;WITH ProductosVendidos AS (
        SELECT
            Id_producto,
            SUM(Cantidad) AS Cantidad
        FROM @Detalle
        GROUP BY Id_producto
    )
    UPDATE I
    SET I.Garrafas_llenas =
        I.Garrafas_llenas - D.Cantidad
    FROM INVENTARIO I WITH (UPDLOCK, HOLDLOCK)
    INNER JOIN ProductosVendidos D
        ON I.Id_producto = D.Id_producto
    WHERE I.Garrafas_llenas >= D.Cantidad;

    -- Comprobar que todos los productos tenían stock suficiente
    IF @@ROWCOUNT <> (
        SELECT COUNT(DISTINCT Id_producto)
        FROM @Detalle
    )
        THROW 50002, 'Stock insuficiente o inventario inexistente.', 1;

    -- 5. Crear el encabezado de la venta
    INSERT INTO VENTA (
        Fecha,
        Modalidad,
        Total,
        Id_cliente,
        Id_metodo_pago
    )
    VALUES (
        GETDATE(),
        @Modalidad,
        @Total,
        @Id_cliente,
        @Id_metodo_pago
    );

    SET @Id_venta = SCOPE_IDENTITY();

    -- 6. Crear el detalle de la venta
    INSERT INTO DETALLE_VENTA (
        Id_producto,
        Id_venta,
        Cantidad,
        Precio_unitario
    )
    SELECT
        Id_producto,
        @Id_venta,
        SUM(Cantidad),
        Precio_unitario
    FROM @Detalle
    GROUP BY Id_producto, Precio_unitario;

    -- 7. Confirmar todas las operaciones
    COMMIT TRANSACTION;

    SELECT
        'Venta registrada correctamente' AS Resultado,
        @Id_venta AS Id_venta,
        @Total AS Total;

END TRY
BEGIN CATCH

    -- Cancelar todos los cambios si ocurrió un error
    IF XACT_STATE() <> 0
        ROLLBACK TRANSACTION;

    SELECT
        ERROR_MESSAGE() AS Error,
        'La venta no fue registrada' AS Resultado;

END CATCH;
GO
