/*
	1.La estructura de bases de datos debe permitir almacenar y relacionar
		Categor�a acad�mica (Bachillerato, Licenciatura, Postgrados, Cursos Libres, Diplomas)
		Carreras 
		Plan de estudio: Cursos 
		Periodos: Cuatrimestres / Trimestres / Bimestres
		Estudiantes / Cursos / Notas
		Profesores / Cursos / Evaluaci�n de desempe�o
		Todas las entidades deben almacenar su historia correspondiente.
*/


/*
	Catelogo donde se guardar�n las diferentes estados
	que puede tener una suscripcion a un curso.
	Ejemplo:
	- Matriculado
	- Aprobado
	- Reprobado
*/
CREATE TABLE cat_suscriptions_status (
	id CHAR(5) NOT NULL,
	title VARCHAR(50) NOT NULL
)
ALTER TABLE cat_suscriptions_status
ADD CONSTRAINT PK_cat_suscriptions_status
PRIMARY KEY (id);


/*
	Catalogo donde se guardar�n las modalidades 
	en las que se podr�n dar las clases
	Ejemplo:
	 - Virtual
	 - Presencial
*/
CREATE TABLE cat_modality(
	id CHAR(5) NOT NULL,
	[name] VARCHAR(20),
	[description] VARCHAR(200)
);

ALTER TABLE cat_modality
ADD CONSTRAINT PK_cat_modality
PRIMARY KEY (id);


/*
	Catalogo de categor�as academicas, donde se guardaran las diferentes 
	categor�as academicas.
	Ejemplo: 
	 - Bachillerato
	 - Licenciatura
	 - Postgrados
	 - Cursos Libres
	 - Diplomas
*/ 
CREATE TABLE cat_academic_category (
	id CHAR(5) NOT NULL,
	[name] VARCHAR(50),
	[description] VARCHAR(200)
);

ALTER TABLE cat_academic_category
ADD CONSTRAINT PK_cat_academic_category
PRIMARY KEY(id);



/*
	Catalogo donde se guardaran los diferentes periodos 
	en los que se organizar los cursos.
	Ejemplo:
	 - Cuatrimestre
	 - Trimestre
*/
CREATE TABLE cat_academic_periods(
	id CHAR(5) NOT NULL,
	[name] VARCHAR(20),
	[description] VARCHAR(200)
)
ALTER TABLE cat_academic_periods
ADD CONSTRAINT PK_cat_academic_periods
PRIMARY KEY(id);


/*
	Catalogo de cursos, donde se guardar�n datos
	tales como las "clases" que se pueden llegar a dar
	en el curso.
	Ejemplo:
	 - Matematicas I
	 - Ingles I
	 - Ingles II
*/ 
CREATE TABLE cat_courses(
    [code] CHAR(10) NOT NULL,
    [name] VARCHAR(100) NOT NULL,
    [description] VARCHAR(200),
	[status] INT NOT NULL DEFAULT 0 -- 1 activo, 0 inactivo
    -- Department VARCHAR(100) NOT NULL,
    -- Credits INT NOT NULL,
    -- Instructor VARCHAR(100) NOT NULL,
    -- Prerequisites TEXT,
    -- SemesterOffered VARCHAR(50),
    --YearOffered INT
);

ALTER TABLE cat_courses
ADD CONSTRAINT PK_cat_courses
PRIMARY KEY (code);


/*
	Catalogo de carreras, donde se guardar�n todas
	las carreras ofrecidas por la universidad.
	Ejemplo:
	 - Ing. Informatica
	 - Contbilidad
	 - Administracion de empresas
*/
-- All careers of university
CREATE TABLE cat_career(
	[code] CHAR(10)  NOT NULL,
    [name] VARCHAR(100) NOT NULL,
    [description] VARCHAR(200),
	[status] INT NOT NULL DEFAULT 0
);

ALTER TABLE cat_career
ADD CONSTRAINT PK_cat_career
PRIMARY KEY (code);


/*
	Catalogo de cursos por carrera, donde se guardara una relacion
	entre la carrera y el curso.
	Ejemplo:
	 - Ing. Informatica --> Matematicas I
	 - Adm. Empresas    --> Matematicas I
	 - Ing. Informatica --> Programaci�n I
	 - Ing. Informatica --> Ingles I
	 - Adm. Empresas    --> Ingles I
*/ 
CREATE TABLE cat_courses_x_career(
	id INT NOT NULL UNIQUE,
	[code_career] CHAR(10)  NOT NULL,
	[code_course] CHAR(10)  NOT NULL
);

ALTER TABLE cat_courses_x_career 
ADD CONSTRAINT PK_cat_courses_x_career
PRIMARY KEY ([code_career],[code_course] ),
--
CONSTRAINT FK01_cat_career__cat_courses
FOREIGN KEY ([code_career])
REFERENCES cat_career([code]),
--
CONSTRAINT FK02_cat_career__cat_courses
FOREIGN KEY ([code_course])
REFERENCES cat_courses([code]);



