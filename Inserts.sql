USE UniversityDB;

-- Ingreso de estados de suscripcion a curso
INSERT INTO cat_suscriptions_status (id, title)
VALUES
    ('M', 'Matriculado'),
    ('A', 'Aprobado'),
    ('R', 'Reprobado'),
    ('C', 'Cancelado');


-- Ingreso de las modalidades
INSERT INTO cat_modality (id, [name], [description])
VALUES
    ('M001', 'Presencial', 'Clases en persona en un lugar espec�fico.'),
    ('M002', 'En l�nea', 'Clases impartidas a trav�s de plataformas en l�nea.'),
    ('M003', 'H�brido', 'Combinaci�n de clases presenciales y en l�nea.'),
    ('M004', 'Autoestudio', 'Material de estudio proporcionado para el aprendizaje independiente.');

-- Ingreso de las diferentes categorias academicas
INSERT INTO cat_academic_category (id, [name], [description])
VALUES
    ('AC001', 'Bachillerato', 'Nivel educativo previo a la educaci�n universitaria.'),
    ('AC002', 'T�cnico', 'Programas de educaci�n t�cnica y formaci�n profesional.'),
    ('AC003', 'Universitario', 'Educaci�n superior en instituciones universitarias.'),
    ('AC004', 'Posgrado', 'Programas de educaci�n despu�s de obtener un t�tulo universitario.'),
    ('AC005', 'Formaci�n Profesional', 'Programas de capacitaci�n laboral y habilidades t�cnicas.'),
    ('AC006', 'Educaci�n Continua', 'Cursos y talleres para el desarrollo profesional.'),
    ('AC007', 'Educaci�n a Distancia', 'Programas educativos que se imparten de manera remota.'),
    ('AC008', 'Educaci�n Vocacional', 'Enfoque en habilidades pr�cticas y vocacionales.'),
    ('AC009', 'Educaci�n Primaria', 'Los primeros a�os de educaci�n formal para ni�os.');


-- Ingreso de los diferentes periodos academicos
INSERT INTO cat_academic_periods (id, [name], [description])
VALUES
    ('AP001', 'Trimestre', 'Per�odo de tres meses que divide el a�o acad�mico.'),
    ('AP002', 'Semestre', 'Per�odo de seis meses que divide el a�o acad�mico en dos partes.'),
    ('AP003', 'Cuatrimestre', 'Per�odo de cuatro meses que divide el a�o acad�mico.'),
    ('AP004', 'Anual', 'Per�odo de un a�o completo de actividades acad�micas.'),
    ('AP005', 'Verano', 'Per�odo de clases durante las vacaciones de verano.');

 
