/*
	2. Reporte de estudiante por curso. Utilizar Cursor
	- Se desea conocer de un estudiante: Los cursos que ha matriculado en la historia, los cursos que ha aprobado y reprobado, 
	  las notas y los cursos pendientes que le faltan para concluir el plan.
	- Consultar por rango de a�os 
*/

CREATE OR ALTER PROCEDURE P_GetEstudentCourseHistory
@Ln_id_student INT,
@Lv_start_year CHAR(4) = NULL,
@Lv_end_year CHAR(4) = NULL
AS
	DECLARE @Lv_status_reprobed CHAR(4) ='R';
	DECLARE @Lv_status_aprobed CHAR(4) ='A';
	DECLARE @Lv_status_suscription CHAR(4) ='M';


	DECLARE c_status_suscriptions CURSOR FOR
	Select id, title
	From cat_suscriptions_status;

	DECLARE @Lv_id_status CHAR(5);
	DECLARE @Lv_title_status VARCHAR(50);

	DECLARE @Lv_student_name VARCHAR(400);
BEGIN
	 
	IF (@Lv_start_year IS NOT NULL AND @Lv_end_year IS NOT NULL) 
	BEGIN
		-- Si el segundo es menor se cambian
		IF ( YEAR(@Lv_start_year) > YEAR(@Lv_end_year) )
		BEGIN
			DECLARE @Lv_elderly_year CHAR(4) = @Lv_start_year;

			SET @Lv_start_year =@Lv_end_year;
			SET @Lv_end_year =@Lv_elderly_year;
		END;
	END;
	
	SET @Lv_student_name = dbo.F_GetCompleteNameUser(@Ln_id_student);
	-- se abre el cursor c_status_suscriptions
	OPEN c_status_suscriptions
	FETCH c_status_suscriptions
	INTO @Lv_id_status, @Lv_title_status;

	PRINT CONCAT('Reporte de historial de cursos del estudiante ',@Lv_student_name, ', del a�o ', @Lv_start_year, ' al ', @Lv_start_year, '.' )

	-- Para cursor c_status_suscriptions
	WHILE @@FETCH_STATUS = 0  
		BEGIN 
			DECLARE @Ln_contador INT = 0;
			PRINT '_________________________________________________________________________'
			PRINT CONCAT('_________________','Cursos ', @Lv_title_status, 's(',TRIM(@Lv_id_status),')','_________________' )

			DECLARE c_courses_student CURSOR FOR
			SELECT
				dbo.F_GetNameCourseFromCourseXCareer(dbo.F_GetCodeCourseByPeriodsCourses(PCS.id_periods_courses)) AS course_name,
				score,
				p.[start_date ],
				p.[end_date]
				--PCS.[status]
			FROM periods_courses_suscriptions  PCS
			Right Join periods_courses PC
				Right Join [periods] P
				On P.id = PC.id_periods
				And (
				-- Si es nula alguna de los dos a�os no se tienen en cuenta
				(@Lv_start_year is null or @Lv_end_year is null)
				 Or
				YEAR( p.[start_date ]) between @Lv_start_year and @Lv_end_year
				Or
				YEAR( p.[end_date]) between @Lv_start_year  and @Lv_end_year
				)
			ON PC.id = PCS.id_periods_courses

			Where student_id = @Ln_id_student
			And PCS.[status] = @Lv_id_status
			Order By  p.[start_date], p.[end_date];

			
			DECLARE @Lv_course_name VARCHAR(400);
			DECLARE @Ln_score VARCHAR(400);
			DECLARE @Ld_start_date DATETIME;
			DECLARE @Ld_end_date DATETIME;

			-- se abre el cursor c_courses_student
			OPEN c_courses_student
			FETCH c_courses_student
			INTO  @Lv_course_name, @Ln_score, @Ld_start_date,@Ld_end_date;

			-- Para cursor c_courses_student
			WHILE @@FETCH_STATUS = 0  
				BEGIN 
					SET @Ln_contador = @Ln_contador+1;
					DECLARE @Lv_fecha VARCHAR(200) ;
					SET @Lv_fecha = CONCAT('[',CONVERT(VARCHAR, @Ld_start_date, 1)  , ' - ', CONVERT(VARCHAR, @Ld_end_date, 1) ,']')

					PRINT  CONCAT(@Lv_student_name, ' - ' , @Lv_course_name ,' - ', @Ln_score ,'. ', @Lv_fecha)
					FETCH c_courses_student
					INTO  @Lv_course_name, @Ln_score, @Ld_start_date,@Ld_end_date;
				END;

			CLOSE c_courses_student  
			DEALLOCATE c_courses_student   


			FETCH c_status_suscriptions
			INTO @Lv_id_status, @Lv_title_status;
			PRINT CONCAT('_________________','Total: ', @Ln_contador,'_________________')
			PRINT ' '
			PRINT ' '
			PRINT ' '
			SET @Ln_contador = 0;
		END
	 
	CLOSE c_status_suscriptions  
	DEALLOCATE c_status_suscriptions   
