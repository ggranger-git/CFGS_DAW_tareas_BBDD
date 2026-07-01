

1. Escribe un bloque PL/SQL que muestre por pantalla la frase: “Hola Mundo”.


2.– Escribir un bloque PL/SQL declarando una variable de tipo VARCHAR2 que
almacene la siguiente frase: “Esta es una variable de tipo VARCHAR2” y
posteriormente se escriba por consola.



3. – Escribir un bloque PL/SQL con una variable de tipo numérica para almacenar
y luego mostrar: 55543.



4.- Escribir un bloque PL/SQL con una variable que almacene la fecha del sistema
y después la muestre por consola en formato dd/mm/yyyy.
Y además, que la escriba en otra línea en formato DD-MM-YYYY HH:MI:SS



5.- Escribir un bloque PL/SQL donde se declaren una constate PI con el valor
3.1415926, y dos variables: radio (con valor 10) y área. Calcular el área del círculo
y mostrar el valor de la variable donde se ha almacenado por consola
NOTA sobre posibilidad de leer por teclado:
Aunque no es común pedir datos por consola en este ámbito, comentar que en SQL Developer
se puede pedir por consola un dato del siguiente modo:
DECLARE
 valor number(4) := &valor;
BEGIN
 DBMS_OUTPUT.PUT_LINE('El valor introducido es ' || valor) ;
END ;
Esto no funciona y da error si se usa por ejemplo en la web: https://livesql.oracle.com



6.- Escribir un bloque PL/SQL con dos variables numéricas que se lean por
teclado. Después, realizar la suma guardando el resultado en otra variable
numérica. Finalmente mostrar el resultado por consola.



7.- Escribir un bloque PL/SQL donde se pruebe el uso de las funciones TRUNC y
ROUND. Para ello, usa en las dos primeras líneas ROUND y TRUNC en las dos
últimas. El resultado por pantalla debería ser algo como:
El número redondeado de 5.3 es 5.
El número redondeado de 5.777 es 6.
El número truncado de 5.3 es 5.
El número truncado de 5.777 es 5.



8.- Escribir un bloque PL/SQL donde se pruebe el uso de las funciones UPPER y
LOWER. El resultado por pantalla debería ser algo como:
Teniendo la cadena: Esto es una cadena normal.
La cadena en minúscula es: ESTO ES UNA CADENA NORMAL
La cadena en minúscula es: esto es una cadena normal



9.- Escribir un bloque PL/SQL para probar el uso de LPAD, RPAD,. Para ello
declara una variable de cadena y dale el valor 'Esto es una cadena de caracteres'.
Posteriormente usa las funciones comentadas para obtener el siguiente resultado
por pantalla:
Tenemos la cadena: Esto es una cadena de caracteres
La longitud de la cadena es: 32
--------------------------------------------------------------------------------------
La cadena con LPAD es: $$$$$$$$$$$$$$$$$$Esto es una cadena de caracteres
La longitud de la cadena con LPAD es: 50
--------------------------------------------------------------------------------------
La cadena con RPAD es: Otra cadena de caracteres#########################
La longitud de la cadena con RPAD es: 50
--------------------------------------------------------------------------------------
La cadena con LPAD y RPAD es: $$$$$$$$$$$$$$$$$$Esta es la última
cadena**************************************************
La longitud de la cadena con LPAD y RPAD es: 100
--------------------------------------------------------------------------------------



10.- Escribir un bloque PL/SQL con dos variables enteras que se lean por teclado.
Después, comparar los valores para determinar si el primero es mayor que el
segundo o viceversa, o bien si son iguales.



11.- Escribir un bloque PL/SQL declarando una variable entera con un valor 0.
Escribir las sentencias usando la estructura CASE para que se escriba 'Es el
número 1'. Y similarmente según el valor sea 1, 2, y que en cualquier otro caso
escriba que se trata de otro número.



12.– Escribir un procedimiento PL/SQL con dos parámetros numéricos de
entrada. EL procedimiento debe realizar la suma de los dos parámetros y mostrar
el resultado por pantalla.



13. Desarrollar una función que reciba una fecha de nacimiento y devuelva la edad
actual de la persona.