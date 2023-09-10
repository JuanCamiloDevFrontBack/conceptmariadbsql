-- Comentario de una línea
/* 
Comentario de varias líneas 
*/

/*
Nota: algunas funciones se pueden ejecutar mucho más rápido utilizando gestores
de bases de datos, en el caso de xampp mariadb ya incorpora phpMyAdmin 
*/

-- Las siguientes consultas(querys)
-- permite mostrar las columnas de cualquier tabla con información más detallada.
describe nameTabla;
desc nameTabla;-- forma resumida

-- permite consultar los usuarios creados y existentes en la base de datos.
select * from mysql.user;

-- permite consultar el usuario con el cual se inicio sesión en la base de datos.
show create user;
show create user nameUser;-- muestra el usuario indicado(nameUser) si esta creado. (opcional)

-- permite crear usuarios en la base de datos. Nota las '' son obligatorias si se agrega el host.
create user nameUser;-- crea el usuario con el host %(indica que puede acceder desde cuaquier pc)
create user 'nameUser'@'localhost';-- crea el usuario con el host localhost(indica que puede acceder unicamente desde el pc con la ip del localhost(127.0.0.1)) (opcional)
create user ''@'192.168.4.7';-- crea un usuario anónimo (opcional)

-- verifica la existencia del usuario y en caso de que exista, lo reemplaza. (opcional)
create or replace user nameUser;

-- verifica la existencia del usuario y en caso de que no exista, lo crea. (opcional)
create user if not exists nameUser;

-- permite crear multiples usuarios. (opcional)
create user nameUser1, nameUser2, ..., nameUserN;

-- permite crear usuarios agregando una contraseña. (opcional)
create user nameUser identified by '123';-- las '' son obligatorias.

-- permite crear un limite de acciones a realizar por el usuario. (opcional)
create user nameUser with MAX_QUERIES_PER_HOUR N;-- N es el número máximo de consultas.
create user nameUser with MAX_UPDATES_PER_HOUR N;-- N es el número máximo de updates.
create user nameUser with MAX_CONNECTIONS_PER_HOUR N;-- N es el número máximo de conexiones.
create user nameUser with MAX_USER_CONNECTIONS N;-- N es el número máximo de conexiones de usuarios.
create user nameUser with MAX_STATEMENT_TIME N;-- N es el número máximo de espera para las consultas.

-- permite crear usuarios indicado que la contraseña tendrá un tipo de caducidad. (opcional)
create user nameUser password expire;
create user nameUser password expire default;
create user nameUser password expire never;
create user nameUser password expire interval N day;-- N es el número de días a expirar

/* mensaje de advertencia(warnings):
permite mostrar las advertencias si existen despues de ejectar una consulta sql. */
show warnings;

/* Nota: no se abordan los temas de TSL_options ni tampoco lock_options pero en la
documentación de MariaDB se puede profundizar en ellos. */

-- /-----------------------------------------------------------------------------------------/

-- Ejemplos
-- 1.
create user if not exists
'adminMain'@'%' identified by '123456', 'testQA'@'%' identified by '123456'
password expire interval 330 day;

-- 2.
create or replace user dev1, dev2 with MAX_QUERIES_PER_HOUR 78 MAX_UPDATES_PER_HOUR 59;

-- 3.
create or replace user dev3 password expire;
create or replace user dev3 password expire default;

/* Nota: en los ejercicios 1 y 2 al anidar la creación de usuarios los comandos
"password expire" y "with" solo se permiten implementar al final, esto porque serán
aplicadas estas restriciones a los usuarios que se indiquen en esa consulta(query). */