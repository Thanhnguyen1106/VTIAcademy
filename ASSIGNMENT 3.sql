

-- QS2
USE 		TESTINGSYSTEM;
SELECT *
FROM 		department;
-- QS3
USE 		TESTINGSYSTEM;
SELECT * 
FROM 		department
where 		departmentNAME = "sale";
-- QS 4
SELECT *, 	 MAX(length(FULLNAME))
FROM 		`ACCOUNT`;

SELECT *
FROM ACCOUNT
WHERE LENGTH(FULLNAME) = (SELECT MAX(LENGTH(FULLNAME))
										FROM `ACCOUNT`)
  ORDER BY  FULLNAME DESC;                                    
  -- Question 5: Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id = 3
  
  SELECT *,    LENGTH(FULLNAME)
  FROM `account`
 WHERE    DEPARTMENTID= 3 AND  LENGTH(FULLNAME) = (SELECT  MAX(LENGTH(FULLNAME))
										FROM `ACCOUNT`);                                   
-- Question 6: lấy ra tên group đã tham gia trước ngày 20/12/2019 
    
SELECT 		groupname
FROM 		`group`
where 		 CreateDate <= '2019-12-20' ;
 -- Question 7: Lấy ra ID của question có >= 4 câu trả lời\
 
 SELECT 	QuestionID, COUNT(QuestionID), GROUP_CONCAT(Content)
FROM 		answer
GROUP BY 	QuestionID
HAVING 		COUNT(QuestionID) >= 4;
-- Question 8: Lấy ra các mã đề thi có thời gian thi >= 60 phút  
  
select * 
from 		exam 
where  		CreateDate < '2019-12-20' and Duration >= 60; 
   
-- Question 9: Lấy ra 5 group được tạo gần đây nhất      

select  	Groupname
from 		`group`
order by 	createdate desc
limit 5;


-- Question 10: Đếm số nhân viên thuộc department có id = 2

select * ,		count(1)
from 		`account`
where 	departmentid in (2);

-- Question 11: Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"

SELECT *
FROM	`account`
WHERE FullName LIKE 'D % o';

-- Question 12: xóa tất cả các exam được tạo trước ngày 20/12/2019

SELECT  *
FROM `exam`;
set 		foreign_key_checks = 0;
DELETE FROM exam 
WHERE 		CreateDate < '2019-12-20';


-- Question 13: xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"

set 		foreign_key_checks = 0;
DELETE FROM question 
WHERE 		Content LIKE 'câu hỏi %';
    
    -- Question 14: update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn
    
UPDATE	 `account` 
SET	 		FullName = 'Nguyễn Bá Lộc', Email = 'loc.nguyenba@vti.com.vn'
WHERE	 AccountID = 5;

-- Question 15: update account có id = 5 sẽ thuộc group có id = 4

UPDATE groupaccount 
SET  GroupID = 4
WHERE AccountID = 5;

