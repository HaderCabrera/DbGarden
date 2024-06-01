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
    codigo_gama VARCHAR(50),
    gama VARCHAR(50),
    descripcion_texto TEXT,
    descripcion_html TEXT,
    imagen VARCHAR(256),
    CONSTRAINT PK_codigo_gama PRIMARY KEY (codigo_gama)
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
    CONSTRAINT FK_gama_producto FOREIGN KEY (gama) REFERENCES gama_producto(codigo_gama), 
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

-- Inserciones para la tabla 'pais'
INSERT INTO pais (nombre_pais) VALUES 
('España'),
('Francia'),
('Alemania'),
('Italia'),
('Reino Unido'),
('Portugal'),
('Países Bajos'),
('Suiza'),
('Suecia'),
('Noruega');

-- Inserciones para la tabla 'region'
INSERT INTO region (nombre_region, pais) VALUES 
('Andalucía', 1),  -- España
('Cataluña', 1),    -- España
('Comunidad de Madrid', 1),  -- España
('Provenza-Alpes-Costa Azul', 2),  -- Francia
('Isla de Francia', 2),    -- Francia
('Baviera', 3),    -- Alemania
('Lombardía', 4),    -- Italia
('Inglaterra', 5),    -- Reino Unido
('Lisboa', 6),    -- Portugal
('Holanda del Norte', 7);   -- Países Bajos

-- Inserciones para la tabla 'ciudad'
INSERT INTO ciudad (nombre_ciudad, region) VALUES 
('Madrid', 3),  -- Comunidad de Madrid, España
('Barcelona', 2),    -- Cataluña, España
('Marsella', 4),    -- Provenza-Alpes-Costa Azul, Francia
('París', 5),    -- Isla de Francia, Francia
('Múnich', 6),    -- Baviera, Alemania
('Milán', 7),    -- Lombardía, Italia
('Londres', 8),    -- Inglaterra, Reino Unido
('Lisboa', 9),    -- Lisboa, Portugal
('Ámsterdam', 10),    -- Holanda del Norte, Países Bajos
('Sevilla', 1),
('Fuenlabrada', 3);   -- Andalucía, España


-- Inserciones para la tabla 'infoDireccion'
INSERT INTO infoDireccion (codigo_direccion, linea_direccion1, linea_direccion2, codigo_postal) VALUES 
('ESP001', 'Calle Mayor', 'Número 1', '28001'),  -- Madrid, España
('ESP002', 'Rambla de Catalunya', 'Piso 2', '08007'),  -- Barcelona, España
('ESP003', 'Calle Alcalá', 'Piso 3', '41001'),  -- Sevilla, España
('ESP004', 'Avenida de la Playa', 'Edificio Sol', '29640'),  -- Málaga, España
('ESP005', 'Plaza Mayor', 'Apartamento 5', '37002'),  -- Salamanca, España
('FRA001', 'Rue de Rivoli', 'Appartement 10', '75001'),  -- París, Francia
('FRA002', 'Boulevard de la Croisette', 'Villa du Soleil', '06400'),  -- Cannes, Francia
('GER001', 'Marienplatz', 'Haus 3', '80331'),  -- Múnich, Alemania
('ITA001', 'Via Montenapoleone', 'Appartamento 7', '20121'),  -- Milán, Italia
('UK001', 'Buckingham Palace Road', 'Flat 15', 'SW1A 1AA'),  -- Londres, Reino Unido
('POR001', 'Rua Augusta', 'Andar 2', '1100-048'),  -- Lisboa, Portugal
('HOL001', 'Dam Square', 'Apartment 8', '1012 JS'),  -- Ámsterdam, Países Bajos
('ESP006', 'Calle Gran Vía', 'Piso 4', '28013'),  -- Madrid, España
('ESP007', 'Paseo de Gracia', 'Edificio Modernista', '08008'),  -- Barcelona, España
('FRA003', 'Avenue des Champs-Élysées', 'Appartement 20', '75008'),  -- París, Francia
('GER002', 'Kurfürstendamm', 'Apartment 12', '10707'),  -- Berlín, Alemania
('UK002', 'Baker Street', 'Flat 221B', 'NW1 6XE'),  -- Londres, Reino Unido
('POR002', 'Rua de Santa Catarina', 'Andar 3', '4000-457'),  -- Oporto, Portugal
('HOL002', 'Prinsengracht', 'Apartment 17', '1015 DK'),  -- Ámsterdam, Países Bajos
('ESP008', 'Calle Serrano', 'Piso 5', '28006');  -- Madrid, España