/*
	Tabla donde se guardar�n todos los roles disponibles
	Ejemplo:
	 - Administrador
	 - Profesor
	 - Estudiante
*/

-- All roles of DB
CREATE TABLE roles (
id CHAR(5) NOT NULL,
[name] VARCHAR(20),
[description] VARCHAR(200)
);

ALTER TABLE roles
ADD CONSTRAINT PK_roles
PRIMARY KEY(id);



/*
	Tabla donde se guardaran todos los usuarios del sistema
*/
-- All users
CREATE TABLE users (
	id INT NOT NULL,
	last_login DATETIME NOT NULL,
	[name] VARCHAR(200),
	[last_name] VARCHAR(200),
	[gender] CHAR(1),
	[birts_date] DATE,
	create_at DATETIME,
	modified_at DATETIME
);

ALTER TABLE users
ADD CONSTRAINT PK_users
PRIMARY KEY (id);


/*
	Tabla de roles por usuario, donde se guardara los roles 
	con los que cuenta cada usuario.
	Ejemplo:
	- User1 --> Administrador
	- User1 --> Profesor
	- User2 --> Estudiante

*/
-- Role X User
CREATE TABLE roles_user (
	id_user INT NOT NULL,
	id_role CHAR(5) NOT NULL
);

ALTER TABLE roles_user 
ADD CONSTRAINT PK_roles_user
PRIMARY KEY (id_user,id_role ),
--
CONSTRAINT FK01_roles_user__users
FOREIGN KEY (id_user)
REFERENCES users(id),
--
CONSTRAINT FK01_roles_user__roles
FOREIGN KEY (id_role)
REFERENCES roles(id);



/*
	Tabla donde se almacenaran los correos de los usuarios.
*/
-- Emails of user
CREATE TABLE user_emails (
	id_user INT NOT NULL,
	[email] NCHAR(255) NOT NULL,
	[default] INT NOT NULL DEFAULT 0,
	[status] INT NOT NULL DEFAULT 0
);
ALTER TABLE user_emails
ADD CONSTRAINT PK_user_emails
PRIMARY KEY (id_user,[email]),
-- 
CONSTRAINT FK_user_emails__users
FOREIGN KEY (id_user)
REFERENCES users(id);

/*
	Tabla donde se guardara la informaci�n de login de los usuarios.

*/
-- Tabla para login 
CREATE TABLE login_user (
	id_user INT NOT NULL,
	[user_access] NCHAR(50) NOT NULL,
	[password] NCHAR(255) NOT NULL,
	[status] INT NOT NULL DEFAULT 0,
	create_at DATETIME,
	modified_at DATETIME
)


ALTER TABLE login_user
ADD CONSTRAINT PK_login_user
PRIMARY KEY (id_user, [user_access]),
-- 
CONSTRAINT FK_login_user__users
FOREIGN KEY (id_user)
REFERENCES users(id);

/*
	Tabla donde se alamacenara los planes de estudio disponibles.
*/
CREATE TABLE study_plan(
	id INT NOT NULL,
	id_academic_category CHAR(5) NOT NULL,
	title VARCHAR(30) NOT NULL,
	[description] VARCHAR(400) NOT NULL,
	create_at DATETIME NOT NULL
)

ALTER TABLE study_plan
ADD CONSTRAINT PK_study_plan
PRIMARY KEY(id),
CONSTRAINT FK01_study_plan__cat_academic_category
FOREIGN KEY  (id_academic_category)
REFERENCES cat_academic_category(id);

/*
	Tabla donde se almacenar� la relacion entre 
	el plan de estudio y los cursos que se llevaran.
*/
CREATE TABLE study_plan_courses(
	id_study_plan INT NOT NULL,
	course_code INT NOT NULL,
	[block] INT NOT NULL,
	[order] INT NOT NULL,
	create_at DATETIME NOT NULL,
	credits INT NOT NULL DEFAULT 0
);

ALTER TABLE study_plan_courses
ADD CONSTRAINT PK_study_plan_courses
PRIMARY KEY (id_study_plan, course_code),
--
CONSTRAINT FK01_study_plan_courses__study_plan
FOREIGN KEY (id_study_plan)
REFERENCES study_plan(id),
--
CONSTRAINT FK02_study_plan_courses__cat_courses
FOREIGN KEY (course_code)
REFERENCES cat_courses_x_career(id)
;

/*
	Tabla donde se almacenar�n los datos sobre los periodos de estudio
	Ejemplo:
		1 - Cuatrimestre - 10/09/2023 - 15/12/2023 - Matricula Abierta
		2 - Cuatrimestre -  15/04/2023 - 10/09/2023 - Concluido

*/
CREATE TABLE [periods](
	id INT NOT NULL,
	id_cat_period CHAR(5) NOT NULL,
	[start_date] DATETIME NOT NULL,
	[end_date] DATETIME NOT NULL,
	[description] VARCHAR(200),
	[status] INT NOT NULL DEFAULT 0
)

