/*
	Reporte de plan de estudios por carrera (curso en una carrera y su división por periodo) Utilizar Cursor
		Se desea conocer el plan de estudios de una carrera (cursos por carrera agrupado por periodo)
*/


CREATE OR ALTER PROCEDURE P_ReportStudyPlan
	@Ln_study_plan CHAR(10)
AS 
	DECLARE c_study_plan_courses CURSOR FOR
	Select id_study_plan, course_code, credits, [block], [order]
	From study_plan_courses
	Where id_study_plan = @Ln_study_plan
	Order By [block], [order];

	DECLARE @Ln_id_period INT;
	DECLARE @Ln_id_periods_courses INT;

	-- Vars for cursor c_study_plan_courses
	DECLARE @Ln_id_study_plan INT;
	DECLARE @Ln_course_code INT;
	DECLARE @Ln_credits INT;
	DECLARE @Ln_block INT;
	DECLARE @Ln_order INT;

	DECLARE @Ln_last_block INT = NULL;

	DECLARE @Lv_title_plan VARCHAR(200);
	DECLARE @Lv_description_plan VARCHAR(400);

	
BEGIN 

	OPEN c_study_plan_courses
	FETCH c_study_plan_courses
	INTO @Ln_id_study_plan, @Ln_course_code, @Ln_credits, @Ln_block, @Ln_order;


	Select 
		@Lv_title_plan = title,
		@Lv_description_plan = [description]
	From study_plan
	Where id = @Ln_study_plan;

	PRINT CONCAT('**** ' ,@Lv_title_plan, ' ****')
	PRINT '_______________________________'
	PRINT @Lv_description_plan; 

	WHILE @@FETCH_STATUS = 0  
		BEGIN
			DECLARE	@Lv_message_course VARCHAR(200);

			SET @Lv_message_course = CONCAT('|	Curso(',@Ln_course_code , ') ', dbo.F_GetNameCourseFromCourseXCareer(@Ln_course_code), ', creditos necesarios: ', @Ln_credits);

			--PRINT CONCAT(@Ln_last_block,' - ' ,@Ln_block)
			IF (@Ln_last_block IS NULL OR @Ln_last_block <> @Ln_block)
			BEGIN
				PRINT '_______________________________'
				PRINT CONCAT( '*** BLOQUE #',@Ln_block, ' ***')
				SET @Ln_last_block = @Ln_block;
			END;

			PRINT @Lv_message_course;

			FETCH c_study_plan_courses
			INTO @Ln_id_study_plan, @Ln_course_code, @Ln_credits, @Ln_block, @Ln_order;
		END;

	CLOSE c_study_plan_courses  
    DEALLOCATE c_study_plan_courses  
END;


exec P_ReportStudyPlan 1;