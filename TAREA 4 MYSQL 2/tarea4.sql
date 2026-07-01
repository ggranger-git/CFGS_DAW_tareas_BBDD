/*1.- Listar todos los clientes de la base de datos.*/

SELECT * FROM cliente;

/*2.- Obtener un listado con el DNI, nombre y apellidos de los voluntarios cuyo país de 
nacionalidad sea España o Ecuador. El listado debe estar ordenado por apellidos.*/

SELECT dni, nombre, apellidos FROM voluntario WHERE pais_na IN ('España' , 'Ecuador')
ORDER BY apellidos ASC;

/*3.- Mostrar el DNI del cliente, el código del viaje y también la fecha y el importe 
en el que cada cliente contrató un viaje durante el primer semestre del año 2024.*/

SELECT c.dni, v.codigo, con.fecha_c, con.importe_c FROM cliente c, viaje v, contratar con 
WHERE c.dni = con.dni_cli AND v.codigo = con.codigo_v 
AND fecha_C BETWEEN '2024-01-01' AND '2024-06-30';

/*4.- Obtener por cada viaje, su código y el importe total recaudado a partir 
de los importes con los que contrataron sus viajes los diferentes clientes.*/

SELECT v.codigo, sum(c.importe_c) Total_Recaudado FROM viaje v, contratar c 
WHERE c.codigo_v = v.codigo GROUP BY v.codigo;

/*5.- Crear un listado con el nombre de la asociación, el nombre del viaje que organiza 
y la fecha del viaje en formato DD/MM/AAAA ordenando el listado por la fecha desde la más reciente hasta la más antigua.*/

SELECT a.nombre, v.nombre, DATE_FORMAT (v.fecha, "%d-%m-%y") AS fecha FROM asociacion a, viaje v
WHERE v.cif_aso = a.cif ORDER BY v.fecha DESC;

/*6.- Se desea conocer para cada asociación (mostrando su nombre), cuántos voluntarios trabajan en cada una de ellas.*/

SELECT a.nombre, COUNT(v.CIF_asoTra) as Total_Vol
FROM asociacion a, voluntario v
WHERE a.CIF = v.CIF_asoTra
GROUP BY a.nombre;

/*7.- Listar todas las sedes que no estén en la misma ciudad que la población de la asociación a la que pertenecen. 
Muestra el número de sede, el nombre de la asociación, la ciudad de la sede y la población de la asociación.*/

SELECT s.nSede, a.nombre, s.ciudad, a.poblacion
FROM sede s, asociacion a
WHERE s.CIF_aso = a.CIF
AND s.ciudad != a.poblacion;

/*8.- Listar los responsables de cada asociación con el formato "Apellidos, Nombre" con su teléfono y el nombre de la asociación.*/

SELECT CONCAT(v.apellidos, ', ', v.nombre) as Responsable, v.telefono, a.nombre 
FROM asociacion a, voluntario v
WHERE a.dni_vRes = v.dni;

/*9.- Obtener un listado con todos los viajes organizados tanto si han sido contratados por algún cliente 
como si todavía no lo han hecho. En el listado hay que mostrar el código, el nombre y la fecha del viaje, 
así como el total de viajeros que lo han contratado. Recuerda que si un viaje todavía no ha sido contratado 
por ningún cliente deberá mostrarse también. Ordena el listado por el total de contrataciones de mayor a menor cantidad.*/

SELECT v.codigo, v.nombre, v.fecha, COUNT(c.dni) as N_viajeros
FROM viaje v
LEFT OUTER JOIN contratar cont ON cont.codigo_v = v.codigo
LEFT OUTER JOIN cliente c ON c.dni = cont.dni_cli
GROUP BY v.codigo
ORDER BY N_viajeros DESC;

/* 10.- Listar los datos completos de aquellos clientes que han pagado el menor importe 
de todos los que han contratado algún viaje.*/

SELECT c.* FROM cliente c, contratar cont
WHERE c.dni = cont.dni_cli
AND cont.importe_c = (SELECT MIN(importe_c) FROM contratar);

/*11.- Mostrar una relación de todos los voluntarios con todos sus datos, siempre y cuando no sean responsables 
en sus correspondientes asociaciones y además la asociación para la cual trabajan tiene alguna sede en Madrid.*/

