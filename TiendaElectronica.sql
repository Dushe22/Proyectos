-- Base de Datos de una Tienda de Electrónica:

-- Entidades: Productos (teléfonos, laptops, etc.), Proveedores, Ventas, Inventario.

-- Relaciones: Los proveedores suministran productos, se registran ventas y se controla el inventario.

CREATE DATABASE tiendaelectronica;

USE tiendaelectronica;

CREATE TABLE productos(id_productos INT PRIMARY KEY AUTO_INCREMENT, nombre_producto ENUM('Ordenador de escritorio', 'Portátil', 
'Monitor', 'Teclado', 'Ratón', 'Impresora', 'Altavoces', 'Auriculares', 'Tarjeta gráfica', 'Disco duro', 
'SSD', 'Memoria RAM', 'Placa base', 'Procesador', 'Consola de videojuegos', 
'Controlador de consola', 'Juegos de consola', 'Accesorios para computadoras', 'Otro') NOT NULL DEFAULT 'Otro', 
precio_producto DECIMAL (10,2) NOT NULL DEFAULT 1 
CHECK (precio_producto > 0), estadoproducto ENUM ('Usado', 'Nuevo','Reacondicionado'), stock BIGINT NOT NULL DEFAULT 0,
INDEX idx_nombre_producto(nombre_producto),
INDEX idx_precio_producto(precio_producto),
INDEX idx_estadoproducto(estadoproducto),
INDEX idx_stock(stock));

CREATE TABLE proveedores (id_proovedor INT PRIMARY KEY AUTO_INCREMENT, nombre_proveedor NVARCHAR(100) NOT NULL DEFAULT 'No Provider', 
paisproveedor ENUM('Estados Unidos', 'China', 'Alemania', 'Japón', 
'México', 'Brasil', 'Canadá', 'Francia', 'Italia', 'España', 'Otro') NOT NULL DEFAULT 'Estados Unidos', 
habilitacion_aduanas BOOLEAN NOT NULL DEFAULT 0 CHECK (habilitacion_aduanas BETWEEN 0 AND 1),
INDEX idx_nombre_proovedor(nombre_proveedor));

CREATE TABLE clientes (id_cliente INT PRIMARY KEY AUTO_INCREMENT, nombre_cliente NVARCHAR(100) NOT NULL DEFAULT 'No Name', 
apellido_cliente NVARCHAR(100) NOT NULL DEFAULT 'No Name', empresacliente NVARCHAR(100) DEFAULT 'No Company', callecliente VARCHAR(50) NOT NULL DEFAULT 'No Street',
nrocasacliente INT NOT NULL DEFAULT 0, aptocliente INT DEFAULT 0, INDEX idx_nombre_cliente(nombre_cliente),
INDEX idx_apellido_cliente(apellido_cliente),
INDEX idx_callecliente(callecliente),
INDEX idx_nrocasacliente(nrocasacliente),
INDEX idx_aptocliente(aptocliente),
INDEX idx_empresacliente(empresacliente));

CREATE TABLE ventas (id_venta INT PRIMARY KEY AUTO_INCREMENT, nombre_producto ENUM('Ordenador de escritorio', 'Portátil', 
'Monitor', 'Teclado', 'Ratón', 'Impresora', 'Altavoces', 'Auriculares', 'Tarjeta gráfica', 'Disco duro', 
'SSD', 'Memoria RAM', 'Placa base', 'Procesador', 'Consola de videojuegos', 
'Controlador de consola', 'Juegos de consola', 'Accesorios para computadoras', 'Otro'), precio_productotienda DECIMAL (10,2) NOT NULL DEFAULT 1,
vendedor VARCHAR(100) NOT NULL DEFAULT 'Empleoyee', id_cliente INT,tipofactura ENUM('Venta', 'Compra', 'Reembolso', 'Servicio', 'Otro') NOT NULL DEFAULT 'Venta',
tipoentrega ENUM ('Retiro En Tienda', 'Envio a Domicilio') NOT NULL DEFAULT 'Retiro En tienda', 
FOREIGN KEY (nombre_producto) REFERENCES productos(nombre_producto),
FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente));
-- En caso de que en tipoentrega se especifique Envio a Domicilio se debe usar la tabla logisticas_de_entrega para coordinar los envios

