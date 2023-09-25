-- Crear Base de Datos Ejercicio 1 DML
CREATE DATABASE Ejercicio1DML;
USE Ejercicio1DML;
CREATE TABLE Fabricantes (Codigo INT AUTO_INCREMENT PRIMARY KEY, Nombre VARCHAR(10));
CREATE TABLE Articulos (Codigo INT AUTO_INCREMENT PRIMARY KEY,Nombre VARCHAR(10),Precio INT, Fabricante INT,
FOREIGN KEY (Fabricante) REFERENCES Fabricantes(Codigo));

-- Insercion de Datos de Ejemplo (ChatGPT)
INSERT INTO Fabricantes (Nombre) VALUES ('Fab1');
INSERT INTO Fabricantes (Nombre) VALUES ('Fab2');
INSERT INTO Fabricantes (Nombre) VALUES ('Fab3');
INSERT INTO Articulos (Nombre, Precio, Fabricante) VALUES ('Producto1', 100, 1);
INSERT INTO Articulos (Nombre, Precio, Fabricante) VALUES ('Producto2', 120, 1);
INSERT INTO Articulos (Nombre, Precio, Fabricante) VALUES ('Producto3', 150, 2);
INSERT INTO Articulos (Nombre, Precio, Fabricante) VALUES ('Producto4', 200, 2);
INSERT INTO Articulos (Nombre, Precio, Fabricante) VALUES ('Producto5', 80, 3);
INSERT INTO Articulos (Nombre, Precio, Fabricante) VALUES ('Producto6', 90, 3);
INSERT INTO Articulos (Nombre, Precio, Fabricante) VALUES ('Producto7', 170, 1);
INSERT INTO Articulos (Nombre, Precio, Fabricante) VALUES ('Producto8', 220, 2);
INSERT INTO Articulos (Nombre, Precio, Fabricante) VALUES ('Producto9', 70, 3);

-- Analisis de Datos (Para cada una de las lineas le pedi a GPT que agregara un comentario de su funcionamiento)
-- Selecciona el nombre y el precio de todos los productos en la tabla "Articulos".
SELECT nombre AS 'Nombre Producto', Precio FROM ARTICULOS;
-- Selecciona el nombre de los productos en la tabla "Articulos" cuyo precio es mayor o igual a $200.
SELECT nombre AS 'Nombre Producto' FROM ARTICULOS WHERE Precio >=200;
-- Selecciona el nombre, precio y fabricante de los productos en la tabla "Articulos" cuyo precio está entre $60 y $120.
SELECT nombre AS 'Nombre Producto', Precio AS 'Precio Producto', Fabricante AS 'Fabricante Producto' FROM ARTICULOS WHERE Precio >=60 AND PRECIO <=120;
-- Selecciona el nombre, precio en dólares y precio en pesos de todos los productos en la tabla "Articulos". El precio en pesos se calcula asumiendo un tipo de cambio de 35 pesos por dólar.
SELECT nombre AS 'Nombre Producto', Precio AS 'Precio Producto (Dolares)', Precio * 35 AS 'Precio Producto (Pesos)' FROM ARTICULOS;
-- Calcula el precio promedio de los productos en la tabla "Articulos" fabricados por el fabricante con el código 2.
SELECT AVG(Precio) AS 'Precio Promedio' FROM ARTICULOS WHERE Fabricante=2;
-- Cuenta cuántos productos en la tabla "Articulos" tienen un precio igual o mayor a $180.
SELECT COUNT(*) AS 'Cantidad de Articulos' FROM ARTICULOS WHERE Precio >= 180;
-- Calcula el precio promedio de todos los productos en la tabla "Articulos".
SELECT AVG(Precio) AS 'Precio Promedio' FROM ARTICULOS;
-- Selecciona el nombre y el precio de los productos en la tabla "Articulos" cuyo precio es igual o mayor a $190, ordenados por precio de forma descendente y por nombre de forma ascendente.
SELECT nombre AS 'Nombre Producto', Precio AS 'Precio Producto' FROM ARTICULOS WHERE PRECIO >=190 ORDER BY Precio DESC, nombre ASC;
-- Selecciona todos los datos de los productos en la tabla "Articulos" junto con el nombre del fabricante al que pertenecen.
SELECT Articulos.*, Fabricantes.Nombre AS NombreFabricante FROM Articulos INNER JOIN Fabricantes ON Articulos.Fabricante = Fabricantes.Codigo;
-- Selecciona el nombre del producto, su precio y el nombre del fabricante al que pertenece.
SELECT Articulos.Nombre AS NombreArticulo, Articulos.Precio, Fabricantes.Nombre AS NombreFabricante FROM Articulos INNER JOIN Fabricantes ON Articulos.Fabricante = Fabricantes.Codigo;
-- Calcula el precio promedio de los productos agrupados por el código del fabricante.
SELECT Fabricante, AVG(Precio) AS 'Precio Promedio' FROM Articulos GROUP BY Fabricante;
-- Calcula el precio promedio de los productos agrupados por el nombre del fabricante.
SELECT Fabricantes.Nombre AS 'Nombre Fabricante', AVG(Articulos.Precio) AS PrecioMedio FROM Articulos INNER JOIN Fabricantes ON Articulos.Fabricante = Fabricantes.Codigo GROUP BY Fabricantes.Nombre;
-- Selecciona el nombre de los fabricantes que ofrecen productos cuyo precio promedio es mayor o igual a $150.
SELECT Fabricantes.Nombre AS NombreFabricante FROM Articulos INNER JOIN Fabricantes ON Articulos.Fabricante = Fabricantes.Codigo GROUP BY Fabricantes.Nombre HAVING AVG(Articulos.Precio) >= 150;
-- Selecciona el nombre y el precio del artículo más barato en la tabla "Articulos".
SELECT Nombre, Precio FROM Articulos WHERE Precio = (SELECT MIN(Precio) FROM Articulos);
-- Selecciona el nombre, precio y fabricante del artículo más caro de cada fabricante.
SELECT F.Nombre AS NombreFabricante, A.Nombre AS NombreArticulo, A.Precio FROM Articulos A INNER JOIN Fabricantes F ON A.Fabricante = F.Codigo WHERE (A.Precio, A.Fabricante) IN (SELECT MAX(Precio), Fabricante FROM Articulos GROUP BY Fabricante);
-- Inserta un nuevo artículo llamado 'Altavoces' con un precio de $70 y asignado al fabricante con el código 2.
INSERT INTO Articulos (Nombre, Precio, Fabricante) VALUES ('Altavoces', 70, 2);
-- Actualiza el nombre del producto con el código 8 a 'Imp Laser'.
UPDATE Articulos SET Nombre = 'Imp Laser' WHERE Codigo = 8;
-- Aplica un descuento del 10% a todos los productos en la tabla "Articulos".
UPDATE Articulos SET Precio = Precio * 0.9;
-- Aplica un descuento de $10 a todos los productos cuyo precio es igual o mayor a $120 en la tabla "Articulos".
UPDATE Articulos SET Precio = Precio - 10 WHERE Precio >= 120;
















