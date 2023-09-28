-- DISTINCT
SELECT DISTINCT author_lname FROM Books;
SELECT released_year FROM Books;
SELECT distinct released_year FROM Books;
SELECT author_fname, author_lname FROM Books;
SELECT DISTINCT concat(author_fname, ' ', author_lname) AS 'Nombre Completo Distinto' FROM Books;
SELECT DISTINCT author_fname, author_lname FROM Books;
SELECT DISTINCT author_fname, author_lname, released_year FROM Books;

-- ORDER BY
SELECT book_id, title, author_lname FROM Books;
INSERT INTO Books (title, author_lname) VALUES ('my life', 'steele');
SELECT book_id, author_fname, author_lname FROM Books ORDER BY author_lname;
SELECT book_id, author_fname, author_lname FROM Books ORDER BY author_fname;
SELECT book_id, author_fname, author_lname FROM Books ORDER BY author_fname DESC;
SELECT book_id, author_fname, author_lname FROM Books ORDER BY author_lname DESC;
SELECT title, pages FROM Books ORDER BY pages;
SELECT title, pages FROM Books ORDER BY pages DESC;
SELECT title, pages FROM Books ORDER BY released_year; -- Se puede usar de todas formas a pesar de que no se selecciona la columna released year
SELECT title, author_fname, author_lname FROM Books ORDER BY 2; -- El numero significa usar una de las columnas que tenemos seleccionadas dentro del SELECT, en este caso author_fname
SELECT title, author_fname, author_lname FROM Books ORDER BY 2,3; -- Se pueden seleccionar varias columnas dentro del Order By
SELECT title, author_fname, author_lname FROM Books ORDER BY 2,3 DESC;
SELECT author_lname, released_year, title FROM Books ORDER BY author_lname;
SELECT author_lname, released_year, title FROM Books ORDER BY author_lname, released_year;
SELECT author_lname, released_year, title FROM Books ORDER BY author_lname, released_year DESC;
SELECT concat(author_fname, ' ', author_lname) AS author FROM Books ORDER BY author; -- Las columnas se pueden ordenar por aquellas que fueron creadas para visualizar datos, en este caso author
SELECT concat(author_fname, ' ', author_lname) AS author FROM Books ORDER BY author DESC;

-- LIMIT (Se refiere a la cantidad de datos que queremos que el resultado de nuestra busqueda nos devuelva)
SELECT book_id, title, released_year FROM Books;
SELECT book_id, title, released_year FROM Books ORDER BY released_year DESC LIMIT 5;
SELECT book_id, title, released_year FROM Books ORDER BY released_year LIMIT 5;
SELECT book_id, title, released_year FROM Books ORDER BY released_year DESC LIMIT 0,5; -- 0,5 significa empezar desde el valor cero y contar cinco valores desde ahi.
SELECT book_id, title, released_year FROM Books ORDER BY released_year DESC LIMIT 3,8; -- Empieza desde la linea tres y cuenta ocho valores
SELECT book_id, title, released_year FROM Books ORDER BY released_year DESC LIMIT 3,40; -- En caso que le des un valor que esta por fuera de los ingresados en tu tabla te va a dar todos los que pueda

-- LIKE 
SELECT title, author_fname, author_lname FROM Books;
SELECT title, author_fname, author_lname FROM Books WHERE author_fname='David';
SELECT title, author_fname, author_lname FROM Books WHERE author_fname LIKE '%da%'; -- % Son Wildcards, significan x cantidad de caracteres antes o despues de lo que vamos a buscar, en este caso, pueden haber otras cosas antes de da y va a mostrar resultados como Freida y David
SELECT title, author_fname, author_lname FROM Books WHERE author_fname LIKE 'da%'; -- Cambiando la posicion del % podemos seleccionar que hayan caracteres antes o despues de nuestra busqueda, en este caso eliminamos la posibilidad de que aparezca Freida porque solo pueden haber caracteres posteriores a Da
SELECT title, author_fname, author_lname FROM Books WHERE author_fname LIKE '%da'; -- Este caso solo muestra a Freida
SELECT * FROM Books WHERE title Like '%:%'; -- Busca todos los titulos que tienen un : en su nombre sin importar la posicion
SELECT * FROM Books WHERE author_fname LIKE '____'; -- _ Es otro wildcard que simboliza un caracter en concreto, en este caso al poner 4 estamos buscando primeros nombres de autores que tengan el largo de 4 caracteres

