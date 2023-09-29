-- Esta Query fue realizada en base al Bootcamp de Colt Steele de Udemy para MySQL
-- Para cualquier diferencia en sintaxis o funcionalidad de comandos por favor referirse a los docs de su DBMS o CHATGPT

-- Tipos de Datos

-- Crear BDD Data Types
CREATE DATABASE datatypes;
USE datatypes;

-- Char VS Varchar

-- CHAR
CREATE TABLE char_ejemplo (CodDep CHAR(3));
INSERT INTO char_ejemplo(CodDep) VALUES ('PAY'),('MVD'),('CAN'),('TAC'),('ART');
-- CHAR presenta un limite de caracteres establecidos, si a la linea se le adjudican 3 caracteres maximos debe tenerlos, y, en caso de que no se completen, el gestor los rellena con espacios vacios
-- En memoria ocupa un byte fijo por caracter asignado al CHAR, sin importar la cantidad de informacion ingresada a la linea el tamaño de la misma se mantiene, en este caso sera 3 Bytes

-- VARCHAR
CREATE TABLE varchar_ejemplo(nombres VARCHAR(10));
INSERT INTO varchar_ejemplo(nombres) VALUES ('Jose'),('Pedro'),('Tomas');
-- VARCHAR presenta un limite de caracteres establecidos pero la posibilidad de contar con una longitud variable, la linea puede tener 10 posibles caracteres totales, pero en caso de ingresar 5
-- la linea solamente almacenara esos 5 sin rellenar los espacios vacios
-- En memoria ocupa uno o dos bytes en memoria para el almacenamiento y despues un byte por caracter. En el caso de Tomas, son 5 caracteres mas 1 o 2 de almacenamiento, dando un total de 6-7 bytes en memoria

-- Numeric

TINYINT: -- Ocupa en memoria un byte. Máximo valor firmado: 127, Mínimo valor firmado: -128. Máximo valor sin firmar: 255, Mínimo valor sin firmar: 0.
SMALLINT: -- Ocupa en memoria dos bytes. Máximo valor firmado: 32,767, Mínimo valor firmado: -32,768. Máximo valor sin firmar: 65,535, Mínimo valor sin firmar: 0.
MEDIUMINT: -- Ocupa en memoria tres bytes. Máximo valor firmado: 8,388,607, Mínimo valor firmado: -8,388,608. Máximo valor sin firmar: 16,777,215, Mínimo valor sin firmar: 0.
INT: -- Ocupa en memoria cuatro bytes. Máximo valor firmado: 2,147,483,647, Mínimo valor firmado: -2,147,483,648. Máximo valor sin firmar: 4,294,967,295, Mínimo valor sin firmar: 0.
BIGINT: -- Ocupa en memoria ocho bytes. Máximo valor firmado: 9,223,372,036,854,775,807, Mínimo valor firmado: -9,223,372,036,854,775,808. Máximo valor sin firmar: 18,446,744,073,709,551,615, Mínimo valor sin firmar: 0.

-- Decimal

