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

CREATE TABLE `department`(
	department_id 	tinyint  auto_increment primary key,
    department_name NVARCHAR(100) NOT NULL
);

CREATE TABLE `position`(
position_id	 		INT primary key,
position_name 	 	NVARCHAR(50) NOT NULL
);

CREATE TABLE `account` (
    account_id 		TINYINT  unsigned auto_increment primary KEY,
    email 			VARCHAR(50) NOT NULL,
    username 		VARCHAR(50) NOT NULL,
    fullname 		NVARCHAR(100) NOT NULL,
    department_id 	tinyint auto_increment,
    position_id 	int, 
    create_date 	DATE,
    foreign key (departmen_id) references `department` (department_id),
    foreign key (position_id) references position (position_id),
);

CREATE TABLE `group`(
	group_id		INT primary KEY,
	group_name 		NVARCHAR(50) not null,
	creator_id 		INT auto_increment,
	create_date	 	DATEtime
);
CREATE TABLE `groupaccount`(
	group_id 		INT primary key,
	account_id		INT auto_increment,
	join_id 		DATEtime,
    foreign key (group_id) references `group`(group_id),
    foreign key (account_id) references `account`(account_id)
);

CREATE TABLE `TypeQuestion`(
	Type_id 		tinyint auto_increment primary key,
	Type_name		NVARCHAR(50) not null
);

CREATE TABLE `CategoryQuestion`(
	Category_id 	INT primary key auto_increment,
	Category_name	VARCHAR(50) not null
);

CREATE TABLE `Question` (
	Question_id 	tinyint auto_increment,
	content 		VARCHAR(50) not null,
	Category_id 	INT auto_increment primary key,
	Type_id			int auto_increment,
	creator_id 		INT auto_increment,
	create_Date 	DATEtime
);

CREATE TABLE `Answer` (
	Answer_id 		INT primary key auto_increment,
	Content 		NVARCHAR(100) not null,
	QuestionI_id 	INT auto_increment,
	isCorrect 		VARCHAR(50) not null
    
);

CREATE TABLE `Exam`(
	Exam_id 		INT auto_increment,
	code_1 			INT auto_increment primary key,
	Title			VARCHAR(50) not null,
	Category_id 	int auto_increment,
	Duration 		DATEtime,
	Creator_id 		INT auto_increment,
	Create_date 	DATEtime,
    foreign key (creator_id) references question (creator_id),
	foreign key (Create_date) references question (create_date),
    foreign key (category_id) references question (category_id)
);

CREATE TABLE `ExamQuestion` (
	Exam_id			 INT auto_increment,
	Question_id		 INT primary key not null,
    foreign key (exam_id) references exam (exam_id),
    foreign key (question_id) references exam (question_id)
    
);












	