END;

EXEC P_GetEstudentCourseHistory 21, '2021', '2020';



CREATE OR ALTER PROCEDURE P_GetMissingCourses
@Ln_id_student INT
AS
	DECLARE c_study_plan_suscriptions CURSOR FOR
	Select id_study_plan, 
		SP.[title] AS plan_study_title, 
		SP.[description] as plan_study_description
	From study_plan_suscriptions SPS
	Left Join study_plan SP
		On SP.id = SPS.id_study_plan
	Where SPS.id_student= @Ln_id_student;

	DECLARE @Lv_study_plan_code INT;
	DECLARE @Lv_study_plan_title VARCHAR(200);
	DECLARE @Lv_study_plan_description CHAR(400);

	DECLARE @Lv_student_name VARCHAR(400);
BEGIN  
	SET @Lv_student_name = dbo.F_GetCompleteNameUser(@Ln_id_student);

	OPEN c_study_plan_suscriptions
	FETCH c_study_plan_suscriptions
	INTO @Lv_study_plan_code, @Lv_study_plan_title, @Lv_study_plan_description;


	PRINT CONCAT('Cursos pendientes de ',@Lv_student_name)
	-- Para cursor carrer_suscriptions
	WHILE @@FETCH_STATUS = 0  
		BEGIN
			
			PRINT CONCAT(@Lv_study_plan_code, ' - ', @Lv_study_plan_title)
			


			DECLARE c_cursos_pendiente CURSOR FOR
			Select SPC.course_code AS id_course,
				CCC.code_course,
				CCC.code_course,
				dbo.F_GetNameCourse(code_course) as course_name,
				SPC.credits     --course_code
			From study_plan_courses SPC
			Left Join cat_courses_x_career CCC
			On CCC.id = SPC.course_code
			Where id_study_plan = @Lv_study_plan_code
			And course_code NOT IN (
				Select PC.code_course
				From periods_courses_suscriptions PCS
				Left Join periods_courses PC
				On PC.id  = PCS.id_periods_courses
				Where  PCS.[status] = 'A'
				And PCS.[student_id] = @Ln_id_student
			)
			Order by SPC.[block], SPC.[order];

			DECLARE @Ln_course_id INT;
			DECLARE @Ln_course_code char(10);
			DECLARE @Ln_career_code char(10);
			DECLARE @Lv_course_name VARCHAR(400);
			DECLARE @Lv_course_credits INT;

			DECLARE @Ln_contador INT = 0;

			OPEN c_cursos_pendiente
			FETCH c_cursos_pendiente
			INTO @Ln_course_id, @Ln_course_code,@Ln_career_code, @Lv_course_name, @Lv_course_credits;

			-- Para cursor c_cursos_pendiente
			WHILE @@FETCH_STATUS = 0
				BEGIN 
					SET @Ln_contador = @Ln_contador +1;
					PRINT CONCAT(CHAR(9), @Lv_course_name, ' creditos necesarios: ', @Lv_course_credits)
					FETCH c_cursos_pendiente
					INTO @Ln_course_id, @Ln_course_code,@Ln_career_code, @Lv_course_name, @Lv_course_credits;
				END
			
			CLOSE c_cursos_pendiente  
			DEALLOCATE c_cursos_pendiente 

			PRINT '__________________________'
			PRINT CONCAT('Un total de ',@Ln_contador,' curso(s) pendiente(s) para ',@Lv_course_name,'.')
			PRINT '__________________________'

			SET @Ln_contador= 0
			FETCH c_study_plan_suscriptions
			INTO @Lv_study_plan_code, @Lv_study_plan_title, @Lv_study_plan_description;
		END


	CLOSE c_study_plan_suscriptions  
	DEALLOCATE c_study_plan_suscriptions 
END;


EXEC P_GetMissingCourses 21;
 