CREATE TABLE logisticas_de_entregas(id_envio INT PRIMARY KEY AUTO_INCREMENT, id_venta INT, nombre_cliente NVARCHAR(100) NOT NULL DEFAULT 'No Name', apellido_cliente NVARCHAR(100) NOT NULL DEFAULT 'No Name', 
empresacliente NVARCHAR(100) DEFAULT 'No Company', callecliente VARCHAR(50) NOT NULL DEFAULT 'No Street',nrocasacliente INT NOT NULL DEFAULT 0, 
aptocliente INT DEFAULT 0, fhentrega DATETIME DEFAULT '2000-01-01 09:00:00',
FOREIGN KEY (id_venta) REFERENCES ventas(id_venta));

CREATE TABLE inventario (id_inventario INT PRIMARY KEY AUTO_INCREMENT, id_productos INT, nombre_producto ENUM('Ordenador de escritorio', 'Portátil', 
'Monitor', 'Teclado', 'Ratón', 'Impresora', 'Altavoces', 'Auriculares', 'Tarjeta gráfica', 'Disco duro', 
'SSD', 'Memoria RAM', 'Placa base', 'Procesador', 'Consola de videojuegos', 
'Controlador de consola', 'Juegos de consola', 'Accesorios para computadoras', 'Otro'), stockentienda BIGINT NOT NULL DEFAULT 0,
FOREIGN KEY (id_productos) REFERENCES productos(id_productos));

-- Ingreso de Datos (ChatGPT)

INSERT INTO productos (nombre_producto, precio_producto, estadoproducto, stock) VALUES
    ('Ordenador de escritorio', 899.99, 'Nuevo', 10),
    ('Portátil', 699.99, 'Nuevo', 15),
    ('Monitor', 199.99, 'Nuevo', 20),
    ('Teclado', 29.99, 'Nuevo', 30),
    ('Ratón', 19.99, 'Nuevo', 40);

INSERT INTO proveedores (nombre_proveedor, paisproveedor, habilitacion_aduanas) VALUES
    ('Proveedor A', 'Estados Unidos', 1),
    ('Proveedor B', 'China', 1),
    ('Proveedor C', 'Alemania', 0),
    ('Proveedor D', 'México', 1),
    ('Proveedor E', 'Japón', 0);

INSERT INTO clientes (nombre_cliente, apellido_cliente, empresacliente, callecliente, nrocasacliente, aptocliente) VALUES
    ('Cliente A', 'Apellido A', 'Empresa A', 'Calle 1', 123, 0),
    ('Cliente B', 'Apellido B', 'Empresa B', 'Calle 2', 456, 101),
    ('Cliente C', 'Apellido C', 'Empresa C', 'Calle 3', 789, 0),
    ('Cliente D', 'Apellido D', 'Empresa D', 'Calle 4', 101, 0),
    ('Cliente E', 'Apellido E', 'Empresa E', 'Calle 5', 222, 0);
    
INSERT INTO ventas (nombre_producto, precio_productotienda, vendedor, id_cliente, tipofactura, tipoentrega) VALUES
    ('Ordenador de escritorio', 899.99, 'Empleado 1', 1, 'Venta', 'Retiro En Tienda'),
    ('Portátil', 699.99, 'Empleado 2', 2, 'Venta', 'Envio a Domicilio'),
    ('Monitor', 199.99, 'Empleado 3', 3, 'Venta', 'Retiro En Tienda'),
    ('Teclado', 29.99, 'Empleado 4', 4, 'Venta', 'Envio a Domicilio'),
    ('Ratón', 19.99, 'Empleado 5', 5, 'Venta', 'Retiro En Tienda');
    
    INSERT INTO logisticas_de_entregas (id_venta, nombre_cliente, apellido_cliente, empresacliente, callecliente, nrocasacliente, aptocliente, fhentrega) VALUES
    (2, 'Cliente B', 'Apellido B', 'Empresa B', 'Calle 2', 456, 101, '2023-09-10 14:00:00'),
    (4, 'Cliente D', 'Apellido D', 'Empresa D', 'Calle 4', 101, 0, '2023-09-11 13:30:00');

    
INSERT INTO inventario (id_productos, nombre_producto, stockentienda) VALUES
    (1, 'Ordenador de escritorio', 10),
    (2, 'Portátil', 15),
    (3, 'Monitor', 20),
    (4, 'Teclado', 30),
    (5, 'Ratón', 40);

