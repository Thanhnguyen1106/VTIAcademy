-- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ

select * 
from 	department d1
join `account`a1 on d1.departmentid = a1.departmentid ;

-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010

select	 *
from 	`account` 
where 	createdate > 2010/12/20;

-- Question 3: Viết lệnh để lấy ra tất cả các developer
use 	testingsystem;
select 	*
from 	`account` 
join position using (positionid)
where positionname='dev';

-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên

select * 
from department 
where DepartmentID > 3;

-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất

select *, count(1)
from examquestion
group by questionid 
order by count(1) desc
limit 1;
 
select *, count(1), group_concat(examid)
from examquestion
group by questionid 
having count(1) =3;

SELECT *,count(1),group_concat(ExamID)
FROM	examquestion
group by QuestionID
having count(1) = (	SELECT MAX(tansuatcauhoi)
					From (	SELECT count(1) AS tansuatcauhoi,QuestionID
					FROM	examquestion
					group by QuestionID) AS table_tamp);

-- Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
select * ,count(1) as thong_ke
from question
group by CategoryID;

-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
SELECT *, COUNT(1)
FROM examquestion
GROUP BY QuestionID;

-- Question 8: Lấy ra Question có nhiều câu trả lời nhất
select *, count(1), QuestionID ,group_concat(Answers)
from answer
group by QuestionId
order by count(1) desc
limit 1;

-- lấy ra danh sách câu hỏi có câu tl =4
select * , count(1), group_concat(Content)
from answer
group by QuestionID
having count(1)=4;

-- Question 9: Thống kê số lượng account trong mỗi group
-- Question 10: Tìm danh sách chức vụ có ít người nhất
select * , count(1)
from `account` 
group by positionid
order by count(1)
limit 1;

select *,group_concat(AccountID)
from `account`
join position using(positionid)
group by PositionID
having count(1) = 2;


-- Question 13: lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
select *, count(1)
from question q1
join typequestion type2 on q1.TypeID = type2.TypeID
group by q1.TypeId;

-- Question 14 +15: lấy ra group không có account nào

select g.groupid, g.groupname,accountid
from `group`g
left join groupaccount ga on g.groupid = ga.groupid
where ga.accountid is null
group by g.groupid;

-- Question 16: lấy ra question không có answer nào
select *
from question q
left join answer a on q.questionid = a.questionid
where a.answers is null
group by q.questionid;


/*DQuestion 17:
a) Lấy các account thuộc nhóm thứ 1
b) Lấy các account thuộc nhóm thứ 2
c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau*/

select AccountID
from groupaccount
where groupid  =1
union 
select accountid
from groupaccount
where groupid  =3;

set foreign_key_checks = 0;

/*Question 18:
a) Lấy các group có lớn hơn 5 thành viên
b) Lấy các group có nhỏ hơn 7 thành viên
c) Ghép 2 kết quả từ câu a) và câu b)*/

select groupid , accountid
from `groupaccount`
where accountid >5
union
select groupid, accountid
from `groupaccount`
where groupid <7;
 

























