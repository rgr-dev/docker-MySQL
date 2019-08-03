
# Base de Datos Mysql Dockerizada

Herramienta para la creacion de un contenedor docker con una Base de Datos Mysql. El objetivo de esta herramienta es poder contar con una base de datos local lista para desplegarse en casos de contingencia.

# Instrucciones de uso:
Si ya tienes Docker y docker-compose ve directo al paso **3**.
Si quieres ejecutar la herramienta y ya tienes la Base de Datos pre-cargada ve al paso **6**.

 1. Instalar Docker y docker compose. Para instalar docker y docker-compose ejecuta:
```sh
        $ cd SETUP
        $ ./FullDockerInstall.sh
```
 2. Si el proceso termina satisfactoriamente continua al paso 3, de lo contrario puedes visitar la pagina de documentacion de Docker y docker-compose, ó puedes llamar a un amigo.

 3. Para instalacion de bases de datos nuevas o para actualizaciones primero debes copiar los archivos .sql que quieras que se ejecuten y en el orden que quieres que se ejecuten el el directorio **scripts/**. Para asegurar el orden debes anteponer un numero en cada uno de los archivos segun el orden en el que quieras que se ejecuten.
 4. Una vez enumerados los .sql y copiados en el directorio **scripts/** se ejecuta el siguiente .sh:
```sh
        $ ./cleanStart.sh
        WARNING! This will remove all local volumes not used by at least one container.
	Are you sure you want to continue? [y/N] y
	Total reclaimed space: 0B
	Creating network "docker-mysql_default" with the default driver
	Creating test-mysql ... done
	The IP of MySQL Database is : 192.168.224.2

```
 5. Como pueden ver, luego de ejecutar el .sh se nos imprimen algunos mensajes informativos en consola, entre ellos el ip de la BD a la que debemos conectarnos. Al usar este comando, cuando inicia la Base de Datos se ejecutan los .sql que colocamos en el directorio **scripts/** y se genera la estructura de archivos necesaria para MySQL en el directorio **datadir/**.

 6.  Si ya habias ejecutado los primeros 5 pasos anteriormente entonces solo debes ejecutar el .sh:
```sh
        $ ./start.sh
```
 7.  El **start.sh** ignora el directorio **scripts/** de manera que no se ejecuta ningun .sql al inicio de la base de datos y trabaja con el contenido existente en el directorio **datadir/**.
 
 8. Para detener la Base de Datos ejecutar:
 ```sh
        $ ./stop.sh
```


## Datos para la conexión y administración de la Base de Datos.
Usuario root = **root**
Usuario dev = **developer**
Contraseña para ambos usuarios = **nemonemo**

### Notas finales.
- Asegurarse seimpre de detener los contenedores ejecutando el archivo **stop.sh**.
- Cualquier cambio o modificacion es bienvenido siempre y cuando sea testeado primero. Recordemos que esta herramienta es para contingencia y si falla....
- Cualquier error en mi ortografia mil disculpas.