# Etapa V: Procedimientos y Funciones Almacenadas

## 1. Definición y Objetivo

* **Funciones Almacenadas (User-Defined Functions - UDF):** Son rutinas de código T-SQL que reciben parámetros de entrada, procesan datos y retornan un único valor (escalar) o una tabla de resultados. Su objetivo principal es encapsular cálculos recurrentes y consultas complejas para ser reutilizadas dentro de sentencias `SELECT`, `WHERE` o `JOIN`.
* **Procedimientos Almacenados (Stored Procedures):** Son programas SQL compilados y guardados en la base de datos que ejecutan secuencias de comandos T-SQL. Pueden aceptar parámetros de entrada/salida, modificar el estado de la base de datos (operaciones DML/DDL), controlar el flujo de la lógica de negocio y manejar transacciones. Su objetivo es centralizar reglas de negocio complejas en el servidor de base de datos.

---

## 2. Ventajas y Aplicaciones

* **Centralización de la Lógica de Negocio:** Evita duplicar código T-SQL en múltiples aplicaciones cliente o scripts externos.
* **Reducción del Tráfico de Red:** En lugar de enviar múltiples sentencias SQL individuales desde la aplicación hacia la base de datos, se envía únicamente una llamada de ejecución (`EXEC`).
* **Seguridad y Abstracción de Datos:** Permite otorgar permisos de ejecución (`GRANT EXECUTE`) sobre el procedimiento a usuarios que no poseen permisos directos de inserción, modificación o lectura sobre las tablas base.
* **Rendimiento y Mantenibilidad:** SQL Server optimiza y reutiliza los planes de ejecución creados para los procedimientos almacenados, facilitando el mantenimiento centralizado ante cambios operacionales.

---

## 3. Casos Concretos Aplicados al Sistema de Ventas de Gas Licuado

Para la distribuidora de LPG, se han diseñado e implementado dos componentes clave:

### A. Función Escalar: `dbo.fn_CalcularDescuentoCliente`
* **Problema de Negocio:** Se requiere premiar la fidelización de clientes calculando un porcentaje de descuento automático según el volumen acumulado de compras históricas registrado en la base de datos.
* **Lógica Aplicada:**
  * Total acumulado $> \$500.000,00 \rightarrow$ **10% de descuento (0.10)**.
  * Total acumulado entre $\$200.000,00$ y $\$500.000,00 \rightarrow$ **5% de descuento (0.05)**.
  * Total acumulado $< \$200.000,00$ o cliente nuevo $\rightarrow$ **0% de descuento (0.00)**.

### B. Procedimiento Almacenado: `dbo.sp_RegistrarVentaCompleta`
* **Problema de Negocio:** Registrar una venta de garrafas/cilindros exige realizar múltiples operaciones: validar stock suficiente de garrafas llenas en inventario, registrar la cabecera en `VENTA`, insertar los ítems en `DETALLE_VENTA`, actualizar el stock en `INVENTARIO` (reducir llenas e incrementar vacías) y calcular los totales.
* **Solución Propuesta:** Un procedimiento almacenado que recibe los parámetros del cliente, método de pago, producto, cantidad y precio unitario para procesar todo el flujo de forma segura en un solo paso.