DROP DATABASE IF EXISTS BookGraph;
GO

CREATE DATABASE BookGraph;
GO

USE BookGraph;
GO

-- �������� �����

-- ������
CREATE TABLE Author (
    Id INT PRIMARY KEY,
    Name NVARCHAR(100),
    Country NVARCHAR(100)
) AS NODE;

-- �����
CREATE TABLE Book (
    Id INT PRIMARY KEY,
    Title NVARCHAR(200),
    YearPublished INT
) AS NODE;

-- ������������
CREATE TABLE Publisher (
    Id INT PRIMARY KEY,
    Name NVARCHAR(100),
    City NVARCHAR(100)
) AS NODE;

-- �������� ����

-- ����� ������� �����
CREATE TABLE Wrote AS EDGE;

-- ����� ������ �������������
CREATE TABLE PublishedBy AS EDGE;

-- ������ ������������
CREATE TABLE CollaboratedWith AS EDGE;

INSERT INTO Author (Id, Name, Country) VALUES
(1, 'Ը��� �����������', '������'),
(2, '��� �������', '������'),
(3, '����� �����', '������'),
(4, '��������� ������', '������'),
(5, '���� ����', '���'),
(6, '������ �������', '������'),
(7, '����� �����', '������'),
(8, '����� �����', '�������'),
(9, '������ ���������', '���'),
(10, '�������� ������ ������', '��������');

INSERT INTO Book (Id, Title, YearPublished) VALUES
(1, '������������ � ���������', 1866),
(2, '����� � ���', 1869),
(3, '������� ���', 1904),
(4, '������� ������', 1833),
(5, '����������� ���� ������', 1876),
(6, '������ �����', 1837),
(7, '�������� � �������������', 1813),
(8, '�������', 1925),
(9, '������ � ����', 1952),
(10, '��� ��� �����������', 1967);

INSERT INTO Publisher (Id, Name, City) VALUES
(1, '������� �������', '������'),
(2, '���������� ������a', '������'),
(3, '�����������', '�����-���������'),
(4, 'Random House', '���-����'),
(5, 'Penguin Books', '������'),
(6, 'Macmillan', '������'),
(7, 'Alfaguara', '������'),
(8, 'Oxford Press', '�������'),
(9, 'Scribner', '���-����'),
(10, 'Vintage Books', '���-����');

INSERT INTO Wrote ($from_id, $to_id) VALUES
((SELECT $node_id FROM Author WHERE Name = 'Ը��� �����������'), (SELECT $node_id FROM Book WHERE Title = '������������ � ���������')),
((SELECT $node_id FROM Author WHERE Name = '��� �������'), (SELECT $node_id FROM Book WHERE Title = '����� � ���')),
((SELECT $node_id FROM Author WHERE Name = '����� �����'), (SELECT $node_id FROM Book WHERE Title = '������� ���')),
((SELECT $node_id FROM Author WHERE Name = '��������� ������'), (SELECT $node_id FROM Book WHERE Title = '������� ������')),
((SELECT $node_id FROM Author WHERE Name = '���� ����'), (SELECT $node_id FROM Book WHERE Title = '����������� ���� ������')),
((SELECT $node_id FROM Author WHERE Name = '������ �������'), (SELECT $node_id FROM Book WHERE Title = '������ �����')),
((SELECT $node_id FROM Author WHERE Name = '����� �����'), (SELECT $node_id FROM Book WHERE Title = '�������� � �������������')),
((SELECT $node_id FROM Author WHERE Name = '����� �����'), (SELECT $node_id FROM Book WHERE Title = '�������')),
((SELECT $node_id FROM Author WHERE Name = '������ ���������'), (SELECT $node_id FROM Book WHERE Title = '������ � ����')),
((SELECT $node_id FROM Author WHERE Name = '�������� ������ ������'), (SELECT $node_id FROM Book WHERE Title = '��� ��� �����������'));

INSERT INTO PublishedBy ($from_id, $to_id) VALUES
((SELECT $node_id FROM Book WHERE Title = '������������ � ���������'), (SELECT $node_id FROM Publisher WHERE Name = '������� �������')),
((SELECT $node_id FROM Book WHERE Title = '����� � ���'), (SELECT $node_id FROM Publisher WHERE Name = '���������� ������a')),
((SELECT $node_id FROM Book WHERE Title = '������� ���'), (SELECT $node_id FROM Publisher WHERE Name = '�����������')),
((SELECT $node_id FROM Book WHERE Title = '������� ������'), (SELECT $node_id FROM Publisher WHERE Name = '�����������')),
((SELECT $node_id FROM Book WHERE Title = '����������� ���� ������'), (SELECT $node_id FROM Publisher WHERE Name = 'Random House')),
((SELECT $node_id FROM Book WHERE Title = '������ �����'), (SELECT $node_id FROM Publisher WHERE Name = 'Penguin Books')),
((SELECT $node_id FROM Book WHERE Title = '�������� � �������������'), (SELECT $node_id FROM Publisher WHERE Name = 'Oxford Press')),
((SELECT $node_id FROM Book WHERE Title = '�������'), (SELECT $node_id FROM Publisher WHERE Name = 'Macmillan')),
((SELECT $node_id FROM Book WHERE Title = '������ � ����'), (SELECT $node_id FROM Publisher WHERE Name = 'Scribner')),
((SELECT $node_id FROM Book WHERE Title = '��� ��� �����������'), (SELECT $node_id FROM Publisher WHERE Name = 'Alfaguara'));

