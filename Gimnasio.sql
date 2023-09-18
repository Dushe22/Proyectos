-- Base de Datos de un Gimnasio:

-- Entidades: Socios, Instructores, Clases, Horarios, Equipos de Ejercicio.

-- Relaciones: Cada socio se inscribe en clases, los instructores imparten clases y utilizan equipos de ejercicio.

-- Creacion de Tablas

CREATE TABLE equiposdeejercicio (
	id_equipo INT AUTO_INCREMENT PRIMARY KEY,
	numeroserie INT NOT NULL DEFAULT 0,
	nombrequipo VARCHAR(100) NOT NULL DEFAULT 'No Name',
	descripcion TEXT NOT NULL,
	disponible BOOLEAN NOT NULL DEFAULT 0 CHECK (disponible BETWEEN 0 AND 1), 
    -- 0 equivale a que esta desocupada, si se agrega uno significa que esta en uso
	id_instructor INT
);

CREATE TABLE instructores (
	id_instructor INT AUTO_INCREMENT PRIMARY KEY,
	Nombre VARCHAR(50) NOT NULL DEFAULT 'No Name',
	Apellido VARCHAR(50) NOT NULL DEFAULT 'No Lastname',
	id_claseimpartida INT,
	id_equipo INT
);
CREATE TABLE clases (
	id_claseimpartida INT AUTO_INCREMENT PRIMARY KEY,
	NombreClase VARCHAR(100) NOT NULL DEFAULT 'No Lesson',
	HorarioInicio TIME NOT NULL DEFAULT '01:00:00',
	HorarioFinaliza TIME NOT NULL DEFAULT '01:00:00',
	id_instructor INT,
	id_equipo INT
);
CREATE TABLE horarios (
	id_horario INT AUTO_INCREMENT PRIMARY KEY,
	id_claseimpartida INT,
	id_instructor INT,
	HorarioInicio TIME NOT NULL DEFAULT '01:00:00',
	HorarioFinaliza TIME NOT NULL DEFAULT '01:00:00'
);
CREATE TABLE socios (
	id_socio INT AUTO_INCREMENT PRIMARY KEY,
	nombresocio VARCHAR(50) NOT NULL DEFAULT 'No Name',
	apellidosocio VARCHAR(50) NOT NULL DEFAULT 'No Lastname',
	sociodesde DATE NOT NULL DEFAULT '2000-01-01',
	sociohasta DATE NOT NULL DEFAULT '2000-02-01',
	cuotapaga BOOLEAN NOT NULL DEFAULT 0 CHECK (cuotapaga BETWEEN 0 AND 1), 
    -- 0 Equivale a que la persona tiene su cuota paga, si se ingresa 1 es que la cuota esta impaga
	id_claseimpartida INT
);
-- Adjudicacion de llaves foraneas
ALTER TABLE equiposdeejercicio ADD FOREIGN KEY (id_instructor) REFERENCES instructores (id_instructor);

ALTER TABLE instructores ADD FOREIGN KEY (id_claseimpartida) REFERENCES clases (id_claseimpartida),
	ADD FOREIGN KEY (id_equipo) REFERENCES equiposdeejercicio (id_equipo);

ALTER TABLE clases ADD FOREIGN KEY (id_instructor) REFERENCES instructores (id_instructor),
	ADD FOREIGN KEY (id_equipo) REFERENCES equiposdeejercicio (id_equipo);

ALTER TABLE horarios ADD FOREIGN KEY (id_claseimpartida) REFERENCES clases (id_claseimpartida);
ALTER TABLE horarios ADD FOREIGN KEY (id_instructor) REFERENCES instructores (id_instructor);
-- Insertar Valores

INSERT INTO equiposdeejercicio(numeroserie,nombrequipo,descripcion,disponible) VALUES 
(000001, 'Maquina de Pesas', 'Equipo de ejercicio para realizar ejercicios de fuerza y resistencia utilizando pesos.', 1);
INSERT INTO instructores (Nombre, Apellido) VALUES ('Juan', 'Perez');
INSERT INTO clases (NombreClase, HorarioInicio, HorarioFinaliza) VALUES ('Levantamiento de Pesas', '17:00:00','18:00:00');
INSERT INTO horarios (HorarioInicio, HorarioFinaliza) Values ('17:00:00','18:00:00');
INSERT INTO socios (nombresocio,apellidosocio,sociodesde,sociohasta,cuotapaga) VALUES ('Pedro', 'Martinez','2019-04-23','2020-06-11',1);