/*
	Nota de un curso por estudiante por periodo
*/

CREATE OR ALTER FUNCTION F_AverageScoreStudentByPeriod( @Ln_id_period INT, @Ln_id_student INT) 
RETURNS DECIMAL
AS  
BEGIN
	DECLARE @Ln_promedio DECIMAL;

	Select @Ln_promedio = sum(score)/count(1)-- AVG(PCS.score)
	From [periods] P
		Right Join periods_courses PC
		 Right Join periods_courses_suscriptions PCS
		 On PCS.id_periods_courses = PC.id
		 And PCS.student_id = @Ln_id_student
		On PC.id_periods = P.id
	Where P.id = @Ln_id_period;

	RETURN ISNULL(@Ln_promedio,0);

END;

SELECT [dbo].F_AverageScoreStudentByPeriod(1,28);


/*
	Promedio de notas por alumno
*/

CREATE OR ALTER FUNCTION F_AverageScoreStudent( @Ln_id_student INT) 
RETURNS DECIMAL
AS  
BEGIN
	DECLARE @Ln_promedio DECIMAL;

	Select @Ln_promedio = sum(score)/count(1) --  @Ln_DECIMAL = AVG(score)
	From periods_courses_suscriptions
	Where student_id = @Ln_id_student;

	RETURN ISNULL(@Ln_promedio,0);
END;

SELECT [dbo].F_AverageScoreStudent(6);