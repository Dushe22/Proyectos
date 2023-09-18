-- Base de Datos de una Cafetería:

-- Entidades: Productos (café, pasteles, etc.), Clientes, Empleados, Pedidos.

-- Relaciones: Los clientes hacen pedidos, los empleados los preparan y se registran los productos vendidos

CREATE DATABASE cafeteria;

USE cafeteria;

CREATE TABLE clientes (id_cliente INT PRIMARY KEY AUTO_INCREMENT, NombreCliente VARCHAR(100) NOT NULL DEFAULT 'No Name', 
ApellidoCliente VARCHAR(100) NOT NULL DEFAULT 'No Lastname');

CREATE TABLE productos (id_producto INT auto_increment, nomproducto ENUM ('Cafe', 'Pasteles', 'Torta') NOT NULL DEFAULT 'Cafe', PRIMARY KEY
(id_producto, nomproducto), INDEX idx_nomproducto (nomproducto)); -- Index en este caso se usa para conseguir la informacion de nomproducto.

CREATE TABLE pedidos (id_pedido INT PRIMARY KEY AUTO_INCREMENT, id_cliente INT, nomproducto ENUM ('Cafe', 'Pasteles', 'Torta') NOT NULL DEFAULT 'Cafe',
precio DECIMAL (10,2) NOT NULL CHECK (precio > 0) DEFAULT '1',
FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente), FOREIGN KEY (nomproducto) REFERENCES productos(nomproducto),
INDEX idx_precio (precio));

CREATE TABLE empleados (id_empleado INT PRIMARY KEY AUTO_INCREMENT, NombreEmpleado VARCHAR(100) NOT NULL DEFAULT 'No Name', 
ApellidoEmpleado VARCHAR(100) NOT NULL DEFAULT 'No Lastname', cargococina ENUM ('Cafeteria', 'Reposteria', 'Caja') NOT NULL DEFAULT 'Cafeteria', 
id_pedido INT, FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido));

CREATE TABLE ventas (id_ventas INT AUTO_INCREMENT, id_cliente INT, id_empleado INT, id_pedido INT, id_producto INT, 
precio DECIMAL (10,2) NOT NULL CHECK (precio > 0) DEFAULT '1', FOREIGN KEY (precio) REFERENCES pedidos(precio),
FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente), FOREIGN KEY (id_producto) REFERENCES productos(id_producto),  
FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido), FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
PRIMARY KEY(id_ventas, id_cliente,id_empleado,id_pedido,id_producto));


-- Insertar datos(Se los pedi a GPT)


INSERT INTO clientes (NombreCliente, ApellidoCliente) VALUES
('Juan', 'Perez'),
('Maria', 'Gomez'),
('Carlos', 'Lopez'),
('Laura', 'Rodriguez');
INSERT INTO productos (nomproducto) VALUES
('Cafe'),
('Pasteles'),
('Torta');
INSERT INTO pedidos (id_cliente, nomproducto, precio) VALUES
(1, 'Cafe', 2.50),
(2, 'Pasteles', 15.99),
(3, 'Torta', 25.50),
(4, 'Cafe', 2.50);
INSERT INTO empleados (NombreEmpleado, ApellidoEmpleado, cargococina, id_pedido) VALUES
('Pedro', 'Gonzalez', 'Cafeteria', 1),
('Ana', 'Martinez', 'Cafeteria', 4),
('Luis', 'Sanchez', 'Cafeteria', NULL),
('Marta', 'Lopez', 'Reposteria', 2),
('David', 'Perez', 'Reposteria', NULL),
('Elena', 'Ramirez', 'Reposteria', 3),
('Sergio', 'Rodriguez', 'Caja', NULL),
('Valeria', 'Garcia', 'Caja', NULL),
('Javier', 'Torres', 'Caja', NULL);
INSERT INTO ventas (id_cliente, id_empleado, id_pedido, id_producto, precio) VALUES
(1, 1, 1, 1, 2.50),
(2, 4, 2, 2, 15.99),
(3, 6, 3, 3, 25.50),
(4, 2, 4, 1, 2.50);






