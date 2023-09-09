-- Comentario de una línea
/* 
Comentario de varias líneas 
*/

/* La siguiente consulta(query) permite consultar los usuarios
creados y existentes en la base de datos */
select * from mysql.user;

/* La siguiente consulta(query) permite consultar el usuario
con el cual se inicio sesión en la base de datos */
show create user;
show create user nameUser;-- muestra el usuario indicado si esta creado. (opcional)

-- La siguiente consulta(query) permite crear usuarios en la base de datos
create user nameUser