DROP DATABASE IF EXISTS tarea3;

CREATE DATABASE tarea3;
USE tarea3;

CREATE TABLE PROYECTO(
codigo int PRIMARY KEY AUTO_INCREMENT,
fecha_inicio date,
presupuesto decimal(10,2),
cod_subproyecto int,
FOREIGN KEY (cod_subproyecto) REFERENCES PROYECTO (codigo)
	ON DELETE CASCADE
    ON UPDATE CASCADE,
CONSTRAINT presupuesto_CK CHECK (presupuesto BETWEEN 0 AND 100000)
);

CREATE TABLE CONFERENCIA(
referencia varchar(20) PRIMARY KEY,
fecha_hora datetime UNIQUE,
lugar enum('Madrid', 'Barcelona', 'Sevilla', 'Granada', 'Valencia'),
duracion smallint DEFAULT(4)
);

CREATE TABLE INVESTIGADOR(
dni char(9) PRIMARY KEY,
nombre varchar(20),
apellidos varchar(100),
direccion varchar(250),
ciudad varchar(100),
telefono varchar(15) NOT NULL,
codigo int,
FOREIGN KEY (codigo) REFERENCES PROYECTO (codigo)
	ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE REALIZA(
dni char(9),
referencia varchar(20),
PRIMARY KEY (dni, referencia),
FOREIGN KEY (dni) REFERENCES INVESTIGADOR (dni)
	ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (referencia) REFERENCES CONFERENCIA (referencia)
	ON DELETE CASCADE
    ON UPDATE CASCADE
);

ALTER TABLE CONFERENCIA 
	CHANGE COLUMN lugar ciudad enum('Madrid', 'Barcelona', 'Sevilla', 'Granada', 'Valencia');
    
ALTER TABLE INVESTIGADOR
	ADD COLUMN salario DECIMAL(10,2),
    ADD CONSTRAINT salario_CK CHECK (salario BETWEEN 30000 AND 80000);
    
ALTER TABLE PROYECTO
	ADD INDEX fecha_inicio_IDX (fecha_inicio);
    
CREATE VIEW contactos_madrid 
	AS SELECT nombre, apellidos, telefono FROM INVESTIGADOR WHERE ciudad = 'Madrid';
    
CREATE USER userJuan@'105.21.0.10' IDENTIFIED BY 'Juan';

GRANT SELECT, UPDATE ON CONFERENCIA TO userJuan;
    
