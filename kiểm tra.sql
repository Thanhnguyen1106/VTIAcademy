DROP DATABASE IF EXISTS			 quanlidiem;
CREATE DATABASE IF NOT EXISTS	 quanlidiem;
USE								 quanlidiem;

DROP TABLE IF EXISTS Student;
CREATE TABLE Student(
		RN 				 TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        `Name`				NVARCHAR(50) NOT NULL,
        Age					TINYINT UNSIGNED NOT NULL,
        Gender				NVARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS 			`Subject`;
CREATE TABLE 					`Subject`(
		S_id    			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        S_name				NVARCHAR(50) NOT NULL UNIQUE KEY
);

DROP TABLE IF EXISTS 	StudentSubject;
CREATE TABLE 			StudentSubject (
		RN 					TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        S_id				TINYINT UNSIGNED NOT NULL,
        MARK				NVARCHAR(100) NOT NULL,
       ` Date`				DATETIME DEFAULT NOW(),
       FOREIGN KEY	(RN) REFERENCES Student(RN)
      
);
       
 INSERT INTO	 Student (RN	,	`NAME`		,		AGE		,		Gender		)
    VALUES          	 ('1'	,	'HOA'		,       '10'		,  ' NU'		),
						('2'	,	'NGA'		,		'12'		,	'NU'		),
						('3'	,	'HOANG'		,		'13'		,	'NAM'		);
                    
  INSERT INTO 	`Subject` 	( S_ID		, 		S_NAME)
  VALUES  					('1'		,		'HOABD'),
							('2'		, 		'NGALM'),
                            ('3'		,		'HOANGBA');
                       
    INSERT INTO  StudentSubject (RN		,		S_ID		,		MARK		,		'DATE'    )            
	VALUES    		             ('1'		,		'3'			,       '8'			,  '2019-03-09' ),
								('2'	,		'4'			,		'9'			,	'2019-03-07'	),
								('3'	,		'5'			,		'10'		,	'2019-03-05'	);
                                
select *
FROM 	`Subject` 
WHERE  S_ID='NULL';


SELECT *
FROM `Subject` 
WHERE  S_ID >= 2;

DROP VIEW IF exists StudentInfo ;
CREATE VIEW StudentInfo AS
SELECT * 
FROM Student
JOIN StudentSubject USING(RN);

UPDATE STUDENT 
SET GENDER ;



DROP TRIGGER IF EXISTS `CasSubject`;
DELIMITER  $$
CREATE TRIGGER `Subject`
before insert on S_ID

FOR EACH ROW
BEGIN

 



