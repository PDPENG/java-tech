# 数据类型
| 数据类型 | 含义 |
| --- | --- |
| CHARACTER\(n\) | 字符/字符串。固定长度 n。 |
| VARCHAR\(n\) 或 CHARACTER VARYING\(n\) | 字符/字符串。可变长度。最大长度 n。 |
| BINARY\(n\) | 二进制串。固定长度 n。 |
| BOOLEAN | 存储 TRUE 或 FALSE 值 |
| VARBINARY\(n\) 或  BINARY VARYING\(n\) | 二进制串。可变长度。最大长度 n。 |
| INTEGER\(p\) | 整数值（没有小数点）。精度 p。 |
| SMALLINT | 整数值（没有小数点）。精度 5。 |
| INTEGER | 整数值（没有小数点）。精度 10。 |
| BIGINT | 整数值（没有小数点）。精度 19。 |
| DECIMAL\(p,s\) | 精确数值，精度 p，小数点后位数 s。例如：decimal\(5,2\) 是一个小数点前有 3 位数，小数点后有 2 位数的数字。 |
| NUMERIC\(p,s\) | 精确数值，精度 p，小数点后位数 s。（与 DECIMAL 相同） |
| FLOAT\(p\) | 近似数值，尾数精度 p。一个采用以 10 为基数的指数计数法的浮点数。该类型的 size 参数由一个指定最小精度的单一数字组成。 |
| REAL | 近似数值，尾数精度 7。 |
| FLOAT | 近似数值，尾数精度 16。 |
| DOUBLE PRECISION | 近似数值，尾数精度 16。 |
| DATE | 存储年、月、日的值。 |
| TIME | 存储小时、分、秒的值。 |
| TIMESTAMP | 存储年、月、日、小时、分、秒的值。 |
| INTERVAL | 由一些整数字段组成，代表一段时间，取决于区间的类型。 |
| ARRAY | 元素的固定长度的有序集合 |
| MULTISET | 元素的可变长度的无序集合 |

# 数据表示方式
长度 `N` 、精度 `P` 、小数位数 `S`

`numeric(P,[S])` 表示数据精度为 P，小数位数为 S

数据精度：能精确到小数点后的位数，小数点右侧位数

# 数据表创建
## Management Studio 建表
> 建立表格其实就是定义每一列的过程

数据库表节点，新建