-- Inserciones para la tabla 'oficina'
INSERT INTO oficina (codigo_oficina, ciudad, info_direccion) VALUES 
('OFI001', 1, 'ESP001'),  -- Madrid, España
('OFI002', 2, 'ESP002'),  -- Barcelona, España
('OFI003', 3, 'ESP003'),  -- Sevilla, España
('OFI004', 4, 'ESP004'),  -- Málaga, España
('OFI005', 5, 'ESP005'),  -- Salamanca, España
('OFI006', 6, 'FRA001'),  -- París, Francia
('OFI007', 7, 'FRA002'),  -- Cannes, Francia
('OFI008', 8, 'GER001'),  -- Múnich, Alemania
('OFI009', 9, 'ITA001'),  -- Milán, Italia
('OFI010', 10, 'UK001'),  -- Londres, Reino Unido
('OFI011', 8, 'POR001'),  -- Lisboa, Portugal
('OFI012', 10, 'HOL001'),  -- Ámsterdam, Países Bajos
('OFI013', 1, 'ESP006'),  -- Madrid, España
('OFI014', 2, 'ESP007'),  -- Barcelona, España
('OFI015', 6, 'FRA003'),
('OFI016', 11, 'ESP001');  -- París, Francia


-- Inserciones para la tabla 'puesto'
INSERT INTO puesto (puesto) VALUES 
('Gerente de Ventas'),
('Representante de Ventas'),
('CSR customer'),
('Especialista en Marketing'),
('Jefe de jefes');


INSERT INTO empleado (codigo_empleado, nombre, apellido1, apellido2, extension, email, puesto, codigo_jefe, codigo_oficina) VALUES
(1, 'Carlos', 'Gonzalez', 'Lopez', '1001', 'carlos.gonzalez@empresa.com', 1, NULL, 'OFI001'), -- Gerente, Madrid
(2, 'Ana', 'Martinez', 'Sanchez', '1002', 'ana.martinez@empresa.com', 2, 1, 'OFI002'), -- Asistente, Barcelona
(3, 'Luis', 'Rodriguez', 'Diaz', '1003', 'luis.rodriguez@empresa.com', 3, 1, 'OFI003'), -- Vendedor, Sevilla
(4, 'Elena', 'Lopez', 'Martinez', '1004', 'elena.lopez@empresa.com', 4, 1, 'OFI004'), -- Contador, Málaga
(5, 'Juan', 'Perez', 'Gomez', '1005', 'juan.perez@empresa.com', 1, 1, 'OFI005'), -- Recepcionista, Salamanca
(6, 'María', 'Garcia', 'Fernandez', '1006', 'maria.garcia@empresa.com', 2, NULL, 'OFI006'), -- Gerente, París
(7, 'Jorge', 'Sanchez', 'Lopez', '1007', 'jorge.sanchez@empresa.com', 3, 6, 'OFI007'), -- Asistente, Cannes
(8, 'Lucia', 'Hernandez', 'Martinez', '1008', 'lucia.hernandez@empresa.com', 3, 6, 'OFI008'), -- Vendedor, Múnich
(9, 'Pedro', 'Ramirez', 'Diaz', '1009', 'pedro.ramirez@empresa.com', 4, 6, 'OFI009'), -- Contador, Milán
(10, 'Sofia', 'Fernandez', 'Gomez', '1010', 'sofia.fernandez@empresa.com', 3, 6, 'OFI010'), -- Recepcionista, Londres
(11, 'Miguel', 'Morales', 'Lopez', '1011', 'miguel.morales@empresa.com', 1, NULL, 'OFI011'), -- Gerente, Lisboa
(12, 'Isabel', 'Alvarez', 'Martinez', '1012', 'isabel.alvarez@empresa.com', 2, 11, 'OFI012'), -- Asistente, Ámsterdam
(13, 'Pablo', 'Gutierrez', 'Rodriguez', '1013', 'pablo.gutierrez@empresa.com', 3, 7, 'OFI013'), -- Vendedor, Madrid
(14, 'Raquel', 'Torres', 'Diaz', '1014', 'raquel.torres@empresa.com', 4, 11, 'OFI014'), -- Contador, Barcelona
(15, 'Manuel', 'Vazquez', 'Sanchez', '1015', 'manuel.vazquez@empresa.com', 3, 7, 'OFI015'); -- Recepcionista, París


UPDATE empleado
SET codigo_oficina = NULL
WHERE codigo_empleado = 15;

UPDATE empleado
SET codigo_jefe = NULL, puesto = 5
WHERE codigo_empleado = 1;

