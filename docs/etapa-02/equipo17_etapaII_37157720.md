Contribución individual -- Etapa II

**Equipo:** 17  
**Integrante:** Fernando Mas González  
**Fecha:** 2026-09-23

## 1. Aporte realizado

Realicé el Diagrama Entidad-Relación, definiendo entidades, atributos, relaciones y cardinalidades.
También hice el proceso de normalización del modelo.

## 2. Decisiones en las que participé

En la entidad Cliente propuse que dirección sea un atributo compuesto por calle, altura y localidad, cumpliendo con la primera formalización. Propuse quitar del diagrama la zona de reparto.
También participé en la decisión de incorporar "tipo_cliente" como una entidad relacionada con cliente, permitiendo clasificar los distintos tipos de clientes sin repetir esa información en cada registro.

Asimismo, participé en la definición de las relaciones y cardinalidades utilizadas en el DER y en su posterior transformación al modelo relacional.

## 3. Problemas o dificultades identificadas

Una de las principales dificultades fue determinar cómo representar correctamente algunos datos del dominio y diferenciar cuándo correspondía utilizar un atributo, un atributo compuesto o una entidad independiente.
Determinar si una entidad tenia sentido que permanezca como parte del diagrama, como zona_reparto, buscando mayor simplicidad para el futuro manejo de los dato.

## 4. Soluciones o propuestas realizadas
Descomponer la dirección del cliente en calle, altura y localidad, y crear la entidad tipo_cliente para gestionar esos datos.
Para la normalización se revisaron las relaciones del modelo verificando la atomicidad de los atributos, las dependencias respecto de las claves y la existencia de posibles dependencias transitivas.

## 5. Evidencias en el repositorio

- docs/etapa-02/DER/DER_PlantaGLP.png: Diagrama Entidad-Relación realizado durante la etapa.
- docs/etapa-02/Relational_Schema_PlantaGLP.png: esquema correspondiente al modelo relacional.
- Commit 5b0e72a – DER y Schema: incorporación del DER y del esquema relacional al repositorio.
- Commit ada3b13 – Modificacion de carpetas: reorganización de los archivos según la estructura definida para la Etapa II.

## 6. Reflexión individual

Durante esta etapa pude comprender mejor cómo pasar de los requerimientos de un sistema a un modelo conceptual y posteriormente a un modelo relacional. También logré afianzar conceptos como entidades, atributos compuestos, cardinalidades, claves primarias y foráneas y, principalmente, el proceso de normalización.