CREATE TABLE decimal_ejemplo(edadint INT, edaddec DECIMAL(5,2)); -- (5 -> Representa la cantidad de numeros antes de la coma que pueden haber, ,2 -> Representa la cantidad de numeros posteriores a la coma que pueden haber
INSERT INTO decimal_ejemplo(edadint) VALUES (1.5),(1.2); -- Cuando se ingresa un valor decimal a un INT automaticamente se redondea al valor entero mas proximo
SELECT * FROM decimal_ejemplo;
INSERT INTO decimal_ejemplo(edaddec) VALUES (1.5),(1.2);
SELECT edaddec AS Decimales, edadint AS Enteros FROM decimal_ejemplo; 

-- Float y Double
-- Permiten almacenar numeros mas grandes en menos espacio a expensas de la precision de los mismos 

-- Float necesita 4bytes en memoria y comienza a tener problemas de precision cerca del 7mo digito
-- Double necesita 8bytes en memoria y comienza a tener problemas de precision cerca del 15to digito

CREATE TABLE FloatyDouble(valorfloat FLOAT, valordouble DOUBLE);
INSERT INTO FloatyDouble(valorfloat,valordouble) VALUES (1.123,1.123);
SELECT * FROM FloatyDouble; -- Por ahora se almacenan sin errores, porque respetamos la cantidad de digitos en el margen de error
-- Entonces vamos a romperlos un poco :)
INSERT INTO FloatyDouble(valorfloat,valordouble) VALUES (1.123456789,1.123456789101112131415161718);
SELECT * FROM FloatyDouble;
-- Que paso?? Bueno, llegamos a los limites de precision para ambos tipos de datos y perdimos precision :(
-- Entonces, cuando usamos FLOAT y DOUBLE? Principalmente cuando necesitamos que las respuestas sean mas veloces que precisas, aprovechando que ocupan menos espacio en memoria.

-- Date y Time

-- Date almacena una fecha en el siguiente formato 'YYYY-MM-DD'
-- Time puede representar la hora de un dia o un intervalo de tiempo en el siguiente formato 'HH:MM:SS'
-- DateTime es la combinacion de ambos y se almacena en el siguiente formato 'YYYY-MM-DD HH:MM:SS' (RESPETAR EL ESPACIO)

-- CURDATE, CURTIME y NOW

-- Vamos a probarlos :D
SELECT CURTIME();
SELECT CURDATE();
SELECT NOW();
-- Increible no? :O Bueno creo que esto explica basicamente la funcionalidad de cada uno, se encargan de brindar fecha y hora (o una combinacion de ambas) que coincidan con la de tu sistema
-- Para que puede servirnos esto? Sobretodo para el ingreso de datos en tiempo real, cuando tenes que crear un log o un historial.

CREATE TABLE currenttimestamps( nombre VARCHAR(100), fechanacimiento DATE, horanacimiento TIME, fechayhoranacimiento DATETIME);
INSERT INTO currenttimestamps(nombre, fechanacimiento, horanacimiento, fechayhoranacimiento) VALUES ('Pedrito', 
CURDATE(), CURTIME(), NOW());
SELECT * FROM currenttimestamps;
-- Y que hicimos aca? Felicitaciones acabas de registrar un recien nacido :), utilizaste la informacion de tu sistema como fecha y hora para almacenarla en tu base de datos, sin la necesidad de hacerlo manualmente.

-- Date y Time Functions
-- O resumido: Como complicar algo tan sencillo como una fecha y una hora D:
-- Bueno ahora sin hacernos los graciosos.
-- Las date functions se utilizan para obtener o asignar datos como por ejemplo: El dia 28/09/2023 tenemos que es un jueves, de septiembre.
-- En criollo, en lugar del numerito encontramos el dia o el mes que corresponde a esa fecha.

-- Vamos a utilizar la tabla que creamos antes para esta parte
SELECT fechanacimiento, DAY(fechanacimiento) FROM currenttimestamps; -- Lo que hacemos con DAY en este caso es aislar el dia de toda la string fechanacimiento
SELECT fechanacimiento, DAYOFWEEK(fechanacimiento) FROM currenttimestamps; 
-- DAYOFWEEK devuelve el dia de la fecha basado en lo siguiente:
-- 1: Domingo 2: Lunes 3: Martes ... hasta llegar a 7: Sabado 
-- Ahora, que pasa si por ejemplo queremos saber el numero de dias que pasaron desde el comienzo del año hasta una fecha especifica, bueno para eso usamos lo siguiente
SELECT fechanacimiento, DAYOFYEAR(fechanacimiento) FROM currenttimestamps; 
-- Que nos esta diciendo esto? Bueno en mi caso me da el resultado 271 porque pasaron 271 dias desde el primero de enero, viste? Es facil :D
-- Ahora que otras cosas podemos ver? Bueno, probemos con meses
SELECT fechanacimiento, MONTHNAME(fechanacimiento) FROM currenttimestamps; 
-- Y que pasa aca? Bueno, simplemente vamos a encontrar el nombre del mes de nuestra fecha
-- Ahora por ultimo, veamos el año
SELECT fechanacimiento, YEAR(fechanacimiento) FROM currenttimestamps; 
-- Pero que pasa si queremos irnos mas profundo, veamos una semana.
SELECT fechanacimiento, WEEK(fechanacimiento) FROM currenttimestamps; 
-- En mi caso la semana equivalente al 2023-09-28 es la numero 39, la tuya va a ser diferente seguramente.
-- PERO tene en cuenta de que esto se encarga de devolverte la semana en la cual te encontras contando desde el principio del año y no del mes.

