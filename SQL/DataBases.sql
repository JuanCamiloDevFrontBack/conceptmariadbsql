-- |----------------------------SHOW DATABASES SECTION COMMAND---------------------------|

-- Las siguientes consultas(querys)
-- permite consultar las bases de datos creadas y existentes.
show databases;
-- OR
show schemas like 'dataToSearch';-- retorna las bases de datos 
show schemas where length('Database') > N;-- retorna la cantidad de bases de datos con las dimenciones especificadas respecto al nombre.

/* Nota: la consulta sql show schemas where length('Database') > N, en la parte
donde se indica el Database, es la columna de la tabla donde está alojadas
las bases de datos.  */

-- |-----------------------------------EXAMPLE SECTION-----------------------------------|

-- 1.
show databases;

-- 2.
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
show create database mysql;

-- |----------------------------------------END------------------------------------------|


-- |---------------------------CREATE DATABASE SECTION COMMAND---------------------------|

-- Las siguientes consultas(querys)
-- permite crear bases de datos.
create database dbName;
-- OR
create schema if not exists dbName;-- SCHEMA es lo mismo que DATABASE, hacen lo mismo.
create or replace schema dbName;

/* Nota: no se abordan el tema de create_specification pero en la documentación de MariaDB
se puede profundizar en ello. */

-- |-----------------------------------EXAMPLE SECTION-----------------------------------|

-- 1.
show databases;
create database user_management_using_database;
show databases;

-- 2.
show databases;
create schema user_management_using_schema;
show databases;
create or replace schema user_management_using_schema;
show databases;

-- 3.
show databases;
create schema user_management_using_schema;
show databases;
create schema if not exists user_management_using_schema;
show warnings;
show databases;

-- 4.
show schemas;
create schema db1;
create database db2;
show databases;

-- |----------------------------------------END------------------------------------------|


-- |---------------------------------USE SECTION COMMAND---------------------------------|

-- Las siguientes consultas(querys)
-- permite usar una bases de datos y comenzar a trabajar en ella.
use dbName;
-- OR
use database dbName;-- disponible solamente para la versión 11.3 de mariadb.

-- permite consultar la base de datos que se esta utilizand.
select database();-- los () son obligatorios.
-- OR
select schema();-- los () son obligatorios.

-- |-----------------------------------EXAMPLE SECTION-----------------------------------|

-- 1.
show schemas;
use db1;
select schema();

-- 2.
show schemas;
use db1;
select schema();
use db2;-- se cambia de base de datos.
select schema();

-- |----------------------------------------END------------------------------------------|


-- |-----------------------------ALTER DATABASE SECTION COMMAND--------------------------|

-- Las siguientes consultas(querys)
-- permite modificar la base de datos.
alter schema dbName CHARACTER SET charsetName;
-- OR
alter schema dbName comment 'commentText';-- solo funciona para las versiones 10.5.0 o superiores de mariadb.
alter schema dbName CHARACTER SET charsetName comment = 'commentText';
alter database dbName CHARACTER SET charsetName collate = collationName;
alter schema dbName collate = collationName;

-- |-----------------------------------EXAMPLE SECTION-----------------------------------|

-- 1.
show schemas;
show create schema db1;
show character set;
ALTER DATABASE db1 CHARACTER SET = 'latin1' COLLATE = 'atin1_swedish_ci';
show schemas;
show create schema db1;

-- 2.
show schemas;
show create schema db2;
show character set;
ALTER DATABASE db2 CHARACTER SET 'latin1';
show schemas;
show create schema db2;

-- 3.
show schemas;
show create schema db2;
show character set;
ALTER schema db2 COLLATE = 'atin1_swedish_ci';
show schemas;
show create schema db2;

-- |----------------------------------------END------------------------------------------|


-- |----------------------------DROP DATABASE SECTION COMMAND----------------------------|

-- Las siguientes consultas(querys)
-- permite eliminar una base de datos.
drop schema dbName;
-- OR
drop shema if exists dbName;
drop database if exists dbName;

-- |-----------------------------------EXAMPLE SECTION-----------------------------------|

-- 1.
show databases;
drop schema db1;
show schemas;

-- 2.
show databases;
drop schema if exists db1;
show warnings;
drop schema if exists db2;
show schemas;

-- |----------------------------------------END------------------------------------------|


-- |---------------------------------XYZ SECTION COMMAND---------------------------------|
-- |-----------------------------------EXAMPLE SECTION-----------------------------------|
-- |----------------------------------------END------------------------------------------|