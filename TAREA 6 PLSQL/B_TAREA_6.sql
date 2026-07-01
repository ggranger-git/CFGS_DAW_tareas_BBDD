/*
Cramos una variable para cada dato que queremos almacenar. Primero se comprueba
si existe el CIF introducido y en caso negativo asignamos DESCONOCIDA al nombre. 
En caso de que exsta el CIF hacemos las consultas necesarias para obtener el 
nombre, número de voluntarios, número de sedes e importe total que han sido 
inicializadas a 0 para que no aparezca vacío dichos valores en el caso de no
existir el CIF.
*/

--Activamos la salida por consola
SET SERVEROUTPUT ON; 

CREATE OR REPLACE PROCEDURE tarea6_B(vCIF varchar2)
AS
--Declaramos las variables donde se almacenarán los datos
vExisteAso NUMBER := 0;
vNombre VARCHAR2(60);
vNumVol NUMBER := 0;
vNumSedes NUMBER := 0;
vTotal NUMBER(10,2) := 0;

BEGIN

SELECT COUNT(*) INTO vExisteAso FROM ASOCIACION WHERE CIF = vCIF;
IF vExisteAso = 0 THEN
    vNombre := 'DESCONOCIDA';
ELSE
    SELECT NOMBRE INTO vNombre FROM ASOCIACION WHERE CIF = vCIF;
    --Averiguamos el número de voluntarios y lo guardamos en la variable cNumVol
    SELECT COUNT(DNI) INTO vNumVol FROM VOLUNTARIO WHERE CIF_AsoTra = vCIF; 
    --Averiguamos el número de sedes y lo guardamos en la variable vNumSedes
    SELECT COUNT(nSede) INTO vNumSedes FROM SEDE WHERE CIF_aso = vCIF;
    --Averiguamos el total recaudado y lo guardamos en la variable vTotal
    SELECT SUM(importe_c) INTO vTotal FROM VIAJE v, CONTRATAR c 
    WHERE v.CODIGO = c.CODIGO_V
    AND v.CIF_aso = vCIF;
END IF;

--Mostramos cada uno de los datos obtenidos
DBMS_OUTPUT.PUT_LINE('El nombre de la asociación es: ' || vNombre);
DBMS_OUTPUT.PUT_LINE('El número de voluntarios que trabajan en ella es: ' || vNumVol);
DBMS_OUTPUT.PUT_LINE('El número de sedes de las que está compuesta es: ' || vNumSedes);
DBMS_OUTPUT.PUT_LINE('El importe total recaudado en todos sus viajes es: ' || vTotal || ' €');

END tarea6_B;

/
--Sentencia para probar el procedimiento con una asociación que no existe
BEGIN
    tarea6_B('00000000');
END;
/
--Sentencia para probar el procedimiento con una asociación que si existe
BEGIN
    tarea6_B('A00113388');
END;