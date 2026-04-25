IF DB_ID('CampusSync') IS NULL
BEGIN
    CREATE DATABASE CampusSync;
END
GO

USE CampusSync;
GO

IF OBJECT_ID('items', 'U') IS NULL
BEGIN
    CREATE TABLE items (
        id INT IDENTITY(1,1) PRIMARY KEY,
        name VARCHAR(120) NOT NULL,
        description VARCHAR(255) NOT NULL,
        category VARCHAR(40) NOT NULL DEFAULT 'Other',
        status VARCHAR(20) NOT NULL DEFAULT 'Lost',
        contact VARCHAR(120) NOT NULL DEFAULT '',
        image_path VARCHAR(500),
        matched_with INT NULL,
        matched_at DATETIME NULL,
        created_at DATETIME NOT NULL DEFAULT GETDATE()
    );
END
GO

IF COL_LENGTH('items', 'category') IS NULL ALTER TABLE items ADD category VARCHAR(40) NOT NULL CONSTRAINT DF_items_category DEFAULT 'Other';
IF COL_LENGTH('items', 'contact') IS NULL ALTER TABLE items ADD contact VARCHAR(120) NOT NULL CONSTRAINT DF_items_contact DEFAULT '';
IF COL_LENGTH('items', 'image_path') IS NULL ALTER TABLE items ADD image_path VARCHAR(500) NULL;
IF COL_LENGTH('items', 'matched_with') IS NULL ALTER TABLE items ADD matched_with INT NULL;
IF COL_LENGTH('items', 'matched_at') IS NULL ALTER TABLE items ADD matched_at DATETIME NULL;
IF COL_LENGTH('items', 'created_at') IS NULL ALTER TABLE items ADD created_at DATETIME NOT NULL CONSTRAINT DF_items_created_at DEFAULT GETDATE();
GO

IF OBJECT_ID('users', 'U') IS NULL
BEGIN
    CREATE TABLE users (
        id INT IDENTITY(1,1) PRIMARY KEY,
        name VARCHAR(80) NOT NULL,
        email VARCHAR(120) NOT NULL,
        username VARCHAR(60) NOT NULL,
        password VARCHAR(80) NOT NULL,
        role VARCHAR(20) NOT NULL DEFAULT 'student'
    );
END
GO

IF COL_LENGTH('users', 'username') IS NULL ALTER TABLE users ADD username VARCHAR(60) NULL;
IF COL_LENGTH('users', 'password') IS NULL ALTER TABLE users ADD password VARCHAR(80) NULL;
UPDATE users SET username = LOWER(REPLACE(name, ' ', '')) WHERE username IS NULL;
UPDATE users SET password = '1234' WHERE password IS NULL;
ALTER TABLE users ALTER COLUMN username VARCHAR(60) NOT NULL;
ALTER TABLE users ALTER COLUMN password VARCHAR(80) NOT NULL;
GO

IF NOT EXISTS (SELECT 1 FROM users WHERE LOWER(username) = 'sakshi')
BEGIN
    INSERT INTO users(name, email, username, password, role)
    VALUES ('Sakshi', 'sakshi@gmail.com', 'sakshi', '1234', 'student');
END
GO

IF OBJECT_ID('skills', 'U') IS NULL
BEGIN
    CREATE TABLE skills (
        id INT IDENTITY(1,1) PRIMARY KEY,
        student_name VARCHAR(120) NOT NULL,
        offered_skill VARCHAR(120) NOT NULL,
        wanted_skill VARCHAR(120) NOT NULL,
        contact VARCHAR(120) NOT NULL,
        meeting_time DATETIME NOT NULL,
        created_at DATETIME NOT NULL DEFAULT GETDATE()
    );
END
GO

