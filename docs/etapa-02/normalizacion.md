Evidencia de 1FN en el diagramaAtributos atómicos: En CLIENTE, la dirección no está amontonada en un solo campo de texto. Se separó en Calle, Altura y Localidad.Sin grupos repetitivos: Para evitar poner columnas repetidas como producto1, producto2 o listas de productos en una misma celda dentro de VENTA, se creó la tabla intermedia DETALLE\_VENTA. Cada fila guarda un solo producto asociado a una venta. 



&#x20; Evidencia de 2FN en el diagramaClave compuesta analizada: La única tabla con clave primaria compuesta es DETALLE\_VENTA, formada por (Id\_producto, Id\_venta).Sin dependencias parciales: Los atributos no clave de esta tabla (Cantidad y Precio\_unitario) dependen de la combinación entera de la clave: la cantidad y el precio cobrado corresponden a ese producto en esa venta específica.   Aislamiento de atributos: Datos propios del producto (como Descripción, Capacidad y Precio\_lista) no están en DETALLE\_VENTA porque dependerían solo de Id\_producto. Por eso se aislaron en la tabla PRODUCTO.



Evidencia de 3FN en el diagramaSin dependencias transitivas: Se sacaron los atributos que dependían de otros atributos no clave para evitar datos redundantemente encadenados.   Separación de entidades asociadas:En vez de poner la descripción del tipo de cliente dentro de CLIENTE, se creó la tabla TIPO\_CLIENTE y en CLIENTE solo se dejó la clave foránea Id\_tipo\_cliente (FK).   Lo mismo pasa con MÉTODO\_PAGO: la descripción del pago no está en VENTA, sino en su propia tabla, dejando en VENTA únicamente la clave foránea Id\_metodo\_pago (FK)

