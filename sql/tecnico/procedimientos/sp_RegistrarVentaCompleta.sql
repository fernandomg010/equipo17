USE gas_licuado;
GO

IF OBJECT_ID('dbo.sp_RegistrarVentaCompleta', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_RegistrarVentaCompleta;
GO

CREATE PROCEDURE dbo.sp_RegistrarVentaCompleta
    @Id_cliente INT,
    @Id_metodo_pago INT,
    @Modalidad VARCHAR(50),
    @Id_producto INT,
    @Cantidad INT
AS
BEGIN
    SET NOCOUNT ON;
	SET XACT_ABORT ON;

    DECLARE @StockActual INT;
    DECLARE @PrecioLista DECIMAL(10,2);
    DECLARE @PorcentajeDescuento DECIMAL(5,2);
    DECLARE @PrecioUnitarioFinal DECIMAL(10,2);
    DECLARE @Subtotal DECIMAL(10,2);
    DECLARE @Id_venta INT;

-- Validación que evita que cantidad sea nulo, 0 o negativa.
IF @Cantidad IS NULL OR @Cantidad <= 0
BEGIN
    RAISERROR('La cantidad debe ser mayor que cero.', 16, 1);
    RETURN;
END;

-- Validación de existencia del cliente.
IF NOT EXISTS (
    SELECT 1
    FROM CLIENTE
    WHERE Id_cliente = @Id_cliente
)
BEGIN
    RAISERROR('El cliente no existe.', 16, 1);
    RETURN;
END;

-- Validación de existencia del método de pago.
IF NOT EXISTS (
    SELECT 1
    FROM METODO_PAGO
    WHERE Id_metodo_pago = @Id_metodo_pago
)
BEGIN
    RAISERROR('El metodo de pago no existe.', 16, 1);
    RETURN;
END;

    -- 1. Validar existencia de producto y obtener precio de lista
SELECT @PrecioLista = Precio_lista 
    FROM PRODUCTO 
    WHERE Id_producto = @Id_producto;

    IF @PrecioLista IS NULL
    BEGIN
        RAISERROR('El producto especificado no existe.', 16, 1);
        RETURN;
    END

    -- 2. Validar stock disponible en inventario
    SELECT @StockActual = Garrafas_llenas 
    FROM INVENTARIO 
    WHERE Id_producto = @Id_producto;

    IF @StockActual IS NULL OR @StockActual < @Cantidad
    BEGIN
        RAISERROR('Stock insuficiente de garrafas llenas para realizar la venta.', 16, 1);
        RETURN;
    END

    -- 3. Calcular descuento aplicable mediante la función
    SET @PorcentajeDescuento = dbo.fn_CalcularDescuentoCliente(@Id_cliente);
    SET @PrecioUnitarioFinal = @PrecioLista * (1.00 - @PorcentajeDescuento);
    SET @Subtotal = @PrecioUnitarioFinal * @Cantidad;

	BEGIN TRY
    BEGIN TRANSACTION;
    -- 4. Registrar la cabecera de la Venta
    INSERT INTO VENTA (Fecha, Modalidad, Total, Id_cliente, Id_metodo_pago)
    VALUES (GETDATE(), @Modalidad, @Subtotal, @Id_cliente, @Id_metodo_pago);

    SET @Id_venta = SCOPE_IDENTITY();

    -- 5. Registrar el detalle de la Venta
    INSERT INTO DETALLE_VENTA (Id_producto, Id_venta, Cantidad, Precio_unitario)
    VALUES (@Id_producto, @Id_venta, @Cantidad, @PrecioUnitarioFinal);

    -- 6. Actualizar inventario (descontar garrafas llenas)
    UPDATE INVENTARIO
    SET Garrafas_llenas = Garrafas_llenas - @Cantidad,
        Garrafas_vacias = Garrafas_vacias + @Cantidad
    WHERE Id_producto = @Id_producto
	AND Garrafas_llenas >= @Cantidad;
	
	-- Verificar que se haya actualizado el inventario.
	IF @@ROWCOUNT <> 1
	BEGIN
    THROW 50006, 'Stock insuficiente o inventario inexistente.', 1;
	END;

        COMMIT TRANSACTION;

    PRINT 'Venta Nro ' + CAST(@Id_venta AS VARCHAR) + ' registrada con éxito.';

END TRY
BEGIN CATCH

    IF XACT_STATE() <> 0
        ROLLBACK TRANSACTION;

    THROW;

END CATCH;
END;
GO