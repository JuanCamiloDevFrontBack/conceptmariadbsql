-- Comentario de una línea
/* 
Comentario de varias líneas 
*/

/* La siguiente consulta(query) permite mostrar las columnas
de cualquier tabla con información más detallada */
describe nameTabla;
desc nameTabla;-- forma resumida

/* La siguiente consulta(query) permite consultar los usuarios
creados y existentes en la base de datos */
select * from mysql.user;

/* La siguiente consulta(query) permite consultar el usuario
con el cual se inicio sesión en la base de datos */
show create user;
show create user nameUser;-- muestra el usuario indicado(nameUser) si esta creado. (opcional)

-- La siguiente consulta(query) permite crear usuarios en la base de datos
create user nameUser;
/* verifica la existencia del usuario y en caso de que exista, lo reemplaza. (opcional)*/
create or replace user nameUser;
/* verifica la existencia del usuario y en caso de que no exista, lo crea. (opcional)*/
create user if not exists nameUser;
-- permite crear multiples usuarios.
create user nameUser1, nameUser2, ..., nameUserN;
-- permite crear usuarios agregando una contraseña. (opcional)
create user nameUser identified by '123';-- las '' son obligatorias.
-- permite crear un limite de acciones a realizar por el usuario. (opcional)
create user nameUser with MAX_QUERIES_PER_HOUR N;-- N es el número máximo de consultas.
create user nameUser with MAX_UPDATES_PER_HOUR N;-- N es el número máximo de updates.
create user nameUser with MAX_CONNECTIONS_PER_HOUR N;-- N es el número máximo de conexiones.
create user nameUser with MAX_USER_CONNECTIONS N;-- N es el número máximo de conexiones de usuarios.
create user nameUser with MAX_STATEMENT_TIME N;-- N es el número máximo declarado.
-- permite crear usuarios indicado que la contraseña tendrá un tipo de caducidad. (opcional)
create user nameUser password expire;
create user nameUser password expire default;
create user nameUser password expire never;
create user nameUser password expire interval N day;-- N es el número de días a expirar

-- /-----------------------------------------------------------------------------------------/

-- Ejemplos
-- 1.
