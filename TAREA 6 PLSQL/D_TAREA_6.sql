CREATE OR REPLACE TRIGGER tarea6_D
AFTER INSERT OR DELETE ON CONTRATAR
FOR EACH ROW

BEGIN
--En caso de que se inserte un nuevo registro en la tabla contratar
IF INSERTING THEN
    UPDATE CLIENTE 
    SET N_VIAJES = N_VIAJES + 1 
    WHERE DNI = :NEW.DNI_CLI;
--En caso de que se borre registro en la tabla contratar
ELSIF DELETING THEN
    UPDATE CLIENTE 
    SET N_VIAJES = N_VIAJES - 1 
    WHERE DNI = :OLD.DNI_CLI;
END IF;

END;

/
--Sentecia para probar el disparador cuando se inserta un nuevo registro en la tabla CONTRATAR
INSERT INTO CONTRATAR VALUES ('88888888H' , 'AY002' , '25/01/24' , 2500);
--Sentecia para probar el disparador cuando se borra registro en la tabla CONTRATAR
DELETE FROM CONTRATAR WHERE DNI_CLI = '88888888H';