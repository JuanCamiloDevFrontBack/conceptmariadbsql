-- |----------------------------SHOW DATABASES SECTION COMMAND---------------------------|

-- Las siguientes consultas(querys)
-- permite consultar las bases de datos creadas y existentes.
show schemas like 'dataToSearch';
show schemas where length('Database') > N;-- retorna la cantidad de bases de datos con las dimenciones especificadas respecto al nombre.

/* Nota: la consulta sql show schemas where length('Database') > N, en la parte
donde se indica el Database, es la columna de la tabla donde está alojadas
las bases de datos.  */

-- |-----------------------------------EXAMPLE SECTION-----------------------------------|

-- 1.
show schemas like 'db_test%';
show schemas where length('Database') > 23;

-- |----------------------------------------END------------------------------------------|


-- |-------------------------SHOW CREATE DATABASE SECTION COMMAND------------------------|

-- Las siguientes consultas(querys)
-- permite consultar la base de datos indicada.
show create schema databaseName;
-- OR
show create database databaseName;

-- |-----------------------------------EXAMPLE SECTION-----------------------------------|

-- 1.
show create schema mysql;
show create daabase mysql;

-- |----------------------------------------END------------------------------------------|


-- |---------------------------CREATE DATABASE SECTION COMMAND---------------------------|

-- Las siguientes consultas(querys)
-- permite crear bases de datos.
create database dbName;
-- OR
create schema if not exists dbName;-- SCHEMA es lo mismo que DATABASE, hacen lo mismo.
create or replace schema dbName;

-- |-----------------------------------EXAMPLE SECTION-----------------------------------|

-- 1.
show databases;
create database db_test_with_database;
show databases;

-- 2.
show databases;
create schema db_test_with_schema;
show databases;
create or replace schema db_test_with_schema;
show databases;

-- 3.
show databases;
create schema db_test_with_schema;
show databases;
create schema if not exists db_test_with_schema;
show warnings;
show databases;

-- |----------------------------------------END------------------------------------------|


-- |---------------------------------XYZ SECTION COMMAND---------------------------------|
-- |-----------------------------------EXAMPLE SECTION-----------------------------------|
-- |----------------------------------------END------------------------------------------|