IF COL_LENGTH('skills', 'student_name') IS NULL ALTER TABLE skills ADD student_name VARCHAR(120) NOT NULL CONSTRAINT DF_skills_student DEFAULT 'Student';
IF COL_LENGTH('skills', 'offered_skill') IS NULL ALTER TABLE skills ADD offered_skill VARCHAR(120) NOT NULL CONSTRAINT DF_skills_offer DEFAULT 'Skill';
IF COL_LENGTH('skills', 'wanted_skill') IS NULL ALTER TABLE skills ADD wanted_skill VARCHAR(120) NOT NULL CONSTRAINT DF_skills_want DEFAULT 'Skill';
IF COL_LENGTH('skills', 'contact') IS NULL ALTER TABLE skills ADD contact VARCHAR(120) NOT NULL CONSTRAINT DF_skills_contact DEFAULT '';
IF COL_LENGTH('skills', 'meeting_time') IS NULL ALTER TABLE skills ADD meeting_time DATETIME NOT NULL CONSTRAINT DF_skills_meeting DEFAULT GETDATE();
IF COL_LENGTH('skills', 'created_at') IS NULL ALTER TABLE skills ADD created_at DATETIME NOT NULL CONSTRAINT DF_skills_created DEFAULT GETDATE();
GO

IF OBJECT_ID('library_seats', 'U') IS NULL
BEGIN
    CREATE TABLE library_seats (
        id INT IDENTITY(1,1) PRIMARY KEY,
        hall VARCHAR(80) NOT NULL,
        floor_no INT NOT NULL,
        section_name VARCHAR(20) NOT NULL,
        seat_no VARCHAR(20) NOT NULL,
        status VARCHAR(20) NOT NULL DEFAULT 'Available',
        booked_by VARCHAR(120),
        start_time DATETIME NULL,
        end_time DATETIME NULL
    );
END
GO

IF COL_LENGTH('library_seats', 'start_time') IS NULL ALTER TABLE library_seats ADD start_time DATETIME NULL;
IF COL_LENGTH('library_seats', 'end_time') IS NULL ALTER TABLE library_seats ADD end_time DATETIME NULL;
GO

IF OBJECT_ID('professor_slots', 'U') IS NULL
BEGIN
    CREATE TABLE professor_slots (
        id INT IDENTITY(1,1) PRIMARY KEY,
        professor_name VARCHAR(120) NOT NULL,
        subject VARCHAR(80) NOT NULL,
        day_of_week VARCHAR(20) NOT NULL,
        start_time TIME NOT NULL,
        end_time TIME NOT NULL,
        slot_type VARCHAR(20) NOT NULL DEFAULT 'Free',
        status VARCHAR(20) NOT NULL DEFAULT 'Free',
        location VARCHAR(120) NOT NULL DEFAULT 'Faculty Lounge',
        student_name VARCHAR(120),
        topic VARCHAR(255),
        contact VARCHAR(120),
        booked_at DATETIME NULL
    );
END
GO

IF COL_LENGTH('professor_slots', 'slot_type') IS NULL ALTER TABLE professor_slots ADD slot_type VARCHAR(20) NOT NULL CONSTRAINT DF_slots_type DEFAULT 'Free';
IF COL_LENGTH('professor_slots', 'location') IS NULL ALTER TABLE professor_slots ADD location VARCHAR(120) NOT NULL CONSTRAINT DF_slots_location DEFAULT 'Faculty Lounge';
GO

IF NOT EXISTS (SELECT 1 FROM library_seats)
BEGIN
    INSERT INTO library_seats (hall, floor_no, section_name, seat_no, status, booked_by, start_time, end_time) VALUES
    ('Central Hall', 1, 'A', 'A1', 'Booked', 'Demo User', GETDATE(), DATEADD(HOUR, 2, GETDATE())),
    ('Central Hall', 1, 'A', 'A2', 'Available', NULL, NULL, NULL),
    ('Central Hall', 1, 'A', 'A3', 'Available', NULL, NULL, NULL),
    ('Central Hall', 1, 'A', 'A4', 'Booked', 'Demo User', GETDATE(), DATEADD(HOUR, 1, GETDATE())),
    ('Central Hall', 1, 'A', 'A5', 'Available', NULL, NULL, NULL),
    ('Central Hall', 1, 'A', 'B1', 'Available', NULL, NULL, NULL),
    ('Central Hall', 1, 'A', 'B2', 'Booked', 'Demo User', GETDATE(), DATEADD(HOUR, 3, GETDATE())),
    ('Central Hall', 1, 'A', 'B3', 'Available', NULL, NULL, NULL),
    ('Central Hall', 1, 'A', 'B4', 'Available', NULL, NULL, NULL),
    ('Central Hall', 1, 'A', 'B5', 'Available', NULL, NULL, NULL);
