-- Comentario de una línea
/* 
Comentario de varias líneas 
*/

/*
Nota: algunas funciones se pueden ejecutar mucho más rápido utilizando gestores
de bases de datos, en el caso de xampp mariadb ya incorpora phpMyAdmin 
*/


-- |-----------------------------CREATE USER SECTION COMMAND-----------------------------|

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

-- |-----------------------------------EXAMPLE SECTION-----------------------------------|

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

-- |----------------------------------------END------------------------------------------|


-- |------------------------------ALTER USER SECTION COMMAND-----------------------------|

-- Las siguientes consultas(querys)
-- permite modificar un usuario ya creado.
alter user createUser identified by password;
alter user current_user() identified by password;-- current_user() obtiene el usuario con el que se inicio sección en la base de datos.

-- permite verificar la existencia del usuario, en caso contrario mostrará una advertencia.
alter user if exists 'createUser'@'IPHost' identified by password;
-- OR
alter user if exists createUser identified by password;-- forma resumida.

-- permite cambiar o agregar un máximo de acciones a realizar por el usuario.
alter user createUser, createUser2, createUserN with MAX_USER_CONNECTIONS 127;
-- OR
alter user createUser, createUser2, createUserN with MAX_USER_CONNECTIONS 127 password expire;


-- |-----------------------------------EXAMPLE SECTION-----------------------------------|

-- 1.
alter user 'testQA'@'%' identified by '36987';
-- OR
alter user testQA identified by '789456';-- forma resumida

-- 2.
alter user if exists dev4 identified by '789';
-- OR
alter user if exists 'dev4'@'%' identified by '789';
show warnings;

-- 3.
alter user dev1 identified by '123', dev2, dev4 with MAX_USER_CONNECTIONS 127;-- muestra error.
alter user if exists dev1 identified by '123', dev2, dev4 with MAX_USER_CONNECTIONS 127;-- muestra warnings.
show warnings;

-- 4.
alter user if exists dev3, dev2, dev4 with MAX_USER_CONNECTIONS 127 password expire;
show warnings;

-- |----------------------------------------END------------------------------------------|


-- |-----------------------------RENAME USER SECTION COMMAND-----------------------------|

-- Las siguientes consultas(querys)
-- permite cambiar el nombre de un usuario.
rename user oldCreateUser to newCreateUser;
-- OR
rename user
oldCreateUser to newCreateUser,
oldCreateUser2 to newCreateUser2,
oldCreateUserN to newCreateUserN;-- (opcional)
rename user 'createUser'@'oldHost' to 'createUser'@'newHost';-- cambia la ip del host. (opcional)

-- |-----------------------------------EXAMPLE SECTION-----------------------------------|

-- 1.
create user 'user1'@'localhost', dev1, 'technicalLeader'@'192.168.0.1';
select user, host from mysql.user;
rename user dev1 to scrumMaster;
select user, host from mysql.user;

--2.
rename user scrumMaster to 'scrumMaster'@'192.168.0.7';
select user, host from mysql.user;
rename user 'scrumMaster'@'192.168.10.7' to 'scrumMaster2'@'192.168.10.7', 'user1'@'localhost' to userDev1;
select user, host from mysql.user;

/* Nota: los usuarios que tengan un host diferente a %
presentan algunos detalles cuando se van a renombrar o efectuar alguna acción,
si este es el caso, a la hora de hacer cualquier cosa con esos usuarios
se deben utilizar con la ip, por ejemplo: 'nameUser'@'ipHost'. */

-- 3.(da un ejemplo práctico de la nota anterior).
/* muestra error porque los host no coinciden, esto porque al utilizar solo el nombre
por defecto el motor de mariaDB le asigna % como host  */
show create user technicalLeader; 
show create user 'technicalLeader'@'192.168.0.1';-- como se le indica el host, funciona.

-- |----------------------------------------END------------------------------------------|


-- |---------------------------SET PASWORD USER SECTION COMMAND--------------------------|

-- Las siguientes consultas(querys)
-- permite cambiar o quitar la contraseña de un usuario.
set password for createUser = password(newPassword);

-- |-----------------------------------EXAMPLE SECTION-----------------------------------|

-- 1.
set password for 'technicalLeader'@'192.168.0.1' = password('789456');
select user, host, password from mysql.user;
set password for 'technicalLeader'@'192.168.0.1' = password('');-- elimina la contraseña
select user, host, password from mysql.user;

-- |----------------------------------------END------------------------------------------|


-- |------------------------------CREATE ROLE SECTION COMMAND----------------------------|
-- |-----------------------------------EXAMPLE SECTION-----------------------------------|
-- |----------------------------------------END------------------------------------------|


-- |----------------------------SET DEFAULT ROLE SECTION COMMAND-------------------------|
-- |-----------------------------------EXAMPLE SECTION-----------------------------------|
-- |----------------------------------------END------------------------------------------|


-- |-------------------------------SET ROLE SECTION COMMAND------------------------------|
-- |-----------------------------------EXAMPLE SECTION-----------------------------------|
-- |----------------------------------------END------------------------------------------|


-- |-------------------------------DROP ROLE SECTION COMMAND-----------------------------|
-- |-----------------------------------EXAMPLE SECTION-----------------------------------|
-- |----------------------------------------END------------------------------------------|


-- |--------------------------------GRANT SECTION COMMAND--------------------------------|

-- Las siguientes consultas(querys)
-- permite visualizar los provilecios otorgados a un usuario o rol.
show grants;-- muestra los privilegios otorgados al usuario con el cual se inicio sesión.
show grants for (nameUser OR nameRol);
-- OR
show grants for current_user;
show grants for current_user();

-- |-----------------------------------EXAMPLE SECTION-----------------------------------|

-- 1.
show grants;
show grants for testQA;

-- |----------------------------------------END------------------------------------------|


-- |--------------------------------REVOKE SECTION COMMAND-------------------------------|
-- |-----------------------------------EXAMPLE SECTION-----------------------------------|
-- |----------------------------------------END------------------------------------------|


-- |-------------------------------DROP USER SECTION COMMAND-----------------------------|

-- Las siguientes consultas(querys)
-- permite eliminar uno o varios usuarios ya creados.
drop user nameUser;
-- OR
drop user if exists nameUser;
drop user if exists nameUser, nameUser2, nameUserN;

-- |-----------------------------------EXAMPLE SECTION-----------------------------------|

-- 1.
drop user if exists dev1, 'dev2'@'%', dev3, 'dev4'@'%';
show warnings;
select user, host, password from mysql.user;

-- |----------------------------------------END------------------------------------------|


-- |------------------------------ALTER USER SECTION COMMAND-----------------------------|
-- |-----------------------------------EXAMPLE SECTION-----------------------------------|
-- |----------------------------------------END------------------------------------------|