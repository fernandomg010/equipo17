USE gas_licuado;
GO

IF OBJECT_ID('dbo.fn_CalcularDescuentoCliente', 'FN') IS NOT NULL
    DROP FUNCTION dbo.fn_CalcularDescuentoCliente;
GO

CREATE FUNCTION dbo.fn_CalcularDescuentoCliente
(
    @Id_cliente INT
)
RETURNS DECIMAL(5, 2)
AS
BEGIN
    DECLARE @TotalAcumulado DECIMAL(10, 2);
    DECLARE @Descuento DECIMAL(5, 2) = 0.00;

    -- Calcular monto acumulado histórico del cliente
    SELECT @TotalAcumulado = ISNULL(SUM(Total), 0.00)
    FROM VENTA
    WHERE Id_cliente = @Id_cliente;

    -- Evaluar escala de descuentos
    IF @TotalAcumulado > 500000.00
        SET @Descuento = 0.10; -- 10%
    ELSE IF @TotalAcumulado >= 200000.00
        SET @Descuento = 0.05; -- 5%
    ELSE
        SET @Descuento = 0.00; -- 0%

    RETURN @Descuento;
END;
GO