UPDATE empleado
SET codigo_jefe = 7
WHERE codigo_empleado = 13;

UPDATE empleado
SET codigo_jefe = 7
WHERE codigo_empleado = 15;

UPDATE empleado
SET codigo_jefe = 1
WHERE codigo_empleado = 6;

UPDATE empleado
SET codigo_jefe = 1
WHERE codigo_empleado = 11;

UPDATE empleado
SET codigo_jefe = 1
WHERE codigo_empleado = 7;

INSERT INTO cliente (codigo_cliente, nombre_cliente, fax, limite_credito, ciudad, direccion, codigo_empleado_rep_ventas) VALUES
(1, 'Juan Perez', '123456789', 50000.00, 1, 'ESP001', 1),
(2, 'Maria Garcia', '987654321', 30000.00, 2, 'ESP002', 2),
(3, 'Carlos Sanchez', '456789123', 40000.00, 3, 'ESP003', 3),
(4, 'Ana Martinez', '789123456', 60000.00, 4, 'ESP004', 4),
(5, 'Luis Fernandez', '321654987', 35000.00, 5, 'ESP005', 5),
(6, 'Lucia Rodriguez', '147258369', 45000.00, 6, 'FRA001', 6),
(7, 'Jorge Lopez', '963852741', 55000.00, 7, 'FRA002', 7),
(8, 'Marta Gomez', '258369147', 25000.00, 8, 'GER001', 8),
(9, 'Raul Diaz', '741852963', 15000.00, 9, 'ITA001', 9),
(10, 'Elena Torres', '852963741', 20000.00, 10, 'UK001', 10),
(11, 'Pedro Alvarez', '369258147', 10000.00, 1, 'ESP006', 11),
(12, 'Sofia Romero', '147369258', 70000.00, 2, 'ESP007', 12),
(13, 'Manuel Vazquez', '852147963', 80000.00, 3, 'ESP003', 13),
(14, 'Isabel Gutierrez', '258147369', 90000.00, 4, 'ESP004', 14),
(15, 'Pablo Ruiz', '741963852', 120000.00, 5, 'ESP005', 15),
(16, 'Carmen Morales', '963741852', 110000.00, 6, 'FRA001', 4),
(17, 'Antonio Ortiz', '369741258', 130000.00, 7, 'FRA002', 1),
(18, 'Laura Herrera', '147963258', 140000.00, 8, 'GER001', 12),
(19, 'Fernando Mendoza', '852369147', 160000.00, 9, 'ITA001', 14),
(20, 'Beatriz Castillo', '258963741', 170000.00, 10, 'UK001', 12),
(21, 'ELver Garcia', '13159872', 51234.00, 1, 'ESP001', 2);

UPDATE cliente
SET codigo_empleado_rep_ventas = 2
WHERE codigo_cliente = 15;

UPDATE cliente
SET codigo_empleado_rep_ventas = 2
WHERE codigo_cliente = 3;

UPDATE cliente
SET codigo_empleado_rep_ventas = 2
WHERE codigo_cliente = 5;




UPDATE cliente
SET codigo_empleado_rep_ventas = 10
WHERE codigo_cliente = 11;

UPDATE cliente
SET ciudad = 11
WHERE codigo_cliente = 19;


INSERT INTO telefono (codigo_telefono, telefono, cliente, oficina) VALUES
(1, '600123456', 1, 'OFI001'),  -- Cliente 1, Oficina Madrid
(2, '600654321', 2, 'OFI002'),  -- Cliente 2, Oficina Barcelona
(3, '600987654', 3, 'OFI003'),  -- Cliente 3, Oficina Sevilla
(4, '600456789', 4, 'OFI004'),  -- Cliente 4, Oficina Málaga
(5, '600789123', 5, 'OFI005'),  -- Cliente 5, Oficina Salamanca
(6, '600321654', 6, 'OFI006'),  -- Cliente 6, Oficina París
(7, '600147258', 7, 'OFI007'),  -- Cliente 7, Oficina Cannes
(8, '600369258', 8, 'OFI008'),  -- Cliente 8, Oficina Múnich
(9, '600741852', 9, 'OFI009'),  -- Cliente 9, Oficina Milán
(10, '600963741', 10, 'OFI010'),  -- Cliente 10, Oficina Londres
(11, '600258147', 11, 'OFI013'),  -- Cliente 11, Oficina Madrid
(12, '600852963', 12, 'OFI014'),  -- Cliente 12, Oficina Barcelona
(13, '600147369', 13, 'OFI003'),  -- Cliente 13, Oficina Sevilla
(14, '600963852', 14, 'OFI004'),  -- Cliente 14, Oficina Málaga
(15, '600369741', 15, 'OFI005');  -- Cliente 15, Oficina Salamanca

