-- |----------------------------SHOW DATABASES SECTION COMMAND---------------------------|
-- |-----------------------------------EXAMPLE SECTION-----------------------------------|
-- |----------------------------------------END------------------------------------------|


-- |-------------------------SHOW CREATE DATABASE SECTION COMMAND------------------------|
-- |-----------------------------------EXAMPLE SECTION-----------------------------------|
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