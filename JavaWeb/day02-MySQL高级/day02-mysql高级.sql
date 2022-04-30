-- 约束

-- 创建员工表
USE demo1;
CREATE TABLE emp (
id INT, -- 员工id，主键且自增长
ename VARCHAR(50), -- 员工姓名，非空且唯一
joindate DATE, -- 入职日期，非空
salary DOUBLE(7,2), -- 工资，非空
bonus DOUBLE(7,2) -- 奖金，如果没有将近默认为0
);

SELECT *
FROM emp;

DROP TABLE IF EXISTS emp;

-- 根据上表具体要求,重新添加约束


CREATE TABLE emp (
id INT PRIMARY KEY, -- 员工id，主键且自增长
ename VARCHAR(50) NOT NULL UNIQUE, -- 员工姓名，非空并且唯一
joindate DATE NOT NULL , -- 入职日期，非空
salary DOUBLE(7,2) NOT NULL , -- 工资，非空
bonus DOUBLE(7,2) DEFAULT 0 -- 奖金，如果没有奖金默认为0
);


-- 添加数据

INSERT INTO emp(id,ename,joindate,salary,bonus) VALUES(1,'张三','1999-11-11',8800,5000);


INSERT INTO emp(id,ename,joindate,salary,bonus) VALUES(null,'张三','1999-11-11',8800,5000);

-- 添加自动增长


-- 1. 查看信息

SELECT * FROM emp;

-- 2.删除id列
ALTER TABLE emp drop id;

-- 3.重新添加自增
ALTER TABLE emp add COLUMN id int NOT NULL auto_increment PRIMARY KEY FIRST; # first 将id字段放置到表格第一条

-- 4.验证自动增长
INSERT INTO emp(ename,joindate,salary,bonus) values('赵六','1999-11-11',8800,null);


-- 删除表
DROP TABLE IF EXISTS emp;
DROP TABLE IF EXISTS dept;


-- 外键约束

-- 部门表
CREATE TABLE dept(
id int primary key auto_increment, # 自增
dep_name varchar(20),
addr varchar(20)
);

-- 员工表
CREATE TABLE emp(
id int primary key auto_increment,
name varchar(20),
age int,
dep_id int,
-- 添加外键 dep_id,关联 dept 表的id主键
CONSTRAINT fk_emp_dept FOREIGN KEY(dep_id) REFERENCES dept(id)
# [CONSTRAINT] [外键名称] FOREIGN KEY(外键列名) REFERENCES 主表(主表列名)
);


-- 删除外键

ALTER TABLE 表名 DROP FOREIGN KEY 外键名称;




-- 多表查询

DROP TABLE IF EXISTS emp;
DROP TABLE IF EXISTS dept;

# 创建部门表
CREATE TABLE dept(
did INT PRIMARY KEY AUTO_INCREMENT,
dname VARCHAR(20)
);

# 创建员工表
CREATE TABLE emp (
id INT PRIMARY KEY AUTO_INCREMENT,
NAME VARCHAR(10),
gender CHAR(1), -- 性别
salary DOUBLE, -- 工资
join_date DATE, -- 入职日期
dep_id INT,
FOREIGN KEY (dep_id) REFERENCES dept(did) -- 外键，关联部门表(部门表的主键)
);

-- 添加部门数据
INSERT INTO dept (dNAME) VALUES ('研发部'),('市场部'),('财务部'),('销售部');

-- 添加员工数据
INSERT INTO emp(NAME,gender,salary,join_date,dep_id) VALUES
('孙悟空','男',7200,'2013-02-24',1),
('猪八戒','男',3600,'2010-12-02',2),
('唐僧','男',9000,'2008-08-08',2),
('白骨精','女',5000,'2015-10-07',3),
('蜘蛛精','女',4500,'2011-03-14',1),
('小白龙','男',2500,'2011-02-14',null);

SELECT * FROM emp;
SELECT * FROM dept;

-- 多表查询

SELECT * FROM emp,dept WHERE emp.dep_id=dept.did; # 值相等,筛选掉重复值(只有两表id号一致才显示信息)


-- 查询 emp的 name， gender，dept表的dname

-- method1 隐式内连接

SELECT emp.name,emp.gender,dept.dname FROM emp,dept where emp.id=dept.did;

-- method2 隐式内连接(重命名表名,方便书写)

SELECT t1.name,t1.gender,t2.dname FROM emp t1,dept t2 where t1.id=t2.did;

-- method3 显式内连接

SELECT emp.name,emp.gender,dept.dname FROM emp INNER JOIN dept ON emp.dep_id=dept.did;

SELECT emp.name,emp.gender,dept.dname FROM emp JOIN dept ON emp.dep_id=dept.did; # INNER 可省略不写

-- 查询emp表所有数据和对应的部门信息（左外连接）

SELECT * FROM emp LEFT JOIN dept ON emp.dep_id=dept.did;

-- 查询dept表所有数据和对应的员工信息（右外连接）

SELECT * FROM emp RIGHT JOIN dept ON emp.dep_id=dept.did;

-- 查询dept表所有数据和对应的员工信息（左外连接）

SELECT * FROM dept LEFT JOIN emp ON emp.dep_id=dept.did;


-- 子查询(嵌套查询)

DROP TABLE IF EXISTS emp;
DROP TABLE IF EXISTS dept;
DROP TABLE IF EXISTS job;
DROP TABLE IF EXISTS salarygrade;

-- 部门表
CREATE TABLE dept (
id INT PRIMARY KEY PRIMARY KEY, -- 部门id
dname VARCHAR(50), -- 部门名称
loc VARCHAR(50) -- 部门所在地
);