INSERT INTO estadoPedido (estado) VALUES
('En proceso'),
('Enviado'),
('Entregado'),
('Cancelado'),
('Pendiente de pago');

UPDATE estadoPedido
SET estado = 'Rechazado'
WHERE codigo_estado = 4;


INSERT INTO pago (id_transaccion, forma_pago, fecha_pago, total, cliente) VALUES
('TRANS031', 'Tarjeta de crédito', '2007-01-01', 150.50, 1),  -- Cliente 1
('TRANS032', 'Transferencia bancaria', '2008-01-01', 200.00, 2),  -- Cliente 2
('TRANS033', 'Efectivo', '2009-01-01', 75.25, 3),  -- Cliente 3
('TRANS034', 'PayPal', '2010-01-01', 300.00, 4),  -- Cliente 4
('TRANS035', 'Tarjeta de débito', '2011-01-01', 50.00, 5),  -- Cliente 5
('TRANS036', 'Tarjeta de crédito', '2012-01-01', 100.00, 6),  -- Cliente 6
('TRANS037', 'Transferencia bancaria', '2013-01-01', 400.75, 7),  -- Cliente 7
('TRANS038', 'Efectivo', '2014-01-01', 150.00, 8),  -- Cliente 8
('TRANS039', 'PayPal', '2015-01-01', 250.00, 9),  -- Cliente 9
('TRANS040', 'Tarjeta de débito', '2016-01-01', 175.50, 10),  -- Cliente 10
('TRANS041', 'Tarjeta de crédito', '2017-01-01', 80.00, 11),  -- Cliente 11
('TRANS042', 'Transferencia bancaria', '2018-01-01', 90.25, 12),  -- Cliente 12
('TRANS043', 'Efectivo', '2019-01-01', 200.00, 13),  -- Cliente 13
('TRANS044', 'PayPal', '2020-01-01', 120.75, 14),  -- Cliente 14
('TRANS045', 'Tarjeta de débito', '2007-01-01', 300.00, 15),  -- Cliente 15
('TRANS046', 'Tarjeta de crédito', '2008-01-01', 250.50, 16),  -- Cliente 16
('TRANS047', 'Transferencia bancaria', '2009-01-01', 180.00, 17),  -- Cliente 17
('TRANS048', 'Efectivo', '2010-01-01', 90.25, 18),  -- Cliente 18
('TRANS049', 'PayPal', '2011-01-01', 350.00, 19),  -- Cliente 19
('TRANS050', 'Tarjeta de débito', '2012-01-01', 200.75, 20);  -- Cliente 20

UPDATE pago
SET fecha_pago = '2008-01-21'
WHERE id_transaccion = 'TRANS049';

UPDATE pago
SET fecha_pago = '2008-08-06'
WHERE id_transaccion = 'TRANS044';


INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, comentarios, estado, cliente) VALUES
('2024-05-01', '2024-05-05', '2024-05-04', 'Pedido entregado antes de la fecha esperada.', 3, 1),  -- Cliente 1, Estado "Entregado"
('2024-05-02', '2024-05-06', '2024-05-07', 'Pedido con retraso en la entrega.', 3, 2),  -- Cliente 2, Estado "Entregado"
('2024-05-03', '2024-05-07', '2024-05-07', 'Pedido entregado a tiempo.', 3, 3),  -- Cliente 3, Estado "Entregado"
('2024-05-04', '2024-05-08', NULL, 'Pedido aún en proceso de entrega.', 1, 4),  -- Cliente 4, Estado "En proceso"
('2024-05-05', '2024-05-09', '2024-05-10', 'Pedido entregado antes de la fecha esperada.', 3, 5),  -- Cliente 5, Estado "Entregado"
('2024-05-06', '2024-05-10', NULL, 'Pedido aún en proceso de entrega.', 1, 6),  -- Cliente 6, Estado "En proceso"
('2024-05-07', '2024-05-11', '2024-05-12', NULL, 2, 7),  -- Cliente 7, Estado "Enviado"
('2024-05-08', '2024-05-12', NULL, 'Pedido aún en proceso de entrega.', 1, 8),  -- Cliente 8, Estado "En proceso"
('2024-05-09', '2024-05-13', '2024-05-14', NULL, 2, 9),  -- Cliente 9, Estado "Enviado"
('2024-05-10', '2024-05-14', '2024-05-14', 'Pedido entregado a tiempo.', 3, 10),  -- Cliente 10, Estado "Entregado"
('2024-05-11', '2024-05-15', '2024-05-16', 'Pedido con retraso en la entrega.', 3, 11),  -- Cliente 11, Estado "Entregado"
('2024-05-12', '2024-05-16', NULL, 'Pedido aún en proceso de entrega.', 1, 12),  -- Cliente 12, Estado "En proceso"
('2024-05-13', '2024-05-17', '2024-05-18', 'Pedido entregado antes de la fecha esperada.', 3, 13),  -- Cliente 13, Estado "Entregado"
('2024-05-14', '2024-05-18', NULL, 'Pedido aún en proceso de entrega.', 1, 14),  -- Cliente 14, Estado "En proceso"
('2024-05-15', '2024-05-19', '2024-05-21', NULL, 2, 15),  -- Cliente 15, Estado "Enviado"
('2024-05-16', '2024-05-20', NULL, 'Pedido aún en proceso de entrega.', 1, 16),  -- Cliente 16, Estado "En proceso"
('2024-05-17', '2024-05-21', '2024-05-22', 'Pedido con retraso en la entrega.', 3, 17),  -- Cliente 17, Estado "Entregado"
('2024-05-18', '2024-05-22', NULL, 'Pedido aún en proceso de entrega.', 1, 18),  -- Cliente 18, Estado "En proceso"
('2024-05-19', '2024-05-23', '2024-05-24', 'Pedido entregado antes de la fecha esperada.', 3, 19),  -- Cliente 19, Estado "Entregado"
('2024-05-20', '2024-05-24', NULL, 'Pedido aún en proceso de entrega.', 1, 20),  -- Cliente 20, Estado "En proceso"
('2024-05-21', '2024-05-25', '2024-05-26', 'Pedido con retraso en la entrega.', 3, 1), -- Cliente 1, Estado "Ent
('2008-01-02', '2008-01-10', NULL, 'Pedido urgente', 1, 10),
('2012-01-08', '2012-01-20', '2012-01-18', 'Entrega a domicilio', 3, 16),
('2015-01-12', '2015-01-25', '2015-01-24', 'Productos de alta demanda', 2, 4);


UPDATE pedido
SET fecha_pedido = '2009-05-20', fecha_esperada = '2009-05-25', fecha_entrega = '2009-05-24'
WHERE codigo_pedido = 2;

UPDATE pedido
SET fecha_esperada = '2024-05-20'
WHERE codigo_pedido = 19;

UPDATE pedido
SET fecha_esperada = '2024-05-14'
WHERE codigo_pedido = 13;

UPDATE pedido
SET estado = 4
WHERE codigo_pedido = 4;

UPDATE pedido
SET estado = 4
WHERE codigo_pedido = 2;


UPDATE pedido
SET fecha_pedido = '2024-01-21', fecha_esperada = '2024-01-25', fecha_entrega = '2024-01-24' 
WHERE codigo_pedido = 21;

INSERT INTO proveedor (nombre_proveedor) VALUES 
('Proveedor A'),
('Proveedor B'),
('Proveedor C'),
('Proveedor D'),
('Proveedor E'),
('Proveedor F'),
('Proveedor G'),
('Proveedor H'),
('Proveedor I'),
('Proveedor J');

INSERT INTO gama_producto (codigo_gama, gama, descripcion_texto, descripcion_html, imagen) VALUES 
('GAMA001', 'Ornamentales', 'Productos decorativos para el hogar y espacios interiores.', '<p>Productos decorativos para el hogar y espacios interiores.</p>', 'ornamentales.jpg'),
('GAMA002', 'Hogar', 'Productos para el hogar, como muebles, electrodomésticos y utensilios.', '<p>Productos para el hogar, como muebles, electrodomésticos y utensilios.</p>', 'hogar.jpg'),
('GAMA003', 'Tecnología', 'Productos electrónicos y dispositivos tecnológicos.', '<p>Productos electrónicos y dispositivos tecnológicos.</p>', 'tecnologia.jpg'),
('GAMA004', 'Juguetes', 'Juguetes para niños de todas las edades.', '<p>Juguetes para niños de todas las edades.</p>', 'juguetes.jpg'),
('GAMA005', 'Joyería', 'Piezas de joyería fina y accesorios.', '<p>Piezas de joyería fina y accesorios.</p>', 'joyeria.jpg'),
('GAMA006', 'Moda', 'Ropa, calzado y accesorios de moda para hombres y mujeres.', '<p>Ropa, calzado y accesorios de moda para hombres y mujeres.</p>', 'moda.jpg');

