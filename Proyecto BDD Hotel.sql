-- Base de Datos de un Hotel:

-- Entidades: Habitaciones, Huéspedes, Reservas, Servicios.

-- Relaciones: Los huéspedes reservan habitaciones y solicitan servicios durante su estadía.

CREATE DATABASE Hotel;

USE Hotel; 

-- Columna huesped que detalla toda la informacion necesaria para ingresar al mismo en el sistema.
CREATE TABLE huespedes (id_huesped BIGINT PRIMARY KEY AUTO_INCREMENT, nombrehuesped NVARCHAR(50) NOT NULL DEFAULT 'No Name', 
apellidohuesped NVARCHAR(50) NOT NULL DEFAULT 'No Lastname', 
documentohuesped ENUM ('DNI','CI','Pasaporte','Licencia de Conducir','Tarjeta de Residencia del Hotel','Visa de Trabajo','Otro') NOT NULL DEFAULT 'CI', 
-- El documento por defecto sera la CI debido a que estamos en Uruguay, en caso de ser extranjero se debe indicar el tipo de documento
nrodocumentohuesped BIGINT(20) UNIQUE NOT NULL DEFAULT '00000000',
nacionalidadhuesped NVARCHAR(50) NOT NULL DEFAULT 'Uruguaya', generohuesped ENUM ('Masculino','Femenino','No Binario','Genero Diverso','Prefiero No Decirlo','Otro') 
NOT NULL DEFAULT 'Prefiero No Decirlo', prefijotelhuesped ENUM ( '+54',  -- Argentina (+54)
  '+55',  -- Brasil (+55)
  '+598', -- Uruguay (+598)
  '+56',  -- Chile (+56)
  '+595', -- Paraguay (+595)
  '+507', -- Panamá (+507)
  '+52',  -- México (+52)
  '+1',   -- Estados Unidos (+1)
  'Otro'),-- Otro prefijo
telhuesped BIGINT NOT NULL DEFAULT '00000000', -- En caso de seleccionar otro prefijo que no se encuentra en la lista el usuario debe ingresarlo manualmente en este campo
correohuesped NVARCHAR(100) UNIQUE DEFAULT 'No Email', fidelizacionhuesped ENUM ('Basic','Silver','Gold','Platinum','VIP','Inactive'),
INDEX idx_nombrehuesped(nombrehuesped),
INDEX idx_apellidohuesped(apellidohuesped),
INDEX idx_documentohuesped(documentohuesped),
INDEX idx_nrodocumentohuesped(nrodocumentohuesped),
INDEX idx_nacionalidadhuesped(nacionalidadhuesped),
INDEX idx_prefijotelhuesped(prefijotelhuesped),
INDEX idx_telhuesped(telhuesped),
INDEX idx_correohuesped(correohuesped),
INDEX idx_fidelizacionhuesped(fidelizacionhuesped));