-- 职务表，职务名称，职务描述
CREATE TABLE job (
id INT PRIMARY KEY,
jname VARCHAR(20),
description VARCHAR(50)
);

-- 员工表
CREATE TABLE emp (
id INT PRIMARY KEY, -- 员工id
ename VARCHAR(50), -- 员工姓名
job_id INT, -- 职务id
mgr INT , -- 上级领导
joindate DATE, -- 入职日期
salary DECIMAL(7,2), -- 工资
bonus DECIMAL(7,2), -- 奖金
dept_id INT, -- 所在部门编号
CONSTRAINT emp_jobid_ref_job_id_fk FOREIGN KEY (job_id) REFERENCES job (id),
CONSTRAINT emp_deptid_ref_dept_id_fk FOREIGN KEY (dept_id) REFERENCES dept (id)
);

-- 工资等级表
CREATE TABLE salarygrade (
grade INT PRIMARY KEY, -- 级别
losalary INT, -- 最低工资
hisalary INT -- 最高工资
);

-- 添加4个部门
INSERT INTO dept(id,dname,loc) VALUES
(10,'教研部','北京'),
(20,'学工部','上海'),
(30,'销售部','广州'),
(40,'财务部','深圳');

-- 添加4个职务
INSERT INTO job (id, jname, description) VALUES
(1, '董事长', '管理整个公司，接单'),
(2, '经理', '管理部门员工'),
(3, '销售员', '向客人推销产品'),
(4, '文员', '使用办公软件');

-- 添加员工
INSERT INTO emp(id,ename,job_id,mgr,joindate,salary,bonus,dept_id) VALUES
(1001,'孙悟空',4,1004,'2000-12-17','8000.00',NULL,20),
(1002,'卢俊义',3,1006,'2001-02-20','16000.00','3000.00',30),
(1003,'林冲',3,1006,'2001-02-22','12500.00','5000.00',30),
(1004,'唐僧',2,1009,'2001-04-02','29750.00',NULL,20),
(1005,'李逵',4,1006,'2001-09-28','12500.00','14000.00',30),
(1006,'宋江',2,1009,'2001-05-01','28500.00',NULL,30),
(1007,'刘备',2,1009,'2001-09-01','24500.00',NULL,10),
(1008,'猪八戒',4,1004,'2007-04-19','30000.00',NULL,20),
(1009,'罗贯中',1,NULL,'2001-11-17','50000.00',NULL,10),
(1010,'吴用',3,1006,'2001-09-08','15000.00','0.00',30),
(1011,'沙僧',4,1004,'2007-05-23','11000.00',NULL,20),
(1012,'李逵',4,1006,'2001-12-03','9500.00',NULL,30),
(1013,'小白龙',4,1004,'2001-12-03','30000.00',NULL,20),
(1014,'关羽',4,1007,'2002-01-23','13000.00',NULL,10);

-- 添加5个工资等级
INSERT INTO salarygrade(grade,losalary,hisalary) VALUES
(1,7000,12000),
(2,12010,14000),
(3,14010,20000),
(4,20010,30000),
(5,30010,99990);

-- 1. 查询所有员工信息。查询员工编号，员工姓名，工资，职务名称，职务描述

# method1 隐式内连接

SELECT emp.id,emp.ename,emp.salary,job.jname,job.description FROM emp,job WHERE emp.job_id=job.id;

# method1 显式内连接

SELECT emp.id,emp.ename,emp.salary,job.jname,job.description FROM emp INNER JOIN job ON emp.job_id=job.id;

-- 2. 查询员工编号，员工姓名，工资，职务名称，职务描述，部门名称，部门位置

SELECT emp.id,emp.ename,emp.salary,job.jname,job.description,dept.dname,dept.loc FROM emp,job,dept WHERE emp.job_id=job.id AND dept.id=emp.dept_id;


-- 事务

DROP TABLE IF EXISTS account;


-- 创建账户表
CREATE TABLE account(
id int PRIMARY KEY auto_increment,
name varchar(10),
money double(10,2)
);

-- 添加数据
INSERT INTO account(name,money) values('张三',1000),('李四',1000);

SELECT * FROM account;

-- 不加事务演示问题

-- 转账操作(假设第二步出问题)

-- 1. 查询李四账户金额是否大于500 (此处查询并不影响实际数据表数据,先不管,测试其后sql异常)
-- 2. 李四账户 -500
UPDATE account set money = money - 500 where name = '李四';
出现异常了... -- 此处不是注释，在整体执行时会出问题，后面的sql则不执行

-- 3. 张三账户 +500
UPDATE account set money = money + 500 where name = '张三';



-- 添加 事务 操作

UPDATE account SET money=1000; # 不加限定条件 更新表中所有money字段值为 1000

-- 开启事务
BEGIN;

-- 转账操作

-- 1. 查询李四账户金额是否大于500
-- 2. 李四账户 -500
UPDATE account set money = money - 500 where name = '李四';
 出现异常了... -- 此处不是注释，在整体执行时会出问题，后面的sql则不执行 (模拟异常操作)

-- 3. 张三账户 +500
UPDATE account set money = money + 500 where name = '张三';

-- 提交事务
COMMIT;

-- 回滚事务
ROLLBACK;

# 在本用户(本窗口)查询,仍能查出异常(少500元) 但因为开启了事务,操作是暂时性的,在其他用户(新建查询)窗口,查出的还是两人都是1000元,并未实际更改数据
UPDATE account set money=1000;
SELECT * FROM account;


SELECT @@autocommit; # 1 自动提交 0 手动提交

SET @@autocommit=0;







