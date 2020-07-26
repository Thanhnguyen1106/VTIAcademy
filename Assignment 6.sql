DROP PROCEDURE IF EXISTS getInfoAccount;
DELIMITER $$
CREATE PROCEDURE getInfoAccount(IN user_name VARCHAR(100)
								,OUT account_id INT) 
	BEGIN
		SELECT AccountID INTO account_id
        FROM Account
        WHERE Username = user_name;		
	END $$
DELIMITER ;
set @account_id = 0;
call testingdemo.getInfoAccount('dangblack',@account_id);
select @account_id;

-- Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các
-- account thuộc phòng ban đó
DROP PROCEDURE IF EXISTS getInfoAccountOfDept;
DELIMITER $$
CREATE PROCEDURE getInfoAccountOfDept(IN department_name VARCHAR(100)) 
 BEGIN
 SELECT *
        FROM `Account`
        WHERE DepartmentID = ( SELECT DepartmentID
								FROM department
								WHERE DepartmentName = department_name); 
 END $$
DELIMITER ;
call testingdemo.getInfoAccountOfDept('Nhân sự');

-- Question 2: Tạo store để in ra số lượng account trong mỗi group
use testingsystem;
DROP procedure IF EXISTS Question2;
DELIMITER $$
CREATE PROCEDURE Question2()
	begin
		select*, count(1), group_concat(accountid)
		from groupaccount
		group by groupid;
	end $$
DELIMITER ;
call testingsystem.question2();

-- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo
-- trong tháng hiện tại
drop procedure IF EXISTS Question3;
delimiter $$
create  procedure Question3()
	begin
		 select typeid ,count(questionid) as "số câu", createdate
		 from question 
		 group by typeid
		 having month(createdate)= month(now());
		 end $$
delimiter ;
call testingsystem.question3();

-- Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất

-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question
/* Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên
chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa chuỗi của
người dùng nhập vào*/
drop procedure if exists Question6;
delimiter $$
create procedure Question6(in nhap_vao varchar(50))
begin
		 SELECT AccountID As ID,Username As `name`,1
        FROM `account` a
        WHERE  Username   LIKE CONCAT('%' , nhap_vao , '%')
        UNION ALL
        SELECT GroupID As ID,GroupName As `name`,2
        FROM `group` a
        WHERE  GroupName   LIKE CONCAT('%' , nhap_vao , '%');   
end $$
delimiter ;
call testingsystem.Question6 ('vti');
/*Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và
trong store sẽ tự động gán
username sẽ giống email nhưng bỏ phần @..mail đi
positionID: sẽ có default là developer
departmentID: sẽ được cho vào 1 phòng chờ
Sau đó in ra kết quả tạo thành công*/
drop procedure if exists Question7;
delimiter $$
create procedure Question7(in in_email varchar(50),in in_fullname nvarchar(50))
		BEGIN
				DECLARE 		Username VARCHAR(150) DEFAULT SUBSTRING_INDEX(in_email,'@',1);
                -- SELECT SUBSTRING_INDEX("cuongnm@gmail.com.vn", "@", 1);
				DECLARE 		PositionID TINYINT UNSIGNED DEFAULT 1;
				DECLARE			 DepartmentID TINYINT UNSIGNED DEFAULT 10;
				set				 FOREIGN_KEY_CHECKS = 0;
				INSERT INTO 	`Account` (Email ,Username, FullName , DepartmentID, PositionID)
				VALUE 			(in_email ,Username, in_fullName , DepartmentID, PositionID);
				SELECT *
				FROM 			`Account`A
				WHERE 			A.Username = Username;
				END$$
DELIMITER ;
call testingsystem.Question7('thanhnh3@vienthongtin.com', ' nguyen huu thanh');

select *
from department;

-- Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice --
-- để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất --

DROP PROCEDURE IF EXISTS Question8;
DELIMITER $$
CREATE PROCEDURE Question8 (IN in_type_name ENUM('Essay', 'Multiple-Choice'))
BEGIN
	SELECT q.Content, LENGTH(q.Content) AS length_of_content
    FROM question q
    WHERE LENGTH(q.Content) = (SELECT MAX(LENGTH(q.Content))
							   FROM question q
							   JOIN typequestion tq ON q.TypeID = tq.TypeID
                               WHERE tq.TypeName = in_type_name);
END$$
DELIMITER ; 

CALL Question8 ('Essay');

CALL Question8 ('Multiple Choice');