UPDATE gama_producto
SET gama = 'Frutales'
WHERE codigo_gama = 'GAMA006';

INSERT INTO producto (codigo_producto, nombre, dimensiones, descripcion, cantidad_en_stock, precio_venta, precio_proveedor, gama, proveedor)
VALUES 
('S10_1678', '1969 Harley Davidson', '48.80 x 66.90 x 26.80', 'Replica motorcycle', 7933, 48.81, 31.24, 'GAMA001', 1),
('S10_1949', '1952 Alpine Renault', '88.60 x 25.60 x 10.90', 'Vintage car model', 7305, 98.58, 38.58, 'GAMA001', 2),
('S10_2016', '1996 Moto Guzzi', '99.00 x 30.00 x 14.00', 'Diecast motorcycle', 6625, 68.99, 37.49, 'GAMA002', 3),
('S10_4698', '2003 Harley-Davidson Eagle Drag Bike', '15.50 x 44.30 x 25.20', 'Drag bike model', 5582, 91.02, 37.76, 'GAMA003', 4),
('S12_1099', '1968 Ford Mustang', '64.50 x 34.90 x 18.60', 'Classic car model', 7312, 95.34, 34.35, 'GAMA003', 5),
('S12_1108', '2001 Ferrari Enzo', '79.20 x 39.80 x 16.20', 'Ferrari Enzo model', 3619, 95.59, 72.59, 'GAMA005', 6),
('S12_1666', '1958 Setra Bus', '77.00 x 35.00 x 10.60', 'Vintage bus model', 1016, 77.90, 47.29, 'GAMA005', 7),
('S12_2823', '2002 Suzuki XREO', '51.60 x 54.90 x 22.70', 'Diecast SUV', 9997, 103.42, 95.70, 'GAMA006', 8),
('S12_3148', '1969 Corvair Monza', '67.20 x 16.30 x 32.20', 'Corvair Monza model', 6906, 89.14, 55.09, 'GAMA001', 9),
('S12_3380', '1968 Dodge Charger', '50.50 x 15.80 x 20.80', 'Dodge Charger model', 9123, 75.16, 58.86, 'GAMA001', 10),
('S12_3891', '1969 Ford Falcon', '83.80 x 32.80 x 32.80', 'Ford Falcon model', 1049, 83.05, 58.15, 'GAMA001', 1),
('S12_3990', '1970 Plymouth Hemi Cuda', '49.20 x 25.60 x 10.60', 'Hemi Cuda model', 5663, 31.92, 14.63,'GAMA003', 2),
('S12_4675', '1969 Dodge Charger', '58.20 x 51.90 x 22.00', 'Dodge Charger model', 7323, 58.73, 50.51, 'GAMA004', 3),
('S18_1129', '1993 Mazda RX-7', '83.10 x 32.80 x 36.40', 'Mazda RX-7 model', 3989, 83.51, 15.96,'GAMA001', 4),
('S18_1342', '1937 Lincoln Berline', '91.50 x 34.20 x 14.50', 'Lincoln Berline model', 8693, 60.62, 23.91, 'GAMA006', 5),
('S18_1367', '1936 Mercedes-Benz 500K Special Roadster', '29.80 x 92.30 x 18.00', 'Special Roadster model', 8635, 24.26, 14.88, 'GAMA004', 6),
('S18_1589', '1965 Aston Martin DB5', '65.00 x 54.90 x 22.00', 'Aston Martin DB5 model', 9042, 65.96, 35.23, 'GAMA001', 7),
('S18_1662', '1980s Black Hawk Helicopter', '10.15 x 52.15 x 16.15', 'Black Hawk Helicopter model', 5330, 77.27, 63.08,'GAMA004', 8),
('S18_1749', '1917 Grand Touring Sedan', '76.00 x 22.30 x 29.30', 'Grand Touring Sedan model', 2724, 86.70, 61.72, 'GAMA001', 9),
('S18_1889', '1948 Porsche 356-A Roadster', '34.10 x 50.50 x 18.30', 'Porsche Roadster model', 8826, 53.90, 77.00, 'GAMA003', 10),
('S18_1984', '1995 Honda Civic', '77.00 x 49.00 x 24.80', 'Honda Civic model', 9772, 93.89, 41.32, 'GAMA003', 1),
('S18_2238', '1998 Chrysler Plymouth Prowler', '33.20 x 36.20 x 17.80', 'Plymouth Prowler model', 8635, 101.51, 76.64, 'GAMA001', 2),
('S18_2248', '1911 Ford Town Car', '76.00 x 34.80 x 23.20', 'Ford Town Car model', 540, 33.30, 23.00, 'GAMA001', 3),
('S18_2319', '1964 Mercedes Tour Bus', '11.40 x 46.00 x 29.00', 'Mercedes Tour Bus model', 8258, 74.86, 61.02,'GAMA003', 4),
('S18_2325', '1932 Model A Ford J-Coupe', '58.00 x 22.00 x 48.00', 'Model A Ford model', 9354, 127.13, 88.51, 'GAMA001', 5),
('S18_2432', '1926 Ford Fire Engine', '24.00 x 60.00 x 29.00', 'Ford Fire Engine model', 2018, 60.77, 24.36, 'GAMA002', 6),
('S18_2581', 'P-51-D Mustang', '49.60 x 14.90 x 23.70', 'P-51-D Mustang model', 9925, 84.48, 42.07, 'GAMA004', 7),
('S18_2625', '1936 Harley Davidson El Knucklehead', '55.30 x 21.90 x 24.80', 'Harley Davidson model', 4357, 60.57, 24.23, 'GAMA001', 8),
('S18_2795', '1928 Mercedes-Benz SSK', '73.80 x 35.60 x 33.80', 'Mercedes-Benz SSK model', 548, 72.56, 47.98, 'GAMA002', 9),
('S18_2870', '1999 Indy 500 Monte Carlo SS', '50.60 x 24.80 x 17.30', 'Indy 500 model', 8164, 56.76, 46.86, 'GAMA005', 10),
('S18_2949', '1913 Ford Model T Speedster', '99.60 x 22.60 x 16.80', 'Ford Model T model', 4189, 60.78, 48.23, 'GAMA002', 1),
('S18_2957', '1934 Ford V8 Coupe', '50.70 x 32.80 x 17.60', 'Ford V8 Coupe model', 5649, 34.35, 15.91, 'GAMA005', 2),
('S18_3029', '1999 Yamaha Speed Boat', '38.00 x 56.00 x 15.00', 'Yamaha Speed Boat model', 4259, 51.61, 44.49, 'GAMA001', 3),
('S18_3140', '1903 Ford Model A', '79.80 x 31.80 x 29.00', 'Ford Model A model', 3913, 68.30, 36.75, 'GAMA006', 4),
('S10_0054', '1969 ASD D', '48.80 x 66.90 x 26.80', 'motorcycle', 1932, 48.81, 31.24, 'GAMA001', 1);




