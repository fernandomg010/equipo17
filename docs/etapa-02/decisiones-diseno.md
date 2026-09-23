1. Modelado de Clientes y Atributo Compuesto para la Dirección
Qué se hizo: Se creó la entidad Cliente con un atributo compuesto (Dirección) que se desglosa en Calle, Altura y Localidad, además de asociarlo a un Tipo_Cliente.

Por qué se decidió de esta forma:

Dirección Compuesta: Se separó la dirección en subcomponentes para facilitar la validación de datos, la organización geográfica, la impresión correcta en facturas y futuras consultas de envíos o logística por zona.

Tipo de Cliente: Se externalizó en una entidad independiente para estandarizar las categorías (por ejemplo: mayorista, minorista, distribuidor) en lugar de usar un campo de texto libre. Esto asegura la integridad referencial y permite aplicar reglas de negocio específicas (descuentos, límites de crédito) según el tipo.

2. Relación de Ventas con Métodos de Pago
Qué se hizo: La entidad Venta se conecta mediante una relación directa con la entidad Método_Pago.

Por qué se decidió de esta forma:

Se evitó almacenar el método de pago como un simple texto dentro de la venta para normalizar la información y evitar errores de tipeo.

Permite escalar el sistema fácilmente si se agregan nuevas formas de pago en el futuro (tarjetas, transferencias, efectivo, cuentas corrientes) sin modificar la estructura de la tabla de ventas.

3. Uso de la entidad intermedia Detalle_Venta
Qué se hizo: Se implementó la entidad Detalle_Venta entre Venta y Producto.

Por qué se decidió de esta forma:

Resuelve una relación de muchos a muchos (N:M) natural entre una venta y los productos (una venta puede incluir varios productos, y un producto puede venderse en múltiples transacciones).

Permite registrar datos específicos que varían por cada ítem transaccionado, como la Cantidad exacta comprada y el Precio_unitario vigente al momento de la venta (protegiendo el histórico ante futuros cambios de lista de precios).

4. Relación entre Producto e Inventario
Qué se hizo: Se relacionó la entidad Producto con la entidad Inventario, la cual incluye atributos específicos como Garrafas_vacias y Garrafas_llenas.

Por qué se decidió de esta forma:

El negocio maneja un tipo de producto específico (gas envasado/garrafas) que requiere un control dual del envase físico además del producto comercializado.

Separar el stock en vacías y llenas permite llevar una trazabilidad operativa precisa del parque de envases, controlando tanto la mercadería para la venta como el recupero de envases vacíos entregados por los clientes.