CREATE TABLE facturacionhuesped(id_huesped BIGINT PRIMARY KEY AUTO_INCREMENT, tipofactura ENUM ('Factura Habitacion','Factura Restaurante','Factura Bar',
'Factura Estacionamiento','Factura Imprevistos', 'Factura Adicional') NOT NULL DEFAULT 'Factura Habitacion', fidelizacionhuesped ENUM ('Basic','Silver','Gold','Platinum','VIP','Inactive'),
montofacturahuesped DECIMAL (10,2) NOT NULL DEFAULT 1 CHECK(montofacturahuesped>0),
facturahuespedpaga BOOLEAN NOT NULL DEFAULT 0 CHECK(facturahuespedpaga BETWEEN 0 AND 1), -- En caso de haber pagado se debe ingresar el 1 sino estara el 0 por defecto
mediopagohuesped ENUM('Efectivo','Tarjeta Credito','Tarjeta Debito', 'Saldo del Hotel') NOT NULL DEFAULT 'Efectivo', -- En caso de usar tarjetas de debido o credito se debe completar el siguiente dato
proveedortarhuesped ENUM (
  'Visa',
  'MasterCard',
  'American Express',
  'Discover',
  'Diners Club',
  'JCB',
  'UnionPay',
  'Maestro',
  'Visa Electron',
  'MasterCard Debit'
-- En caso de que la tarjeta del huesped no este entre las soportadas por el sistema de pagos debe abonar en efectivo
), nombrehuesped NVARCHAR(50) NOT NULL DEFAULT 'No Name', 
apellidohuesped NVARCHAR(50) NOT NULL DEFAULT 'No Lastname', 
documentohuesped ENUM ('DNI','CI','Pasaporte','Licencia de Conducir','Tarjeta de Residencia del Hotel','Visa de Trabajo','Otro') NOT NULL DEFAULT 'CI', 
-- El documento por defecto sera la CI debido a que estamos en Uruguay, en caso de ser extranjero se debe indicar el tipo de documento
nrodocumentohuesped BIGINT(20) UNIQUE NOT NULL DEFAULT '00000000',
nacionalidadhuesped NVARCHAR(50) NOT NULL DEFAULT 'Uruguaya', correohuesped NVARCHAR(100) UNIQUE DEFAULT 'No Email',
prefijotelhuesped ENUM ( '+54',  -- Argentina (+54)
  '+55',  -- Brasil (+55)
  '+598', -- Uruguay (+598)
  '+56',  -- Chile (+56)
  '+595', -- Paraguay (+595)
  '+507', -- Panamá (+507)
  '+52',  -- México (+52)
  '+1',   -- Estados Unidos (+1)
  'Otro'),-- Otro prefijo
telhuesped BIGINT NOT NULL DEFAULT '00000000', -- En caso de seleccionar otro prefijo que no se encuentra en la lista el usuario debe ingresarlo manualmente en este campo
FOREIGN KEY (id_huesped) REFERENCES huespedes(id_huesped), FOREIGN KEY(nombrehuesped) REFERENCES huespedes(nombrehuesped),
FOREIGN KEY(apellidohuesped) REFERENCES huespedes(apellidohuesped),FOREIGN KEY(nrodocumentohuesped) 
REFERENCES huespedes(nrodocumentohuesped),FOREIGN KEY (nacionalidadhuesped) REFERENCES huespedes(nacionalidadhuesped),
INDEX idx_tipofactura(tipofactura),
INDEX idx_montofacturahuesped(montofacturahuesped));

CREATE TABLE reservas(id_reserva BIGINT PRIMARY KEY AUTO_INCREMENT,id_huesped BIGINT, fecha_entrada DATETIME NOT NULL DEFAULT '2000-01-01 09:00:00', 
fecha_salida DATETIME DEFAULT '2000-01-01 09:00:00', tipohabitacion ENUM('Individual','Doble','Matrimonial','Suite Junior','Suite Ejecutiva','Suite Presidencial','Familiar'),
nrohabitacion BIGINT UNIQUE NOT NULL DEFAULT 1, fidelizacionhuesped ENUM ('Basic','Silver','Gold','Platinum','VIP','Inactive'), -- La tarifahabitacion cambia dependiendo la fidelizacionhuesped
tarifahabitacion DECIMAL (10,2) NOT NULL DEFAULT 1 CHECK(tarifahabitacion>0), tipofactura ENUM ('Factura Habitacion','Factura Restaurante','Factura Bar',
'Factura Estacionamiento','Factura Imprevistos', 'Factura Adicional') NOT NULL DEFAULT 'Factura Habitacion', montofacturahuesped DECIMAL (10,2) NOT NULL DEFAULT 1 CHECK(montofacturahuesped>0),
FOREIGN KEY (id_huesped) REFERENCES huespedes(id_huesped),FOREIGN KEY (tipofactura) REFERENCES facturacionhuesped(tipofactura),
INDEX idx_tipohabitacion(tipohabitacion),
INDEX idx_nrohabitacion(nrohabitacion));

CREATE TABLE imagenescarnet(id_imagen BIGINT PRIMARY KEY AUTO_INCREMENT, nombreimagen VARCHAR(100) NOT NULL, imagen BLOB);