INSERT INTO detalle_pedido (producto, pedido, cantidad, precio_unidad, numero_linea, estado, cliente) VALUES
('S10_1678', 1001, 5, 10.50, 1, 1, 101),
('S12_3891', 1001, 3, 15.75, 2, 1, 101),
('S18_1984', 1001, 2, 20.00, 3, 1, 101),
('S18_2949', 1002, 4, 8.99, 1, 1, 102),
('S10_1949', 1002, 6, 12.25, 2, 1, 102),
('S12_3990', 1003, 2, 30.00, 1, 1, 103),
('S18_2238', 1004, 3, 18.50, 1, 1, 104),
('S18_2957', 1004, 1, 25.00, 2, 1, 104),
('S10_2016', 1005, 5, 11.75, 1, 1, 105),
('S12_4675', 1005, 2, 22.50, 2, 1, 105),
('S18_2248', 1005, 3, 17.25, 3, 1, 105),
('S18_3029', 1006, 1, 40.00, 1, 1, 106),
('S10_4698', 1007, 4, 9.99, 1, 1, 107),
('S18_1129', 1007, 2, 15.00, 2, 1, 107),
('S18_2319', 1007, 3, 20.50, 3, 1, 107),
('S18_3140', 1008, 6, 12.75, 1, 1, 108),
('S12_1099', 1008, 1, 28.00, 2, 1, 108),
('S18_1342', 1009, 3, 35.00, 1, 1, 109),
('S18_2325', 1010, 2, 17.99, 1, 1, 110),
('S12_1108', 1010, 4, 21.25, 2, 1, 110),
('S18_1367', 1010, 1, 29.50, 3, 1, 110),
('S18_2432', 1011, 5, 13.75, 1, 1, 111),
('S12_1666', 1011, 2, 24.00, 2, 1, 111),
('S18_1589', 1012, 3, 12.50, 1, 1, 112),
('S18_2581', 1013, 1, 15.99, 1, 1, 113),
('S18_2625', 1013, 4, 19.00, 2, 1, 113),
('S12_2823', 1013, 2, 26.50, 3, 1, 113),
('S18_1662', 1014, 3, 14.75, 1, 1, 114),
('S18_2795', 1015, 5, 18.00, 1, 1, 115),
('S12_3148', 1016, 2, 30.99, 1, 1, 116),
('S18_1749', 1016, 3, 25.25, 2, 1, 116),
('S12_3380', 1017, 4, 11.50, 1, 1, 117),
('S18_1889', 1017, 1, 32.00, 2, 1, 117),
('S18_2870', 1018, 2, 16.00, 1, 1, 118),
('S18_1984', 1019, 3, 20.99, 1, 1, 119),
('S18_1342', 1019, 5, 15.25, 2, 1, 119),
('S12_2823', 1020, 1, 10.50, 1, 1, 120),
('S18_1589', 1021, 4, 27.00, 1, 1, 121),
('S18_2581', 1021, 2, 18.75, 2, 1, 121),
('S18_2625', 1021, 3, 21.50, 3, 1, 121),
('S12_3148', 1022, 5, 14.25, 1, 1, 122),
('S18_1749', 1022, 2, 26.00, 2, 1, 122),
('S18_1662', 1023, 3, 22.50, 1, 1, 123),
('S18_2795', 1024, 1, 11.99, 1, 1, 124),
('S12_3380', 1024, 4, 17.00, 2, 1, 124),
('S18_1889', 1024, 2, 23.50, 3, 1, 124),
('S18_2870', 1025, 3, 13.75, 1, 1, 125),
('S18_1984', 1025, 5, 19.00, 2, 1, 125),
('S12_2823', 1026, 1, 12.50, 1, 1, 126),
('S18_1589', 1026, 2, 31.99, 2, 1, 126);


