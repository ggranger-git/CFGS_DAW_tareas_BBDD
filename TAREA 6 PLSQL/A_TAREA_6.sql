/*
El procedimiento contiene dos consultas. Una para averiguar si el DNI introducido
por parámetro existe en la tabla CLIENTES y otra para obtener los datos de las
asociaciones con la que el cliente ha contratado. Para ello necesitamos consultar
las tablas CLIENTE, ASOCIACION, VIAJE y CONTRATAR. 
Mediante un SELECT COUNT cuyo valor guardaremos en una variable controlamos si la 
consulta DNI devuelve resultados. En caso negativo mostramos mensaje. 
Con un IF verificamos si el DNI previamente comprobado posee contrataciones o no.
Para ello usaremos un cursor para practicar el FETCH y %FOUND.
En caso negativo mostramos mesaje y en caso afirmativo listamos los resultados 
recorriendo la consulta con un WHILE LOOP.
*/

--Activamos la salida por consola
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE tarea6_A(vDNI varchar2)
AS

--Creamos una variable para guardar el resultado de un SELEC COUNT posterior
vExisteDNI NUMBER;
--Creamos el cursor para buscar los viajes contratados en caso de que exista el DNI
CURSOR cViajes IS 
    SELECT A.CIF, A.NOMBRE, A.TELEFONO, COUNT(V.CODIGO) AS N_VIAJES 
    FROM ASOCIACION A, VIAJE V, CONTRATAR CONT, CLIENTE C
    WHERE C.DNI = CONT.DNI_CLI
    AND CONT.CODIGO_V = V.CODIGO
    AND V.CIF_ASO = A.CIF
    AND C.DNI = vDNI
    GROUP BY A.CIF, A.NOMBRE, A.TELEFONO;
--Declaramos variable para almacenar cada linea de la consulta    
vConsulta cViajes%ROWTYPE;

BEGIN

--Comprobamos si el DNI existe haciendo un SELECT COUNT y volcando el resultado en vExisteDNI
SELECT COUNT(*) INTO vExisteDNI FROM CLIENTE WHERE DNI = vDNI;

--Encaso de que la consulta no haya obtenido ningún resultado vExisteDNI será 0
IF vExisteDNI = 0 THEN
    DBMS_OUTPUT.PUT_LINE('El cliente no está dado de alta');
    
--Si por el contrario la consulta obtiene resultados (por tanto el DNI existe) abrimos cursor
ELSE
    OPEN cViajes;
    FETCH cViajes INTO vConsulta;
    --SI hay contrataciones (la consulta tiene resultados)recorremos el cursor
    --Primero mostramos la cabecera (una sóla vez)
    IF cViajes%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('El cliente con DNI ' || vDNI || ' ha realizado viajes con:');
        DBMS_OUTPUT.PUT_LINE(
            RPAD('CIF', 15, ' ')      || 
            RPAD('NOMBRE', 15, ' ')   || 
            RPAD('TELÉFONO', 15, ' ') || 
            LPAD('Núm.Viajes', 10, ' ')
             );
        DBMS_OUTPUT.PUT_LINE(RPAD('-', 55, '-'));
        --Luego hacemos un bucle para listar todos los resultados
        WHILE cViajes%FOUND LOOP
            DBMS_OUTPUT.PUT_LINE(
            RPAD(vConsulta.CIF, 15, ' ')      || 
            RPAD(vConsulta.NOMBRE, 15, ' ')   || 
            RPAD(vConsulta.TELEFONO, 15, ' ') || 
            LPAD(vConsulta.N_VIAJES, 10, ' ')
             );
            FETCH cViajes INTO vConsulta;
         END LOOP;
         --Cerramos cursor cViajes
         CLOSE cViajes;
    --NO hay contrataciones (la consulta no tiene resultados)
    ELSE
        DBMS_OUTPUT.PUT_LINE('No hay viajes para el cliente con DNI ' || vDNI);
        --Cerramos cursor cViajes
        CLOSE cViajes;
    --Cerramos el IF de la comprobación de si existen contrataciones
    END IF;

--Cerramos el IF de la comprobacion del DNI
END IF;
--Cerramos el procedimiento
END tarea6_A;
/

--Sentencia para probar el procedimiento con un cliente que existe
BEGIN
    tarea6_A('11111111A');
END;
/
--Sentencia para probar el procedimiento con un cliente que no existe
BEGIN
    tarea6_A('00000000');
END;
/
--Sentencia para probar el procedimiento con un cliente que no tiene viajes
BEGIN
    tarea6_A('88888888H');
END;