SELECT v.*
FROM voluntario v, asociacion a, sede s
WHERE a.cif = v.cif_asoTra 
AND a.cif = s.cif_aso
AND a.dni_vRes != v.dni
AND a.cif IN (SELECT cif_aso FROM sede WHERE ciudad ='Madrid');

/*12.- Mostrar la información del nombre completo de los voluntarios cuyo primer apellido comienzo por "S", 
su país de nacionalidad, el nombre de la asociación en la que trabaja y el número de años que lleva en la 
asociación desde su fecha de ingreso. Ordena el listado de mayor a menor número de años.*/

SELECT CONCAT(v.nombre, ' ' , v.apellidos) as Nombre_Completo, v.pais_na, a.nombre, 
TIMESTAMPDIFF (year, v.fecha_in, CURRENT_TIMESTAMP()) as diferencia
FROM voluntario v, asociacion a
WHERE v.cif_asoTra = a.cif
AND v.apellidos LIKE ('S%')
ORDER BY diferencia DESC;

/*13.- ¿Cuál es la ciudad o ciudades donde está el mayor número de sedes de las diferentes asociaciones? 
Mostrar el nombre de esa ciudad o ciudades.*/

SELECT ciudad
FROM sede 
GROUP BY ciudad
HAVING COUNT(*) = (SELECT COUNT(*) FROM sede GROUP BY ciudad ORDER BY COUNT(*) DESC LIMIT 1);

/*14.- Obtener el nombre y apellidos del cliente, el importe por el que contrató el viaje, 
el importe del viaje y la diferencia de ambos importes para comprobar la cantidad que se ha ahorrado. 
El listado sólo tiene que sacar aquellos registros donde se haya producido un ahorro distinto de cero.*/

SELECT c.nombre, c.apellidos, cont.importe_c, v.importe, (v.importe - cont.importe_c) as ahorro
FROM cliente c, contratar cont, viaje v
WHERE cont.dni_cli = c.dni
AND cont.codigo_v = v.codigo
AND v.importe > cont.importe_c;

/*15.- Se quiere averiguar la cantidad de meses de media de antelación con el que se contratan los viajes. 
Para ello se debe mostrar el nombre del viaje y el valor medio de la diferencia en meses entre la fecha del viaje 
y la fecha en la que han contratado los clientes dicho viaje teniendo en cuenta que sólo interesa obtener 
los que estén de media por debajo de 3 meses en su contratación.*/

SELECT v.nombre, AVG (TIMESTAMPDIFF(MONTH, cont.fecha_c, v.fecha)) as AVG_meses_antelacion
FROM contratar cont, viaje v
WHERE v.codigo = cont.codigo_v
GROUP BY v.nombre
HAVING AVG_meses_antelacion < 3;

/*16.- Muestra por cada mes del año 2024, el nombre del mes y la cantidad de viajes que 
se han contratado en cada mes siempre y cuando haya más de una contratación.*/

SELECT MONTHNAME(fecha_c) as mes, COUNT(fecha_c) as contrataciones
FROM contratar
WHERE YEAR(fecha_c) = '2024'
GROUP BY mes
HAVING contrataciones > 1
;

/*17.- Averiguar el nombre de la asociación donde el cliente de nombre "Patricio" 
no haya contratado ningún viaje que ha organizado dicha asociación.*/

SELECT a.nombre
FROM asociacion a
WHERE a.cif NOT IN 
	(
	SELECT a.cif
	FROM asociacion a, cliente c, contratar cont, viaje v
	WHERE c.dni = cont.dni_cli
	AND cont.codigo_v = v.codigo
	AND v.cif_aso = a.cif
	AND c.nombre = 'Patricio'
	)
GROUP BY a.nombre
;

/*18.- Obtener el nombre, apellidos de los clientes y el total de importes que han gastado 
al contratar sus viajes teniendo en cuenta que dicho total sea mayor que el máximo importe de todos los viajes.
Ordena el listado de mayor a menor importe gastado.*/

SELECT c.nombre, c.apellidos, SUM(cont.importe_c) as total
FROM cliente c, contratar cont
WHERE c.dni = cont.dni_cli
GROUP BY c.nombre, c.apellidos
HAVING total > (SELECT MAX(v.importe) FROM viaje v)
ORDER BY total DESC
;

