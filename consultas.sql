USE tienda;

-- 1. Nombre del producto, precio y nombre del fabricante
SELECT 
  nombre AS nombre_producto,
  precio,
  (SELECT nombre FROM fabricante WHERE fabricante.id = producto.id_fabricante) AS nombre_fabricante
FROM producto;

-- 2. Igual al anterior pero ordenado por nombre de fabricante
SELECT 
  nombre AS nombre_producto,
  precio,
  (SELECT nombre FROM fabricante WHERE fabricante.id = producto.id_fabricante) AS nombre_fabricante
FROM producto
ORDER BY nombre_fabricante;

-- 3. id producto, nombre producto, id fabricante, nombre fabricante
SELECT 
  id AS id_producto,
  nombre AS nombre_producto,
  id_fabricante,
  (SELECT nombre FROM fabricante WHERE fabricante.id = producto.id_fabricante) AS nombre_fabricante
FROM producto;

-- 4. Productos con nivel de precio
SELECT 
  nombre AS nombre_producto,
  precio,
  IF(precio >= 200, 'Alto', 'Bajo') AS nivel_precio
FROM producto;

-- 5. Productos clasificados en categorías por precio
SELECT 
  id AS id_producto,
  nombre AS nombre_producto,
  precio,
  CASE 
    WHEN precio < 100 THEN 'Bajo'
    WHEN precio BETWEEN 100 AND 500 THEN 'Medio'
    ELSE 'Alto'
  END AS categoria
FROM producto;

-- 6. Clasificación por precio + orden alfabético
SELECT 
  nombre AS nombre_producto,
  precio,
  (SELECT nombre FROM fabricante WHERE fabricante.id = producto.id_fabricante) AS nombre_fabricante,
  CASE 
    WHEN precio <= 100 THEN 'Económico'
    WHEN precio BETWEEN 101 AND 500 THEN 'Intermedio'
    ELSE 'Premium'
  END AS clasificacion
FROM producto
ORDER BY nombre_producto;

-- 7. Vista productos > 1000
CREATE OR REPLACE VIEW vista_productos_caros AS
SELECT id AS id_producto, nombre, precio
FROM producto
WHERE precio > 1000;

-- 8. Vista productos > 100 con nombre fabricante
CREATE OR REPLACE VIEW vista_productos_precio_alto AS
SELECT 
  nombre AS nombre_producto,
  (SELECT nombre FROM fabricante WHERE fabricante.id = producto.id_fabricante) AS nombre_fabricante
FROM producto
WHERE precio > 100;

-- 9. Vista productos de Lenovo o Xiaomi
CREATE OR REPLACE VIEW vista_productos_lenovo_xiaomi AS
SELECT 
  nombre AS nombre_producto,
  precio,
  (SELECT nombre FROM fabricante WHERE fabricante.id = producto.id_fabricante) AS nombre_fabricante
FROM producto
WHERE id_fabricante IN (
  SELECT id FROM fabricante WHERE nombre IN ('Lenovo', 'Xiaomi')
);

-- 10. Vista productos > 200 ordenados por precio ascendente
CREATE OR REPLACE VIEW vista_productos_ordenados AS
SELECT 
  nombre AS nombre_producto,
  precio,
  (SELECT nombre FROM fabricante WHERE fabricante.id = producto.id_fabricante) AS nombre_fabricante
FROM producto
WHERE precio > 200
ORDER BY precio ASC;