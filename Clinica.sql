-- Base de Datos de una Clínica Médica:

-- Entidades: Pacientes, Médicos, Citas, Historiales Médicos.

-- Relaciones: Los médicos atienden a pacientes, se programan citas y se mantienen los historiales médicos.
DROP DATABASE clinica;

CREATE DATABASE clinica;

USE clinica;

-- Base de Datos Clinica

CREATE TABLE pacientes (id_paciente INT PRIMARY KEY AUTO_INCREMENT, 
nompaciente VARCHAR(50) NOT NULL DEFAULT 'No Name', apepaciente VARCHAR(50) NOT NULL DEFAULT 'No Lastname', nacimientopaciente DATE NOT NULL 
DEFAULT '2000-01-01', pacientecalle VARCHAR(50) NOT NULL DEFAULT 'No Street', numerocasapaciente INT NOT NULL DEFAULT 0, nroaptopaciente INT NOT NULL 
DEFAULT '0', telefonopaciente BIGINT NOT NULL DEFAULT '099000000', nroseguro BIGINT NOT NULL DEFAULT '0',
INDEX idx_apepaciente(apepaciente));

CREATE TABLE medicos (id_medico INT PRIMARY KEY AUTO_INCREMENT, nommedico VARCHAR(50) NOT NULL DEFAULT 'No Name', 
apemedico VARCHAR(50) NOT NULL DEFAULT 'No Lastname', nacimientomedico DATE NOT NULL 
DEFAULT '2000-01-01', medicocalle VARCHAR(50) NOT NULL DEFAULT 'No Street', numerocasamedico INT NOT NULL DEFAULT 0, nroaptomedico INT NOT NULL 
DEFAULT '0', telefonomedico BIGINT NOT NULL DEFAULT '099000000', nrohabilitacion BIGINT NOT NULL DEFAULT '0', 
especialidad ENUM ('Cardiología', 'Dermatología', 'Endocrinología', 'Gastroenterología', 'Hematología', 'Neurología', 'Oftalmología', 
'Oncología', 'Ortopedia', 'Pediatría', 'Psiquiatría', 'Radiología', 'Urología', 'Otra') DEFAULT 'Otra' NOT  NULL, 
INDEX idx_especialidad(especialidad), INDEX idx_apemedico(apemedico));

CREATE TABLE citas (id_citamed INT AUTO_INCREMENT, id_medico INT, apemedico VARCHAR(50) NOT NULL DEFAULT 'No Lastname', especialidad ENUM 
('Cardiología', 'Dermatología', 'Endocrinología', 'Gastroenterología', 'Hematología', 'Neurología', 'Oftalmología', 
'Oncología', 'Ortopedia', 'Pediatría', 'Psiquiatría', 'Radiología', 'Urología', 'Otra') DEFAULT 'Otra' NOT  NULL, 
fhcitamedica DATETIME NOT NULL DEFAULT '2000-01-01 09:00:00', id_paciente INT,  apepaciente VARCHAR(50) NOT NULL DEFAULT 'No Lastname',
FOREIGN KEY (id_medico) REFERENCES medicos(id_medico), FOREIGN KEY (apemedico) REFERENCES medicos(apemedico), 
FOREIGN KEY (especialidad) REFERENCES medicos(especialidad), FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente), 
FOREIGN KEY (apepaciente) REFERENCES pacientes(apepaciente), INDEX idx_fhcitamedica(fhcitamedica), 
PRIMARY KEY (id_citamed, id_medico, id_paciente));

CREATE TABLE historial_medico(id_historial INT PRIMARY KEY AUTO_INCREMENT, id_paciente INT, id_medico INT, 
fhcitamedica DATETIME NOT NULL DEFAULT '2000-01-01 09:00:00', diagnostico TEXT NOT NULL, tratamiento TEXT NOT NULL, 
FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente), FOREIGN KEY(id_medico) REFERENCES medicos(id_medico), 
FOREIGN KEY (fhcitamedica) REFERENCES citas(fhcitamedica));

-- Ingresar Datos(ChatGPT)

INSERT INTO pacientes (nompaciente, apepaciente, nacimientopaciente, pacientecalle, numerocasapaciente, nroaptopaciente, telefonopaciente, nroseguro)
VALUES
    ('Juan', 'Pérez', '1980-05-15', 'Calle A', 123, 0, 0991234567, 1234567890),
    ('María', 'López', '1995-03-20', 'Calle B', 456, 0, 0999876543, 9876543210),
    ('Carlos', 'Gómez', '1988-09-10', 'Calle C', 789, 0, 0995556666, 5555555555);

INSERT INTO medicos (nommedico, apemedico, nacimientomedico, medicocalle, numerocasamedico, nroaptomedico, telefonomedico, nrohabilitacion, especialidad)
VALUES
    ('Dra. Ana', 'Martínez', '1975-02-28', 'Avenida X', 101, 0, 0991112222, 1234567890, 'Cardiología'),
    ('Dr. Luis', 'García', '1982-07-12', 'Avenida Y', 202, 0, 0993334444, 2345678901, 'Dermatología'),
    ('Dra. Laura', 'Rodríguez', '1978-11-05', 'Avenida Z', 303, 0, 0997778888, 3456789012, 'Pediatría');

-- Asumiendo que los pacientes y médicos anteriores ya existen en la base de datos
INSERT INTO citas (id_medico, apemedico, especialidad, fhcitamedica, id_paciente, apepaciente)
VALUES
    (1, 'Martínez', 'Cardiología', '2023-09-18 10:30:00', 1, 'Pérez'),
    (2, 'García', 'Dermatología', '2023-09-19 15:45:00', 2, 'López'),
    (3, 'Rodríguez', 'Pediatría', '2023-09-20 11:15:00', 3, 'Gómez');

-- Asumiendo que las citas ya existen en la base de datos
INSERT INTO historial_medico (id_paciente, id_medico, fhcitamedica, diagnostico, tratamiento)
VALUES
    (1, 1, '2023-09-18 10:30:00', 'Hipertensión arterial', 'Medicación y seguimiento'),
    (2, 2, '2023-09-19 15:45:00', 'Dermatitis leve', 'Crema recetada'),
    (3, 3, '2023-09-20 11:15:00', 'Control pediátrico', 'Vacunas y consejos de salud');

