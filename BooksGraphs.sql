DROP DATABASE IF EXISTS BookGraph;
GO

CREATE DATABASE BookGraph;
GO

USE BookGraph;
GO

-- Создание узлов

-- Авторы
CREATE TABLE Author (
    Id INT PRIMARY KEY,
    Name NVARCHAR(100),
    Country NVARCHAR(100)
) AS NODE;

-- Книги
CREATE TABLE Book (
    Id INT PRIMARY KEY,
    Title NVARCHAR(200),
    YearPublished INT
) AS NODE;

-- Издательства
CREATE TABLE Publisher (
    Id INT PRIMARY KEY,
    Name NVARCHAR(100),
    City NVARCHAR(100)
) AS NODE;

-- Создание рёбер

-- Автор написал книгу
CREATE TABLE Wrote AS EDGE;

-- Книга издана издательством
CREATE TABLE PublishedBy AS EDGE;

-- Авторы сотрудничали
CREATE TABLE CollaboratedWith AS EDGE;

INSERT INTO Author (Id, Name, Country) VALUES
(1, 'Фёдор Достоевский', 'Россия'),
(2, 'Лев Толстой', 'Россия'),
(3, 'Антон Чехов', 'Россия'),
(4, 'Александр Пушкин', 'Россия'),
(5, 'Марк Твен', 'США'),
(6, 'Чарльз Диккенс', 'Англия'),
(7, 'Джейн Остин', 'Англия'),
(8, 'Франс Кафка', 'Австрия'),
(9, 'Эрнест Хемингуэй', 'США'),
(10, 'Габриэль Гарсия Маркес', 'Колумбия');

INSERT INTO Book (Id, Title, YearPublished) VALUES
(1, 'Преступление и наказание', 1866),
(2, 'Война и мир', 1869),
(3, 'Вишнёвый сад', 1904),
(4, 'Евгений Онегин', 1833),
(5, 'Приключения Тома Сойера', 1876),
(6, 'Оливер Твист', 1837),
(7, 'Гордость и предубеждение', 1813),
(8, 'Процесс', 1925),
(9, 'Старик и море', 1952),
(10, 'Сто лет одиночества', 1967);

INSERT INTO Publisher (Id, Name, City) VALUES
(1, 'Русский вестник', 'Москва'),
(2, 'Типография Катковa', 'Москва'),
(3, 'Современник', 'Санкт-Петербург'),
(4, 'Random House', 'Нью-Йорк'),
(5, 'Penguin Books', 'Лондон'),
(6, 'Macmillan', 'Лондон'),
(7, 'Alfaguara', 'Богота'),
(8, 'Oxford Press', 'Оксфорд'),
(9, 'Scribner', 'Нью-Йорк'),
(10, 'Vintage Books', 'Нью-Йорк');

INSERT INTO Wrote ($from_id, $to_id) VALUES
((SELECT $node_id FROM Author WHERE Name = 'Фёдор Достоевский'), (SELECT $node_id FROM Book WHERE Title = 'Преступление и наказание')),
((SELECT $node_id FROM Author WHERE Name = 'Лев Толстой'), (SELECT $node_id FROM Book WHERE Title = 'Война и мир')),
((SELECT $node_id FROM Author WHERE Name = 'Антон Чехов'), (SELECT $node_id FROM Book WHERE Title = 'Вишнёвый сад')),
((SELECT $node_id FROM Author WHERE Name = 'Александр Пушкин'), (SELECT $node_id FROM Book WHERE Title = 'Евгений Онегин')),
((SELECT $node_id FROM Author WHERE Name = 'Марк Твен'), (SELECT $node_id FROM Book WHERE Title = 'Приключения Тома Сойера')),
((SELECT $node_id FROM Author WHERE Name = 'Чарльз Диккенс'), (SELECT $node_id FROM Book WHERE Title = 'Оливер Твист')),
((SELECT $node_id FROM Author WHERE Name = 'Джейн Остин'), (SELECT $node_id FROM Book WHERE Title = 'Гордость и предубеждение')),
((SELECT $node_id FROM Author WHERE Name = 'Франс Кафка'), (SELECT $node_id FROM Book WHERE Title = 'Процесс')),
((SELECT $node_id FROM Author WHERE Name = 'Эрнест Хемингуэй'), (SELECT $node_id FROM Book WHERE Title = 'Старик и море')),
((SELECT $node_id FROM Author WHERE Name = 'Габриэль Гарсия Маркес'), (SELECT $node_id FROM Book WHERE Title = 'Сто лет одиночества'));