INSERT INTO CollaboratedWith ($from_id, $to_id) VALUES
((SELECT $node_id FROM Author WHERE Name = 'Ը��� �����������'), (SELECT $node_id FROM Author WHERE Name = '��� �������')),
((SELECT $node_id FROM Author WHERE Name = '��� �������'), (SELECT $node_id FROM Author WHERE Name = '����� �����')),
((SELECT $node_id FROM Author WHERE Name = '����� �����'), (SELECT $node_id FROM Author WHERE Name = '��������� ������')),
((SELECT $node_id FROM Author WHERE Name = '���� ����'), (SELECT $node_id FROM Author WHERE Name = '������ �������')),
((SELECT $node_id FROM Author WHERE Name = '������ �������'), (SELECT $node_id FROM Author WHERE Name = '����� �����')),
((SELECT $node_id FROM Author WHERE Name = '����� �����'), (SELECT $node_id FROM Author WHERE Name = '������ ���������')),
((SELECT $node_id FROM Author WHERE Name = '������ ���������'), (SELECT $node_id FROM Author WHERE Name = '�������� ������ ������')),
((SELECT $node_id FROM Author WHERE Name = '����� �����'), (SELECT $node_id FROM Author WHERE Name = 'Ը��� �����������')),
((SELECT $node_id FROM Author WHERE Name = '��������� ������'), (SELECT $node_id FROM Author WHERE Name = '���� ����')),
((SELECT $node_id FROM Author WHERE Name = '�������� ������ ������'), (SELECT $node_id FROM Author WHERE Name = 'Ը��� �����������'));

--1. ����� �����, ���������� Ը����� �����������
SELECT b.Title, b.YearPublished
FROM Author a, Book b, Wrote w
WHERE MATCH (a-(w)->b)
  AND a.Name = 'Ը��� �����������';

--2. ����� ���� �������, ��� ����� ���� ������ � ���-�����
SELECT DISTINCT a.Name, p.City
FROM Author a, Book b, Publisher p, Wrote w, PublishedBy pb
WHERE MATCH (a-(w)->b-(pb)->p)
  AND p.City = '���-����';

-- 3. ����� ���� �������, �������������� � ������� �������
SELECT a2.Name AS Collaborator
FROM Author a1, Author a2, CollaboratedWith c
WHERE MATCH (a1-(c)->a2)
  AND a1.Name = '����� �����';

--4. ����� ������� � �� �����, �������� "�������������"
SELECT a.Name AS Author, b.Title AS Book
FROM Author a, Book b, Publisher p, Wrote w, PublishedBy pb
WHERE MATCH (a-(w)->b-(pb)->p)
  AND p.Name = '�����������';

--5. ����� ��� ���� �������, ������� ������������
SELECT a1.Name AS Author1, a2.Name AS Author2
FROM Author a1, Author a2, CollaboratedWith c
WHERE MATCH (a1-(c)->a2);

--1.����� ���������� ���� �������������� �� Ը���� ������������ �� �������� ������ �������
-- CTE ��� ����������� ����

SELECT a1.Name AS FromAuthor,
       STRING_AGG(a2.Name, ' -> ') WITHIN GROUP (GRAPH PATH) AS PathToOtherAuthors
FROM Author AS a1,
     CollaboratedWith FOR PATH AS cw,
     Author FOR PATH AS a2
WHERE MATCH(SHORTEST_PATH(a1(-(cw)->a2)+))
  AND a1.Name = N'Ը��� �����������';

--����� ���� �������������� �� ������ ������ ������ �� 1 �� 3 �����

SELECT a1.Name AS FromAuthor,
       STRING_AGG(a2.Name, ' -> ') WITHIN GROUP (GRAPH PATH) AS CollaboratorsPath
FROM Author AS a1,
     CollaboratedWith FOR PATH AS cw,
     Author FOR PATH AS a2
WHERE MATCH(SHORTEST_PATH(a1(-(cw)->{1,3} a2)))
  AND a1.Name = N'����� �����';

