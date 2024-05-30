CREATE DATABASE garden;

use garden;

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
    info_direccion VARCHAR(50),
    CONSTRAINT PK_codigo_oficina PRIMARY KEY (codigo_oficina),
    CONSTRAINT FK_oficina_ciudad FOREIGN KEY (ciudad) REFERENCES ciudad(codigo_ciudad), 
    CONSTRAINT FK_oficina_direccion FOREIGN KEY (info_direccion) REFERENCES infoDireccion(codigo_direccion)
);

CREATE TABLE empleado (
    codigo_empleado INT(11),
    nombre VARCHAR(50) NOT NULL,
    apellido1 VARCHAR(50) NOT NULL,
    apellido2 VARCHAR(50),
    extension VARCHAR(10) NOT NULL,
    email VARCHAR(45) NOT NULL,
    puesto INT,
    codigo_jefe INT,
    codigo_oficina VARCHAR(10),
    CONSTRAINT PK_codigo_empleado PRIMARY KEY (codigo_empleado),
    CONSTRAINT FK_codigo_puesto FOREIGN KEY (puesto) REFERENCES puesto(codigo_puesto), 
    CONSTRAINT FK_codigo_oficina FOREIGN KEY (codigo_oficina) REFERENCES oficina(codigo_oficina)
);


CREATE TABLE cliente (
    codigo_cliente INT(11),
    nombre_cliente VARCHAR(50) NOT NULL,
    fax VARCHAR(15) NOT NULL,
    limite_credito DECIMAL(15,2),
    ciudad INT,
    direccion VARCHAR(50),
    codigo_empleado_rep_ventas INT,
    CONSTRAINT PK_codigo_empleado PRIMARY KEY (codigo_cliente),
    CONSTRAINT FK_cliente_ciudad FOREIGN KEY (ciudad) REFERENCES ciudad(codigo_ciudad), 
    CONSTRAINT FK_cliente_direccion FOREIGN KEY (direccion) REFERENCES infoDireccion(codigo_direccion),
    CONSTRAINT FK_cliente_empleado FOREIGN KEY (codigo_empleado_rep_ventas) REFERENCES empleado(codigo_empleado)
);

CREATE TABLE contactoCliente (
    codigo_contacto INT AUTO_INCREMENT,
    nombre_contacto VARCHAR(30),
    apellido_contacto VARCHAR(30),
    cliente INT,
    CONSTRAINT PK_codigo_oficina PRIMARY KEY (codigo_contacto),
    CONSTRAINT FK_cliente_contacto FOREIGN KEY (cliente) REFERENCES cliente(codigo_cliente) 
);

CREATE TABLE pago (
    id_transaccion VARCHAR(50),
    forma_pago VARCHAR(40) NOT NULL,
    fecha_pago VARCHAR(40) NOT NULL,
    total DECIMAL(15,2) NOT NULL,
    cliente INT,
    CONSTRAINT PK_codigo_oficina PRIMARY KEY (id_transaccion),
    CONSTRAINT FK_cliente_pago FOREIGN KEY (cliente) REFERENCES cliente(codigo_cliente) 
);

CREATE TABLE pedido (
    codigo_pedido INT(11) AUTO_INCREMENT,
    fecha_pedido DATE NOT NULL,
    fecha_esperada DATE NOT NULL,
    fecha_entrega DATE,
    comentarios TEXT,
    estado INT,
    cliente INT,
    CONSTRAINT PK_codigo_oficina PRIMARY KEY (codigo_pedido),
    CONSTRAINT FK_pedido_estadoPedido FOREIGN KEY (estado) REFERENCES estadoPedido(codigo_estado), 
    CONSTRAINT FK_pedido_cliente FOREIGN KEY (cliente) REFERENCES cliente(codigo_cliente) 
);


CREATE TABLE detalle_pedido (
    producto VARCHAR(15),
    pedido INT,
    cantidad INT(11) NOT NULL,
    precio_unidad DECIMAL(15,2) NOT NULL,
    numero_linea SMALLINT(6) NOT NULL,
    estado INT,
    cliente INT,
    CONSTRAINT PK_factura_productoo PRIMARY KEY (producto,pedido),
    CONSTRAINT FK_factura_producto FOREIGN KEY (producto) REFERENCES producto(codigo_producto), 
    CONSTRAINT FK_factura_pedido FOREIGN KEY (pedido) REFERENCES pedido(codigo_pedido) 
);

CREATE TABLE telefono (
    codigo_telefono INT(11),
    telefono VARCHAR(15) NOT NULL,
    cliente INT(11),
    oficina VARCHAR(10),
    CONSTRAINT PK_telf_cliente_oficina PRIMARY KEY (codigo_telefono),
    CONSTRAINT FK_telefono_cliente FOREIGN KEY (cliente) REFERENCES cliente(codigo_cliente), 
    CONSTRAINT FK_telefono_oficina FOREIGN KEY (oficina) REFERENCES oficina(codigo_oficina) 
);

YA INSERTE EN REGION/PAIS/CIUDAD, INFODIRECCION, OFICINA, PUESTO, CLIENTE, TELEFONO

SELECT O.codigo_oficina as oficina, C.nombre_ciudad as ciudad 
FROM oficina AS O
INNER JOIN ciudad as C ON C.codigo_ciudad = O.ciudad;


SELECT  DISTINCT C.nombre_ciudad
FROM pais as P
JOIN region as R ON P.codigo_pais = R.pais
JOIN ciudad as C ON  R.pais = C.region
JOIN oficina as O ON C.codigo_ciudad = O.ciudad
WHERE P.nombre_pais = 'España';


SELECT
    T.oficina as Oficina ,T.telefono as Telefono
FROM
    telefono AS T
WHERE
    T.oficina IN (SELECT  DISTINCT O.codigo_oficina
FROM pais as P
JOIN region as R ON P.codigo_pais = R.pais
JOIN ciudad as C ON  R.pais = C.region
JOIN oficina as O ON C.codigo_ciudad = O.ciudad
WHERE P.nombre_pais = 'España');


SELECT E.nombre as Nombre, E.apellido1 as Apellido, E.