CREATE TABLE supervisores(id_supervisor BIGINT PRIMARY KEY AUTO_INCREMENT, nombresupervisor NVARCHAR(50) NOT NULL DEFAULT 'No Name', 
apellidosupervisor NVARCHAR(50) NOT NULL DEFAULT 'No Lastname', nacimientosupervisor DATE NOT NULL DEFAULT '2000-01-01', generoempleado ENUM ('Masculino','Femenino','No Binario',
'Genero Diverso','Prefiero No Decirlo','Otro') NOT NULL DEFAULT 'Prefiero No Decirlo', documentosupervisor ENUM ('DNI','CI','Pasaporte','Licencia de Conducir','Tarjeta de Residencia del Hotel',
'Visa de Trabajo','Otro') NOT NULL DEFAULT 'CI', 
-- El documento por defecto sera la CI debido a que estamos en Uruguay, en caso de ser extranjero se debe indicar el tipo de documento
nrodocumentosupervisor BIGINT(20) UNIQUE NOT NULL DEFAULT '00000000', nacionalidadsupervisor NVARCHAR(50) NOT NULL DEFAULT 'Uruguaya', correosupervisor NVARCHAR(100) NOT NULL UNIQUE DEFAULT 'No Email', 
prefijotelsupervisor ENUM ( '+54',  -- Argentina (+54)
  '+55',  -- Brasil (+55)
  '+598', -- Uruguay (+598)
  '+56',  -- Chile (+56)
  '+595', -- Paraguay (+595)
  '+507', -- Panamá (+507)
  '+52',  -- México (+52)
  '+1',   -- Estados Unidos (+1)
  'Otro'),-- Otro prefijo
telsupervisor BIGINT NOT NULL DEFAULT '00000000', puestrotrabajosupervisor ENUM('Supervisor Recepcion','Supervisor Limpieza','Supervisor Cocina','Supervisor General')
NOT NULL DEFAULT 'Supervisor General', fechacontratado DATE NOT NULL DEFAULT '2000-01-01', fechafinalizacontrato DATE DEFAULT '2000-01-01', 
salariosupervisor DECIMAL (10,2) NOT NULL DEFAULT 1 CHECK(salariosupervisor>0), infoadicionalempleado TEXT, id_imagen BIGINT);

CREATE TABLE empleadohotel(id_empleado BIGINT PRIMARY KEY AUTO_INCREMENT, nombreempleado NVARCHAR(50) NOT NULL DEFAULT 'No Name', 
apellidoempleado NVARCHAR(50) NOT NULL DEFAULT 'No Lastname', nacimientoempleado DATE NOT NULL DEFAULT '2000-01-01', generoempleado ENUM ('Masculino','Femenino','No Binario',
'Genero Diverso','Prefiero No Decirlo','Otro') NOT NULL DEFAULT 'Prefiero No Decirlo', documentoempleado ENUM ('DNI','CI','Pasaporte','Licencia de Conducir','Tarjeta de Residencia del Hotel',
'Visa de Trabajo','Otro') NOT NULL DEFAULT 'CI', 
-- El documento por defecto sera la CI debido a que estamos en Uruguay, en caso de ser extranjero se debe indicar el tipo de documento
nrodocumentoempleado BIGINT(20) UNIQUE NOT NULL DEFAULT '00000000', nacionalidadempleado NVARCHAR(50) NOT NULL DEFAULT 'Uruguaya', correoempleado NVARCHAR(100) NOT NULL UNIQUE DEFAULT 'No Email', 
prefijotelempleado ENUM ( '+54',  -- Argentina (+54)
  '+55',  -- Brasil (+55)
  '+598', -- Uruguay (+598)
  '+56',  -- Chile (+56)
  '+595', -- Paraguay (+595)
  '+507', -- Panamá (+507)
  '+52',  -- México (+52)
  '+1',   -- Estados Unidos (+1)
  'Otro'),-- Otro prefijo
telempleado BIGINT NOT NULL DEFAULT '00000000', puestrotrabajoempleado ENUM ('Recepcionista', 'Conserje', 'Camarero', 'Chef', 'Cocinero','Ayudante de Cocina','Limpieza','Otro')
NOT NULL DEFAULT 'Recepcionista',
fechacontratado DATE NOT NULL DEFAULT '2000-01-01', fechafinalizacontrato DATE DEFAULT '2000-01-01', salarioempleado DECIMAL (10,2) NOT NULL DEFAULT 1 CHECK(salarioempleado>0), 
infoadicionalempleado TEXT, id_supervisor BIGINT, id_imagen BIGINT, FOREIGN KEY (id_supervisor) REFERENCES supervisores(id_supervisor), 
INDEX idx_nombreempleado(nombreempleado),
INDEX idx_apellidoempleado(apellidoempleado),
INDEX idx_puestrotrabajoempleado(puestrotrabajoempleado));

