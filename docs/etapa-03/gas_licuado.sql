CREATE DATABASE gas_licuado;
GO
USE gas_licuado;
GO

-- 1. Tabla TIPO_CLIENTE
CREATE TABLE TIPO_CLIENTE (
    Id_tipo_cliente INT IDENTITY(1,1) PRIMARY KEY,
    Descripcion VARCHAR(100) NOT NULL
);

-- 2. Tabla CLIENTE
CREATE TABLE CLIENTE (
    Id_cliente INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Telefono VARCHAR(30) UNIQUE,
    Cuit VARCHAR(20) UNIQUE,
    Calle VARCHAR(100),
    Altura VARCHAR(20),
    Localidad VARCHAR(100),
    Id_tipo_cliente INT NOT NULL,
    CONSTRAINT fk_cliente_tipo FOREIGN KEY (Id_tipo_cliente) REFERENCES TIPO_CLIENTE(Id_tipo_cliente)
);

-- 3. Tabla MÉTODO_PAGO
CREATE TABLE METODO_PAGO (
    Id_metodo_pago INT IDENTITY(1,1) PRIMARY KEY,
    Descripcion VARCHAR(100) NOT NULL
);

-- 4. Tabla VENTA
CREATE TABLE VENTA (
    Id_venta INT IDENTITY(1,1) PRIMARY KEY,
    Fecha DATETIME NOT NULL,
    Modalidad VARCHAR(50),
    Total DECIMAL(10, 2) NOT NULL,
    Id_cliente INT NOT NULL,
    Id_metodo_pago INT NOT NULL,
    CONSTRAINT fk_venta_cliente FOREIGN KEY (Id_cliente) REFERENCES CLIENTE(Id_cliente),
    CONSTRAINT fk_venta_metodo FOREIGN KEY (Id_metodo_pago) REFERENCES METODO_PAGO(Id_metodo_pago)
);

-- 5. Tabla PRODUCTO
CREATE TABLE PRODUCTO (
    Id_producto INT IDENTITY(1,1) PRIMARY KEY,
    Descripcion VARCHAR(100) NOT NULL,
    Capacidad VARCHAR(50),
    Precio_lista DECIMAL(10, 2) NOT NULL
);

-- 6. Tabla DETALLE_VENTA
CREATE TABLE DETALLE_VENTA (
    Id_producto INT NOT NULL,
    Id_venta INT NOT NULL,
    Cantidad INT NOT NULL,
    Precio_unitario DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (Id_producto, Id_venta),
    CONSTRAINT fk_detalle_producto FOREIGN KEY (Id_producto) REFERENCES PRODUCTO(Id_producto),
    CONSTRAINT fk_detalle_venta FOREIGN KEY (Id_venta) REFERENCES VENTA(Id_venta)
);

-- 7. Tabla INVENTARIO
CREATE TABLE INVENTARIO (
    Id_inventario INT IDENTITY(1,1) PRIMARY KEY,
    Garrafas_vacias INT NOT NULL,
    Garrafas_llenas INT NOT NULL,
    Id_producto INT NOT NULL,
    CONSTRAINT fk_inventario_producto FOREIGN KEY (Id_producto) REFERENCES PRODUCTO(Id_producto)
);