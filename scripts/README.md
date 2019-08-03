#Instrucciones

Aqui colocar los scripts en anteponiendoles un numero para el orden de ejecucion.

Los scrips de inicializacion son ejecutados en orden alphabetico o numerico. Asegurate de que la dependencia entre scripts este protegida por esta numenclatura.

Ejemplo:

	scripts/0-init.sql
	scripts/1-PS_20190801131950_STRUCTURE.sql
	scripts/2-PS_20190801131950_ROUTINES.sql
	scripts/3-PS_20190801131950_DATA.sql


##NOTAS

- El script **scripts/0-init.sql** es imprescindible. NUNCA LO BORRES
- No dejes en este directorios archivos pesados ya que ademas de que siempre son actualizados, embasuras el repo.
- Ante la duda pregunta.