CREATE TABLE servicioshuesped (
id_servicio BIGINT PRIMARY KEY AUTO_INCREMENT, id_huesped BIGINT, id_empleado BIGINT, fechaservicio DATETIME NOT NULL DEFAULT '2000-01-01', descripcionservicio TEXT,
FOREIGN KEY (id_huesped) REFERENCES huespedes(id_huesped),
FOREIGN KEY (id_empleado) REFERENCES empleadohotel(id_empleado)
);

-- Ingreso de Datos(ChatGPT)

-- Insertar datos ficticios en la tabla 'huespedes' (Guests)
INSERT INTO huespedes (nombrehuesped, apellidohuesped, documentohuesped, nrodocumentohuesped, nacionalidadhuesped, generohuesped, prefijotelhuesped, telhuesped, correohuesped, fidelizacionhuesped)
VALUES
  ('John', 'Doe', 'DNI', 12345678, 'Uruguaya', 'Masculino', '+598', 98765432, 'john.doe@example.com', 'Gold'),
  ('Jane', 'Smith', 'CI', 87654321, 'Uruguaya', 'Femenino', '+598', 12345678, 'jane.smith@example.com', 'Silver'),
  ('Carlos', 'Gonzalez', 'Pasaporte', 11223344, 'Argentin', 'Masculino', '+54', 11223344, 'carlos.gonzalez@example.com', 'Basic');
  -- Agrega más datos aquí
;

-- Insertar datos ficticios en la tabla 'facturacionhuesped' (Guest Billing)
INSERT INTO facturacionhuesped (tipofactura, fidelizacionhuesped, montofacturahuesped, facturahuespedpaga, mediopagohuesped, proveedortarhuesped, nombrehuesped, apellidohuesped, documentohuesped, nrodocumentohuesped, nacionalidadhuesped, correohuesped, prefijotelhuesped, telhuesped)
VALUES
  ('Factura Habitacion', 'Platinum', 1500.00, 1, 'Tarjeta Credito', 'Visa', 'John', 'Doe', 'DNI', 12345678, 'Uruguaya', 'john.doe@example.com', '+598', 98765432),
  ('Factura Restaurante', 'Silver', 250.50, 0, 'Efectivo', NULL, 'Jane', 'Smith', 'CI', 87654321, 'Uruguaya', 'jane.smith@example.com', '+598', 12345678),
  ('Factura Estacionamiento', 'Gold', 50.00, 1, 'Saldo del Hotel', NULL, 'Carlos', 'Gonzalez', 'Pasaporte', 11223344, 'Argentin', 'carlos.gonzalez@example.com', '+54', 11223344);
  -- Agrega más datos aquí
;

-- Insertar datos ficticios en la tabla 'reservas' (Reservations)
INSERT INTO reservas (id_huesped, fecha_entrada, fecha_salida, tipohabitacion, nrohabitacion, fidelizacionhuesped, tarifahabitacion, tipofactura, montofacturahuesped)
VALUES
  (1, '2023-09-15 14:00:00', '2023-09-18 12:00:00', 'Doble', 101, 'Platinum', 300.00, 'Factura Habitacion', 900.00),
  (2, '2023-09-20 15:00:00', '2023-09-22 10:00:00', 'Individual', 102, 'Silver', 150.00, 'Factura Habitacion', 300.00),
  (3, '2023-09-25 12:00:00', '2023-09-27 11:00:00', 'Matrimonial', 103, 'Gold', 200.00, 'Factura Habitacion', 400.00);
  -- Agrega más datos aquí
;

