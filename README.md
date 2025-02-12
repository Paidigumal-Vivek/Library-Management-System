# Library-Management-System

**Author:** Paidigumal Vivek Patil 

---

## Project Overview

The Library Management System is a database-driven project designed to automate and streamline library operations. It helps manage materials, members, borrowing activities, and staff records efficiently. The system enables easy cataloging, borrowing, returning, and querying of materials to improve accessibility and operational efficiency.

---

## Features

-**Material Cataloging:** Manages books, magazines, e-books, and audiobooks.  
-**Member Management:** Handles member registration, contact details, and membership tracking.  
-**Borrowing System:** Tracks borrowing and returning of materials with due dates.  
-**Author Records:** Stores detailed author information and links them to authored materials.  
-**Staff Management:** Manages library staff records, job roles, and responsibilities.  
-**Querying Platform:** Allows users to search for materials by title, author, or genre.  

---

## Files in the Repository

### **Final Report** (`FINAL REPORT.pdf`)
- Detailed project documentation covering:
  - Project scope
  - ER Diagram & Relational Schema
  - Database schema design
  - System functionalities and extended features

### **Database Schema & SQL Scripts** (`Code.sql`)
- **SQL scripts** to create and manage the database.
- Includes:
  - Table creation (`CREATE TABLE`)
  - Data loading (`LOAD DATA INFILE`)
  - Schema definitions

### **CSV Data Files**
- **Author.csv** → Author details  
- **Authorship.csv** → Relationship between authors and materials  
- **Borrow.csv** → Borrowing transactions  
- **Catalog.csv** → Library catalog details  
- **Genre.csv** → Classification of books by genre  
- **Material.csv** → List of materials (books, e-books, etc.)  
- **Member.csv** → Library members' information  

---

## Database Schema

### **Entities & Relationships**
- **Material** → Books, e-books, etc.
- **Catalog** → Organizes library materials  
- **Genre** → Categorizes materials into fiction, non-fiction, etc.  
- **Member** → Represents registered library users  
- **Staff** → Library employees  
- **Borrow** → Tracks book borrowing transactions  
- **Author** → Stores author details  
- **Authorship** → Many-to-many relationship between authors and materials  

---

## Installation & Usage

### **Set up MySQL**
- Install MySQL Server on your system.
- Create a new database.

### **Load SQL Schema**
- Run the SQL script to create tables.

### **Load Sample Data**
- Use `LOAD DATA INFILE` to populate tables with CSV files.

### **Run Queries**
- Execute queries to interact with the system.

---

## Extended Features
-**Daily Overdue Alerts:** Auto-detect overdue books  
-**Membership Auto-Deactivation:** Suspend members with 3+ overdue books  
-**Real-time Queries:** Instant access to material availability  

---

## Future Enhancements
-Add a web interface for managing the library  
-Implement barcode scanning for fast checkouts  
-Integrate REST API for remote access  

