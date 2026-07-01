CREATE OR REPLACE FUNCTION tarea6_C (vNom VARCHAR2, vApe VARCHAR2)
RETURN NUMBER
AS

vNumClientes NUMBER;
vImporte NUMBER(10,2);

BEGIN

SELECT COUNT(*) INTO vNumClientes FROM CLIENTE WHERE NOMBRE = vNom AND APELLIDOS = vApe;

IF vNumClientes = 0 THEN 
     vImporte := -1;
ELSIF vNumClientes > 1 THEN 
     vImporte := -2;
ELSE 
    -- Si hay exactamente un cliente, obtenemos el importe
    SELECT COALESCE(SUM(IMPORTE_C), 0) INTO vImporte
    FROM CONTRATAR cont 
    JOIN CLIENTE c ON cont.DNI_CLI = c.DNI
    WHERE c.NOMBRE = vNom AND c.APELLIDOS = vApe;
END IF;

RETURN vImporte;

END tarea6_C;

/
--Sentencia pra probar el funcionamiento de la función
SELECT DNI, NOMBRE, APELLIDOS, tarea6_C(NOMBRE, APELLIDOS) AS IMPORTE_TOTAL
FROM CLIENTE;