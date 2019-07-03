# 1.查询同时存在1课程和2课程的情况
select * from student where id in(
select studentId from student_course 
where courseId=1 and studentId in 
(select studentId from student_course where courseId=2));
# 2.查询同时存在1课程和2课程的情况
select * from student where id in 
(select sc1.studentId from student_course sc1,student_course sc2
where sc1.studentId=sc2.studentId and sc1.courseId=1 and sc2.courseId=2);
# 3.查询平均成绩大于等于60分的同学的学生编号和学生姓名和平均成绩
select s.id,s.name,avg(sc.score) 
from student s inner join student_course sc on s.id=sc.studentId
group by s.id,s.name having avg(sc.score)>=60;
# 4.查询在student_course表中不存在成绩的学生信息的SQL语句
select * from student 
where student.id=
(select student.id from student 
where student.id not in
(select studentId from student_course));

# 5.查询所有有成绩的SQL		?
	#查询所有科目都有成绩的学生信息
	select * from student where id in(
	select studentId from student_course 
	group by studentId having count(score)=(select count(*) from course));

# 6.查询学过编号为1并且也学过编号为2的课程的同学的信息
select * from student where id in(select studentId from student_course 
where courseId=1 and studentId in 
(select studentId from student_course where courseId=2));
# 7.检索1课程分数小于60，按分数降序排列的学生信息
select * from student 
where id in (select student_course.studentId from student_course 
where courseId=1 and score<60 order by score desc);
# 8.查询每门课程的平均成绩，结果按平均成绩降序排列，平均成绩相同时，按课程编号升序排列
select sc.courseId,c.name,avg(score) from student_course sc
inner join course c on sc.courseId=c.id
group by sc.courseId,c.name order by avg(score) desc ,sc.courseId asc;
# 9.查询课程名称为"数学"，且分数低于60的学生姓名和分数
select s.name,score 
from course c inner join student_course sc on c.id=sc.courseId
inner join student s on sc.studentId=s.id
where c.name='数学' and score<60;