-- Ingreso de los diferentes curos que se pueden llevar 
INSERT INTO cat_courses ([code], [name], [description], [status])
VALUES
    ('C001', 'Introducci�n a la Programaci�n', 'Curso introductorio sobre conceptos de programaci�n.', 1),
    ('C002', 'Dise�o Gr�fico Digital', 'Aprende a crear dise�os gr�ficos con herramientas digitales.', 1),
    ('C003', 'Matem�ticas Avanzadas', 'Curso de matem�ticas enfocado en temas avanzados.', 0),
    ('C004', 'Ingl�s para Viajeros', 'Aprende frases y vocabulario �tiles para viajar.', 1),
    ('C005', 'Econom�a B�sica', 'Conceptos fundamentales de econom�a y finanzas.', 1),
    ('C006', 'Introducci�n a la Biolog�a', 'Curso introductorio sobre conceptos b�sicos de biolog�a.', 1),
    ('C007', 'Desarrollo Web Avanzado', 'Aprende a crear aplicaciones web avanzadas.', 1),
    ('C008', 'Historia del Arte', 'Explora la evoluci�n del arte a lo largo de la historia.', 0),
    ('C009', 'Marketing Digital', 'Estrategias y t�cnicas de marketing en l�nea.', 1),
    ('C010', 'Psicolog�a del Comportamiento', 'Comprende el comportamiento humano desde la perspectiva psicol�gica.', 1),
    ('C011', 'Introducci�n a la Inteligencia Artificial', 'Conceptos b�sicos de IA y sus aplicaciones.', 1),
    ('C012', 'Fotograf�a Digital', 'Aprende t�cnicas de fotograf�a con c�maras digitales.', 1),
    ('C013', 'Literatura Universal', 'Explora obras literarias de diferentes culturas.', 0),
    ('C014', 'Finanzas Personales', 'Gesti�n de finanzas y planificaci�n econ�mica personal.', 1),
    ('C015', 'Nutrici�n y Salud', 'Principios b�sicos de una dieta equilibrada y saludable.', 1),
    ('C016', 'Introducci�n a la Psicolog�a', 'Conceptos fundamentales de la psicolog�a moderna.', 1),
    ('C017', 'Programaci�n en Python', 'Aprende a programar utilizando el lenguaje Python.', 1),
    ('C018', 'Literatura Contempor�nea', 'Estudio de la literatura de los �ltimos siglos.', 0),
    ('C019', 'Dise�o de Interacci�n', 'Enfoque en la experiencia del usuario y dise�o de interfaces.', 1),
    ('C020', 'Historia Mundial', 'Exploraci�n de eventos hist�ricos en diferentes �pocas y lugares.', 1),
    ('C021', 'Introducci�n a la Econom�a', 'Principios b�sicos de la econom�a y teor�a econ�mica.', 1),
    ('C022', 'Programaci�n en Java', 'Aprende a programar utilizando el lenguaje Java.', 1),
    ('C023', 'Dibujo Art�stico', 'Desarrolla habilidades de dibujo y expresi�n art�stica.', 0),
    ('C024', 'Estad�sticas Aplicadas', 'Aplicaci�n de m�todos estad�sticos en situaciones reales.', 1),
    ('C025', 'Gesti�n de Proyectos', 'Fundamentos de planificaci�n y gesti�n de proyectos.', 1),
    ('C026', 'Filosof�a Moderna', 'Explora las corrientes filos�ficas de los �ltimos siglos.', 0),
    ('C027', 'Programaci�n Web', 'Desarrollo de aplicaciones web utilizando tecnolog�as actuales.', 1),
    ('C028', 'Ecolog�a y Medio Ambiente', 'Estudio de las interacciones entre organismos y su entorno.', 1),
    ('C029', 'Comunicaci�n Escrita', 'Mejora tus habilidades de escritura y redacci�n.', 1),
    ('C030', 'Historia del Cine', 'Explora la evoluci�n del cine a lo largo de la historia.', 0),
    ('C031', 'Marketing Estrat�gico', 'Planificaci�n de estrategias de marketing y branding.', 1),
    ('C032', 'Introducci�n a la Sociolog�a', 'Conceptos fundamentales de la sociolog�a y la sociedad.', 1),
    ('C033', 'Programaci�n en C#', 'Aprende a programar utilizando el lenguaje C#.', 1),
    ('C034', 'Arquitectura Moderna', 'Exploraci�n de la arquitectura del siglo XX en adelante.', 0),
    ('C035', 'Psicolog�a del Desarrollo', 'Estudio de los cambios psicol�gicos a lo largo de la vida.', 1);


