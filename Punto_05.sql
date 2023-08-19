/*
	Un alumno no puede matricular mas de 4 cursos por periodo
*/

CREATE or ALTER TRIGGER TR01_MaxSuscriptionsStudent
ON periods_courses_suscriptions
FOR Insert 
AS 
	DECLARE @Ln_id_suscription INT;
	DECLARE @Ln_num_suscriptions INT;
	DECLARE @Ln_id_student INT;
	DECLARE @Ln_id_periods_courses INT;
	DECLARE @Ln_id_periods INT;

	DECLARE @Ln_max_suscriptions INT = 4;
BEGIN

	SELECT 
		@Ln_id_suscription = id,
		@Ln_id_periods_courses  = id_periods_courses,
		@Ln_id_student = student_id
	From inserted;


	SET @Ln_id_periods =  [dbo].F_GetIdPeriodOfSuscription(@Ln_id_suscription);

	SET  @Ln_num_suscriptions = [dbo].F_TotalSuscriptionByPeriod(@Ln_id_periods, @Ln_id_student);

	IF ( @Ln_num_suscriptions> @Ln_max_suscriptions )
	BEGIN
		DECLARE @Lv_message_error VARCHAR(200);
		SET @Lv_message_error = CONCAT('El estudiante ya cuenta con ',@Ln_max_suscriptions,' de ', @Ln_max_suscriptions, ' suscripciones.');

		RAISERROR (@Lv_message_error, -- Message text.
		15, -- Severity,
		1 -- State
		); 
		ROLLBACK TRANSACTION;
	END;
 
END;

/*
	Un profesor no puede impartir mas de 6 cursos por periodo
*/


CREATE or ALTER TRIGGER TR01_MaxSuscriptionsTeacher
ON periods_courses
FOR Insert
AS  
	DECLARE @Ln_num_suscriptions INT;
	DECLARE @Ln_id_teacher INT; 
	DECLARE @Ln_id_periods INT;

	DECLARE @Ln_max_suscriptions INT = 6;
BEGIN

	SELECT 
		@Ln_id_periods = id_periods, 
		@Ln_id_teacher = id_teacher
	From inserted;

	SET  @Ln_num_suscriptions = [dbo].F_TotalSuscriptionByPeriodTeacher(@Ln_id_periods, @Ln_id_teacher);

	IF ( @Ln_num_suscriptions> @Ln_max_suscriptions )
	BEGIN
		DECLARE @Lv_message_error VARCHAR(200);
		SET @Lv_message_error = CONCAT('El profesor ya cuenta con ',@Ln_max_suscriptions,' de ', @Ln_max_suscriptions, ' suscripciones.');

		RAISERROR (@Lv_message_error, -- Message text.
		15, -- Severity,
		1 -- State
		); 
		ROLLBACK TRANSACTION;
	END;
 
END;