-- Ahora veamos horarios tambien!
SELECT horanacimiento, HOUR(horanacimiento) FROM currenttimestamps; 
-- Esto se encarga de aislar solamente la hora de la string horanacimiento
-- Lo mismo con minutos y segundos
SELECT horanacimiento, MINUTE(horanacimiento) FROM currenttimestamps; 
SELECT horanacimiento, SECOND(horanacimiento) FROM currenttimestamps; 

-- Unos extra y seguimos :p 
-- Podemos aislar los datos DATE y TIME de un DATETIME de la siguiente forma
SELECT fechayhoranacimiento, DATE(fechayhoranacimiento), TIME(fechayhoranacimiento) FROM currenttimestamps;
-- Como pueden observar si hicieron todo bien hasta aca se aislan las fechas y las horas de fechayhoranacimiento. 

-- Formato de Fechas

-- Que pasa si queremos ver nuestra fecha en un formato diferente, podemos hacerlo? La respuesta es si, dejame explicarte como :) 

-- Empecemos aplicando lo que aprendimos hasta ahora:
SELECT MONTHNAME(fechanacimiento), DAY(fechanacimiento), YEAR(fechanacimiento) FROM currenttimestamps;
-- Lo que hicimos fue simplemente extraer el mes con MONTHNAME, el dia con DAY y el año con YEAR 
-- Pero esto no es una fecha, son 3 columnas D:
-- Bueno ansioso espera que te explico, tenemos que darle el formato nosotros, y como hacemos eso? Usamos la funcion CONCAT()
SELECT CONCAT(MONTHNAME(fechanacimiento), DAY(fechanacimiento), YEAR(fechanacimiento)) AS FechaFormateada FROM currenttimestamps;
-- Ya casi! Bueno lo que probablemente vas a ver aca es que nuestra fecha esta relativamente bien pero esta toda junta, no tiene espacios, por que?
-- Esto se debe a que al concatenar valores los espacios entre los mismos deben asignarse manualmente, debemos recordar que ' ' es un caracter mas, asi como lo es para CHAR, en esto tambien
-- Entonces como quedaria con los espacios entre valores? Asi
SELECT CONCAT(MONTHNAME(fechanacimiento), ' ', DAY(fechanacimiento), ' ', YEAR(fechanacimiento)) AS FechaFormateada FROM currenttimestamps;
-- Felicitaciones! Aprendiste a formatear y concatenar una fecha :D, recorda que podes separarla con otros caracteres no solo un espacio, ejemplo:
SELECT CONCAT(MONTHNAME(fechanacimiento), '-', DAY(fechanacimiento), '-', YEAR(fechanacimiento)) AS FechaFormateada FROM currenttimestamps;
-- O 
SELECT CONCAT(MONTHNAME(fechanacimiento), '/', DAY(fechanacimiento), '/', YEAR(fechanacimiento)) AS FechaFormateada FROM currenttimestamps;
-- Siempre tenes que recordar que tu separador o lo que quieras poner entre medio de tus valores en un concat debe ir entre comillas SIMPLES.

-- Bueno se que ahora pensaras, que esto ya esta y que terminamos, pero no, si, tu fecha tiene otro formato, pero hay una forma mas simple de resolver esto
-- Ademas esto era una manera de que tambien aprendieras a usar el operador CONCAT() :D

-- Ahora si, a formatear.

