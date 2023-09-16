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
describe nameTable;
desc nameTable;-- forma resumida

-- permite consultar los usuarios creados y existentes en la base de datos.
select * from mysql.user;

-- permite consultar el usuario con el cual se inicio sesión en la base de datos.
show create user;
show create user userName;-- muestra el usuario indicado(userName) si esta creado. (opcional)

-- permite crear usuarios en la base de datos. Nota las '' son obligatorias si se agrega el host.
create user userName;-- crea el usuario con el host %(indica que puede acceder desde cuaquier pc)
create user 'userName'@'localhost';-- crea el usuario con el host localhost(indica que puede acceder unicamente desde el pc con la ip del localhost(127.0.0.1)) (opcional)
create user ''@'192.168.4.7';-- crea un usuario anónimo (opcional)

-- verifica la existencia del usuario y en caso de que exista, lo reemplaza. (opcional)
create or replace user userName;

-- verifica la existencia del usuario y en caso de que no exista, lo crea. (opcional)
create user if not exists userName;

-- permite crear multiples usuarios. (opcional)
create user userName1, userName2, ..., userNameN;

-- permite crear usuarios agregando una contraseña. (opcional)
create user userName identified by '123';-- las '' son obligatorias.
select password('password to consult');-- las '' son obligatorias y muestra la contraseña codificada.

-- permite crear un limite de acciones a realizar por el usuario. (opcional)
create user userName with MAX_QUERIES_PER_HOUR N;-- N es el número máximo de consultas.
create user userName with MAX_UPDATES_PER_HOUR N;-- N es el número máximo de updates.
create user userName with MAX_CONNECTIONS_PER_HOUR N;-- N es el número máximo de conexiones.
create user userName with MAX_USER_CONNECTIONS N;-- N es el número máximo de conexiones de usuarios.
create user userName with MAX_STATEMENT_TIME N;-- N es el número máximo de espera para las consultas.

-- permite crear usuarios indicado que la contraseña tendrá un tipo de caducidad. (opcional)
create user userName password expire;
create user userName password expire default;
create user userName password expire never;
create user userName password expire interval N day;-- N es el número de días a expirar

/* mensaje de advertencia(warnings):
permite mostrar las advertencias si existen despues de ejectar una consulta sql. */
show warnings;

/* Nota: no se abordan los temas de TSL_options ni tampoco lock_options pero en la
documentación de MariaDB se puede profundizar en ellos. */

-- |-----------------------------------EXAMPLE SECTION-----------------------------------|

-- 1.
select user, host from mysql.user;
create user if not exists
'adminMain'@'%' identified by '123456', 'testQA'@'%' identified by '654321'
password expire interval 330 day;
select user, host from mysql.user;
show create user adminMain;
show create user testQA;

-- 2.
create or replace user dev1, dev2 with MAX_QUERIES_PER_HOUR 78 MAX_UPDATES_PER_HOUR 59;
show create user dev1;
show create user dev2;

-- 3.
create or replace user dev3 password expire;
show create user dev3;
create or replace user dev3 password expire default;
show create user dev3;

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
select user, host, password from mysql.user;
alter user 'testQA'@'%' identified by '36987';
-- OR
alter user testQA identified by '789456';-- forma resumida
select user, host, password from mysql.user;

-- 2.
alter user if exists dev4 identified by '789';
-- OR
alter user if exists 'dev4'@'%' identified by '789';
show warnings;

-- 3.
select user, host, password from mysql.user;
show create user dev1;
show create user dev2;
alter user dev1 identified by '123', dev2, dev4 with MAX_USER_CONNECTIONS 127;-- muestra error.
alter user if exists dev1 identified by '123', dev2, dev4 with MAX_USER_CONNECTIONS 127;-- muestra warnings.
show warnings;
show create user dev1;
show create user dev2;

