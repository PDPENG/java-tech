-- 基于mysql

CREATE DATABASE IF NOT EXISTS demo1; # 避免警告信息

DROP DATABASE IF EXISTS demo;

USE demo1; # 使用数据库

SELECT DATABASE(); # 查看当前使用的数据库

SHOW TABLES; # 查询数据库下所有表名称

DESC table_name; # 查询表结构(如果该表存在)

CREATE TABLE student_info (
	学号 int,
	姓名 VARCHAR(5),
	班级 VARCHAR(3),
	年龄 int -- 此处无逗号
);

DESC student_info; # 查询此表结构

SHOW TABLES; # 显示所有表名称

-- 需求设计

# 需求：设计一张学生表，请注重数据类型、长度的合理性
# 1. 编号
# 2. 姓名，姓名最长不超过10个汉字
# 3. 性别，因为取值只有两种可能，因此最多一个汉字
# 4. 生日，取值为年月日
# 5. 入学成绩，小数点后保留两位
# 6. 邮件地址，最大长度不超过 64
# 7. 家庭联系电话，不一定是手机号码，可能会出现 - 等字符
# 8. 学生状态（用数字表示，正常、休学、毕业...）

CREATE TABLE sutdent (
			编号 INT(10),
			姓名 VARCHAR(10),
			性别 VARCHAR(2), -- 变长字符串
			生日 INT(9),
			入学成绩 FLOAT(2),
			邮件地址 VARCHAR(64),
			家庭联系电话 INT(11),
			学生状态 INT(1)
);

-- 参考答案

CREATE TABLE stu (
 id int, -- 编号
 name varchar(20), -- 姓名
 age int, -- 年龄
 sex varchar(5), -- 性别
 address varchar(100), -- 地址
 math double(5,2), -- 数学成绩
 english double(5,2), -- 英语成绩
 hire_date date -- 入学时间
);

# 建立表格 字段名使用英文示意

-- 删除表

DROP TABLE IF EXISTS table_name;

-- 修改表名

ALTER TABLE table_old_name RENAME TO table_new_name;

ALTER TABLE student_info RENAME TO student_info_me;

ALTER TABLE stu RENAME TO student_info_ans;

SHOW TABLES;

-- 添加一列

ALTER TABLE student_info_me ADD 微信号 VARCHAR(15);

-- 修改数据类型

ALTER TABLE student_info_me MODIFY 微信号 VARCHAR(12);

USE demo1; # 语句以分号结尾
SELECT *
FROM student_info_me;

-- 修改列名和数据类型

ALTER TABLE student_info_me CHANGE 姓名 你的姓名 VARCHAR(6);

-- 删除列

ALTER TABLE student_info_me DROP 微信号;

SELECT *
from student_info_me;

-- DML 增删改查

-- 指定列添加数据 INSERT INTO 表名(列名1,列名2,…) VALUES(值1,值2,…);


INSERT INTO student_info_me(学号,你的姓名,班级,年龄) VALUES(2020,'000',03,19) # 注意中文字符要添加单引号

-- 全部列添加数据 (填入数据个数须和列数匹配对应)

INSERT INTO student_info_me VALUES(02,03,04,05)

UPDATE student_info_me sex='女' where name='xxx'; # 不加 where 条件会修改所有数据表


-- 数据删除

-- 删除单条记录
DELETE FROM student_info_me where 学号=2; # where可省略

-- 删除所有数据信息
DELETE FROM student_info_me;


-- DQL 演示

DROP TABLE IF EXISTS stu;

CREATE TABLE stu (
	id INT,
	name VARCHAR(20),
	age INT,
	sex VARCHAR(5),
	address VARCHAR(100),
	math DOUBLE(5,2),
	english DOUBLE(5,2),
	hire_date date
);

SELECT *
FROM stu;

INSERT INTO stu(id,NAME,age,sex,address,math,english,hire_date)
VALUES
(1,'马运',55,'男','杭州',66,78,'1995-09-01'),
(2,'马花疼',45,'女','深圳',98,87,'1998-09-01'),
(3,'马斯克',55,'男','香港',56,77,'1999-09-02'),
(4,'柳白',20,'女','湖南',76,65,'1997-09-05'),
(5,'柳青',20,'男','湖南',86,NULL,'1998-09-01'),
(6,'刘德花',57,'男','香港',99,99,'1998-09-01'),
(7,'张学右',22,'女','香港',99,99,'1998-09-01'),
(8,'德玛西亚',18,'男','南京',56,65,'1994-09-02');

-- 以上完成建立 stu 表,批量添加信息

-- 基础查询语句

SELECT name from stu;

SELECT * FROM stu;

SELECT DISTINCT name from stu; # 去重

-- 模糊查询

-- '_' 单个字符 '%' 任意个字符

SELECT * FROM stu WHERE name like '%花';

SELECT * FROM stu WHERE name like '_花%';

-- 顺序
 
-- DESC 降序 ASC 升序 (默认值)

SELECT * from stu order by age DESC;

SELECT * from stu order by age ASC;

# 查询学生信息，按照数学成绩降序排列，如果数学成绩一样，再按照英语成绩升序排列

SELECT * FROM stu ORDER BY math desc,english asc;


-- 聚合函数

# null 值不参与所有聚合函数运算

SELECT COUNT(*) AS 总人数 FROM stu;

SELECT MAX(math) as 数学最高分 FROM stu;

SELECT AVG(english) as 英语平均分 FROM stu;


-- 分组查询

# SELECT 字段列表 FROM 表名 [WHERE 分组前条件限定] GROUP BY 分组字段名 [HAVING 分组后条件过滤];

SELECT sex,avg(math) as 数学平均分 from stu GROUP BY sex;

SELECT sex,avg(math),COUNT(*) FROM stu GROUP BY sex;


-- 分页查询

#  SELECT 字段列表 FROM 表名 LIMIT 起始索引 , 查询条目数;         起始索引是从0开始

-- 起始索引 = (当前页码 - 1) * 每页显示的条数

-- 1.从0开始查询，查询3条数据

SELECT * FROM stu LIMIT 0,3;

-- 2.每页显示3条数据，查询第1页数据

SELECT * FROM stu LIMIT 6,3;