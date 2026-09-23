Reglas de Negocio (RN)

RN.01 - Asociación Cliente - Venta: Un cliente puede realizar múltiples compras (registradas

como ventas en el sistema), pero cada venta está asociada a un único cliente.

RN.02 - Estructura de la Venta: Una venta debe contener al menos un producto en su

detalle y asociar exactamente un método de pago.

RN.03 - Histórico de Precios: Cada renglón del detalle de venta debe almacenar el precio

unitario pactado al momento de la operación, independiente del precio de lista actual del

producto.

RN.04 - Control de Disponibilidad: Una venta solo puede concretarse si la cantidad de

garrafas solicitada es menor o igual al stock disponible de garrafas llenas en depósito.

RN.05 - Correspondencia de Envases: Por cada garrafa llena vendida, la operación debe

registrar la recepción de un envase vacío equivalente o, en su defecto, el cobro de un

envase nuevo.

RN.06 - Modificación de Inventario: La confirmación de una venta descuenta unidades del

stock de garrafas llenas e incrementa en igual cantidad el stock de envases vacíos.

RN.07 - Entregas a Domicilio y Zonas: Una venta con modalidad de envío a domicilio debe

asociar obligatoriamente una dirección y una zona de reparto, la cual determina el costo de

envío aplicable.

RN.08 - Crédito Comercial: Un cliente comercial puede registrar un límite de crédito máximo

que condiciona el monto permitido para sus ventas a crédito sin cancelar.