-- 4.
show create user dev2;
show create user dev3;
alter user if exists dev3, dev2, dev4 with MAX_USER_CONNECTIONS 127 password expire;
show warnings;
show create user dev2;
show create user dev3;

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
select user, host from mysql.user;
create user 'user1'@'localhost', devTest1, 'technicalLeader'@'192.168.0.1';
select user, host from mysql.user;
rename user devTest1 to scrumMaster;
select user, host from mysql.user;

--2.
select user, host from mysql.user;
rename user scrumMaster to 'scrumMaster'@'192.168.0.7';
select user, host from mysql.user;
rename user 'scrumMaster'@'192.168.0.7' to 'scrumMaster2'@'192.168.10.7', 'user1'@'localhost' to user1;
select user, host from mysql.user;

/* Nota: los usuarios que tengan un host diferente a %
presentan algunos detalles cuando se van a renombrar o efectuar alguna acción,
si este es el caso, a la hora de hacer cualquier cosa con esos usuarios
se deben utilizar con la ip, por ejemplo: 'userName'@'ipHost'. */

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
select user, host, password from mysql.user;
set password for 'technicalLeader'@'192.168.0.1' = password('789456');
select user, host, password from mysql.user;
set password for 'technicalLeader'@'192.168.0.1' = password('');-- elimina la contraseña
select user, host, password from mysql.user;

-- |----------------------------------------END------------------------------------------|


-- |------------------------------CREATE ROLE SECTION COMMAND----------------------------|

-- Las siguientes consultas(querys)
-- permite consultar los roles creados y existentes.
select * from information_schema.applicable_roles;

-- permite crear un rol.
create role roleName;

-- permite asignar un rol a las opciones que se especifican a continuación. (opcional)
create or replace role if not exists roleName with admin current_user;
create or replace role if not exists roleName with admin current_role;
create or replace role if not exists roleName with admin userName;
create or replace role if not exists roleName with admin roleName;

-- |-----------------------------------EXAMPLE SECTION-----------------------------------|

-- 1.
select * from information_schema.applicable_roles;
create role architect;
select * from information_schema.applicable_roles;
select user, host, is_role from mysql.user;

-- 2.
select * from information_schema.applicable_roles;
create role devFront;
select * from information_schema.applicable_roles;
create or replace role devFront;
select * from information_schema.applicable_roles;

/* Nota: en el ejercicio 2 no es muy visible el (or replace), pero para
comprobar que si funciona, se puede intentar crear por segunda vez el
mismo rol sin usar esa cláusula(palabra reservada de sql) y se vera que
genera error, pero al tener esa cláusula es trasnparente la ejecución. */

-- |----------------------------------------END------------------------------------------|


-- |--------------------------------GRANT SECTION COMMAND--------------------------------|

-- |------show grants------|
-- Las siguientes consultas(querys)
-- permite visualizar los provilecios otorgados a un usuario o rol.
show grants;-- muestra los privilegios otorgados al usuario con el cual se inicio sesión.
show grants for (userName OR roleName);
-- OR
show grants for current_user;
show grants for current_user();

-- |------grants------|
-- permite otorgar permisos, privilegios y roles a un usuario.
grant privilegeType on privilegeLevel to userName;
-- OR
grant privilegeType on privilegeLevel to userName with MAX_CONNECTIONS_PER_HOUR 78;
grant privilegeType on nameDatabase.* to userName;
grant privilegeType on nameDatabase.nameTable to userName;

-- permite tener propiedad de otro usuario.
grant proxy on userName to userName with grant option;
-- OR
grant proxy on userName to userName, userName2, userNameN;
grant proxy on userName to userName, userName2, userNameN with grant option;
grant proxy on userName to userName, userName2, userNameN with MAX_QUERIES_PER_HOUR 12;
grant proxy on userName to userName with MAX_CONNECTIONS_PER_HOUR 12;
grant proxy on userName to userName, userName2, userNameN with MAX_STATEMENT_TIME 12;
grant proxy on userName to userName, userName2, userNameN with MAX_UPDATES_PER_HOUR 12;
grant proxy on userName to userName with MAX_USER_CONNECTIONS 12 MAX_STATEMENT_TIME 12;