SELECT fechanacimiento, DATE_FORMAT(fechanacimiento, '%b') FROM currenttimestamps;
-- Que hicimos aca? Bueno, para resumir dentro de DATEFORMAT seleccionamos la columna fechadenacimiento y '%b', este ultimo lo que hace es 
-- devolver una abreviacion de 3 caracteres del mes presente en la fecha que proporcionamos, en este caso para el 2023-09-28 nos devolvera SEP
SELECT fechanacimiento, DATE_FORMAT(fechanacimiento, '%W') FROM currenttimestamps;
-- Ahora con el dia de la semana
SELECT fechanacimiento, DATE_FORMAT(fechanacimiento, '%a') FROM currenttimestamps;
-- Tambien dia de la semana pero abreviado
-- Podes encontrar cada uno de los % en los documentos de tu DBMS (Esto se hizo en MySQL, para SQL Server referirse a los documentos correspondientes)
-- Sigamos, te preguntaras, podemos tener mas % dentro de DATE_FORMAT? Si, te muestro
SELECT fechanacimiento, DATE_FORMAT(fechanacimiento, '%a %W') FROM currenttimestamps;
-- Que hicimos aca? Simplemente tenemos %a que corresponde a el dia de la semana abreviado y %W que corresponde al dia de la semana completo
-- Pero tambien podemos separarlos de otra manera
SELECT fechanacimiento, DATE_FORMAT(fechanacimiento, '%a,%W') FROM currenttimestamps;
-- Viste que ahora aparece una coma? Bueno, en esto '%a,%W' la coma funciona como separador y se va a mostrar al ejecutar la query
-- Probemos otro separador para que quede mas claro
SELECT fechanacimiento, DATE_FORMAT(fechanacimiento, '%a-%W') FROM currenttimestamps;
-- En lugar de una coma tenemos un guion, y funciona, sin la necesidad de usar concat.
-- Entonces ahora por fin, hagamos una fecha completa y formateada
SELECT fechanacimiento, DATE_FORMAT(fechanacimiento, '%W %d Of %M %Y') FROM currenttimestamps;
-- Que hicimos aca? Formateamos una fecha y la escribimos de tal forma que pareciera un textito recitado de cuando te toca decir la fecha en ingles 

-- Matematicas con Fechas
-- Si, matematicas. Se que suena feo pero es bastante sencillo, te muestro

SELECT fechanacimiento FROM currenttimestamps;
-- Ahora supongamos que queremos ver la diferencia de dias entre nuestra fecha actual y las que tenemos almacenadas en nuestra tabla
SELECT DATEDIFF(CURDATE(),fechanacimiento) FROM currenttimestamps;
-- Como podes ver nos va a devolver un numero que representa la cantidad de dias que pasaron desde que se genero el registro 
-- Bueno ahora a complicarla mas 
SELECT DATE_FORMAT(CURDATE(), '%W %d Of %M %Y');
-- Empecemos con la fecha de hoy, supongamos que a nuestra fecha queremos agregarle (por alguna extraña razon un dia), podemos!
SELECT DATE_ADD(curdate(), INTERVAL 1 DAY);
-- Que hace esto? Agrega un dia a nuestra fecha actual, tambien podemos hacerlo con fechas pasadas, agregandolas manualmente o desde una tabla exportando los datos
SELECT DATE_ADD(curdate(), INTERVAL 1 YEAR);
-- Ahora sumamos un año :D
-- Pero tambien podemos substraer 
SELECT DATE_SUB(curdate(), INTERVAL 1 DAY);
-- Quitamos un dia a nuestra fecha de hoy
SELECT DATE_SUB(curdate(), INTERVAL 1 YEAR);
-- Quitamos un año a nuestra fecha de hoy
-- Antes de terminar probemos algo
-- Queremos saber cuando pedrito va a tener 18 años, entonces lo que podemos hacer es lo siguiente
SELECT nombre, fechanacimiento AS Nacimiento, DATE_ADD(fechanacimiento, INTERVAL 18 YEAR) AS 'Pacientes 18 years later' FROM currenttimestamps;
-- Este es un ejemplo muy basico, pero creo que explica bastante bien las posibles funcionalidades de los ADD y SUB en DATE

