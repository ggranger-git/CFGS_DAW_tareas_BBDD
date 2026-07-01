/
--ejer 1
begin
    DBMS_OUTPUT.PUT_LINE('Hola Mundo');
end;

/
--ejer 2
declare
    v_variable varchar2(100) := 'Esto es una variable de tipo VARCHAR2';
begin
    DBMS_OUTPUT.PUT_LINE(v_variable);
end;

/
--ejer3
declare
    v_variable number := 55543;
begin
    DBMS_OUTPUT.PUT_LINE(v_variable);
end;

/
--ejer4
declare
    v_variable date := sysdate;
begin
    DBMS_OUTPUT.PUT_LINE(v_variable);
    DBMS_OUTPUT.PUT_LINE(systimestamp);
    DBMS_OUTPUT.PUT_LINE(TO_CHAR(v_variable, 'DD-MM-YYYY'));
    DBMS_OUTPUT.PUT_LINE(TO_CHAR(v_variable, 'DD-MM-YYYY HH24:MI:SS'));
end;

/
--ejer5
declare
    pi CONSTANT REAL:= 3.1415; 
    v_radio number := &radio;
    v_area number;
begin
    v_area := pi * v_radio ** 2;
    DBMS_OUTPUT.PUT_LINE('El área del círculo es: ' || v_area);
end;

/
--ejer 6
declare 
    v_n1 number := &n1;
    v_n2 number := &n2;
    v_suma number;
begin
    v_suma := v_n1 + v_n2;
    DBMS_OUTPUT.PUT_LINE('La suma de ' || v_n1 || ' + '  
                          || v_n2 || ' es: ' || v_suma);
end;

/
--ejer 7
declare 
    v_n1 number := &n1;
    v_n2 number := &n2;
begin

    DBMS_OUTPUT.PUT_LINE('El número redondeado de '|| v_n1 || ' es '|| ROUND(v_n1));
    DBMS_OUTPUT.PUT_LINE('El número redondeado de '|| v_n2 || ' es '|| ROUND(v_n2));
    DBMS_OUTPUT.PUT_LINE('El número truncado de '|| v_n1 || ' es '|| TRUNC(v_n1));
    DBMS_OUTPUT.PUT_LINE('El número truncado de '|| v_n2 || ' es '|| TRUNC(v_n2));
end;

/
--ejer 8
declare 
    v_texto varchar2(100) := '&texto';

begin

    DBMS_OUTPUT.PUT_LINE('El texto normal es: ' || v_texto);
    DBMS_OUTPUT.PUT_LINE('El texto MAY es: ' || UPPER(v_texto));
    DBMS_OUTPUT.PUT_LINE('El texto MIN es: ' || LOWER(v_texto));
end;

/
--ejer 9

declare 
    v_texto varchar2(100) := 'Esto es una cadena de caracteres';

begin

    DBMS_OUTPUT.PUT_LINE('Tenemos la cadena: ' || v_texto);
    DBMS_OUTPUT.PUT_LINE('La longitud de la cadena es: ' || LENGTH(v_texto));
    DBMS_OUTPUT.PUT_LINE('La cadena con LPAD es: ' || LPAD(v_texto, 50 , '$'));
    DBMS_OUTPUT.PUT_LINE('La longitud de la cadena con LPAD es:' || LENGTH(LPAD('Otra cadena de caracteres', 50 , '$')));
    DBMS_OUTPUT.PUT_LINE('La cadena con RPAD es: ' || RPAD(v_texto, 50 , '$'));
    DBMS_OUTPUT.PUT_LINE('La longitud de la cadena con RPAD es:' || LENGTH(RPAD(v_texto, 50 , '#')));
    DBMS_OUTPUT.PUT_LINE('La cadena con LPAD y RPAD es: ' || RPAD(LPAD('Última cadena' , 50 , '$'), 100 , '*'));
    DBMS_OUTPUT.PUT_LINE('La longitud de la cadena con LPAD y RPAD es:' || 
    LENGTH(RPAD(LPAD(v_texto, 50 , '$'), 100 , '*')));
end;

/
--ejer 10

declare 
    v_n1 number := &n1;
    v_n2 number := &n2;
begin
    
    if v_n1 =  v_n2 then
        DBMS_OUTPUT.PUT_LINE('n1 y n2 son iguales');
    elsif v_n1 < v_n2 then
        DBMS_OUTPUT.PUT_LINE('n1 es menor que n2');
    else
        DBMS_OUTPUT.PUT_LINE('n1 es mayor que n2');
    end if;
        
end;

/
--ejer 11

create or replace procedure ejer11(valor number)
as

    v_con number := valor;
begin
    case 
        when v_con = 0 then
            DBMS_OUTPUT.PUT_LINE('El número es 0');
        when v_con = 1 then
            DBMS_OUTPUT.PUT_LINE('El número es 1');
        when v_con = 2 then
            DBMS_OUTPUT.PUT_LINE('El número es 2');
        else
            DBMS_OUTPUT.PUT_LINE('El número es diferente a 0, 1 o 2');
    end case;

end;
/
--prueba de procedimiento
begin
    ejer11(0);
end;

/
--ejer12


create or replace procedure ejer12(valor1 number, valor2 number)
as
    v_valor1 number := valor1;
    v_valor2 number := valor2;
begin
    
    DBMS_OUTPUT.PUT_LINE(valor1 + valor2);
end;
/
--prueba de procedimiento
begin
    ejer12(7, 7);
end;

/
--ejer13

create or replace function ejer13(fecha varchar2)
return number
as
    v_fecha date := to_date(fecha, 'YYYY-MM-DD');
    v_edad number;
begin
    v_edad := TRUNC((sysdate - v_fecha) / 365);
    return v_edad;
end;
/
--prueba de función
begin
    DBMS_OUTPUT.PUT_LINE(ejer13('1978-11-09'));
end;



