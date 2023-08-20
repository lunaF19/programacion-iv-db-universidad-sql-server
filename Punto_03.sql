/*
	Reporte de profesores por curso. Utilizar Cursor
		Se desea conocer de un profesor: Los cursos que ha impartido en la historia, 
		su antigüedad como profesor y un promedio de sus evaluaciones de desempeño.
		
		Consultar por rango de años.
*/


CREATE OR ALTER PROCEDURE P_GetTeacherHistory
@Ln_id_teacher INT,
@Lv_start_year CHAR(4) = NULL,
@Lv_end_year CHAR(4) = NULL
AS
	
	

	DECLARE c_evaluations CURSOR FOR
	Select  
		PE.id, 
		PE.id_user, 
		PE.[start_date],
		PE.[end_date], 
		PE.reason, 
		AVG(PED.score) As Score,
		COUNT(1) as TotalReviews
	From [performance_evaluation] PE
	Left Join  [performance_evaluation_details] PED
	On PED.id_performance_evaluation = PE.ID
	Where PE.id_user = @Ln_id_teacher
	Group By PE.id, PE.id_user,PE.[start_date],PE.[end_date], PE.reason;

	DECLARE @Lv_code_course CHAR(10);
	DECLARE @Lv_course_name VARCHAR(100);
	DECLARE @Lv_course_description VARCHAR(200);

	DECLARE @Ld_last_date_curse DATETIME;
	DECLARE @Ld_first_date_curse DATETIME;
	DECLARE @Ln_name_teacher VARCHAR(400);
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


	-- Cursor recupera los cursos impartidos por el profesor
	DECLARE c_courses_teacher CURSOR FOR
	Select 
		--PC.id_teacher, 
		CC.code, 
		CC.[name], 
		CC.[description]
	From periods_courses PC
	Left Join [periods] P
	On P.id = PC.id_periods
	Left Join cat_courses_x_career CCC
		Left Join cat_courses CC
		On CC.code = CCC.code_course
	On CCC.id = PC.code_course
	Where PC.id_teacher = @Ln_id_teacher
	And (
		-- Si es nula alguna de los dos años no se tienen en cuenta
		(@Lv_start_year is null or @Lv_end_year is null)
			Or
		YEAR( p.[start_date ]) between @Lv_start_year and @Lv_end_year
		Or
		YEAR( p.[end_date]) between @Lv_start_year  and @Lv_end_year
		)
	Group By  PC.id_teacher , CC.code, CC.[name], CC.[description];

	SET @Ln_name_teacher = dbo.F_GetCompleteNameUser(@Ln_id_teacher);
	Select 
		@Ld_first_date_curse = MIN(P.[start_date ]),
		@Ld_last_date_curse = MAX(P.[start_date ])
	From periods_courses PC
	Left Join [periods] P
		On P.id = PC.id_periods
	Where PC.id_teacher = @Ln_id_teacher;

	PRINT CONCAT('Reporte de historia del profesor ',@Ln_name_teacher, ', del año ', @Lv_start_year, ' al ', @Lv_start_year, '.' )
	PRINT CONCAT('El primer curso que impartio fue en  ',CONVERT(VARCHAR, @Ld_first_date_curse, 1) )
	PRINT CONCAT('El ultimo curso impartido fue en ',CONVERT(VARCHAR, @Ld_last_date_curse, 1) )
	 
	OPEN c_courses_teacher  
	FETCH c_courses_teacher
	INTO  @Lv_code_course , @Lv_course_name , @Lv_course_description; 

	BEGIN
		DECLARE @Ln_contador_cursos INT =0;
		PRINT 'Cursos que ha impartido:'
		-- Para cursor c_courses_teacher
		WHILE @@FETCH_STATUS = 0  
			BEGIN 
				PRINT CONCAT(CHAR(9),'(',trim(@Lv_code_course),')' ,' ', @Lv_course_name )
				FETCH c_courses_teacher
				INTO  @Lv_code_course , @Lv_course_name , @Lv_course_description; 
				SET @Ln_contador_cursos= @Ln_contador_cursos +1;
			END
			PRINT CONCAT('Total de cursos impartidos: ',@Ln_contador_cursos)
			PRINT '____________________'
		CLOSE c_courses_teacher  
		DEALLOCATE c_courses_teacher   
	END

	BEGIN
		DECLARE @Ln_id_evalation INT;
		DECLARE @Ln_id_user_evalation INT;
		DECLARE	@Ln_start_date_evaluation DATETIME;
		DECLARE	@Ln_end_date_evaluation DATETIME;
		DECLARE	@Lv_reason_evaluation VARCHAR(2100);
		DECLARE @Ln_score_evaluation INT;
		DECLARE @Ln_total_reviews_evaluation INT;

		PRINT 'Datos sobre evaluaciones:'
		OPEN c_evaluations;
		FETCH c_evaluations
		INTO @Ln_id_evalation,
			@Ln_id_user_evalation,
			@Ln_start_date_evaluation,
			@Ln_end_date_evaluation,
			@Lv_reason_evaluation,
			@Ln_score_evaluation,
			@Ln_total_reviews_evaluation;
	
		-- Para cursor c_evaluations
		WHILE @@FETCH_STATUS = 0  
		BEGIN

			PRINT CONCAT(CHAR(9),'Evaluación #',@Ln_id_evalation)
			PRINT CONCAT(CHAR(9),'Habilitada desde ',CONVERT(VARCHAR, @Ln_start_date_evaluation, 1), ' hasta ', CONVERT(VARCHAR, @Ln_start_date_evaluation, 1), '.')
			PRINT CONCAT(CHAR(9),'Puntuación: ',@Ln_score_evaluation)
			PRINT CONCAT(CHAR(9),'Total de evalaciones: ', @Ln_total_reviews_evaluation)

			PRINT CONCAT(CHAR(9),'Razón: ',@Lv_reason_evaluation)
			PRINT '_____________________________________'

			FETCH c_evaluations
			INTO @Ln_id_evalation,
				@Ln_id_user_evalation,
				@Ln_start_date_evaluation,
				@Ln_end_date_evaluation,
				@Lv_reason_evaluation,
				@Ln_score_evaluation,
				@Ln_total_reviews_evaluation;
		END;

		CLOSE c_evaluations  
		DEALLOCATE c_evaluations  

	END;
	
END;

EXEC P_GetTeacherHistory 21;
EXEC P_GetTeacherHistory 21, '2019', '2022';

 