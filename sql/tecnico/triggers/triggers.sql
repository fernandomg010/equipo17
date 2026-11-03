-- 1. Creación de la tabla de auditoría para el esquema gas_licuado
CREATE TABLE AUDITORIA_PRODUCTO (
    Id_auditoria INT IDENTITY(1,1) PRIMARY KEY,
    Fecha_hora DATETIME NOT NULL DEFAULT GETDATE(),
    Usuario VARCHAR(100) NOT NULL,
    Id_producto INT NOT NULL,
    Descripcion_producto VARCHAR(100) NOT NULL,
    Precio_anterior DECIMAL(10,2) NOT NULL,
    Precio_nuevo DECIMAL(10,2) NOT NULL,
    Tipo_operacion VARCHAR(20) NOT NULL
);
GO

-- 2. Creación del Trigger de Auditoría sobre la tabla PRODUCTO
CREATE TRIGGER trg_auditoria_precio_producto
ON PRODUCTO
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Verificamos si realmente se modificó el precio de lista
    IF UPDATE(Precio_lista)
    BEGIN
        INSERT INTO AUDITORIA_PRODUCTO (
            Fecha_hora,
            Usuario,
            Id_producto,
            Descripcion_producto,
            Precio_anterior,
            Precio_nuevo,
            Tipo_operacion
        )
        SELECT 
            GETDATE(),
            SYSTEM_USER,
            i.Id_producto,
            i.Descripcion,
            d.Precio_lista,  -- Precio antes del cambio
            i.Precio_lista,  -- Precio nuevo actualizado
            'UPDATE'
        FROM deleted d
        INNER JOIN inserted i ON d.Id_producto = i.Id_producto;
    END
END;
GO