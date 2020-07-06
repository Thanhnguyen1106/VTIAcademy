drop database if exists managemente;
CREATE DATABASE if not exists Managemente;
USE Managemente;

/* USE TABLE  (
		trainee_id 	INT,
        full_name	,
        birt_date	DATE,
        gender	
		et_iq		VARCHAR(20),
        et_gmath	VARCHAR(20),
		et_english	VARCHAR(50),
        training_class	INT,
        ev_assessment	INT,
); */
DROP DATABASE IF EXISTS testingsystem;
CREATE DATABASE IF NOT EXISTS testingsystem;
USE testingsystem;

CREATE TABLE `department` (
    department_id 		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    department_name 	NVARCHAR(100) NOT NULL
);

CREATE TABLE `position` (
    position_id 		INT PRIMARY KEY,
    position_name 		NVARCHAR(50) NOT NULL
);

CREATE TABLE `account` (
    account_id 		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    email 			VARCHAR(50) NOT NULL,
    username 		VARCHAR(50) NOT NULL,
    fullname 		NVARCHAR(100) NOT NULL,
    department_id 	TINYINT AUTO_INCREMENT,
    position_id 	INT,
    create_date 	DATE,
    FOREIGN KEY (departmen_id) REFERENCES `department` (department_id),
    FOREIGN KEY (position_id)  REFERENCES position (position_id)
);

CREATE TABLE `group` (
    group_id 		INT PRIMARY KEY,
    group_name 		NVARCHAR(50) NOT NULL,
    creator_id 		TINYINT AUTO_INCREMENT,
    create_date 	DATETIME,
    FOREIGN KEY (creator_id) REFERENCES `account` (account_id)
);
CREATE TABLE `groupaccount` (
    group_id 		INT PRIMARY KEY,
    account_id		TINYINT UNSIGNED AUTO_INCREMENT,
    join_date 		datetime,
    FOREIGN KEY (group_id)   REFERENCES `group` (group_id),
    FOREIGN KEY (account_id) REFERENCES `account` (account_id)
);

CREATE TABLE `TypeQuestion` (
    Type_id 		TINYINT AUTO_INCREMENT PRIMARY KEY,
    Type_name		ENUM('essay','multiple-choice')
);

CREATE TABLE `CategoryQuestion` (
    Category_id 	INT PRIMARY KEY AUTO_INCREMENT,
    Category_name 	VARCHAR(50) NOT NULL
);

CREATE TABLE `Question` (
    Question_id 	TINYINT AUTO_INCREMENT,
    content 		TEXT,
    Category_id 	INT AUTO_INCREMENT PRIMARY KEY,
    Type_id 		INT AUTO_INCREMENT,
    creator_id 		INT AUTO_INCREMENT,
    create_Date 	DATETIME
);

CREATE TABLE `Answer` (
    Answer_id 		INT PRIMARY KEY AUTO_INCREMENT,
    Content 		NVARCHAR(100) NOT NULL,
    QuestionI_id 	INT AUTO_INCREMENT,
    isCorrect 		VARCHAR(50) NOT NULL
);

CREATE TABLE `Exam` (
    Exam_id 		INT AUTO_INCREMENT,
    code_1 			INT AUTO_INCREMENT PRIMARY KEY,
    Title 			VARCHAR(50) NOT NULL,
    Category_id 	INT AUTO_INCREMENT,
    Duration 		DATETIME,
    Creator_id 		INT AUTO_INCREMENT,
    Create_date 	DATETIME,
    FOREIGN KEY (creator_id)  REFERENCES question (creator_id),
    FOREIGN KEY (Create_date) REFERENCES question (create_date),
    FOREIGN KEY (category_id) REFERENCES question (category_id)
);

CREATE TABLE `ExamQuestion` (
    Exam_id 		INT AUTO_INCREMENT,
    Question_id 	INT PRIMARY KEY NOT NULL,
    FOREIGN KEY (exam_id) 	  REFERENCES exam (exam_id),
    FOREIGN KEY (question_id) REFERENCES exam (question_id)
);












	


