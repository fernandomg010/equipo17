\# Casos de uso del sistema de comercialización de garrafas de GLP

\#\# 1\. Introducción

El presente documento describe los principales casos de uso del sistema de comercialización y distribución de garrafas de Gas Licuado de Petróleo (GLP). El sistema permite gestionar clientes, registrar ventas, consultar productos, controlar el inventario de garrafas llenas y vacías, y generar comprobantes de las operaciones realizadas.

El sistema contempla ventas realizadas directamente en mostrador y ventas con entrega a domicilio, destinadas a clientes particulares, comercios e industrias.

\#\# 2\. Actores del sistema

Se identifican los siguientes actores:

\*\*Vendedor:\*\* es el usuario responsable de registrar las ventas, consultar los productos disponibles, seleccionar el método de pago y emitir o consultar comprobantes.

\*\*Cliente:\*\* es quien adquiere las garrafas. Puede ser un particular, un comercio o una industria. Proporciona los datos necesarios para identificar la operación y recibe el producto adquirido.

Los actores representan roles funcionales. Su implementación como usuarios independientes del sistema dependerá del alcance definitivo del proyecto.

\#\# 3\. Listado de casos de uso

| Código | Caso de uso | Actor principal |  
|---|---|---|  
| CU-01 | Registrar cliente | Vendedor |  
| CU-02 | Consultar cliente | Vendedor |  
| CU-03 | Consultar productos y precios | Vendedor |  
| CU-04 | Registrar venta | Vendedor |  
| CU-05 | Generar comprobante de venta | Vendedor |  
| CU-06 | Consultar ventas realizadas | Vendedor |  
| CU-07 | Consultar inventario | Responsable de inventario |  
| CU-08 | Actualizar inventario | Responsable de inventario |  
| CU-09 | Administrar productos | Administrador del sistema |  
| CU-10 | Administrar métodos de pago | Administrador del sistema |

\#\# 4\. Descripción de los casos de uso principales

\#\#\# CU-01: Registrar cliente

\*\*Objetivo:\*\* incorporar un nuevo cliente al sistema.

\*\*Actor principal:\*\* vendedor.

\*\*Precondiciones:\*\* el sistema debe estar disponible y el usuario debe tener permisos para registrar clientes.

\*\*Flujo principal:\*\*

1\. El vendedor solicita registrar un nuevo cliente.  
2\. El sistema solicita los datos identificatorios y de contacto.  
3\. El vendedor ingresa nombre, teléfono, CUIT, domicilio y tipo de cliente, según corresponda.  
4\. El sistema valida los datos obligatorios y comprueba que no existan duplicados en los campos únicos.  
5\. El sistema registra el cliente y asigna un identificador.

\*\*Flujos alternativos:\*\*

\- Si falta un dato obligatorio, el sistema informa el error y solicita corregirlo.  
\- Si el teléfono o CUIT ya está registrado, el sistema informa la duplicación y evita registrar otro cliente con el mismo valor.

\*\*Postcondición:\*\* el cliente queda disponible para asociarlo a futuras ventas.

