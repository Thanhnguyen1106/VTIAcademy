-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale 
-- c1
DROP VIEW if exists pv_department;
create view pv_department as
select * 
from `account`
where DepartmentID =2;

select *
from pv_department;
-- c2
WITH CTE_account AS

    (SELECT AccountID,FullName,Email,DepartmentID
    FROM
        `account`
    WHERE
        DepartmentID = 2)
SELECT *
FROM CTE_account;

-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
-- c1 
DROP VIEW IF exists AG_ACCOUNT ;
CREATE VIEW AG_ACCOUNT AS
    
-- tim dah sach cac tài khoản có tham gia 3 group
	SELECT *,count(1)
    FROM `groupaccount`    
    group by accountid
    having count(1) = (SELECT 
							COUNT(1)
						FROM
							`groupaccount`
						GROUP BY accountid
						ORDER BY COUNT(1) DESC
						LIMIT 1);


select *
from AG_ACCOUNT;

-- c2 
with cte_account as
(SELECT groupid , accountid ,count(1)
    FROM `groupaccount`    
    group by accountid
    having count(1) = (SELECT 
							COUNT(1)
						FROM
							`groupaccount`
						GROUP BY accountid
						ORDER BY COUNT(1) DESC
						LIMIT 1)
)
SELECT *
FROM CTE_account;

-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ
-- được coi là quá dài) và xóa nó đi
drop view  if exists ch_content;
create view ch_content as
select * ,count(1)
from question
where  length(content) >=300;
drop view ch_content ;

-- c2
with cte_content  as
(	select * ,count(1)
from question
where  length(content) >=300

)
select *
from ch_content;
drop  view cte_content;

-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất
drop view if exists d_department;
create view d_department as
select *,group_concat(fullname,accountid)
from `account`
join department using (departmentid)
group by departmentid
having count(1) = (select count(1)
					from `account`
					group by departmentid
					order by count(1) desc
					limit 1);
select *
from d_department;
-- c2
with cte_department as
(select *,group_concat(fullname,accountid)
from `account`
join department using (departmentid)
group by departmentid
having count(1) = (select count(1)
					from `account`
					group by departmentid
					order by count(1) desc
					limit 1)

)
select *
from cte_department ;



-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
drop view if exists  ho_nguyen;
create  view ho_nguyen as
select *
from `account` a
join question q on a.accountid = q.creatorid
where fullname like 'Nguyễn%'
group by QuestionID;

select *
from ho_nguyen;

-- c2
with cte_nguyen as 
(select group_concat(content),creatorid, accountid,fullname
from `account` a
join question q on a.accountid = q.creatorid
where fullname like 'Nguyễn%'
group by QuestionID)
select *
from cte_nguyen;