-- Insertar datos ficticios en la tabla 'imagenescarnet' (ID Images)
INSERT INTO imagenescarnet (nombreimagen, imagen)
VALUES
  ('imagen1.jpg', NULL),
  ('imagen2.jpg', NULL),
  ('imagen3.jpg', NULL);
  -- Agrega más datos aquí
;

-- Insertar datos ficticios en la tabla 'supervisores' (Supervisors)
INSERT INTO supervisores (nombresupervisor, apellidosupervisor, nacimientosupervisor, generoempleado, documentosupervisor, nrodocumentosupervisor, nacionalidadsupervisor, correosupervisor, prefijotelsupervisor, telsupervisor, puestrotrabajosupervisor, fechacontratado, salariosupervisor, infoadicionalempleado, id_imagen)
VALUES
  ('Supervisor1', 'Apellido1', '1990-05-15', 'Masculino', 'DNI', 1234567, 'Uruguaya', 'supervisor1@example.com', '+598', 123456789, 'Supervisor Recepcion', '2022-01-15', 2000.00, 'Información adicional 1', 1),
  ('Supervisor2', 'Apellido2', '1985-07-20', 'Femenino', 'CI', 7654321, 'Uruguaya', 'supervisor2@example.com', '+598', 987654321, 'Supervisor Cocina', '2021-11-10', 1800.00, 'Información adicional 2', 2),
  ('Supervisor3', 'Apellido3', '1988-03-10', 'Masculino', 'Pasaporte', 9876543, 'Argentin', 'supervisor3@example.com', '+54', 654321987, 'Supervisor Limpieza', '2022-02-20', 2200.00, 'Información adicional 3', 3);
;

-- Insertar datos ficticios en la tabla 'empleadohotel' (Hotel Employees)
INSERT INTO empleadohotel (nombreempleado, apellidoempleado, nacimientoempleado, generoempleado, documentoempleado, nrodocumentoempleado, nacionalidadempleado, correoempleado, prefijotelempleado, telempleado, puestrotrabajoempleado, fechacontratado, salarioempleado, infoadicionalempleado, id_supervisor, id_imagen)
VALUES
  ('Empleado1', 'Apellido1', '1995-08-25', 'Masculino', 'DNI', 9876543, 'Uruguaya', 'empleado1@example.com', '+598', 234567890, 'Recepcionista', '2022-03-01', 1500.00, 'Información adicional 1', 1, 4),
  ('Empleado2', 'Apellido2', '1992-12-12', 'Femenino', 'CI', 1234567, 'Uruguaya', 'empleado2@example.com', '+598', 345678901, 'Camarero', '2022-02-15', 1400.00, 'Información adicional 2', 2, 5),
  ('Empleado3', 'Apellido3', '1987-06-30', 'Masculino', 'Pasaporte', 7654321, 'Argentin', 'empleado3@example.com', '+54', 456789012, 'Chef', '2021-12-05', 1800.00, 'Información adicional 3', 3, 6);
  -- Agrega más datos aquí
;

-- Insertar datos ficticios en la tabla 'servicioshuesped' (Guest Services)
INSERT INTO servicioshuesped (id_huesped, id_empleado, fechaservicio, descripcionservicio)
VALUES
  (1, 1, '2023-09-01 08:00:00', 'Descripción del servicio 1'),
  (2, 2, '2023-09-02 10:30:00', 'Descripción del servicio 2'),
  (3, 3, '2023-09-03 12:15:00', 'Descripción del servicio 3');
  -- Agrega más datos aquí
;
INSERT INTO huespedes (nombrehuesped, apellidohuesped, documentohuesped, nrodocumentohuesped, nacionalidadhuesped, generohuesped, prefijotelhuesped, telhuesped, correohuesped, fidelizacionhuesped)
VALUES
  ('Juan', 'Perez', 'DNI', 12345679, 'Uruguaya', 'Masculino', '+598', 98765433, 'juan.perez@example.com', 'Gold'),
  ('Ana', 'Lopez', 'CI', 87654322, 'Uruguaya', 'Femenino', '+598', 12345679, 'ana.lopez@example.com', 'Silver'),
  ('Pedro', 'Garcia', 'Pasaporte', 11223345, 'Argentin', 'Masculino', '+54', 11223345, 'pedro.garcia@example.com', 'Basic');
  -- Puedes agregar más datos aquí