\*\*Tablas involucradas:\*\* \`CLIENTE\`, \`TIPO\_CLIENTE\`.

\#\#\# CU-03: Consultar productos y precios

\*\*Objetivo:\*\* permitir que el vendedor conozca los productos disponibles para la comercialización.

\*\*Actor principal:\*\* vendedor.

\*\*Precondiciones:\*\* los productos deben estar registrados en el sistema.

\*\*Flujo principal:\*\*

1\. El vendedor solicita consultar los productos.  
2\. El sistema recupera la descripción, la capacidad y el precio de lista.  
3\. El vendedor selecciona el producto que desea comercializar.  
4\. El sistema permite utilizar esa información para registrar la venta.

\*\*Postcondición:\*\* el vendedor dispone de la información necesaria para preparar la operación.

\*\*Tablas involucradas:\*\* \`PRODUCTO\`, \`INVENTARIO\`.

\#\#\# CU-04: Registrar venta

\*\*Objetivo:\*\* registrar una operación comercial, incluyendo los productos, las cantidades, los precios aplicados y el método de pago.

\*\*Actor principal:\*\* vendedor.

\*\*Precondiciones:\*\*

\- El cliente debe estar registrado.  
\- Los productos deben existir en el sistema.  
\- Debe existir un método de pago válido.  
\- Debe verificarse la disponibilidad de las garrafas necesarias para completar la operación.

\*\*Flujo principal:\*\*

1\. El vendedor inicia una nueva venta.  
2\. El sistema solicita seleccionar al cliente.  
3\. El vendedor indica la modalidad de venta: mostrador o entrega a domicilio.  
4\. El vendedor agrega los productos y las cantidades solicitadas.  
5\. El sistema recupera los precios correspondientes y calcula los subtotales.  
6\. El sistema calcula el total de la operación.  
7\. El vendedor selecciona el método de pago.  
8\. El sistema valida los datos de la venta y la disponibilidad del inventario.  
9\. El sistema registra el encabezado en \`VENTA\`.  
10\. El sistema registra los productos vendidos en \`DETALLE\_VENTA\`.  
11\. El sistema actualiza las existencias de garrafas llenas y vacías según las reglas de inventario definidas.  
12\. El sistema confirma que la venta se registró correctamente.

\*\*Flujos alternativos:\*\*

\- Si el cliente no existe, el vendedor debe registrarlo antes de continuar.  
\- Si no hay existencias suficientes, el sistema informa la situación y no permite confirmar la venta con una cantidad superior a la disponible.  
\- Si el usuario ingresa una cantidad inválida, el sistema solicita corregirla.  
\- Si ocurre un error durante el registro, la operación debe cancelarse o revertirse para evitar que el encabezado, el detalle y el inventario queden inconsistentes.

\*\*Postcondiciones:\*\*

\- La venta queda registrada.  
\- Los productos vendidos quedan asociados a la operación.  
\- El total registrado coincide con la suma de los subtotales.  
\- El inventario queda actualizado de acuerdo con la operación realizada.

\*\*Tablas involucradas:\*\* \`VENTA\`, \`DETALLE\_VENTA\`, \`CLIENTE\`, \`METODO\_PAGO\`, \`PRODUCTO\`, \`INVENTARIO\`.

\#\#\# CU-05: Generar comprobante de venta

\*\*Objetivo:\*\* presentar de forma consolidada la información de una venta registrada.

\*\*Actor principal:\*\* vendedor.

\*\*Precondiciones:\*\* debe existir una venta registrada con su correspondiente detalle.

\*\*Flujo principal:\*\*

1\. El vendedor selecciona una venta.  
2\. El sistema recupera los datos del encabezado.  
3\. El sistema obtiene los datos del cliente y el método de pago.  
4\. El sistema recupera los productos, las cantidades y los precios unitarios.  
5\. El sistema calcula el subtotal de cada renglón.  
6\. El sistema suma los subtotales para obtener el total de la venta.  
7\. El sistema presenta el comprobante con los datos de la operación.

\*\*Flujos alternativos:\*\*

\- Si el identificador no corresponde a una venta existente, el sistema informa que no se encontró la operación.  
\- Si la venta no tiene productos asociados, el sistema informa que no es posible generar un comprobante completo.

\*\*Postcondición:\*\* el comprobante queda disponible para su consulta o impresión, si esa funcionalidad está implementada.

\*\*Tablas involucradas:\*\* \`VENTA\`, \`DETALLE\_VENTA\`, \`CLIENTE\`, \`METODO\_PAGO\`, \`PRODUCTO\`.

\*\*Restricción:\*\* la consulta desarrollada genera una representación interna de la venta. No constituye por sí misma una factura fiscal autorizada.

\#\#\# CU-06: Consultar ventas realizadas

\*\*Objetivo:\*\* consultar las operaciones registradas para facilitar el seguimiento comercial.

\*\*Actor principal:\*\* vendedor.

\*\*Precondiciones:\*\* deben existir ventas registradas.

\*\*Flujo principal:\*\*

1\. El vendedor solicita consultar las ventas.  
2\. El sistema presenta los registros disponibles.  
3\. El vendedor selecciona una operación para ver sus detalles.  
4\. El sistema muestra el encabezado, los productos vendidos y los importes correspondientes.

\*\*Flujos alternativos:\*\*

\- Si no existen ventas para los criterios de búsqueda, el sistema informa que no se encontraron resultados.

\*\*Postcondición:\*\* el vendedor obtiene información sobre las operaciones realizadas.

\*\*Tablas involucradas:\*\* \`VENTA\`, \`CLIENTE\`, \`METODO\_PAGO\`, \`DETALLE\_VENTA\`, \`PRODUCTO\`.

\#\#\# CU-07: Consultar inventario

\*\*Objetivo:\*\* conocer la cantidad de garrafas llenas y vacías registradas para cada producto.

\*\*Actor principal:\*\* responsable de inventario.

\*\*Precondiciones:\*\* los productos y sus registros de inventario deben existir.

\*\*Flujo principal:\*\*

1\. El responsable solicita consultar el inventario.  
2\. El sistema recupera las existencias registradas.  
3\. El sistema presenta las cantidades de garrafas llenas y vacías para cada producto.

\*\*Flujos alternativos:\*\*

\- Si un producto no tiene un registro de inventario, el sistema informa que no dispone de información de existencias para ese producto.

\*\*Postcondición:\*\* el responsable conoce las existencias registradas.

\*\*Tablas involucradas:\*\* \`INVENTARIO\`, \`PRODUCTO\`.

\#\#\# CU-08: Actualizar inventario

\*\*Objetivo:\*\* mantener actualizadas las existencias de garrafas llenas y vacías.

\*\*Actor principal:\*\* responsable de inventario.

\*\*Precondiciones:\*\* el producto debe estar registrado y el usuario debe tener autorización para modificar las existencias.

\*\*Flujo principal:\*\*

1\. El responsable selecciona el producto.  
2\. El sistema muestra las cantidades actuales.  
3\. El responsable registra las cantidades correspondientes al movimiento de inventario.  
4\. El sistema valida que los valores sean enteros no negativos.  
5\. El sistema guarda la actualización.

\*\*Flujos alternativos:\*\*

\- Si se ingresan cantidades negativas o inválidas, el sistema rechaza los datos.  
\- Si el producto no existe, no se permite realizar la actualización.

\*\*Postcondición:\*\* las existencias quedan actualizadas.

\*\*Tablas involucradas:\*\* \`INVENTARIO\`, \`PRODUCTO\`.

\#\# 5\. Relaciones entre los casos de uso

El registro de una venta requiere consultar los productos, identificar al cliente y seleccionar un método de pago. Una vez completada la operación, el usuario puede generar el comprobante y consultar la venta posteriormente.

La consulta y actualización del inventario complementan el proceso comercial, ya que permiten controlar las existencias y evitar registrar ventas que superen la disponibilidad real.

Estas relaciones representan dependencias funcionales del proceso. Si se elabora un diagrama UML, pueden utilizarse relaciones \`include\` para las funcionalidades obligatorias reutilizadas por otros casos de uso y \`extend\` para comportamientos opcionales que se ejecutan bajo determinadas condiciones.

