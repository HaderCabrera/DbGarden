CREATE DATABASE garden;

use garden;

CREATE TABLE puesto (
    codigo_puesto INT PRIMARY KEY AUTO
)

CREATE TABLE puesto (
    codigo_puesto INT AUTO_INCREMENT,
    puesto VARCHAR(45),
    CONSTRAINT PK_codigo_puesto PRIMARY KEY (codigo_puesto)
);

CREATE TABLE estadoPedido (
    codigo_estado INT AUTO_INCREMENT,
    estado VARCHAR(50),
    CONSTRAINT PK_codigo_estado PRIMARY KEY (codigo_estado)
);

CREATE TABLE proveedor (
    codigo_proveedor INT AUTO_INCREMENT,
    nombre_proveedor VARCHAR(50),
    CONSTRAINT PK_codigo_proveedor PRIMARY KEY (codigo_proveedor)
);

CREATE TABLE gama_producto (
    gama VARCHAR(50),
    descripcion_texto TEXT,
    descripcion_html TEXT,
    imagen VARCHAR(256),
    CONSTRAINT PK_gama_producto PRIMARY KEY (gama)
);

CREATE TABLE producto (
    codigo_producto VARCHAR(15),
    nombre VARCHAR(70) NOT NULL,
    dimensiones VARCHAR(50),
    descripcion TEXT,
    cantidad_en_stock SMALLINT(6) NOT NULL,
    precio_venta DECIMAL(15,2) NOT NULL,
    precio_proveedor DECIMAL(15,2),
    gama VARCHAR(50),
    proveedor INT,
    CONSTRAINT PK_codigo_producto PRIMARY KEY (codigo_producto),
    CONSTRAINT FK_gama_producto FOREIGN KEY (gama) REFERENCES gama_producto(gama), 
    CONSTRAINT FK_codigo_proveedor FOREIGN KEY (proveedor) REFERENCES proveedor(codigo_proveedor)
);

CREATE TABLE pais (
    codigo_pais INT AUTO_INCREMENT,
    nombre_pais VARCHAR(50),
    CONSTRAINT PK_codigo_pais PRIMARY KEY (codigo_pais)
);

CREATE TABLE region (
    codigo_region INT AUTO_INCREMENT,
    nombre_region VARCHAR(50),
    pais INT,
    CONSTRAINT PK_codigo_region PRIMARY KEY (codigo_region),
    CONSTRAINT FK_region_pais FOREIGN KEY (pais) REFERENCES pais(codigo_pais)
);

CREATE TABLE ciudad (
    codigo_ciudad INT AUTO_INCREMENT,
    nombre_ciudad VARCHAR(50),
    region INT,
    CONSTRAINT ciudad PRIMARY KEY (codigo_ciudad),
    CONSTRAINT FK_region_ciudad FOREIGN KEY (region) REFERENCES region(codigo_region)
);

CREATE TABLE infoDireccion (
    codigo_direccion VARCHAR(50),
    linea_direccion1 VARCHAR(50) NOT NULL,
    linea_direccion2 VARCHAR(50),
    codigo_postal VARCHAR(10) NOT NULL,
    CONSTRAINT PK_codigo_direccion PRIMARY KEY (codigo_direccion)
);

CREATE TABLE oficina (
    codigo_oficina VARCHAR(10),
    ciudad INT,
    info_direccion INT,
    CONSTRAINT PK_codigo_oficina PRIMARY KEY (codigo_oficina),
    CONSTRAINT FK_oficina_ciudad FOREIGN KEY (ciudad) REFERENCES ciudad(codigo_ciudad), 
    CONSTRAINT FK_oficina_direccion FOREIGN KEY (info_direccion) REFERENCES infoDireccion(codigo_proveedor)
);
