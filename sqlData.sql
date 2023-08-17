CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


INSERT INTO productos (nombre, descripcion, precio, stock) 
VALUES ('Laptop Gamer', 'Laptop con 16GB RAM, 1TB SSD, NVIDIA RTX 3060', 1200.50, 10);

INSERT INTO productos (nombre, descripcion, precio, stock) 
VALUES ('Smartphone Pro', 'Smartphone con pantalla OLED de 6.5 pulgadas, 128GB almacenamiento', 800.00, 25);

INSERT INTO productos (nombre, descripcion, precio, stock) 
VALUES ('Audífonos Bluetooth', 'Audífonos inalámbricos con cancelación de ruido', 150.75, 30);

INSERT INTO productos (nombre, descripcion, precio, stock) 
VALUES ('Teclado Mecánico', 'Teclado con switches azules y retroiluminación RGB', 70.00, 15);

INSERT INTO productos (nombre, descripcion, precio, stock) 
VALUES ('Mouse Gamer', 'Mouse con 8 botones programables y DPI ajustable', 45.99, 20);



DELIMITER //
CREATE PROCEDURE InsertarProducto(IN p_nombre VARCHAR(255), IN p_descripcion TEXT, IN p_precio DECIMAL(10, 2), IN p_stock INT)
BEGIN
    INSERT INTO productos (nombre, descripcion, precio, stock) 
    VALUES (p_nombre, p_descripcion, p_precio, p_stock);
END //
DELIMITER ;

#CALL InsertarProducto('Mouse Gamer', 'Mouse con 8 botones programables y DPI ajustable', 45.99, 20)

DELIMITER //
CREATE PROCEDURE ActualizarProducto(IN p_id_producto INT, IN p_nombre VARCHAR(255), IN p_descripcion TEXT, IN p_precio DECIMAL(10, 2), IN p_stock INT)
BEGIN
    UPDATE productos 
    SET nombre = p_nombre, 
        descripcion = p_descripcion, 
        precio = p_precio, 
        stock = p_stock 
    WHERE id_producto = p_id_producto;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE SeleccionarTodosProductos()
BEGIN
    SELECT *
    FROM productos;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE EliminarProducto(IN p_id_producto INT)
BEGIN
    DELETE FROM productos 
    WHERE id_producto = p_id_producto;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE SeleccionarProductoPorID(IN productoID INT)
BEGIN
    SELECT * FROM productos WHERE id_producto = productoID;
END //
DELIMITER ;






