# Proyecto para curso Programación IV - Base de datos para Universidad

El objetivo de la base de datos es gestionar eficientemente la información académica de una institución educativa, proporcionando una estructura que permita almacenar, relacionar y consultar los datos de categorías académicas, carreras, planes de estudio, periodos, estudiantes, profesores y sus respectivas evaluaciones. La base de datos permitirá rastrear y consultar la historia académica tanto de estudiantes como de profesores, generando informes que incluyan el progreso de los estudiantes en sus cursos, así como el desempeño docente a lo largo de los años. Además, se implementarán restricciones para asegurar que los estudiantes no matriculen más de 4 cursos por periodo y que los profesores no impartan más de 6 cursos por periodo.

El sistema permitirá consultas detalladas a través de cursores, facilitando la generación de reportes por rango de años para estudiantes, profesores y planes de estudio, con el fin de obtener un panorama completo del rendimiento académico y docente. 

## Requerimientos

### La estructura de bases de datos debe permitir almacenar y relacionar

- Categoría académica (Bachillerato, Licenciatura, Postgrados, Cursos Libres, Diplomas)
- Carreras 
- Plan de estudio: Cursos 
- Periodos: Cuatrimestres / Trimestres / Bimestres
- Estudiantes / Cursos / Notas
- Profesores / Cursos / Evaluación de desempeño
- Todas las entidades deben almacenar su historia correspondiente.

### Reporte de estudiante por curso. 

- **Se debe utilizar cursor**
- Se desea conocer de un estudiante: Los cursos que ha matriculado en la historia, los cursos que ha aprobado y reprobado, 
  las notas y los cursos pendientes que le faltan para concluir el plan.
- Consultar por rango de años

### Reporte de profesores por curso.

- **Se debe utilizar cursor**
- Se desea conocer de un profesor: Los cursos que ha impartido en la historia, 
su antigüedad como profesor y un promedio de sus evaluaciones de desempeño.
- Consultar por rango de años.

### Reporte de plan de estudios por carrera (curso en una carrera y su división por periodo)
- **Se debe utilizar cursor**
- Se desea conocer el plan de estudios de una carrera (cursos por carrera agrupado por periodo)

### Restricciones
- Un alumno no puede matricular más de 4 cursos por periodo
- Un profesor no puede impartir mas de 6 cursos por periodo


### Nota de un curso por estudiante por periodo
- Nota estudiante por periodo
- Promedio del estudiante
