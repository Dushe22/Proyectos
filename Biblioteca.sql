-- Crear la base de datos Actividad1
CREATE DATABASE Actividad1;
USE Actividad1;

-- Crear la tabla Autor
CREATE TABLE Autor (
    NombreCompleto VARCHAR(100) PRIMARY KEY NOT NULL DEFAULT 'No Name',
    Nacimiento DATE NOT NULL DEFAULT '2000-01-01',
    Fallecimiento DATE NOT NULL DEFAULT '2000-01-01'
);

-- Crear la tabla Titulo
CREATE TABLE Titulo (
    IDtitulo INT PRIMARY KEY AUTO_INCREMENT,
    Titulo VARCHAR(100) NOT NULL DEFAULT 'Noname',
    NombreCompleto VARCHAR(100) NOT NULL DEFAULT 'Noname',
    Edicion INT NOT NULL,
    ISBN INT NOT NULL,
    URL VARCHAR(100) NOT NULL DEFAULT 'NoURL',
    FOREIGN KEY (NombreCompleto) REFERENCES Autor(NombreCompleto)
);

-- Crear la tabla Usuario
CREATE TABLE Usuario (
    ID_Usuario INT PRIMARY KEY AUTO_INCREMENT,
    Usuario VARCHAR(25) NOT NULL DEFAULT 'No User',
    Contraseña VARCHAR(30) NOT NULL DEFAULT 'No Password',
    Mail VARCHAR(100) NOT NULL DEFAULT 'No Mail',
    Nombre_Persona VARCHAR(100) NOT NULL DEFAULT 'No Name',
    Fecha_Registro DATE NOT NULL DEFAULT '2000-01-01'
);

-- Crear la tabla Evaluaciones
CREATE TABLE Evaluaciones (
    ID_Evaluacion INT PRIMARY KEY AUTO_INCREMENT,
    ID_Usuario INT NOT NULL,
    IDTitulo INT NOT NULL,
    Valoracion INT NOT NULL DEFAULT '0',
    Reseña TEXT NOT NULL,
    FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario),
    FOREIGN KEY (IDTitulo) REFERENCES Titulo(IDtitulo)
);

-- Crear la tabla categoria
CREATE TABLE categoria (
    IDTitulo INT,
    Categoria VARCHAR(50) NOT NULL DEFAULT 'No Category',
    FOREIGN KEY (IDTitulo) REFERENCES Titulo(IDtitulo)
);