-- Ingreso de las diferentes carreras que se ofrecen
INSERT INTO cat_career ([code], [name], [description], [status])
VALUES
    ('CAR001', 'Ingenier�a Inform�tica', 'Dise�o y desarrollo de software y sistemas inform�ticos.', 1),
    ('CAR002', 'Administraci�n de Empresas', 'Gesti�n y direcci�n de organizaciones y negocios.', 1),
    ('CAR003', 'Psicolog�a', 'Estudio del comportamiento y procesos mentales.', 1),
    ('CAR004', 'Medicina', 'Pr�ctica m�dica y atenci�n a la salud humana.', 0),
    ('CAR005', 'Dise�o Gr�fico', 'Creaci�n de dise�os visuales para comunicaci�n.', 1),
    ('CAR006', 'Arquitectura', 'Planificaci�n y dise�o de estructuras y espacios.', 1),
    ('CAR007', 'Contabilidad', 'Registro y an�lisis financiero de transacciones.', 1),
    ('CAR008', 'Educaci�n Primaria', 'Formaci�n de maestros para la educaci�n b�sica.', 1),
    ('CAR009', 'Derecho', 'Estudio de leyes y sistemas legales.', 0),
    ('CAR010', 'Ingenier�a Civil', 'Dise�o y construcci�n de infraestructuras y obras civiles.', 1),
    ('CAR011', 'Enfermer�a', 'Atenci�n y cuidado de pacientes en entornos de salud.', 1),
    ('CAR012', 'Marketing', 'Planificaci�n y ejecuci�n de estrategias de marketing.', 1),
    ('CAR013', 'Pedagog�a', 'Estudio de m�todos de ense�anza y educaci�n.', 0),
    ('CAR014', 'Biolog�a', 'Estudio de los seres vivos y sus procesos.', 1),
    ('CAR015', 'Ingenier�a El�ctrica', 'Dise�o y mantenimiento de sistemas el�ctricos.', 1);

-- Crea datos de las carreras, recorriendo todas las carreras y agregando materias o cursos a las mismas
CREATE OR ALTER PROCEDURE P_RelactionBetweenCoursesXCareer 
AS 
	DECLARE c_cat_career CURSOR FOR 
	SELECT [code]
	FROM cat_career;

	DECLARE @Ln_next_id INT;
	DECLARE @Lv_career_code CHAR(10);
	DECLARE @Lv_course_code CHAR(10);
	
BEGIN
	 
	 DELETE cat_courses_x_career;
	--select * from cat_courses_x_career 
	-- Open Cursor c_cat_career
	OPEN c_cat_career
    FETCH NEXT FROM c_cat_career 
	INTO @Lv_career_code;


	-- Para cursor c_cat_career
	 WHILE @@FETCH_STATUS = 0  
		BEGIN 

			DECLARE c_cat_courses CURSOR FOR 
			SELECT [code]
			FROM cat_courses;


			-- Open Cursor c_cat_courses
			OPEN c_cat_courses
			FETCH NEXT FROM c_cat_courses 
			INTO @Lv_course_code;

			-- Para cursor c_cat_courses
			WHILE @@FETCH_STATUS = 0  
			BEGIN
				DECLARE @Ln_insert_ind INT;


				-- Random value para ver si se ingresa el curso o no
				SET @Ln_insert_ind = CAST(RAND() * 2 AS INT) + 1;
				
				IF (@Ln_insert_ind = 2)
				BEGIN 
					SELECT @Ln_next_id = ISNULL(MAX(ID),0)+1 
					FROM cat_courses_x_career;
					
					INSERT INTO  cat_courses_x_career(id, [code_career], [code_course])
					VALUES (@Ln_next_id, @Lv_career_code, @Lv_course_code );
				END;
				--select * from cat_courses_x_career
		 
				FETCH NEXT FROM c_cat_courses 
				INTO @Lv_course_code;
			END
	
			CLOSE c_cat_courses;
			DEALLOCATE c_cat_courses;
			
			FETCH NEXT FROM c_cat_career 
			INTO @Lv_career_code;
        END
  
    CLOSE c_cat_career  
    DEALLOCATE c_cat_career  

	/*
	CREATE TABLE cat_courses_x_career(
	id INT NOT NULL UNIQUE,
	[code_career] CHAR(10)  NOT NULL,
	[code_course] CHAR(10)  NOT NULL
	
	);
	*/

END;

EXEC P_RelactionBetweenCoursesXCareer;
SELECT * FROM cat_courses_x_career; 


 

