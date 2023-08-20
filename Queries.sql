-- Profesores
Select * 
From Users
Where [dbo].F_UserHasRole(id, 'TEACHER') = 1;


-- Estudiantes
Select * 
From Users
Where [dbo].F_UserHasRole(id, 'STUDEN') = 1;