![](https://img-blog.csdnimg.cn/6a1b08c6e9dc4edfbecc275bc62b0d41.png)

定义列属性，完成建表操作

![](https://img-blog.csdnimg.cn/4a7e2a38bb3f4f49b5043c7cec39ce15.png)

## SQL 指令建表

```sql
-- SQL指令建立学生表
create table student
(
SNo varchar(6), -- 非定长字符型
SN nvarchar(10), -- Unicode 字符型(所能容纳字符数)
Sex nchar(1) default '男',
Age int, -- 定长 4,精度10,小数位数0(本字段可存放10位无小数点整数,4字节大小)  无需设置精度和小数位数
Dept nvarchar(20)
)
```

![](https://img-blog.csdnimg.cn/6cdff6f1e41a4ab49c2cf9b53e6d1bf4.png)

# 数据表约束

数据完整性

> 保证数据库中数据的正确性、有效性、相容性，完整性机制主要有：
> - 约束 Constraint
> - 默认 Default
> - 规则 Rule
> - 触发器 Trigger
> - 存储过程 Stotred Procedure

## Constrain 
### NULL / NOT NULL
> ==NULL 值表示“不知道、不确定、没有数据”==，仅当某字段值 `必须输入` 才有效时可设置 `NOT NULL` （eg：主键），仅用于定义 `列约束`

定义约束名称后（若不定义，系统将自动创建），若数据录入错误，系统将提示报错信息，无 `NOT NULL` 约束下，系统缺省值为 `NULL`

```sql
-- NOT NULL 约束
create table s
(
Sno varchar(6) constraint s_cons not null, -- s_cons 定义约束名称
Sn varchar(10),
Sex nchar(1),
Age int,
Dept nvarchar(20)
)
```

### UNIQUE
> 唯一约束，定义某一列或多列组合取值 `必须唯一`，被 UNIQUE 定义的列称为 `唯一键`，最多只能有一个 NULL 值，列约束、表约束均可

#### 列约束 

```sql
-- UNIQUE 列约束
create table s1
(
Sno varchar(6) constraint s_uniq UNIQUE, -- s_uniq 定义约束名称(可省略)
Sn varchar(10),
Sex nchar(1),
Age int,
Dept nvarchar(20)
)
```

#### 表约束

```sql
-- UNIQUE 表约束
create table s2
(
Sno varchar(6),
Sn varchar(10) UNIQUE,
Sex nchar(1),
Age int,
Dept nvarchar(20),
constraint s_unique UNIQUE(Sn,Sex) -- 表约束 语法格式 s_unique 定义约束名称(可省略) Sn+Sex 为唯一键
)
```

### PRIMARY KEY

> 主键约束，其值不能重复，不能为 NULL，既可表约束又可列约束

PRIMARY KEY  UNIQUE 区别：
- 基本表中可定义多个 UNIQUE 约束，但仅可有一个 PRIMARY KEY
- UNIQUE 约束的唯一键值可为 NULL ，PRIMARY KEY 约束的一列或多列组合，任意列都不能出现 NULL 值
- 同一列或同一组列，不能同时定义 PRIMARY KEY 和 UNIQUE

#### 列约束

```sql
-- PRIMARY KEY 列约束
create table s3
(
Sno varchar(6) constraint s_prim PRIMARY KEY, 
Sn varchar(10) UNIQUE,
Sex nchar(1),
Age int,
Dept nvarchar(20)
)
```

#### 表约束

```sql
-- PRIMARY KEY 表约束
create table s4
(
Sno varchar(6) NOT NULL, 
Sn varchar(10) NOT NULL,
Sex nchar(1),
Age int,
Dept nvarchar(20),
constraint s4_prim PRIMARY KEY(Sno,Sn)
)
```

### FOREIGN KEY

> 外键约束，约束某一列或几列作为外部键，包含外键的表称为从表（或参照表），主键所在表称为主表（或被参照表）。既可表约束又可列约束
> 为保证参照完整性，系统保证外键的取值为：
> 1. 空值 
> 2. 主键取值

换言之，外键存在至少需要两张表，在第一张表中作为主键的属性在第二张表（从表，参照表）中做普通属性，则此键称为第一张表（主表，被参照表）的外键

#### 列约束

```sql
-- FOREIGN KEY 列约束
create table s5
(
Sno varchar(6) NOT NULL constraint s5_foreign FOREIGN KEY REFERENCES s3(Sno), 
Sn varchar(10) NOT NULL,
Sex nchar(1),
Age int,
Dept nvarchar(20)
)
```

#### 表约束

```sql
-- FOREIGN KEY 表约束

-- 定义数据表 T
create table T
(
TNo varchar(6) constraint T_Prim PRIMARY KEY,
TN nvarchar(10) UNIQUE,
Sex nchar(1),
Age int,
Dept nvarchar(20)
)

-- 定义数据表 C
create table C
(
CNo varchar(6) constraint C_Prim PRIMARY KEY,
CN nvarchar(10) UNIQUE,
CT int
)

-- 建立 TC 表,定义 TNo、CNo 为 TC 外键
create table TC
(
TNo varchar(6) NOT NULL constraint T_Fore FOREIGN KEY REFERENCES T(TNo),
CNo varchar(6) NOT NULL constraint C_Fore FOREIGN KEY REFERENCES C(CNo),
Score NUMERIC(4,1), -- 精度为8,小数位数为1
Dept nvarchar(20)
)
```

### CHECK

> 检查约束，限定某字段只能录入允许范围内的值，既可表约束又可列约束

注意：
- 一个基本表中可定义多个 CHECK
- 一个字段仅能定义一个 CHECK
- 多个字段定义的 CHECK 必须为表约束

#### 列约束

```sql
-- CHECK 列约束
create table limit
(
sno varchar(6),
cno varchar(10),
score numeric(4,1) constraint score_check CHECK(score >=0 AND score <=100)
)
```

#### 表约束

```sql
-- CHECK 列约束
create table persons
(
P_Id int NOT NULL,
LastName varchar(255) NOT NULL,
FirstName varchar(255),
Address varchar(255),
Country varchar(255),
CONSTRAINT chk_Person CHECK (P_Id>0 AND Country='China')
)
```

# 数据表修改
## Management Studio 修改表

![](https://img-blog.csdnimg.cn/af2636a6d0c143d8b1b0c8b4f12eb033.png)

![](https://img-blog.csdnimg.cn/45693c7e5d8a450cb63ba2d51c14d075.png)

## SQL 指令修改表
### ADD
> ADD 方式为新加列自动填充 NULL 值，不可指定 NOT NULL

```sql
-- ADD
ALTER TABLE S
ADD --增加两项
Class_No varchar(6),
Address nvarchar(20)

ALTER TABLE TC
ADD
CONSTRAINT Score_chk CHECK(Score BETWEEN 0 AND 100)
```

### ALTER
注意：
- 列名不可变
- 含 NULL 值得列不可指定为 NOT NULL
- 存在于列中的数据不可改变数据类型、减少列宽
- 仅能修改 NOT NULL 、NULL 约束，其他约束需要通过“删除后重新添加“的方式完成修改

```sql
-- ALTER
ALTER TABLE S
ALTER COLUMN
SN nvarchar(12)
```

### DROP

> 仅用于删除完整性约束定义

```sql
-- DROP
ALTER TABLE s3
DROP CONSTRAINT s_prim
```

# 数据表查看
右键 表 ，属性

![](https://img-blog.csdnimg.cn/0d2e3dd88d284a20ab573ef2004db74d.png)

查看表信息

![](https://img-blog.csdnimg.cn/b1b0611e5d834bfa91850f21690c142a.png)

# 数据表删除
## Management Studio 删除表
> 表存在依赖对象时，不可删除

![](https://img-blog.csdnimg.cn/3b9cf20021b54bf6b2aa8352a9d157ca.png)

## SQL 指令删除表
> 仅可删除匹配用户建立的表，用户权限要对应

```sql
-- 删除基本表
DROP TABLE s
```