-- Question 9: Viết 1 store cho phép người dùng xóa exam dựa vào ID 
DROP PROCEDURE IF EXISTS Question9;
DELIMITER $$
CREATE PROCEDURE Question9 (IN in_exam_id TINYINT)
BEGIN
	DELETE FROM examquestion 
    WHERE ExamID = in_exam_id;
    
    DELETE FROM exam
    WHERE ExamID = in_exam_id;
END$$
DELIMITER ;

CALL Question9(3);
-- Question 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử
-- dụng store ở câu 9 để xóa), sau đó in số lượng record đã remove từ các table liên quan
-- trong khi removing
DROP PROCEDURE IF EXISTS sp_DeleteUser3Years;
DELIMITER $$
CREATE PROCEDURE sp_DeleteUser3Years()
BEGIN
 SET foreign_key_checks = 0;
 WITH ExamID3Year AS(
 SELECT  ExamID
 FROM  Exam
 WHERE (YEAR(NOW()) - YEAR(CreateDate)) > 3
    )    
 DELETE
    FROM Exam
    WHERE ExamID = (
 SELECT * FROM ExamID3Year
    );
END$$
DELIMITER ;
call  sp_DeleteUser3Years;
select *
FROM  Exam;
-- question 11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng
-- nhập vào tên phòng ban và các account thuộc phòng ban đó sẽ được chuyển về phòng
-- ban default là phòng ban chờ việc
DROP PROCEDURE IF EXISTS sp_DeleteDepartment;
DELIMITER $$
CREATE PROCEDURE sp_DeleteDepartment (IN in_DepartmentName NVARCHAR(50))
BEGIN
	SET foreign_key_checks = 0;
	UPDATE  `Account`
    SET DepartmentID = 10
    WHERE DepartmentID = (SELECT  DepartmentID 
							FROM Department
							WHERE  DepartmentName = in_DepartmentName);
	DELETE 
	FROM Department
    WHERE DepartmentName = in_DepartmentName;
END$$
DELIMITER ;
call  sp_DeleteDepartment;
-- Question 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm nay --

DROP PROCEDURE IF EXISTS Question12 ;
DELIMITER $$
CREATE PROCEDURE Question12()
BEGIN
	SELECT months_in_year.`month`, COUNT(q.QuestionID) AS number_of_questions
	FROM question q 
    RIGHT JOIN (SELECT 1 AS `month` UNION
				SELECT 2 AS `month` UNION
				SELECT 3 AS `month` UNION
				SELECT 4 AS `month` UNION
				SELECT 5 AS `month` UNION
				SELECT 6 AS `month` UNION
				SELECT 7 AS `month` UNION
				SELECT 8 AS `month` UNION
				SELECT 9 AS `month` UNION
				SELECT 10 AS `month` UNION
				SELECT 11 AS `month` UNION
				SELECT 12 AS `month`) AS months_in_year
	ON MONTH(q.CreateDate) = months_in_year.`month`
	WHERE YEAR(q.CreateDate) = YEAR(NOW())
	-- WHERE DATE_FORMAT(q.create_date, '%Y') = DATE_FORMAT(NOW(), '%Y')
	GROUP BY months_in_year.`month`;
END$$
DELIMITER ;

CALL Question12();
-- Question 13: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong --
-- 6 tháng gần đây nhất (nếu tháng nào không có thì sẽ in ra là 'không có câu hỏi nào trong tháng') --

DROP PROCEDURE IF EXISTS Question13;
DELIMITER $$
CREATE PROCEDURE Question13()
BEGIN
	SELECT last_six_months.`month`, 
    IF(COUNT(q.QuestionID) = 0, 'khong co cau hoi nao trong thang', COUNT(q.QuestionID)) AS number_of_questions
	FROM (SELECT MONTH(CURRENT_DATE - INTERVAL 5 MONTH) AS `month` UNION
		  SELECT MONTH(CURRENT_DATE - INTERVAL 4 MONTH) AS `month` UNION
		  SELECT MONTH(CURRENT_DATE - INTERVAL 3 MONTH) AS `month` UNION
		  SELECT MONTH(CURRENT_DATE - INTERVAL 2 MONTH) AS `month` UNION
		  SELECT MONTH(CURRENT_DATE - INTERVAL 1 MONTH) AS `month` UNION
		  SELECT MONTH(CURRENT_DATE - INTERVAL 0 MONTH) AS `month`) AS last_six_months
	LEFT JOIN question q ON last_six_months.`month` = MONTH(q.CreateDate)
	GROUP BY last_six_months.`month`;
END$$
DELIMITER ;

CALL Question13();