-- tipos de privilegios.
grant usage on nameDatabase.nameTable to userName;-- otorga el uso de *.* al usuario o rol
-- OR
grant all privileges on nameDatabase.nameTable to userName;
grant all privileges on nameDatabase.nameTable to userName1, userName2, userNameN;
grant all on nameDatabase.nameTable to userName;-- forma resumida
grant create, insert, select, privilegeTypeN on nameDatabase.nameTable to userName;

-- permite asociar privilegios exclusivamente en las columnas de las tablas indicadas.
grant update(column1, column2mn, columnN) on nameDatabase.nameTable to userName;

-- permite otorgar un mismo rol a diferentes usuarios.
grant roleName to userName with admin option;

/* Nota: no se abordan los temas de TSL_options ni tampoco object_type pero en la
documentación de MariaDB se puede profundizar en ellos. */

-- |-----------------------------------EXAMPLE SECTION-----------------------------------|

-- 1.
show grants for testQA;-- usuari creado en secciones anteriores.
show grants for 'scrumMaster2'@'192.168.10.7';-- usuari creado en secciones anteriores.
show grants for devFront;-- rol creado en la sección anterior.

-- |----------------------------------------END------------------------------------------|


-- |----------------------------SET DEFAULT ROLE SECTION COMMAND-------------------------|

-- Las siguientes consultas(querys)
-- permite configurar roles por defecto al usuario con el que inicio sesión.
set default role roleName;
-- OR
set default role none;

-- permite indicar el usuario a realacionar con el rol por defecto.
set default role roleName for userName;


-- |-----------------------------------EXAMPLE SECTION-----------------------------------|

-- 1.
select user, host, is_role, default_role from mysql.user;
set default role architect;
select user, host, is_role, default_role from mysql.user;

-- 2.
select user, host, is_role, default_role from mysql.user;
show grants for 'technicalLeader'@'192.168.0.1';
grant architect to 'technicalLeader'@'192.168.0.1';-- es obligatorio darle los permisos al rol.
set default role architect for 'technicalLeader'@'192.168.0.1';
select user, host, is_role, default_role from mysql.user;

/* Nota: en el ejemplo 1 para el usuario technicalLeader se debe ingresar
con el host, esto porque es diferente de un usuario que por el contrario
tenga como host %, ya que a estos últimos no son necesarios especificar el host. */

-- |----------------------------------------END------------------------------------------|


-- |-------------------------------SET ROLE SECTION COMMAND------------------------------|
-- |-----------------------------------EXAMPLE SECTION-----------------------------------|
-- |----------------------------------------END------------------------------------------|


-- |-------------------------------DROP ROLE SECTION COMMAND-----------------------------|
-- |-----------------------------------EXAMPLE SECTION-----------------------------------|
-- |----------------------------------------END------------------------------------------|


-- |--------------------------------REVOKE SECTION COMMAND-------------------------------|
-- |-----------------------------------EXAMPLE SECTION-----------------------------------|
-- |----------------------------------------END------------------------------------------|


-- |-------------------------------DROP USER SECTION COMMAND-----------------------------|

-- Las siguientes consultas(querys)
-- permite eliminar uno o varios usuarios ya creados.
drop user userName;
-- OR
drop user if exists userName;
drop user if exists userName, userName2, userNameN;

-- |-----------------------------------EXAMPLE SECTION-----------------------------------|

-- 1.
drop user if exists dev1, 'dev2'@'%', dev3, 'dev4'@'%';
show warnings;
select user, host, password from mysql.user;

-- |----------------------------------------END------------------------------------------|


-- |------------------------------ALTER USER SECTION COMMAND-----------------------------|
-- |-----------------------------------EXAMPLE SECTION-----------------------------------|
-- |----------------------------------------END------------------------------------------|