ALTER TABLE [periods]
ADD CONSTRAINT PK_periods
PRIMARY KEY(id),
--
CONSTRAINT FK01_periods__cat_academic_periods
FOREIGN KEY (id_cat_period)
REFERENCES cat_academic_periods(id);


/*
	Tabla donde se almacenara el detalle de los cursos 
	que se llevar�n acabo en ese periodo de estudio.

*/
CREATE TABLE periods_courses (
	id INT NOT NULL UNIQUE,
	id_periods INT NOT NULL ,
	id_teacher INT NOT NULL,
	[code_course] INT NOT NULL,
	day_week CHAR(1) NOT NULL, -- L M K J V S D
	start_hour CHAR(4) NOT NULL,  -- En formato militar la hora 6pm --> 1800
	end_hour CHAR(4) NOT NULL,
	modality CHAR(5) NOT NULL,
	class_room_id CHAR(4),
	modified_at DATETIME NOT NULL,
	create_at DATETIME NOT NULL
	-- falta dia de semna y hora
);



ALTER TABLE periods_courses
ADD CONSTRAINT PK_periods_courses
PRIMARY KEY (id_periods,id_teacher,[code_course], day_week, start_hour),
--
CONSTRAINT FK01_periods_courses__periods
FOREIGN KEY (id_periods)
REFERENCES [periods](id),

CONSTRAINT FK02_periods_courses__users
FOREIGN KEY (id_teacher)
REFERENCES users(id),
--
CONSTRAINT FK03_periods_courses__cat_courses
FOREIGN KEY ([code_course])
REFERENCES cat_courses_x_career(id),
-- 
CONSTRAINT FK04_periods_courses__cat_modality
FOREIGN KEY (modality)
REFERENCES cat_modality(id);

/*
	Tabla de las suscripciones que se llevar�n acabo en los
	cursos correspondientes al periodo de estudio.
	En esta tabla se almacenar�n datos relevantes tales como el estudiante
	relacionado este con la nota que obtuvo y el status(matriculado,aprobado,etc)

*/

CREATE TABLE periods_courses_suscriptions(
	id INT NOT NULL UNIQUE, -- SACAR PARA LAS NOTAS
	id_periods_courses INT NOT NULL,
	student_id INT NOT NULL,
	[status] CHAR(5) NOT NULL,
	score decimal(18,5) NOT NULL DEFAULT 0,
	create_at DATETIME NOT NULL,
	modified_at DATETIME NOT NULL
);

 
ALTER TABLE periods_courses_suscriptions
ADD CONSTRAINT PK_periods_courses_suscriptions
PRIMARY KEY(id_periods_courses,student_id),
--
CONSTRAINT FK01_periods_courses_suscriptions__users
FOREIGN KEY (student_id)
REFERENCES users(id),
--
CONSTRAINT FK02_periods_courses_suscriptions__periods_courses
FOREIGN KEY (id_periods_courses)
REFERENCES  periods_courses(id),
--
CONSTRAINT FK03_periods_courses_suscriptions__cat_suscriptions_status
FOREIGN KEY ([status])
REFERENCES  cat_suscriptions_status(id)
;


CREATE TABLE study_plan_suscriptions(
	id_study_plan INT NOT NULL,
	id_student INT NOT NULL,
	[status]  INT not null, -- 0 inactiva, 1 activa, 2 completada
	create_at DATETIME NOT NULL
);


ALTER TABLE study_plan_suscriptions
ADD CONSTRAINT PK_study_plan_suscriptions
PRIMARY KEY (id_study_plan, id_student),
CONSTRAINT FK01_study_plan_suscriptions__S
FOREIGN KEY (id_study_plan)
REFERENCES study_plan(id),
CONSTRAINT FK02_study_plan_suscriptions__users
FOREIGN KEY (id_student)
REFERENCES users(id);



CREATE TABLE performance_evaluation(
	id INT NOT NULL,
	id_user INT NOT NULL,
	[start_date] DATETIME ,
	[end_date] DATETIME ,
	create_at DATETIME NOT NULL,
	modified_at DATETIME NOT NULL,
	reason VARCHAR(2000)
);


ALTER TABLE performance_evaluation
ADD CONSTRAINT PK_performance_evaluation
PRIMARY KEY(id),

CONSTRAINT FK01_performance_evaluation__users
FOREIGN KEY (id_user)
REFERENCES users(id);

  
CREATE TABLE performance_evaluation_details(
	id_performance_evaluation  INT NOT NULL,
	[sequence] INT NOT NULL,
	id_user INT NOT NULL,
	comment VARCHAR(2000),
	score decimal(18,5) NOT NULL DEFAULT 0
);

ALTER TABLE performance_evaluation_details
ADD CONSTRAINT PK_performance_evaluation_details
PRIMARY KEY(id_performance_evaluation, [sequence]),

CONSTRAINT FK01_performance_evaluation__details
FOREIGN KEY (id_performance_evaluation)
REFERENCES performance_evaluation(id),

CONSTRAINT FK02_performance_evaluation__users
FOREIGN KEY (id_user)
REFERENCES users(id);