INSERT INTO facturacionhuesped (tipofactura, fidelizacionhuesped, montofacturahuesped, facturahuespedpaga, mediopagohuesped, proveedortarhuesped, nombrehuesped, apellidohuesped, documentohuesped, nrodocumentohuesped, nacionalidadhuesped, correohuesped, prefijotelhuesped, telhuesped)
VALUES
  ('Factura Habitacion', 'Platinum', 1500.00, 1, 'Tarjeta Credito', 'Visa', 'Juan', 'Perez', 'DNI', 12345679, 'Uruguaya', 'juan.perez@example.com', '+598', 98765433),
  ('Factura Restaurante', 'Silver', 250.50, 0, 'Efectivo', NULL, 'Ana', 'Lopez', 'CI', 87654322, 'Uruguaya', 'ana.lopez@example.com', '+598', 12345679),
  ('Factura Estacionamiento', 'Gold', 50.00, 1, 'Saldo del Hotel', NULL, 'Pedro', 'Garcia', 'Pasaporte', 11223345, 'Argentin', 'pedro.garcia@example.com', '+54', 11223345);
  -- Puedes agregar más datos aquí
INSERT INTO reservas (id_huesped, fecha_entrada, fecha_salida, tipohabitacion, nrohabitacion, fidelizacionhuesped, tarifahabitacion, tipofactura, montofacturahuesped)
VALUES
  (1, '2023-09-15 14:00:00', '2023-09-18 12:00:00', 'Doble', 104, 'Platinum', 300.00, 'Factura Habitacion', 900.00),
  (2, '2023-09-20 15:00:00', '2023-09-22 10:00:00', 'Individual', 105, 'Silver', 150.00, 'Factura Habitacion', 300.00),
  (3, '2023-09-25 12:00:00', '2023-09-27 11:00:00', 'Matrimonial', 106, 'Gold', 200.00, 'Factura Habitacion', 400.00);
  -- Puedes agregar más datos aquí

INSERT INTO imagenescarnet (nombreimagen, imagen)
VALUES
  ('imagen4.jpg', NULL),
  ('imagen5.jpg', NULL),
  ('imagen6.jpg', NULL);
  -- Puedes agregar más datos aquí

-- Ejemplos Analisis de Datos

SELECT concat(nombrehuesped,' ',apellidohuesped) AS 'Nombre Completo' ,montofacturahuesped AS Impagos FROM facturacionhuesped WHERE facturahuespedpaga = 0;
SELECT SUM(montofacturahuesped) AS 'Facturacion Total del Hotel' FROM facturacionhuesped;
SELECT tipofactura, SUM(montofacturahuesped) AS 'Facturacion Total del Hotel' FROM facturacionhuesped GROUP BY tipofactura;
SELECT concat(nombreempleado,' ', apellidoempleado) AS 'Nombre Completo del Empleado', concat(correoempleado,' ', prefijotelempleado, telempleado) AS 'Datos de Contacto del Empleado' FROM empleadohotel;
SELECT AVG(salarioempleado) AS 'Salario Promedio' FROM empleadohotel;
SELECT proveedortarhuesped as 'Proovedor de Tarjeta', COUNT(*) AS 'Cantidad de Clientes' FROM facturacionhuesped 
WHERE proveedortarhuesped IS NOT NULL GROUP BY proveedortarhuesped;
SELECT fidelizacionhuesped AS 'Fidelizacion', concat(tipofactura,' ', '$', ' ', montofacturahuesped) AS 'Datos de Factura',
concat(nombrehuesped,' ',apellidohuesped, ' ', documentohuesped, ' ', nrodocumentohuesped , ' ', nacionalidadhuesped) AS 'Informacion Del Huesped',
CASE WHEN facturahuespedpaga = 1 THEN 'Pago' WHEN facturahuespedpaga = 0 THEN 'Impago' ELSE 'No hay Informacion' 
END AS 'Estado del Pago', IFNULL(mediopagohuesped, 'Pago en Efectivo') AS 'Opcion de Pago' FROM facturacionhuesped;