--  Ingreso de los roles del sistema
INSERT INTO roles(id,[name],[description])
VALUES ('ADMIN', 'Administrator', 'Full administrative privileges.'),
('MODER', 'Moderator', 'Moderation privileges and responsibilities.'),
('TEACH', 'Teacher', 'Teacher of university.'),
('STUDE', 'Student', 'Student of university.'),
('USER', 'User', 'Standard user role with basic access.'),
('GUEST', 'Guest', 'Limited access for guests.'),
('MGR', 'Manager', 'Managerial role with specific privileges.');


-- Ingreso de usuarios 
INSERT INTO users (id, last_login, [name], last_name, [gender], birts_date, create_at, modified_at)
VALUES
(1, '2023-08-19 09:15:00', 'John', 'Doe', 'M', '1990-05-15', '2023-08-10 14:30:00', '2023-08-15 18:20:00'),
(2, '2023-08-18 16:40:00', 'Emily', 'Smith', 'F', '1985-10-20', '2023-08-05 09:45:00', '2023-08-18 16:40:00'),
(3, '2023-08-19 07:30:00', 'Michael', 'Johnson', 'M', '1995-02-12', '2023-08-01 21:10:00', '2023-08-19 07:30:00'),
(4, '2023-08-17 11:20:00', 'Sarah', 'Williams', 'F', '1988-07-28', '2023-07-25 18:55:00', '2023-08-17 11:20:00'),
(5, '2023-08-19 08:50:00', 'David', 'Brown', 'M', '1982-11-03', '2023-08-12 10:15:00', '2023-08-19 08:50:00'),
(6, '2023-08-18 14:15:00', 'Jennifer', 'Davis', 'F', '1993-04-18', '2023-08-03 16:20:00', '2023-08-18 14:15:00'),
(7, '2023-08-19 06:05:00', 'Christopher', 'Martinez', 'M', '1979-09-08', '2023-07-29 22:45:00', '2023-08-19 06:05:00'),
(8, '2023-08-17 19:30:00', 'Jessica', 'Anderson', 'F', '1991-12-10', '2023-08-06 14:10:00', '2023-08-17 19:30:00'),
(9, '2023-08-19 10:25:00', 'Kevin', 'Taylor', 'M', '1987-03-22', '2023-08-14 09:40:00', '2023-08-19 10:25:00'),
(10, '2023-08-18 22:55:00', 'Amanda', 'White', 'F', '1998-06-07', '2023-08-08 11:25:00', '2023-08-18 22:55:00'),
(11, '2023-08-19 14:30:00', 'Robert', 'Miller', 'M', '1992-09-18', '2023-08-11 09:20:00', '2023-08-19 14:30:00'),
(12, '2023-08-18 10:40:00', 'Linda', 'Jackson', 'F', '1986-03-25', '2023-08-06 12:15:00', '2023-08-18 10:40:00'),
(13, '2023-08-19 16:30:00', 'William', 'Brown', 'M', '1980-11-08', '2023-08-02 17:40:00', '2023-08-19 16:30:00'),
(14, '2023-08-17 08:20:00', 'Karen', 'Wilson', 'F', '1994-07-12', '2023-07-27 14:50:00', '2023-08-17 08:20:00'),
(15, '2023-08-19 12:50:00', 'Richard', 'Jones', 'M', '1977-02-28', '2023-08-09 11:30:00', '2023-08-19 12:50:00'),
(16, '2023-08-18 18:15:00', 'Patricia', 'Davis', 'F', '1990-06-03', '2023-08-04 15:25:00', '2023-08-18 18:15:00'),
(17, '2023-08-19 09:05:00', 'Charles', 'Martinez', 'M', '1983-12-14', '2023-07-30 20:10:00', '2023-08-19 09:05:00'),
(18, '2023-08-17 14:30:00', 'Jennifer', 'Taylor', 'F', '1988-05-22', '2023-08-07 13:45:00', '2023-08-17 14:30:00'),
(19, '2023-08-19 11:25:00', 'Daniel', 'Brown', 'M', '1996-03-02', '2023-08-13 10:55:00', '2023-08-19 11:25:00'),
(20, '2023-08-18 08:55:00', 'Elizabeth', 'Miller', 'F', '1999-08-09', '2023-08-08 16:30:00', '2023-08-18 08:55:00'), 
(21, '2023-08-19 15:30:00', 'Christopher', 'Clark', 'M', '1984-11-01', '2023-08-10 11:20:00', '2023-08-19 15:30:00'),
(22, '2023-08-18 09:40:00', 'Mary', 'White', 'F', '1993-04-17', '2023-08-05 08:35:00', '2023-08-18 09:40:00'),
(23, '2023-08-19 13:20:00', 'Matthew', 'Smith', 'M', '1989-07-06', '2023-08-01 14:45:00', '2023-08-19 13:20:00'),
(24, '2023-08-17 17:10:00', 'Patricia', 'Johnson', 'F', '1981-02-23', '2023-07-26 12:55:00', '2023-08-17 17:10:00'),
(25, '2023-08-19 10:45:00', 'James', 'Anderson', 'M', '1975-09-16', '2023-08-11 15:30:00', '2023-08-19 10:45:00'),
(26, '2023-08-18 14:05:00', 'Jessica', 'Davis', 'F', '1992-05-04', '2023-08-06 13:40:00', '2023-08-18 14:05:00'),
(27, '2023-08-19 12:15:00', 'David', 'Wilson', 'M', '1987-12-11', '2023-08-02 09:25:00', '2023-08-19 12:15:00'),
(28, '2023-08-17 08:40:00', 'Sarah', 'Taylor', 'F', '1985-03-28', '2023-07-28 10:10:00', '2023-08-17 08:40:00'),
(29, '2023-08-19 14:30:00', 'John', 'Brown', 'M', '1997-11-19', '2023-08-12 11:20:00', '2023-08-19 14:30:00'),
(30, '2023-08-18 10:50:00', 'Emily', 'Miller', 'F', '1984-06-09', '2023-08-07 14:45:00', '2023-08-18 10:50:00');