END
GO

IF NOT EXISTS (SELECT 1 FROM professor_slots)
BEGIN
    INSERT INTO professor_slots (professor_name, subject, day_of_week, start_time, end_time, slot_type, status, location) VALUES
    ('Ayush Gurjar', 'Object Oriented Programming', 'Monday', '09:00', '10:00', 'Class', 'Busy', 'IT Tower Floor 3 Section A Seat 12'),
    ('Ayush Gurjar', 'Object Oriented Programming', 'Monday', '10:00', '12:00', 'Free', 'Free', 'IT Tower Floor 3 Section A Seat 12'),
    ('Ayush Gurjar', 'Object Oriented Programming', 'Monday', '14:00', '16:00', 'Free', 'Free', 'IT Tower Floor 3 Section A Seat 12'),
    ('Shashwat Shukla', 'Software Engineering', 'Tuesday', '09:00', '11:00', 'Free', 'Free', '10 Block Floor 2 Section B Seat 7'),
    ('Shashwat Shukla', 'Software Engineering', 'Tuesday', '11:00', '13:00', 'Class', 'Busy', '10 Block Floor 2 Section B Seat 7'),
    ('Nisha Verma', 'Linear Algebra', 'Wednesday', '09:00', '12:00', 'Free', 'Free', '9 Block Floor 1 Section C Seat 4'),
    ('Raghav Sharma', 'Python', 'Wednesday', '13:00', '15:00', 'Free', 'Free', 'Hubble Floor 2 Section A Seat 3'),
    ('Meera Iyer', 'DSA', 'Thursday', '10:00', '12:00', 'Free', 'Free', 'IT Tower Floor 4 Section B Seat 11'),
    ('Kabir Khan', 'DAA', 'Thursday', '14:00', '16:00', 'Free', 'Free', '11 Block Floor 3 Section A Seat 9'),
    ('Priya Menon', 'Operating Systems', 'Friday', '09:00', '11:00', 'Free', 'Free', 'IT Tower Floor 2 Section C Seat 6'),
    ('Arjun Rao', 'DBMS', 'Friday', '12:00', '15:00', 'Free', 'Free', '9 Block Floor 2 Section A Seat 10'),
    ('Simran Kaur', 'Computer Networks', 'Saturday', '10:00', '13:00', 'Free', 'Free', '10 Block Floor 1 Section A Seat 2'),
    ('Dev Patel', 'AI Basics', 'Saturday', '14:00', '17:00', 'Free', 'Free', 'Hubble Floor 1 Section B Seat 8');
END
GO
USE CampusSync;
GO

IF COL_LENGTH('users', 'username') IS NULL
    ALTER TABLE users ADD username VARCHAR(60) NULL;

IF COL_LENGTH('users', 'password') IS NULL
    ALTER TABLE users ADD [password] VARCHAR(80) NULL;

UPDATE users
SET username = LOWER(REPLACE(name, ' ', ''))
WHERE username IS NULL OR username = '';

UPDATE users
SET [password] = '1234'
WHERE [password] IS NULL OR [password] = '';

IF NOT EXISTS (SELECT 1 FROM users WHERE LOWER(username) = 'sakshi')
BEGIN
    INSERT INTO users(name, email, username, [password], role)
    VALUES ('Sakshi', 'sakshi@gmail.com', 'sakshi', '1234', 'student');
END

SELECT id, name, email, username, [password], role FROM users;