INSERT INTO detalle_pedido (producto, pedido, cantidad, precio_unidad, numero_linea) VALUES
('S10_1678', 6, 5, 10.50, 1),
('S12_3891', 8, 3, 15.75, 2),
('S18_1984', 12, 2, 20.00, 3),
('S18_2949', 14, 4, 8.99, 1),
('S10_1949', 16, 6, 12.25, 2),
('S12_3990', 18, 2, 30.00, 1),
('S18_2238', 20, 3, 18.50, 1),
('S18_2957', 22, 1, 25.00, 2),
('S10_2016', 7, 5, 11.75, 1),
('S12_4675', 9, 2, 22.50, 2),
('S18_2248', 15, 3, 17.25, 3),
('S18_3029', 24, 1, 40.00, 1),
('S10_4698', 1, 4, 9.99, 1),
('S18_1129', 3, 2, 15.00, 2),
('S18_2319', 5, 3, 20.50, 3),
('S18_3140', 10, 6, 12.75, 1),
('S12_1099', 11, 1, 28.00, 2),
('S18_1342', 13, 3, 35.00, 1),
('S18_2325', 17, 2, 17.99, 1),
('S12_1108', 19, 4, 21.25, 2),
('S18_1367', 21, 1, 29.50, 3),
('S18_2432', 23, 5, 13.75, 1),
('S12_1666', 2, 2, 24.00, 2),
('S18_1589', 4, 3, 12.50, 1),
('S18_2581', 16, 1, 15.99, 1),
('S18_2625', 18, 4, 19.00, 2),
('S12_2823', 20, 2, 26.50, 3),
('S18_1662', 22, 3, 14.75, 1),
('S18_2795', 8, 5, 18.00, 1),
('S12_3148', 10, 2, 30.99, 1),
('S18_1749', 12, 3, 25.25, 2),
('S12_3380', 14, 4, 11.50, 1),
('S18_1889', 16, 1, 32.00, 2),
('S18_2870', 18, 2, 16.00, 1),
('S18_1984', 20, 3, 20.99, 1),
('S18_1342', 7, 5, 15.25, 2),
('S12_2823', 9, 1, 10.50, 1),
('S18_1589', 15, 4, 27.00, 1),
('S18_2581', 24, 2, 18.75, 2),
('S18_2625', 1, 3, 21.50, 3),
('S12_3148', 3, 5, 14.25, 1),
('S18_1749', 5, 2, 26.00, 2),
('S18_1662', 10, 3, 22.50, 1),
('S18_2795', 11, 1, 11.99, 1),
('S12_3380', 13, 4, 17.00, 2),
('S18_1889', 17, 2, 23.50, 3),
('S18_2870', 19, 3, 13.75, 1),
('S18_1984', 21, 5, 19.00, 2),
('S12_2823', 23, 1, 12.50, 1),
('S18_1589', 2, 2, 31.99, 2);






