#Java Servlet web dev Project

---

## Descripcion del proyecto
Este proyecto fue realizado para el curso de bases de datos
de la universidad de chile, consiste en una aplicacion web para 
consultar datos recolectados de partidas profesionales del
videojuego Counter Strike Global Offensive, datos sacados de
[Kaggle](https://www.kaggle.com/mateusdmachado/csgo-professional-matches?select=players.csv).

## Creacion de la base de datos
Haciendo uso del programa Xammp iniciamos el servidor local con las opciones Apache y MySql,
teniendo eso entramos a ```http://localhost/phpmyadmin/``` desde algun navegador
podemos empezar a crear la base de datos, para eso corremos los
comandos sql, dentro del esquema que mejor le parezca, encontrados en la carpeta sql dentro de ```src/main/webapp```, aqui encontramos
archivos sql que debemos correr en el servidor local en este orden. Primero 
players.sql (en caso de no poder ejecutarlo por su peso usar players.sql.zip), luego 
results.sql y finalmente JavaServlet.sql

## Uso de la aplicacion
Una vez correctamente creada la base de datos podemos ejecutar el proyecto, este hace uso de Tomcat 10.0.6 y fue 
desarrollado en Intellij. Una vez ejecutado el proyecto se abrira en la pestaña de su navegador, donde podra ejecutar
las consultas prediseñadas para sacar partido a la base de datos que inspira el proyecto

## Explicacion base de datos
Dentro de los datos originales encontraremos cerca de 300mil tuplas por lo que
,despues de crear las tablas players y results, las instrucciones en JavaServlet.sql
se encargaran de estructurar correctamente el diseño dentro del esquema, creando tablas auxiliares (matches y events),
indices, constraints de llaves primarias y foraneas, y vistas necesarias para tener un optimo funcionamiento de la
aplicacion web.

