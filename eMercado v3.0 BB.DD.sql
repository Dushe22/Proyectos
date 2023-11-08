CREATE DATABASE eMercado;
USE eMercado;
CREATE TABLE Contrasenas (
    Id_Contraseña INT PRIMARY KEY AUTO_INCREMENT,
    HashContraseña VARCHAR(255), 
    SaltContraseña VARCHAR(64) 
)
ENGINE = InnoDB;


CREATE TABLE Usuario (
    Id_Usuario INT PRIMARY KEY AUTO_INCREMENT,
    PrimerNombre VARCHAR(50) NOT NULL DEFAULT 'No Name',
    SegundoNombre VARCHAR(50) DEFAULT 'No Second Name',
    PrimerApellido VARCHAR(50) NOT NULL DEFAULT 'No Surname',
    SegundoApellido VARCHAR(50) DEFAULT 'No Second Surname',
    Email VARCHAR(100) UNIQUE NOT NULL,
    ImagenDePerfil MEDIUMBLOB,
    TelefonoDeContacto VARCHAR(20),
    ContraseñaUsuario INT,
    CONSTRAINT ValidarNombre CHECK (PrimerNombre NOT REGEXP '[^a-zA-Z\s]' AND PrimerNombre REGEXP '^[a-zA-Z]'),
    CONSTRAINT ValidarSegundoNombre CHECK (SegundoNombre NOT REGEXP '[^a-zA-Z\s]' AND SegundoNombre REGEXP '^[a-zA-Z]'),
    CONSTRAINT ValidarPrimerApellido CHECK (PrimerApellido NOT REGEXP '[^a-zA-Z\s]' AND PrimerApellido REGEXP '^[a-zA-Z]'),
    CONSTRAINT ValidarSegundoApellido CHECK (SegundoApellido NOT REGEXP '[^a-zA-Z\s]' AND SegundoApellido REGEXP '^[a-zA-Z]'),
    CONSTRAINT ValidarEmail CHECK (Email REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$'),
    -- Un error a resolver es que las constraints no dejan almacenar nombres con tildes
    INDEX IDX_PRIMERNOMBRE(PrimerNombre),
    INDEX IDX_PRIMERAPELLIDO(PrimerApellido),
    INDEX IDX_EMAIL(Email),
    INDEX IDX_TELEFONOUSUARIO(TelefonoDeContacto),
    CONSTRAINT FK_Usuario_Contrasenas FOREIGN KEY (ContraseñaUsuario) REFERENCES Contrasenas(Id_Contraseña)
)
ENGINE = INNODB;

DELIMITER //

CREATE PROCEDURE InsertarUsuario(IN _primerNombre VARCHAR(50), IN _segundoNombre VARCHAR(50), IN 
_primerApellido VARCHAR(50), IN _segundoApellido VARCHAR(50), IN _email VARCHAR(100), IN _imagenDePerfil BINARY(255), 
IN _telefonoDeContacto VARCHAR(20), IN _contrasenaPlana VARCHAR(255))
BEGIN
DECLARE _salt VARBINARY(32); 
DECLARE _hashContrasena CHAR(64);
SET _salt = UNHEX(SHA2(RAND(), 256));
SET _hashContrasena = SHA2(CONCAT(_contrasenaPlana, _salt), 256);
INSERT INTO Contrasenas (HashContraseña, SaltContraseña) VALUES (_hashContrasena, HEX(_salt));
SET @Id_Contrasena = LAST_INSERT_ID();
INSERT INTO Usuario (PrimerNombre, SegundoNombre, PrimerApellido, 
SegundoApellido, Email, ImagenDePerfil, TelefonoDeContacto, ContraseñaUsuario) VALUES
(_primerNombre, _segundoNombre, _primerApellido, _segundoApellido, _email, _imagenDePerfil, _telefonoDeContacto, @Id_Contrasena);
END //
DELIMITER ;

CALL InsertarUsuario(
    'Juan',            
    'Carlos',         
    'Perez',           
    'Gonzalez',        
    'juan.perez@email.com', 
    NULL,              
    '1234567890',      
    'miContraseña123'  
);

-- Este es un ejemplo de como llamar la procedure anteriormente creada generado nuestro hash y salt 

CREATE TABLE Categorias (
    Id_Categoria INT PRIMARY KEY AUTO_INCREMENT,
    Nombre NVARCHAR(50) NOT NULL UNIQUE,
    Descripcion NVARCHAR(255) NULL,
    FechaCreacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FechaModificacion DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,
    CreadoPor INT NULL,
    ModificadoPor INT NULL 
)
ENGINE = INNODB;

CREATE TABLE Articulos (
    Id_Articulo INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(20) UNIQUE,
    Descripcion VARCHAR(50),
    CategoriaID INT,
    Precio DECIMAL(10, 2) CHECK (Precio >= 0),
    Moneda CHAR(3) CHECK (Moneda IN ('USD', 'UYU')), 
    CantidadComprados INT DEFAULT 0 CHECK (CantidadComprados >= 0),
    Imagen1 MEDIUMBLOB,
    Imagen2 MEDIUMBLOB,
    Imagen3 MEDIUMBLOB,
    Imagen4 MEDIUMBLOB,
    PuntuacionComentarios DECIMAL(3, 2) CHECK (PuntuacionComentarios BETWEEN 0 AND 5),
    FechaCreacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FechaActualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (CategoriaID) REFERENCES Categorias(Id_Categoria)
) 
ENGINE = InnoDB;

CREATE TABLE Ventas (
    Id_Venta INT PRIMARY KEY AUTO_INCREMENT,
    UsuarioID INT,
    ArticuloID INT,
    CantidadVendida INT CHECK (CantidadVendida >= 0),
    PrecioUnitario DECIMAL(10, 2) CHECK (PrecioUnitario >= 0),
    CostoTotal DECIMAL(10, 2) CHECK (CostoTotal >= 0),
    FechaVenta DATETIME DEFAULT CURRENT_TIMESTAMP,
    TipoPublicacion ENUM('Venta Directa', 'Subasta', 'Oferta Especial'),
    PorcentajeComision DECIMAL(5, 2),
    VendedorID INT, 
    EstadoVenta ENUM('Pendiente', 'Completada', 'Cancelada'),
    FOREIGN KEY (UsuarioID) REFERENCES Usuario(Id_Usuario),
    FOREIGN KEY (ArticuloID) REFERENCES Articulos(Id_Articulo),
    FOREIGN KEY (VendedorID) REFERENCES Usuario(Id_Usuario)
)
ENGINE = InnoDB;

CREATE TABLE MetodoEnvio (
    Id_MetodoEnvio INT PRIMARY KEY AUTO_INCREMENT,
    DireccionID INT,
    TipoEnvio ENUM('Estandar', 'Express', 'Internacional'),
    Costo DECIMAL(10, 2) CHECK (Costo >= 0),
    FOREIGN KEY (DireccionID) REFERENCES Direcciones(Id_Direccion) 
)
ENGINE = InnoDB;

CREATE TABLE Direcciones (
    Id_Direccion INT PRIMARY KEY AUTO_INCREMENT,
    Ciudad VARCHAR(50),
    Calle VARCHAR(50),
    Numero VARCHAR(10),
    Esquina VARCHAR(50) NULL
)
ENGINE = InnoDB;

-- Crear la tabla FormaPago
CREATE TABLE FormaPago (
    Id_FormaPago INT PRIMARY KEY AUTO_INCREMENT,
    Tipo NVARCHAR(20) NOT NULL,
    NumeroTarjeta NVARCHAR(16),
    CodigoSeguridad NVARCHAR(4),
    FechaVencimiento NVARCHAR(5),
    NumeroCuenta NVARCHAR(20)
)
ENGINE = InnoDB;

CREATE TABLE FormaPago (
    Id_FormaPago INT PRIMARY KEY AUTO_INCREMENT,
    UsuarioID INT,
    Tipo ENUM('Tarjeta de Crédito', 'Cuenta Bancaria', 'PayPal'), 
    NumeroTarjeta VARCHAR(16), 
    CodigoSeguridad VARCHAR(4), 
    FechaVencimiento DATE, 
    NumeroCuenta VARCHAR(20), 
    Expirada BOOLEAN, 
    FechaCreacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FechaActualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)
Engine = InnoDb;


CREATE TABLE UsuariosFormasPago (
    UsuarioID INT,
    FormaPagoID INT,
    PRIMARY KEY (UsuarioID, FormaPagoID),
    FOREIGN KEY (UsuarioID) REFERENCES Usuario(Id_Usuario),
    FOREIGN KEY (FormaPagoID) REFERENCES FormaPago(Id_FormaPago)
)
Engine = InnoDB;

DELIMITER //
CREATE PROCEDURE FormaDePagoEncriptada(
    IN p_UsuarioID INT,
    IN p_Tipo ENUM('Tarjeta de Crédito', 'Cuenta Bancaria', 'PayPal'),
    IN p_NumeroTarjeta VARCHAR(16),
    IN p_CodigoSeguridad VARCHAR(4),
    IN p_FechaVencimiento DATE,
    IN p_NumeroCuenta VARCHAR(20),
    IN p_Expirada BOOLEAN
)
BEGIN
    DECLARE encryptedCodigoSeguridad VARBINARY(255);     
    SET encryptedCodigoSeguridad = AES_ENCRYPT(p_CodigoSeguridad, 'clave_secreta');
    INSERT INTO FormaPago (UsuarioID, Tipo, NumeroTarjeta, CodigoSeguridad, FechaVencimiento, NumeroCuenta, 
    Expirada, FechaCreacion, FechaActualizacion)
    VALUES (p_UsuarioID, p_Tipo, p_NumeroTarjeta, encryptedCodigoSeguridad, p_FechaVencimiento, p_NumeroCuenta, p_Expirada, NOW(), NOW())
    ON DUPLICATE KEY UPDATE
    Tipo = p_Tipo,
    NumeroTarjeta = p_NumeroTarjeta,
    CodigoSeguridad = encryptedCodigoSeguridad,
    FechaVencimiento = p_FechaVencimiento,
    NumeroCuenta = p_NumeroCuenta,
    Expirada = p_Expirada,
    FechaActualizacion = NOW();
END;
//
DELIMITER ;

CALL FormaDePagoEncriptada(
    1, 
    'Tarjeta de Crédito', 
    '1234567890123456', 
    0101, 
    '2023-12-31',  
    '0123456789', 
    0
);
-- El procedure sigue sin funcionar correctamente, hay un error con el tipo de dato

CREATE TABLE CarritoDeCompras (
    Id_Carrito INT PRIMARY KEY AUTO_INCREMENT,
    UsuarioID INT,
    ArticuloID INT,
    Cantidad INT,
    CostoUnitario DECIMAL(10, 2),
    Descuento DECIMAL(10, 2),
    CostoEnvio DECIMAL(10, 2),
    CostoTotal DECIMAL(10, 2),
    MetodoEnvioID INT,
    FormaPagoID INT,
    FechaCompra DATETIME DEFAULT CURRENT_TIMESTAMP(),
    EstadoCompra ENUM('Pendiente', 'Completada', 'Cancelada') DEFAULT 'Pendiente',
    DireccionEnvioID INT,
    MetodoPago VARCHAR(50),  
    Comentarios TEXT,        
    HistorialCompra BOOLEAN, 
    NumeroSeguimiento VARCHAR(50),  
    FOREIGN KEY (UsuarioID) REFERENCES Usuario(Id_Usuario),
    FOREIGN KEY (ArticuloID) REFERENCES Articulos(Id_Articulo),
    FOREIGN KEY (MetodoEnvioID) REFERENCES MetodoEnvio(Id_MetodoEnvio),
    FOREIGN KEY (FormaPagoID) REFERENCES FormaPago(Id_FormaPago),
    FOREIGN KEY (DireccionEnvioID) REFERENCES Direcciones(Id_Direccion)
)
ENGINE = InnoDB ;


