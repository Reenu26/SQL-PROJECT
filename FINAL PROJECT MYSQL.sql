CREATE DATABASE library;

USE library;

--  Branch table
CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(15)
);

--  Employee table
CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(100),
    Position VARCHAR(50),
    Salary DECIMAL(10, 2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);

--  Books table
CREATE TABLE Books (
    ISBN INT PRIMARY KEY,
    Book_title VARCHAR(100),
    Category VARCHAR(50),
    Rental_Price DECIMAL(10, 2),
    Status ENUM('yes', 'no'),
    Author VARCHAR(100),
    Publisher VARCHAR(100)
);

--  Customer table
CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(100),
    Customer_address VARCHAR(255),
    Reg_date DATE
);

-- IssueStatus table
CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(100),
    Issue_date DATE,
    Isbn_book INT,
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);

-- ReturnStatus table
CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(100),
    Return_date DATE,
    Isbn_book2 INT,
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);


INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no) VALUES
(1, 101, '123 Main St, Springfield', '555-1234'),
(2, 102, '456 Elm St, Shelbyville', '555-5678'),
(3, 103, '789 Oak St, Capital City', '555-8765'),
(4, 104, '321 Pine St, Smallville', '555-4321'),
(5, 105, '654 Maple St, Metropolis', '555-0000');

select * from Branch;


INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no) VALUES
(1, 'Alice Johnson', 'Manager', 60000.00, 1),
(2, 'Bob Smith', 'Librarian', 45000.00, 1),
(3, 'Charlie Brown', 'Assistant Librarian', 35000.00, 2),
(4, 'Diana Prince', 'Manager', 70000.00, 2),
(5, 'Edward Elric', 'Librarian', 48000.00, 3),
(6, 'Fiona Green', 'Assistant Librarian', 32000.00, 3),
(7, 'George White', 'Manager', 65000.00, 4),
(8, 'Hannah Black', 'Librarian', 42000.00, 4),
(9, 'Ian Gray', 'Assistant Librarian', 34000.00, 5),
(10, 'Julia Red', 'Manager', 72000.00, 5);


select * from Employee;


INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher) VALUES
(101, 'The Great Gatsby', 'Fiction', 5.00, 'yes', 'F. Scott Fitzgerald', 'Scribner'),
(102, '1984', 'Dystopian', 6.50, 'yes', 'George Orwell', 'Secker & Warburg'),
(103, 'To Kill a Mockingbird', 'Fiction', 7.00, 'no', 'Harper Lee', 'J.B. Lippincott & Co.'),
(104, 'The Catcher in the Rye', 'Fiction', 5.50, 'yes', 'J.D. Salinger', 'Little, Brown and Company'),
(105, 'Moby Dick', 'Classic', 8.00, 'yes', 'Herman Melville', 'Harper & Brothers'),
(106, 'Pride and Prejudice', 'Romance', 4.50, 'no', 'Jane Austen', 'T. Egerton'),
(107, 'The Hobbit', 'Fantasy', 5.75, 'yes', 'J.R.R. Tolkien', 'George Allen & Unwin'),
(108, 'Brave New World', 'Dystopian', 6.25, 'yes', 'Aldous Huxley', 'Chatto & Windus'),
(109, 'The Diary of a Young Girl', 'Biography', 5.50, 'yes', 'Anne Frank', 'Contact Publishing'),
(110, 'The Alchemist', 'Adventure', 4.75, 'no', 'Paulo Coelho', 'HarperCollins');


select * from Books;


INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date) VALUES
(1, 'Alice Johnson', '123 Maple St, Springfield', '2021-05-15'),
(2, 'Bob Smith', '456 Oak St, Springfield', '2021-06-10'),
(3, 'Charlie Brown', '789 Pine St, Springfield', '2022-02-20'),
(4, 'Diana Prince', '135 Elm St, Metropolis', '2021-12-05'),
(5, 'Edward Elric', '246 Cedar St, Central City', '2023-01-10');


select * from Customer;


INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date,ISBN_book ) VALUES
(1, 1, 'The Great Gatsby', '2023-06-01', 101),
(2, 2, 'To Kill a Mockingbird', '2023-06-15', 103),
(3, 3, '1984', '2023-07-01', 102),
(4, 4, 'Moby Dick', '2023-05-20', 105),
(5, 5, 'Pride and Prejudice', '2023-08-10', '106');

select * from IssueStatus;


INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, ISBN_book2) VALUES
(1, 1, 'The Great Gatsby', '2023-06-10', 101),
(2, 2, 'To Kill a Mockingbird', '2023-06-25', 103),
(3, 3, '1984', '2023-07-15', 102),
(4, 4, 'Moby Dick', '2023-06-05', 105),
(5, 5, 'Pride and Prejudice', '2023-09-01', 106);

select * from ReturnStatus;


SELECT Book_title, Category, Rental_Price FROM Books WHERE Status = 'yes';


SELECT Emp_name, Salary FROM Employee ORDER BY Salary DESC;


SELECT b.Book_title, c.Customer_name 
FROM IssueStatus i 
JOIN Books b ON i.ISBN_book = b.ISBN 
JOIN Customer c ON i.Issued_cust = c.Customer_Id;


SELECT Category, COUNT(*) AS Total_Books FROM Books GROUP BY Category;

SELECT Emp_name, Position 
FROM Employee 
WHERE Salary > 50000;

SELECT Customer_name 
FROM Customer c 
WHERE Reg_date < '2022-01-01' 
AND NOT EXISTS (
    SELECT 1 
    FROM IssueStatus i 
    WHERE i.Issued_cust = c.Customer_Id
);

SELECT Branch_no, COUNT(*) AS Total_Employees 
FROM Employee 
GROUP BY Branch_no;


SELECT DISTINCT c.Customer_name 
FROM IssueStatus i 
JOIN Customer c ON i.Issued_cust = c.Customer_Id 
WHERE i.Issue_date BETWEEN '2023-06-01' AND '2023-06-30';


SELECT Book_title 
FROM Books 
WHERE Book_title LIKE 'history';

SELECT Book_title 
FROM Books 
WHERE Book_title LIKE 'The Great Gatsby';


SELECT Branch_no, COUNT(*) AS Total_Employees 
FROM Employee 
GROUP BY Branch_no 
HAVING COUNT(*) > 1;


SELECT e.Emp_name, b.Branch_address 
FROM Employee e 
JOIN Branch b ON e.Branch_no = b.Branch_no 
WHERE e.Position = 'Manager'; 

SELECT DISTINCT c.Customer_name 
FROM IssueStatus i 
JOIN Books b ON i.ISBN_book = b.ISBN 
JOIN Customer c ON i.Issued_cust = c.Customer_Id 
WHERE b.Rental_Price > 3;














