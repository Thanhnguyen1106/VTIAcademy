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
USE testingsystym;

CREATE TABLE `department`(
	department_id 	INT,
    department_name VARCHAR(50)
);

CREATE TABLE `position`(
position_id	 		INT,
position_name 	 	VARCHAR(50)
);

CREATE TABLE `account`(
	account_id		INT,
	email	 		INT,
	username 		INT,
	fullname 		INT,
	department_id 	INT,
	position_id 	VARCHAR(50),
	create_date		DATE
);

CREATE TABLE `group`(
	group_id		INT,
	group_name 		VARCHAR(50),
	creator_id 		INT,
	create_date	 	DATE
);
CREATE TABLE `groupaccount`(
	group_id 		INT,
	account_id		VARCHAR(50),
	join_id 		DATE
);

CREATE TABLE `TypeQuestion`(
	Type_id 		INT,
	Type_name		VARCHAR(50)
);

CREATE TABLE `CategoryQuestion`(
	Category_id 	INT,
	Category_name	VARCHAR(50)
);

CREATE TABLE `Question` (
	Question_id 	INT,
	content 		VARCHAR(50),
	Category_id 	INT,
	Type_id			INT,
	creator_id 		INT,
	create_Date 	DATE
	);

CREATE TABLE `Answer` (
	Answer_id 		INT,
	Content 		VARCHAR(50),
	QuestionI_id 	INT,
	isCorrect 		VARCHAR(50)
);

CREATE TABLE `Exam`(
	Exam_id 		INT,
	code_1 			INT,
	Title			INT,
	Category_id 	INT,
	Duration 		DATE,
	Creator_id 		INT,
	Create_date 	DATE
);

CREATE TABLE `ExamQuestion` (
	Exam_id			 INT,
	Question_id		 INT
);












	


