/*NOTA: Tienes que crear la asociación con CIF A01894327 
para poder crear el viaje con código: ED006. Los datos de la asociación son:
Nombre. 'Saudar, Dirección: Plaza de España,27, Población: Jaén,  Teléfono: 900684764,
Labor: Por una Infancia Feliz, Pais: España, Dni_vRes:null*/

INSERT INTO asociacion (cif, nombre, poblacion, direccion, telefono, labor, pais)
VALUES ('A01894327', 'Saudar', 'Jaén', 'Plaza de España,27', '900684764', 'Por una Infancia Feliz');

/*APARTADO B*/

/*1.- Insertar los siguientes datos en la tabla VIAJE teniendo en cuenta que debes 
insertar sólo los valores necesarios en los campos correspondientes.*/

INSERT INTO viaje (codigo, importe, fecha, nombre, cif_aso)
VALUES ('AY004', 1500, '2025-05-10', 'Viaje a Senegal', '00118832X');

INSERT INTO viaje (codigo, importe, fecha, nombre, cif_aso)
VALUES ('HP016', 2100, '2025-04-15', 'Ayuda alimentaria en Etiopía', 'A00113388');

INSERT INTO viaje (codigo, importe, fecha, nombre, cif_aso)
VALUES ('ED006', 1200, '2025-06-18', 'Escuela de Perú', 'A01894327');


/*2.- Actualiza el importe por el que han contratado el viaje 'Salud en Mauritania', 
rebajándolo en un 10%, a todos los clientes que lo hayan contratado. 
(Debes hacerlo con una única sentencia).*/

/*OPCION 1*/
UPDATE contratar, viaje
SET importe_c = importe_c - (importe_c * 0.1)
WHERE codigo_v = codigo
AND nombre = 'Salud en Mauritania';

/*OPCION 2*/
UPDATE contratar
SET importe_c = importe_c - (importe_c * 0.1)
WHERE codigo_v = (SELECT DISTINCT codigo FROM viaje WHERE nombre = 'Salud en Mauritania');

/*3.- Elimina todos los viajes que no hayan sido contratados  
por ningún cliente. (Debes hacerlo con una única sentencia).*/

DELETE FROM viaje
WHERE codigo NOT IN
((SELECT DISTINCT codigo_v FROM contratar));

/*4.- Decrementa el precio de los viajes en 150 euros para todos aquellos viajes  
que hayan sido contratados por menos de 4 clientes.*/

UPDATE viaje
SET importe = importe - 150
WHERE codigo IN (SELECT codigo_v FROM contratar GROUP BY codigo_v HAVING COUNT(*) >= 4);

/*5.- Actualiza el campo “n_viajes” de la tabla CLIENTE  con el número total de  viajes 
que haya contratado cada cliente. ( Debes hacerlo con una única sentencia).*/

UPDATE cliente c 
SET c.n_viajes = 
(
	SELECT COUNT(cont.dni_cli)
    FROM contratar cont 
    WHERE c.dni = cont.dni_cli
);

/*6.- Incrementa en 50 los puntos a todos los voluntarios que pertenezcan a asociaciones 
que hayan organizado dos o más viajes. (Debes hacerlo con una única sentencia).*/

UPDATE voluntario vol
SET vol.puntos = vol.puntos + 50
WHERE vol.cif_asoTra IN
(
	SELECT a.cif 
	FROM asociacion a, contratar cont , viaje v
	WHERE a.cif = v.cif_aso
	AND v.codigo = cont.codigo_v
	GROUP BY a.cif
	HAVING count(*) >= 2
);

/*7.- Insertar en la tabla RECAUDACION_VIAJES,  por cada viaje: 
su código, nombre, fecha, importe y la recaudación total obtenida por todos los clientes 
que han contratado ese viaje ordenados de mayor a menor. (Debes hacerlo con una única sentencia). 
Nota: Antes de realizar la sentencia se debe crear la tabla RECAUDACION_VIAJES.*/

CREATE TABLE RECAUDACION_VIAJES (
codigo VARCHAR (5) PRIMARY KEY,
nombre VARCHAR(50),
fecha DATE,
importe MEDIUMINT UNSIGNED,
recaudacion_total INT 
);

INSERT INTO recaudacion_viajes
SELECT cont.codigo_v, v.nombre, v.fecha, v.importe, SUM(cont.importe_c) as suma
FROM contratar cont JOIN viaje v ON cont.codigo_v = v.codigo
GROUP BY cont.codigo_v
ORDER BY suma DESC
;

/*APARTADO B*/

/*8.- Bloquea la tabla VOLUNTARIO en modo lectura y seguidamente intenta cambiar el tipo de ayuda de ‘Giulia Santos’ por ‘Socióloga’. 
Muestra la captura de pantalla dónde muestre el mensaje resultante.*/

LOCK TABLES voluntario READ;

UPDATE voluntario 
SET tipo_ayuda = 'Socióloga' 
WHERE nombre = 'Giulia'
AND apellidos = 'Santos';

/*9.- Inicia una transacción.*/

START TRANSACTION;

/*Elimina todas las sedes de la asociación ‘Medival’. */

DELETE FROM sede 
WHERE cif_aso = 
(
	SELECT cif 
    FROM asociacion 
    WHERE nombre = 'MEDIVAL'
);

/*Deshaz la transacción y comprueba que los registros no han sido eliminados. */

ROLLBACK;

/*Muestra la captura de pantalla donde se muestre el resultado.*/

SELECT * FROM sede 
WHERE cif_aso = 
(
	SELECT cif_aso 
    FROM asociacion 
    WHERE nombre = 'MEDIVAL'
);






