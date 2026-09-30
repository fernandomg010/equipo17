USE gas_licuado;
GO

-- 1. Poblado de TIPO_CLIENTE (10 registros)
INSERT INTO TIPO_CLIENTE (Descripcion) VALUES
('Residencial'),
('Comercial'),
('Industrial'),
('Gubernamental'),
('Educativo'),
('Salud'),
('Agropecuario'),
('Distribuidor'),
('Sin Fines de Lucro'),
('Evento Temporal');

-- 2. Poblado de CLIENTE (10 registros)
INSERT INTO CLIENTE (Nombre, Telefono, Cuit, Calle, Altura, Localidad, Id_tipo_cliente) VALUES
('Juan Pérez', '3794112233', '20-35412879-8', 'Av. 3 de Abril', '1240', 'Corrientes', 1),
('María González', '3794223344', '27-38991234-4', 'Junín', '850', 'Corrientes', 1),
('Panadería El Sol', '3794334455', '30-71123456-9', 'Mendoza', '432', 'Corrientes', 2),
('Restaurante San Martín', '3794445566', '30-72234567-1', 'San Martín', '1560', 'Corrientes', 2),
('Metalúrgica del Nea', '3794556677', '30-65432109-8', 'Ruta 12', 'Km 1020', 'Riachuelo', 3),
('Hospital Escuela', '3794667788', '30-60001234-5', 'Av. Cazadores de Correntinos', '3200', 'Corrientes', 6),
('Escuela Técnica N° 1', '3794778899', '30-60005678-2', 'Belgrano', '910', 'Corrientes', 5),
('Distribuidora Norte', '3794889900', '30-73345678-3', 'Av. Maipú', '2100', 'Corrientes', 8),
('Estancia Las Marías', '3794990011', '30-54321678-0', 'Ruta Provincial 5', 'Km 12', 'Laguna Brava', 7),
('Club Deportivo Regatas', '3794001122', '30-52123456-7', 'Parque Mitre', 's/n', 'Corrientes', 9);

-- 3. Poblado de METODO_PAGO (10 registros)
INSERT INTO METODO_PAGO (Descripcion) VALUES
('Efectivo'),
('Tarjeta de Débito'),
('Tarjeta de Crédito'),
('Transferencia Bancaria'),
('Mercado Pago'),
('Cheque'),
('Cuenta Corriente'),
('Pago QR'),
('Vale Corporativo'),
('Depósito Directo');

-- 4. Poblado de PRODUCTO (10 registros)
INSERT INTO PRODUCTO (Descripcion, Capacidad, Precio_lista) VALUES
('Garrafa de Gas 10kg', '10 kg', 12000.00),
('Garrafa de Gas 15kg', '15 kg', 18000.00),
('Cilindro de Gas 45kg', '45 kg', 52000.00),
('Garrafa para Autoelevador', '15 kg', 21000.00),
('Garrafa de Camping 2kg', '2 kg', 4500.00),
('Garrafa de Camping 3kg', '3 kg', 6000.00),
('Cilindro Propano Industrial 45kg', '45 kg', 58000.00),
('Tanque Estacionario 1000L', '1000 L', 850000.00),
('Regulador de Presión Estándar', 'N/A', 8500.00),
('Manguera de Alta Presión 1.5m', '1.5 m', 4200.00);

-- 5. Poblado de VENTA (10 registros)
INSERT INTO VENTA (Fecha, Modalidad, Total, Id_cliente, Id_metodo_pago) VALUES
('2026-09-01 08:30:00', 'Mostrador', 12000.00, 1, 1),
('2026-09-02 10:15:00', 'Envío a domicilio', 36000.00, 2, 5),
('2026-09-03 11:45:00', 'Envío a domicilio', 104000.00, 3, 4),
('2026-09-05 09:00:00', 'Mostrador', 52000.00, 4, 3),
('2026-09-08 14:20:00', 'Planta', 232000.00, 5, 7),
('2026-09-10 16:00:00', 'Envío a domicilio', 156000.00, 6, 4),
('2026-09-12 10:30:00', 'Mostrador', 18000.00, 7, 2),
('2026-09-15 08:00:00', 'Planta', 520000.00, 8, 4),
('2026-09-20 12:10:00', 'Envío a domicilio', 116000.00, 9, 7),
('2026-09-25 17:45:00', 'Mostrador', 24000.00, 10, 1);

-- 6. Poblado de DETALLE_VENTA (10 registros)
INSERT INTO DETALLE_VENTA (Id_producto, Id_venta, Cantidad, Precio_unitario) VALUES
(1, 1, 1, 12000.00),
(1, 2, 3, 12000.00),
(3, 3, 2, 52000.00),
(3, 4, 1, 52000.00),
(7, 5, 4, 58000.00),
(3, 6, 3, 52000.00),
(2, 7, 1, 18000.00),
(3, 8, 10, 52000.00),
(7, 9, 2, 58000.00),
(1, 10, 2, 12000.00);

-- 7. Poblado de INVENTARIO (10 registros)
INSERT INTO INVENTARIO (Garrafas_vacias, Garrafas_llenas, Id_producto) VALUES
(45, 120, 1),
(30, 85, 2),
(15, 40, 3),
(10, 25, 4),
(5, 50, 5),
(8, 40, 6),
(12, 35, 7),
(0, 5, 8),
(0, 50, 9),
(0, 60, 10);
GO