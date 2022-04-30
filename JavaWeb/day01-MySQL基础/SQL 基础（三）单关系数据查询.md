
@[toc]
# 单关系（表）数据查询结构

查询结果仍为表，`WHERE`、`SELECT` 分别相当于关系代数中的 `选取`、`投影` 操作

SQL 指令功能强大，无需规定投影、选取、连接执行顺序

# 无条件查询

> 仅包含 `SELECT……FROM` 查询，等价于对关系做 `投影` 操作

## 1.查询指定信息

```sql
USE db_student -- 指定数据库
SELECT sno,sn,birthday -- 查询信息指定
FROM tb_student -- 指定表
```

![](https://img-blog.csdnimg.cn/f1294486acf54a93a6995e0b5b2bbff3.png)

计算成绩表中学生年龄，并用学号、姓名、年龄做表头

方法：当前日期减去生日日期求得年龄，用别名修改生成表表头信息

```sql
use db_student20
select sno as 学号,sn as 姓名,
year(getdate())-year(birthday) as 年龄 -- 属性起别名
from tb_student
```

## 2.查询全部信息

```sql
SELECT *
FROM tb_student
```

![](https://img-blog.csdnimg.cn/427c9b8b0a624930bc979a8e8be748c3.png)

可以看到显示了表中所有学生的所有属性信息

## 3.查询表单身份信息

> 不使用 WHERE 子句的无条件查询称**投影查询**，SQL中只有使用 `DISTINCT` 关键字才会消去重复列，关系代数投影运算自动消去 

```sql
SELECT distinct polity
FROM tb_student
```

![](https://img-blog.csdnimg.cn/80f548d75cc84d3fa0bc751c211fccf9.png)

可以查看到数据表中所有身份信息，并已删除重复列

查询信息表中，我校开设的所有专业信息

```sql
select distinct major 
from tb_student	
```

如果不加 `distinct` ，查询结果将会显示所有符合结果（含重复列），不易阅读


## 4.查询所有学生的学号/姓名/身份

```sql
SELECT sno , sn , polity -- 逗号分隔不同属性值
FROM tb_student
```

![](https://img-blog.csdnimg.cn/603ec7cbc9224681ada94c4ea90093b1.png)

# 条件查询
## 1.比较大小（全匹配）
常用比较运算符

|运算符| 含义 |
|--|--|
| =、>、< 、<= 、>= 、!= 、`<>` | 比较大小 |
| AND、OR、NOT | 复合条件 |
| BETWEEN AND | 确定范围 |
| IN | 确定集合 |
| LIKE | 字符匹配 |
| IS NULL | 空值 |

*注：`<>` 表示（否定，不，反义）

查询所有学生中是党员的学生学号和姓名

```sql
SELECT sno,sn
FROM tb_student
WHERE polity='党员'
```

查询成绩表中，学生成绩不及格的学生学号

```sql
SELECT sno
FROM tb_score
WHERE score<60
```

## 2.多重条件查询（全匹配）

> 优先级由高到低：`NOT`、`AND`、`OR` 常用在复合逻辑表达式中

查询学生信息表中，软件学院男生是党员的学生信息

```sql
select sex,dept,polity
from tb_student
where (sex='男' AND dept='软件学院') AND (polity='党员')
```


## 3.确定范围（全匹配）
查询成绩表中，成绩段`在` 70~90 之间的学生学号和学分信息

```sql
select sno,xf
from tb_score
where score>=70 AND score<=90  --SQL Server 中等价于 where score BETWEEN 70 AND 90
```

*注：某些 DBMS 中 BETWEEN AND 不包含边界值等号

查询成绩表中，成绩段`不在` 70~90 之间的学生学号和学分信息

```sql
select sno,xf
from tb_score
where score NOT BETWEEN 70 AND 90 -- NOT 否定
```

## 4.确定集合（全匹配）
查询成绩表中，`选修` c03、c17 课号学生的学分和学号信息

```sql
select cno,sno,xf
from tb_score
where cno IN('c03','c17') -- 等价 where cno='03' OR cno='17'
```
查询成绩表中，`未选修` c03、c17 课号学生的学分和学号信息

```sql
select cno,sno,xf
from tb_score
where cno NOT IN('c03','c17') -- 等价 where cno <> '03' AND cno <> '17'
```
*注：重点注意 `<>` 符号
## 5.模糊查询（部分匹配）
当我们在不能清楚的知道所查询数据的精确值时，可以使用模糊查询的方式检索数据，利用如下通配符以实现模糊搜索

字符中可加**通配符**

| 通配符 | 功能 | 示例 |
|-------|--|-- |
| `%` | 代表0或多个字符 | ‘%ab’ 后可接任意字符串 |
| `_` | 代表一个字符 | ‘a_b’ 间有一个字符 |
| `[ ]`| 表示在某范围的字符 | [0~10] 范围字符，仅匹配一个字符 |
|` [^ ]` | 表示不在某范围的字符 | 不在 [0~10] 范围内字符 |


查询所有姓王的学生姓名和学院信息

```sql
select sn，dept
from tb_student
where sn LIKE '王%'
```

查询所有学生信息中，姓名第二个字是明的学生姓名和学院信息

```sql
select sn,dept
from tb_student
where sn LIKE '_明%'
```

## 6.空值查询
==NULL 值表示“不知道、不确定、没有数据”==，和 0 值要注意区分

查询没有考试成绩（未参加考试，不是考试成绩为 0 分）的学生学号及课程号信息

```sql
select sno,cno
from tb_score
where score IS NULL -- 比较运算符 IS NULL
```

# 统计汇总查询
常用库函数（聚合函数）：

|函数名称| 功能 |
|--|--|
| AVG | 按列求平均值 |
| SUM | 按列求和 |
| MAX | 求列最大值 |
| MIN | 求列最小值 |
| COUNT | 按列求个数 |

- `count(*)`  对表中数目进行计数，无论是否为空
- `count(colum)` 对特定列中具有的值计数，忽略 `NULL`

查询学号为 XXX 的学生总成绩和平均成绩

```sql
select SUM(score) AS totalscore,AVG(score) AS avgscore
from tb_score
where (sno='XXX')
```
*注：如果 AS 后不写别名，查询后的表没有表头（无列名）

查询软件学院学生总数

```sql
select COUNT(*) from tb_student
where dept='软件学院'
```
*注：`COUNT(*)` 统计元组个数，不消除重复行，不可用 `DISTINCT` 关键字
# 分组查询
> `select` 中既有基本字段又有聚合函数时需要 `group by`，否则将会出现语法错误
> 空值作为单独分组返回值

查询选修两门课以上课程的学生学号和选课总数

```sql
select sno,COUNT(*) AS sc_num
from tb_student
group by sno
having (COUNT(*)>=2) -- 必须是选修课程数大于等于二的
```

查询成绩表中成绩不及格的学生信息，并给出每门课程需要重修的人数（人数大于 5 ）

```sql
select cno as 课程号,COUNT(*) as 补考人数
from tb_score
where score<60
group by cno --分组之后继续筛信息 加 having 
having COUNT(*)>=5
order by cno asc
```

*注：各子句顺序 `WHERE` 、`GROUP BY`、`HAVING`

# 排序查询结果
> `ORDER BY` 查询排序结果，位置必须在其他子句后，指定缺省默认为 `升序 ASC` [DESC 降序 / ASC 升序]

- 降序 descending order
- 升序 ascending order

==`NULL` 在排序时认为是最小值==

查询成绩表中，选修 c10 课程的学生学号，并按成绩降序排列

```sql
select sno,score
from tb_score
where (cno='c10')
order by score DESC
```

![](https://img-blog.csdnimg.cn/67f7ecd2c22448eb842e59bc358ac385.png)

成绩表中，查询选修 c10，c03，c09 或 c20 课程的学号和成绩，结果按学号升序排列

```sql
select sno,cno,score
from tb_score
where cno IN('c10','c03','c09','c20')
order by sno -- 指定缺省默认为升序 ASC
```

