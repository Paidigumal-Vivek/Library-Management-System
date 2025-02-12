create database cs;
use cs;
drop database cs;


CREATE TABLE Member (
Member_ID NUMERIC NOT NULL,
Name VARCHAR(200),
Contact_Info VARCHAR(200),
Join_Date DATE,
PRIMARY KEY (Member_ID)
);

CREATE TABLE Staff (
Staff_ID NUMERIC NOT NULL,
Name VARCHAR(200),
Contact_Info VARCHAR(200),
Job_Title VARCHAR(200),
Hire_Date DATE,
PRIMARY KEY (Staff_ID)
);

CREATE TABLE Author (
Author_ID NUMERIC NOT NULL,
Name VARCHAR(200),
Birth_Date DATE,
Nationality VARCHAR(200),
PRIMARY KEY (Author_ID)
);

CREATE TABLE Catalog (
    Catalog_ID NUMERIC,
    Name VARCHAR(200),
    Location VARCHAR(200),
    PRIMARY KEY (Catalog_ID)
);

CREATE TABLE Genre (
    Genre_ID NUMERIC,
    Name VARCHAR(200),
    Description text,
    PRIMARY KEY (Genre_ID)
);

CREATE TABLE Material (
Material_ID NUMERIC NOT NULL,
Title VARCHAR(200),
Publication_Date DATE,
Catalog_ID NUMERIC,
Genre_ID NUMERIC,
PRIMARY KEY (Material_ID),
FOREIGN KEY (Catalog_ID) REFERENCES Catalog(Catalog_ID) 
ON DELETE CASCADE 
ON UPDATE CASCADE,
FOREIGN KEY (Genre_ID) REFERENCES Genre(Genre_ID)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE Authorship (
Authorship_ID NUMERIC NOT NULL,
Author_ID NUMERIC,
Material_ID NUMERIC,
PRIMARY KEY (Authorship_ID),
FOREIGN KEY (Author_ID) REFERENCES Author(Author_ID)
ON DELETE CASCADE
ON UPDATE CASCADE,
FOREIGN KEY (Material_ID) REFERENCES Material(Material_ID)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE Borrow (
Borrow_ID NUMERIC NOT NULL,
Material_ID NUMERIC,
Member_ID NUMERIC,
Staff_ID NUMERIC,
Borrow_Date DATE,
Due_Date DATE,
Return_Date DATE,
PRIMARY KEY (Borrow_ID),
FOREIGN KEY (Material_ID) REFERENCES Material(Material_ID)
ON DELETE CASCADE
ON UPDATE CASCADE,
FOREIGN KEY (Member_ID) REFERENCES Member(Member_ID)
ON DELETE CASCADE
ON UPDATE CASCADE,
FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID)
ON DELETE CASCADE
ON UPDATE CASCADE
);

LOAD DATA INFILE "C:\Users\VIVEK\Desktop\Final Project\Author.csv"
INTO TABLE Author
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

select * from Author;

LOAD DATA INFILE "C:\Users\VIVEK\Desktop\Final Project\Author.csv"
INTO TABLE Catalog
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
select * from Catalog;


LOAD DATA INFILE "C:\Users\VIVEK\Desktop\Final Project\Genre.csv"
INTO TABLE Genre
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
select * from Genre;

LOAD DATA INFILE "C:\Users\VIVEK\Desktop\Final Project\Material.csv"
INTO TABLE Material
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

select * from Material;


LOAD DATA INFILE "C:\Users\VIVEK\Desktop\Final Project\Authorship.csv"
INTO TABLE Authorship
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
select * from Authorship;

LOAD DATA INFILE "C:\Users\VIVEK\Desktop\Final Project\Member.csv"
INTO TABLE Member
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

select * from Member;


LOAD DATA INFILE "C:\Users\VIVEK\Desktop\Final Project\Staff.csv"
INTO TABLE Staff
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

select * from Staff;


LOAD DATA INFILE "C:\Users\VIVEK\Desktop\Final Project\Borrow.csv"
INTO TABLE Borrow
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

update Borrow
set Return_Date= null
where Return_Date='0000-00-00';

select * from Borrow;

#Search Query
select Name from Member
where Join_Date<'2018-12-31';

#Insert Query
insert into Catalog values (11,'Books1','E11,2');
select * from Catalog where Name='Books1';

#Update Query
update Catalog
set Name='Magazines1'
where Name='Books1';
select * from Catalog where Name='Magazines1';

#Delete Query
Delete from Catalog
where Name='Magazines1';
select * from Catalog where Name='Magazines1';

#Inner Join Query
select Material.Title,Catalog.Name,Catalog.Location from Material
inner join Catalog on Material.Catalog_ID=Catalog.Catalog_ID
where Catalog.Name='Novels';

select * from Material;

#Aggregation Query
select count(Material.Title) as Count,Genre.Name from Material 
inner join Genre on Material.Genre_ID=Genre.Genre_ID
where Genre.Name='General Fiction'
group by Genre.Name
order by Count desc;

select * from Genre;

#Subquery Demo
select Title,Count(Title) from Material
Where Genre_ID= (select Genre_ID from Genre
			   where Name='Dystopian & Apocalyptic');

#Q1
SELECT MD.Material_ID,MD.Title
FROM Material AS MD
WHERE MD.Material_ID NOT IN (
SELECT BR.Material_ID FROM Borrow AS BR
WHERE BR.Return_Date IS NULL);

#Q2
SELECT MD.Material_ID,MD.Title,BR.Borrow_Date,BR.Due_Date 
FROM Material AS MD
INNER JOIN Borrow AS BR ON MD.Material_ID = BR.Material_ID
WHERE BR.Return_Date IS NULL AND BR.Due_Date < '2023-04-01';

#Q3
SELECT MD.Material_ID,MD.Title, COUNT(BR.Material_ID) AS COUNT
FROM Material AS MD
INNER JOIN Borrow AS BR ON MD.Material_ID = BR.Material_ID
GROUP BY MD.Title, MD.Material_ID
ORDER BY COUNT DESC LIMIT 10;


#Q4
SELECT AD.Name,COUNT(DISTINCT MD.Material_ID) AS COUNT 
FROM Author AS AD
INNER JOIN Authorship AS ASH ON AD.Author_ID = ASH.Author_ID
INNER JOIN Material AS MD ON ASH.Material_ID = MD.Material_ID
WHERE AD.Name = 'Lucas Piki'
GROUP BY AD.Name;

#Q5
SELECT MD.Material_ID, MD.Title, COUNT(AD.Author_ID) AS Number_Author
FROM Author AS AD
INNER JOIN Authorship AS ASH ON AD.Author_ID = ASH.Author_ID
INNER JOIN Material AS MD ON ASH.Material_ID = MD.Material_ID
GROUP BY MD.Material_ID, MD.Title
HAVING COUNT(AD.Author_ID) >= 2
ORDER BY MD.Material_ID ASC;

#Q6
SELECT GD.Name, COUNT(BR.Borrow_ID) AS Count1
FROM Genre AS GD
INNER JOIN Material AS MD ON GD.Genre_ID = MD.Genre_ID
INNER JOIN Borrow AS BR ON MD.Material_ID = BR.Material_ID
GROUP BY GD.Name
ORDER BY Count1 DESC;

#Q7
SELECT BD.Material_ID,COUNT(DISTINCT BD.Material_ID) AS Count1 FROM Borrow AS BD
WHERE BD.Borrow_Date BETWEEN '2020-09-01' AND '2020-10-01'
GROUP BY BD.Material_ID
ORDER BY Count1 DESC;

select * from borrow;

#Q8
UPDATE Borrow AS BD
SET BD.Return_Date = '2023-04-01'
WHERE BD.Material_ID IN (
    SELECT MD.Material_ID 
    FROM Material AS MD
    WHERE MD.Title = 'Harry Potter and the Philosopher''s Stone'
) 
AND BD.Return_Date IS NULL;
SELECT * FROM Borrow WHERE Return_Date='2023-04-01';

#Q9
DELETE FROM Member WHERE Name='Emily Miller';

SELECT * FROM Member WHERE Name='Emily Miller';

#Q10
BEGIN;
INSERT INTO Material (Material_ID, Title, Publication_Date, Catalog_ID, Genre_ID)
SELECT (SELECT MAX(Material_ID) + 1 FROM Material),'New Book','2020-08-01',(SELECT Catalog_ID FROM Catalog WHERE Name = 'E-Books'), 
       (SELECT Genre_ID FROM Genre WHERE Name = 'Mystery & Thriller');

INSERT INTO Author (Author_ID, Name)
SELECT (SELECT MAX(Author_ID) + 1 FROM Author), 'Lucas Luke';

INSERT INTO Authorship (Authorship_ID, Author_ID, Material_ID)
SELECT (SELECT MAX(Authorship_ID) + 1 FROM Authorship),(SELECT Author_ID FROM Author WHERE Name = 'Lucas Luke'),
	    (SELECT MAX(Material_ID) FROM Material);
COMMIT;

SELECT * FROM Material 
WHERE Title = 'New Book';


SELECT * FROM Author
WHERE Name = 'Lucas Luke';





SELECT * FROM Authorship
WHERE Author_ID=21;