select * from users

CREATE OR ALTER PROCEDURE P_AddRolesToUser
AS 
	DECLARE c_users CURSOR FOR 
	SELECT id
	FROM users;

	
	DECLARE @Ln_user_id INT;
	DECLARE @Lv_id_role CHAR(5);
	
BEGIN
	
	
	DELETE roles_user;
	 
	-- Open Cursor c_users
	OPEN c_users
    FETCH NEXT FROM c_users 
	INTO @Ln_user_id;


	-- Para cursor c_users
	 WHILE @@FETCH_STATUS = 0  
		BEGIN 
			DECLARE @Ln_insert_ind INT;
			DECLARE c_roles CURSOR FOR
			SELECT id
			FROM roles;

			-- Open Cursor c_roles
			OPEN c_roles
			FETCH NEXT FROM c_roles 
			INTO @Lv_id_role;


			-- Para cursor c_users
			 WHILE @@FETCH_STATUS = 0  
				BEGIN 

					SET @Ln_insert_ind = CAST(RAND() * 2 AS INT) + 1;
				
					IF (@Ln_insert_ind = 2)
					BEGIN 
						INSERT INTO roles_user ( id_user , id_role)
						VALUES (@Ln_user_id, @Lv_id_role);
					END;

					FETCH NEXT FROM c_roles 
					INTO @Lv_id_role;
				END;

			CLOSE c_users  
			DEALLOCATE c_users  

		END
	CLOSE c_users  
    DEALLOCATE c_users  
END;

SELECT * FROM USERS
WHERE CAST(RAND() * 2 AS INT) + 1 = 2

select CAST(RAND() * 2 AS INT) + 1 