-- Bueno y que pasa con la hora, podemos hacer lo mismo? Si
SELECT CURTIME();
-- Supongamos que queres saber hace cuantas horas te levantaste, hacemos esto
SELECT TIMEDIFF(CURTIME(), '07:34:00'); -- En mi caso me levante a las 7 y 30, entonces veamos que diferencia me da
-- Podes cambiar mi dato por el tuyo para aprovechar y practicar los formatos 
-- Esto me da como resultado que me desperte hace 01:42:27.
-- Pero tambien podemos hacerlo con datos predefinidos
SELECT TIMEDIFF(horanacimiento, CURTIME()) FROM currenttimestamps;
-- En este caso vemos la cantidad de horas que pasaron desde que asignamos a Pedrito a su tabla en currenttimestamps.
-- Pero esto no es todo, sabias que podes hacer operaciones en tu gestor?
SELECT 3/4,4-1,5+5,5*2; -- Aca tenes division, resta, suma y multiplicacion.
-- Esto lo podemos hacer con por ejemplo la fecha de hoy
SELECT NOW(); -- Este es tu DATETIME de hoy
SELECT NOW() - INTERVAL 40 YEAR; 
-- Le restamos 40 años a la fecha de hoy, magia verdad? :)
-- Y como siempre podemos usar datos reales
SELECT nombre, fechanacimiento FROM currenttimestamps;
-- Aca tenemos a pedrito, supongamos que queremos saber en cuantos años va a poder votar
SELECT nombre, fechanacimiento + INTERVAL 18 YEAR AS 'Puede votar en el' FROM currenttimestamps;
-- Y asi de facil podemos visualizar nuestros intervalos de fecha en nuestros datos
-- Pero una cosa mas, supongamos que no queremos saber la fecha completa en la cual va a votar, sino el año
SELECT nombre, YEAR(fechanacimiento + INTERVAL 18 YEAR) AS 'Puede votar en el' FROM currenttimestamps;
-- Te acordas de YEAR() que la usabamos para aislar el dato año de una fecha? Bueno, lo usamos aca 

-- Timestamps
-- Como vimos antes con varios ejemplos, Timestamps tiene la misma funcionalidad que Datetime
-- Pero
-- Timestamps ocupa menos espacio en memoria a expensas de poder almacenar un registro de fechas mas corto. Desde el 1970-01-01 00:00:01 UTC al 2038-01-19 03:14:07 UTC

SELECT current_timestamp();
SELECT timestamp(now()); -- Convertiste el DATETIME de hoy en un TIMESTAMP, es lo mismo, pero con las diferencia de arriba
-- Tambien tenes los TIMESTAMPDIFF() y TIMESTAMPADD() como con las demas fechas, su funcionalidad en cuanto a codigo es la misma, la diferencia es que es mas eficiente 

-- DEFAULT y ON UPDATE TIMESTAMP (Por favor referirse a los docs para saber si esto esta presente en su DBMS)

CREATE TABLE captions(text VARCHAR(150), created_at TIMESTAMP default current_timestamp);
-- Te acordas de cuando usabamos AUTO_INCREMENT o IDENTITY (1,1) para generar valores automaticos? Bueno esto es parecido, solo que con la fecha
INSERT INTO captions (text) VALUES ('La vaca lola tiene cabeza y tiene cola');
SELECT * FROM captions;
-- Ahora podes ver que al texto que agregamos a nuestra tabla se le asigno una fecha predeterminada :D 
-- Pero que pasa si queremos tener un valor que se actualice automaticamente cada vez que hacemos cambios?
CREATE TABLE captions2(text VARCHAR(150), created_at TIMESTAMP default current_timestamp, updated_at TIMESTAMP ON UPDATE current_timestamp
default current_timestamp);
INSERT INTO captions2 (text) VALUES ('La vaca lola tiene cabeza y tiene cola y hace muu');
SELECT * FROM captions2;
UPDATE captions2 SET text='Me hice alto asado con la vaca lola';
SELECT * FROM captions2;
-- Como podes observar, tenemos dos fechas diferentes, la de creacion y la fecha en la cual la string se actualizo con UPDATE,
-- Asi de facil podemos llevar un registo de cambios en un log, en una tienda o lo que fuera.
