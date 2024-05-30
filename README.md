# DbGarden Taller
Crear repositorio con la solucion de cada requerimiento de base de datos. El repositorio debe contener Readme con el enumciado de la consulta, la solucion y el resultado obtenido.  Asegurese que todas las consultas arrojen resultados.
## CONSULTAS SOBRE UNA TABLA

1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.

        SELECT O.codigo_oficina as oficina, C.nombre_ciudad as ciudad 
        FROM oficina AS O
        INNER JOIN ciudad as C ON C.codigo_ciudad = O.ciudad;   
    ![](./imagenes/01.png)

2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.

        SELECT
            T.oficina as Oficina ,T.telefono as Telefono
        FROM
            telefono AS T
        WHERE
            T.oficina IN (SELECT  DISTINCT O.codigo_oficina
        FROM pais as P
        JOIN region as R ON P.codigo_pais = R.pais
        JOIN ciudad as C ON  R.pais = C.region
        JOIN oficina as O ON C.codigo_ciudad = O.ciudad
        WHERE P.nombre_pais = 'España'); 
    ![](./imagenes/02.png)

3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo
jefe tiene un código de jefe igual a 7.