-- ESCAPING WILDCARDS
SELECT * FROM Books WHERE title LIKE '%\%%'; -- El \ Se encarga de separar en este caso los % que son wildcards del % que queremos usar como caracter para identificar libros por ejemplo que tienen el signo en su titulo
SELECT * FROM Books WHERE title Like '%\_%'; -- Lo mismo pero con la wildcard _ 

-- EJERCICIOS
SELECT title FROM Books WHERE title LIKE '%stories%'; -- Todos los titulos que contengan stories 
SELECT title, pages FROM Books ORDER BY pages DESC LIMIT 0,1; -- El libro con la mayor cantidad de paginas
SELECT concat(title, '-', released_year) AS 'Summary' FROM Books ORDER BY released_year DESC LIMIT 0,3; -- Un sumario de los 3 libros mas recientes ordenados por su fecha de salida de forma descendente
SELECT title, author_lname FROM Books WHERE author_lname LIKE '% %'; -- Selecciona todos los libros cuyo autor tenga un espacio en su apellido
SELECT title, released_year, stock_quantity FROM Books ORDER BY stock_quantity LIMIT 3; -- Ordena los 3 libros con menos stock
SELECT title, author_lname FROM Books ORDER BY author_lname, title; -- Ordena las columnas por el apellido y el titulo de los libros
SELECT title, author_lname FROM Books ORDER BY 2,1; -- Misma funcionalidad solo que usando numeros
SELECT UPPER(concat('MY FAVOURITE AUTHOR IS', ' ', author_fname, ' ', author_lname)) AS yell FROM books ORDER BY author_lname;

-- COUNT
SELECT COUNT(*) FROM Books; -- Esto cuenta la cantidad de lineas no importa si hay valores en ellas o no
SELECT COUNT(author_fname) FROM Books; -- Cuando se le especifica la columna va a contar la cantidad de filas con valores en ellas
INSERT INTO Books () VALUES (); -- Al agregarle dos veces valores vacios, el count con asterisco va a ser de 21 pero dentro de author_fname va a ser 19 porque no tiene realmente nada para contar, uno cuenta el total de filas, el otro los valores 
SELECT COUNT(DISTINCT author_fname) FROM Books; -- Muestra la cantidad de valores unicos existentes dentro de author_fname
SELECT COUNT(DISTINCT released_year) FROM Books;
SELECT COUNT(DISTINCT author_lname) FROM Books;
SELECT COUNT(*) FROM Books WHERE title LIKE '%the%'; -- Cuenta la cantidad de libros que contienen the

-- GROUP BY Agrupa data del mismo valor en una unica fila
SELECT author_lname FROM Books GROUP BY author_lname;
SELECT author_lname, COUNT(*) AS books_written FROM Books GROUP BY author_lname; -- Muestra el apellido y a su lado una columna count con la cantidad de veces que esta presente el apellido
SELECT author_lname, COUNT(*) AS books_written FROM Books GROUP BY author_lname ORDER BY books_written; -- Se ordena en base a la cantidad de libros escritos 
SELECT author_lname, COUNT(*) AS books_written FROM Books GROUP BY author_lname ORDER BY books_written DESC; 
SELECT released_year FROM Books GROUP BY released_year; -- Muestra valores unicos, algo parecido a Distinct
SELECT released_year, COUNT(*) FROM Books GROUP BY released_year; -- Muestra la cantidad de veces que los años o valores se repiten
SELECT released_year, COUNT(*) AS years FROM Books GROUP BY released_year ORDER BY years DESC; -- Cuenta, ordena y muestra la cantidad de veces que se repiten

-- MIN MAX
SELECT MIN(released_year) FROM Books; -- Muestra el libro mas antiguo, menor valor
SELECT MAX(released_year) FROM Books; -- Muestra el libro mas nuevo, mayor valor
SELECT MAX(pages) FROM Books;
SELECT MIN(pages) FROM Books;
SELECT MIN(author_lname) FROM Books; -- Cuando se trata de texto va a encontrar el mayor o el menor de los valores ordenados alfabeticamente. 
SELECT MAX(author_lname) FROM Books;

-- SUBQUERIES
SELECT title, pages FROM Books ORDER BY pages desc limit 1;
SELECT * FROM books WHERE pages = (SELECT Min(pages) FROM Books); -- Muestra todas las columnas, pero genera una subquery que determina que se debe mostrar solamente el valor minimo dentro de pages
SELECT * FROM books WHERE pages = (SELECT MAX(pages) FROM Books); -- Tambien funciona para el mas grande
SELECT * FROM books WHERE author_lname = (SELECT MAX(author_lname) FROM Books); -- Para el que esta mas abajo alfabeticamente en nuestra lista
SELECT * FROM books WHERE author_lname = (SELECT MIN(author_lname) FROM Books); -- O para el que esta mas arriba
SELECT title, pages FROM Books WHERE pages =(SELECT MAX(pages) FROM Books); -- Funciona seleccionando columnas especificas en tu primera query tambien, esto funciona igual que el order by, pero no establece limites de valores unicos, muestra todos los mas grandes, no uno solo
SELECT title, pages FROM Books WHERE pages =(SELECT MIN(pages) FROM Books);
INSERT INTO Books (title,pages) VALUES ('My life in words', 634);
SELECT title, released_year FROM books WHERE released_year = (SELECT MIN(released_year) FROM Books);

