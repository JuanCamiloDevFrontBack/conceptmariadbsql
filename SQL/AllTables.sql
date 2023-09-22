-- |-----------------------------SHOW TABLES SECTION COMMAND-----------------------------|

-- Las siguientes consultas(querys)
-- permite consultar las tablas creadas y existntes en una base de datos.
show tables;-- muestras las tablas de la base de datos en uso.
-- OR
show tables form dbName;-- muestra las tablas de la base de datos indicada (opcional).
show full tables form dbName;-- muestra todas las tablas y los tipos de tablas (opcional).
show full tables like 'dataToSearch';-- filtra los resultados por el parámetro de búsqueda (opcional).
show full tables form dbName like 'dataToSearch';-- (opcional).
show full tables form dbName where Tables_in_dbName like 'dataToSearch';/* el nombre de la
columna 'Tables_in_' es dinámico dependiendo la base de datos a consultar, por ejemplo
Tables_in_expenses ó Tables_in_cinema, en la primera la base de datos es 'expenses' y en la
segunda la base de datos es 'cinema' (opcional). */


-- |-----------------------------------EXAMPLE SECTION-----------------------------------|

-- 1.
show tables;

-- 2.
show full tables;

-- 3.
show tables from mysql;-- la base de datos MYSQL es una que ya trae mariadb al instalarlo en el pc, y allí guarda algunas configuraciones y otras cosas para el funcionamiento de las bases de datos a crear.

-- 4.
show full tables from mysql;

-- 5.
show full tables from mysql where Tables_in_mysql like 'ti%';

-- |----------------------------------------END------------------------------------------|


-- |--------------------------SHOW CREATE TABLE SECTION COMMAND--------------------------|

/* Pasos a ejecutar:
 */

 -- Las siguientes consultas(querys)
-- permite modificar la base de datos.

-- |-----------------------------------EXAMPLE SECTION-----------------------------------|
-- |----------------------------------------END------------------------------------------|


-- |-----------------------------SHOW COLUMNS SECTION COMMAND----------------------------|
-- |-----------------------------------EXAMPLE SECTION-----------------------------------|
-- |----------------------------------------END------------------------------------------|


-- |---------------------------------XYZ SECTION COMMAND---------------------------------|
-- |-----------------------------------EXAMPLE SECTION-----------------------------------|
-- |----------------------------------------END------------------------------------------|