INSERT INTO PublishedBy ($from_id, $to_id) VALUES
((SELECT $node_id FROM Book WHERE Title = 'Преступление и наказание'), (SELECT $node_id FROM Publisher WHERE Name = 'Русский вестник')),
((SELECT $node_id FROM Book WHERE Title = 'Война и мир'), (SELECT $node_id FROM Publisher WHERE Name = 'Типография Катковa')),
((SELECT $node_id FROM Book WHERE Title = 'Вишнёвый сад'), (SELECT $node_id FROM Publisher WHERE Name = 'Современник')),
((SELECT $node_id FROM Book WHERE Title = 'Евгений Онегин'), (SELECT $node_id FROM Publisher WHERE Name = 'Современник')),
((SELECT $node_id FROM Book WHERE Title = 'Приключения Тома Сойера'), (SELECT $node_id FROM Publisher WHERE Name = 'Random House')),
((SELECT $node_id FROM Book WHERE Title = 'Оливер Твист'), (SELECT $node_id FROM Publisher WHERE Name = 'Penguin Books')),
((SELECT $node_id FROM Book WHERE Title = 'Гордость и предубеждение'), (SELECT $node_id FROM Publisher WHERE Name = 'Oxford Press')),
((SELECT $node_id FROM Book WHERE Title = 'Процесс'), (SELECT $node_id FROM Publisher WHERE Name = 'Macmillan')),
((SELECT $node_id FROM Book WHERE Title = 'Старик и море'), (SELECT $node_id FROM Publisher WHERE Name = 'Scribner')),
((SELECT $node_id FROM Book WHERE Title = 'Сто лет одиночества'), (SELECT $node_id FROM Publisher WHERE Name = 'Alfaguara'));

INSERT INTO CollaboratedWith ($from_id, $to_id) VALUES
((SELECT $node_id FROM Author WHERE Name = 'Фёдор Достоевский'), (SELECT $node_id FROM Author WHERE Name = 'Лев Толстой')),
((SELECT $node_id FROM Author WHERE Name = 'Лев Толстой'), (SELECT $node_id FROM Author WHERE Name = 'Антон Чехов')),
((SELECT $node_id FROM Author WHERE Name = 'Антон Чехов'), (SELECT $node_id FROM Author WHERE Name = 'Александр Пушкин')),
((SELECT $node_id FROM Author WHERE Name = 'Марк Твен'), (SELECT $node_id FROM Author WHERE Name = 'Чарльз Диккенс')),
((SELECT $node_id FROM Author WHERE Name = 'Чарльз Диккенс'), (SELECT $node_id FROM Author WHERE Name = 'Джейн Остин')),
((SELECT $node_id FROM Author WHERE Name = 'Франс Кафка'), (SELECT $node_id FROM Author WHERE Name = 'Эрнест Хемингуэй')),
((SELECT $node_id FROM Author WHERE Name = 'Эрнест Хемингуэй'), (SELECT $node_id FROM Author WHERE Name = 'Габриэль Гарсия Маркес')),
((SELECT $node_id FROM Author WHERE Name = 'Джейн Остин'), (SELECT $node_id FROM Author WHERE Name = 'Фёдор Достоевский')),
((SELECT $node_id FROM Author WHERE Name = 'Александр Пушкин'), (SELECT $node_id FROM Author WHERE Name = 'Марк Твен')),
((SELECT $node_id FROM Author WHERE Name = 'Габриэль Гарсия Маркес'), (SELECT $node_id FROM Author WHERE Name = 'Фёдор Достоевский'));

--1. Найти книги, написанные Фёдором Достоевским
SELECT b.Title, b.YearPublished
FROM Author a, Book b, Wrote w
WHERE MATCH (a-(w)->b)
  AND a.Name = 'Фёдор Достоевский';

--2. Найти всех авторов, чьи книги были изданы в Нью-Йорке
SELECT DISTINCT a.Name, p.City
FROM Author a, Book b, Publisher p, Wrote w, PublishedBy pb
WHERE MATCH (a-(w)->b-(pb)->p)
  AND p.City = 'Нью-Йорк';

-- 3. Найти всех авторов, сотрудничавших с Антоном Чеховым
SELECT a2.Name AS Collaborator
FROM Author a1, Author a2, CollaboratedWith c
WHERE MATCH (a1-(c)->a2)
  AND a1.Name = 'Антон Чехов';

--4. Найти авторов и их книги, изданные "Современником"
SELECT a.Name AS Author, b.Title AS Book
FROM Author a, Book b, Publisher p, Wrote w, PublishedBy pb
WHERE MATCH (a-(w)->b-(pb)->p)
  AND p.Name = 'Современник';

--5. Найти все пары авторов, которые сотрудничали
SELECT a1.Name AS Author1, a2.Name AS Author2
FROM Author a1, Author a2, CollaboratedWith c
WHERE MATCH (a1-(c)->a2);

--1.Найти кратчайший путь сотрудничества от Фёдора Достоевского до Габриэля Гарсиа Маркеса
-- CTE для кратчайшего пути

SELECT a1.Name AS FromAuthor,
       STRING_AGG(a2.Name, ' -> ') WITHIN GROUP (GRAPH PATH) AS PathToOtherAuthors
FROM Author AS a1,
     CollaboratedWith FOR PATH AS cw,
     Author FOR PATH AS a2
WHERE MATCH(SHORTEST_PATH(a1(-(cw)->a2)+))
  AND a1.Name = N'Фёдор Достоевский';

--Найти путь сотрудничества от Антона Чехова длиной от 1 до 3 шагов

SELECT a1.Name AS FromAuthor,
       STRING_AGG(a2.Name, ' -> ') WITHIN GROUP (GRAPH PATH) AS CollaboratorsPath
FROM Author AS a1,
     CollaboratedWith FOR PATH AS cw,
     Author FOR PATH AS a2
WHERE MATCH(SHORTEST_PATH(a1(-(cw)->{1,3} a2)))
  AND a1.Name = N'Антон Чехов';