-- GROUP BY Para varias columnas
SELECT author_fname, author_lname FROM Books;
SELECT author_fname, author_lname FROM Books ORDER BY author_lname;
SELECT author_lname, COUNT(*) FROM Books GROUP BY author_lname; -- Tecnicamente funcionaria pero no tiene en cuenta que al contar a Harris como apellido se trata de dos personas diferentes
SELECT author_lname, COUNT(*) FROM Books GROUP BY author_lname,author_fname; -- En este caso al agrupar por varias columnas va a realizar la diferenciacion entre los Harris y el apellido va a salir dos veces porque no son la misma persona
SELECT author_fname, author_lname, COUNT(*) FROM Books GROUP BY author_lname,author_fname; -- Aca se puede ver mas claramente la diferenciacion
SELECT CONCAT(author_fname, ' ', author_lname)AS Author, COUNT(*) FROM Books GROUP BY Author; -- Funciona de la misma forma que el anterior, solamente que ahora agrupamos los valores en base a la columna concatenada llamada autor

-- MIN MAX GROUP BY
SELECT author_fname, author_lname, MIN(released_year) FROM Books GROUP BY author_lname, author_fname; -- Muestra el primer libro publicado por cada autor
SELECT CONCAT(author_fname,' ', author_lname) AS Author, MIN(released_year) AS FirstBook FROM Books GROUP BY Author ORDER BY FirstBook;
SELECT CONCAT(author_fname,' ', author_lname) AS Author, MAX(released_year) AS FirstBook FROM Books GROUP BY Author; -- Muestra el ultimo libro publicado por cada autor
SELECT CONCAT(author_fname,' ', author_lname) AS Author, MIN(released_year) AS FirstBook, MAX(released_year) AS LastBook FROM Books GROUP BY Author ORDER BY FirstBook;
SELECT CONCAT(author_fname,' ', author_lname) AS Author, COUNT(*) AS BooksAmount, MIN(released_year) AS FirstBook, MAX(released_year) AS LastBook 
FROM Books GROUP BY Author ORDER BY FirstBook; -- Muestra el nombre completo del autor, la cantidad de libros escritos, el primero y el ultimo publicado
SELECT CONCAT(author_fname,' ', author_lname) AS Author, COUNT(*) AS BooksAmount, MIN(released_year) AS FirstBook, MAX(released_year) AS LastBook, MAX(pages) AS LargestBook
FROM Books GROUP BY Author ORDER BY LargestBook;

-- SUM
SELECT SUM(pages) FROM Books; -- Sumatoria total de las paginas de todos los libros de nuestra tabla 
SELECT CONCAT(author_fname,' ', author_lname) AS Author, SUM(pages) FROM Books GROUP BY Author; -- Sumatoria de cantidad de paginas escritas por cada autor

-- AVG
SELECT AVG(released_year)FROM Books;
SELECT AVG(pages)FROM Books;
SELECT AVG(stock_quantity)FROM Books;
SELECT released_year, AVG(stock_quantity), COUNT(*) FROM Books GROUP BY released_year;

-- EJERICICIOS
SELECT COUNT(*) FROM Books; -- Cuenta la cantidad de libros
SELECT released_year, COUNT(*) AS BooksAmount FROM Books GROUP BY released_year;
SELECT SUM(stock_quantity) FROM Books;
SELECT CONCAT(author_fname,' ', author_lname) AS Author, ROUND(AVG(released_year)) AS AVGRelease FROM books GROUP BY Author;
SELECT CONCAT(author_fname,' ', author_lname) AS Author, pages FROM Books WHERE pages =(SELECT MAX(pages) FROM Books) LIMIT 1;
SELECT CONCAT(author_fname,' ', author_lname) AS Author, pages FROM BOOKS ORDER BY pages DESC LIMIT 1;
SELECT released_year, COUNT(*) AS BooksAmount, ROUND(AVG(pages)) FROM BOOKS GROUP BY released_year ORDER BY released_year;