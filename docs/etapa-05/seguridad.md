## =====SEGURIDAD: Manejo de permisos a nivel de usuarios y roles.=====

-La seguridad en una base de datos permite controlar que usuarios pueden acceder a la información y qué operaciones pueden realizar. SQL Server permite administrar permisos de manera individual(usuarios) o agrupándolos mediante roles. Esto facilita proteger la información. 

-Principio de Mínimo privilegio: es un principio de seguridad que establece que a cada usuario o proceso se le deben otorgar únicamente los permisos estrictamente necesarios para cumplir con sus funciones. 

## -Logins vs. Usuarios: 
    LOGIN: autenticación a nivel de servidor o instancia de SQL Server. 
    USUARIO (Data Base User): identidad y autorización mapeada a un Login dentro de una base de datos especifica. 

## Roles: agrupaciones de usuarios para facilitar la administración centralizada de permisos.

## ABSTRACCION MEDIATNE PROCEDIMIENTOS

La combinación de permisos a nivel de procedimiento almacenado permite implementar un esquema seguro: un usuario de nivel operativo (como un vendedor) no tiene permisos directos para hacer INSERT o UPDATE en las tablas, pero si tiene permiso EXECUTE sobre un procedimiento que realiza la operación bajo reglas estrictamente controladas.
