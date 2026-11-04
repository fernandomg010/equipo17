# Etapa V: Procedimientos y Funciones Almacenadas

## 1. Definición y Objetivo

* **Funciones Almacenadas (User-Defined Functions - UDF):** Son rutinas de código T-SQL que reciben parámetros de entrada, procesan datos y retornan un único valor (escalar) o una tabla de resultados. Su objetivo principal es encapsular cálculos recurrentes y consultas complejas para ser reutilizadas dentro de sentencias `SELECT`, `WHERE` o `JOIN`.
* **Procedimientos Almacenados (Stored Procedures):** Son programas SQL compilados y guardados en la base de datos que ejecutan secuencias de comandos T-SQL. Pueden aceptar parámetros de entrada/salida, modificar el estado de la base de datos (operaciones DML/DDL), controlar el flujo de la lógica de negocio y manejar transacciones. Su objetivo es centralizar reglas de negocio complejas en el servidor de base de datos.

---

## 2. Ventajas y Aplicaciones

* **Centralización de la Lógica de Negocio:** Evita duplicar código T-SQL en múltiples aplicaciones cliente o scripts externos.
* **Reutilización: permite ejecutar las mismas operaciones mediante llamadas al procedimiento.
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

Script de demostración:
SELECT
    C.Id_cliente,
    C.Nombre,
    dbo.fn_CalcularDescuentoCliente(C.Id_cliente) AS Descuento
FROM CLIENTE AS C;

Resultados obtenidos:
Prueba de la función
Se ejecutó la función sobre los clientes registrados en la base de datos. Entre los resultados observados se encuentran:

Id_cliente	Nombre			Descuento
1		Juan Pérez		0.00
2		María González		0.00
3		Panadería El Sol	0.00
4		Restaurante San Martín	0.00
5		Metalúrgica del Nea	0.05
6		Hospital Escuela	0.00
7		Escuela Técnica N° 1	0.00
8		Distribuidora Norte	0.10
9		Estancia Las Marías	0.00
10		Club Deportivo Regatas	0.00

Pruebas del procedimiento almacenado
Se realizaron pruebas utilizando diferentes valores de entrada.

Escenario
Cantidad negativa: Operación rechazada
Cliente inexistente: Operación rechazada
Método de pago inexistente: Operación rechazada
Stock insuficiente: Operación rechazada
Venta con stock disponible: Operación ejecutada correctamente

Verificación del inventario
Se ejecutó una venta de prueba correspondiente a una garrafa del producto 1.
Los resultados fueron:

Inventario	Antes de la venta	Durante la venta
Garrafas llenas 118			117
Garrafas vacías	45			46

La operación se ejecutó dentro de una transacción externa que posteriormente fue revertida mediante ROLLBACK.
Una consulta posterior confirmó que el inventario volvió a sus valores originales: 118 garrafas llenas y 45 vacías.

Resultado general
Las pruebas permitieron comprobar el funcionamiento de la función de descuentos, las validaciones del procedimiento y la actualización del inventario durante una venta.
Asimismo, se verificó el funcionamiento de ROLLBACK mediante pruebas controladas de transacciones.