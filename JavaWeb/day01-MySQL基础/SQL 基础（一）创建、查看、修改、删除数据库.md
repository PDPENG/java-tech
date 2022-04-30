
> SQL（Structured Query Language），结构化查询语言
# 基础理论
`T-SQL` 和 `SQL` 的区别:

-  `T-SQL` 是 `SQL` 语言的一种版本，且只能在 `SQL SERVER` 上使用。是 `ANSI SQL` 的加强版语言、提供了标准的 `SQL` 命令。另外，`T-SQL` 还对 `SQL` 做了许多补允，提供了类似 `C`、`Basic` 和 `Pascal` 的基本功能，如变量说明、流控制语言、功能函数等
-  `SQL` 由甲骨文发布，`T-SQL` 由微软发布
-  `SQL` 是一种标准，`T-SQL` 是 `SQL` 在 `SQL SERVER` 上的实现


主要功能：
- 数据查询 Query
- 数据定义 Definition
- 数据操纵 Manipulation
- 数据控制 Control

主要文件：
- 主数据文件 `.mdf`
- 次数据文件 `.ndf`
- 事物日志文件 `.ldf`

# 数据库创建
## 使用 Management Studio 

![](https://img-blog.csdnimg.cn/3a9905c4e86c42ef818a811594ac2cf2.png)

![](https://img-blog.csdnimg.cn/5ac7141d731144d1b904fe39f495b9b5.png)

## SQL 语句创建
```sql
CREATE DATABASE db_test
ON
(
NAME=test,
FILENAME='D:\Data\test.mdf', --路径+文件名(加扩展名)
SIZE=5MB,
MAXSIZE=10MB,
FILEGROWTH=5% --最后一句指令后不加逗号
)
LOG ON
(
NAME=test_log,
FILENAME='D:\Data\test_log.ldf',
SIZE=5MB,
MAXSIZE=10MB,
FILEGROWTH=2% --具体容量或 UNLIMITED 不限制
)
```
# 修改数据库
```sql
ALTER DATABASE db_test
ADD FILE
(
NAME=test_file, --在数据库 db_test 中添加次要数据文件                   逻辑名
FILENAME='D:\Data\test_file.ndf', -- 文件名.ndf 注意文件格式
SIZE=100,
MAXSIZE=200,
FILEGROWTH=10 -- 文件自动增量为10MB
)
```
# 查看数据库

```sql
EXECUTE Sp_helpdb db_test --查看数据库
```

# 迁移数据库 分离与附加

```sql
EXECUTE Sp_detach_db db_test --分离数据库

EXECUTE Sp_attach_db db_test,物理文件名(.mdf文件位置) --附加数据库
```

*注：数据库的分离与附加一般发生在数据库在不同机器迁移的情况下使用，当使用 Management Studio 操作时，可能会因**权限**问题导致附加失败，下面演示如何修改**控制权限**

本地找到数据库主文件（.mdf）右键修改属性，勾选**完全控制**

![](https://img-blog.csdnimg.cn/1ab3546a1d364dfcad90b8765aaed89a.png)

打开 Management Studio 选中数据库节点，进入**附加数据库**窗口

![](https://img-blog.csdnimg.cn/95b3669a8b074109bebe0c387e791250.png)

选择数据库文件位置，添加执行即可

![](https://img-blog.csdnimg.cn/3c9060d2080b4163bea8e51e88a2640f.png)

# 删除数据库

```sql
DROP DATABASE db_test
```

*注：SQL 指令常用大写，减少后台指令转换执行时间，提升速度，影响较小，基本可忽略

# 练习
## 题目
**实验任务 1**
要求设计一个数据库，数据库名为 db_HX(要求利用 SQL Server Management
Studio 平台，T-SQL 语句两种方式创建数据库)；数据库名为 db_HX;数据库中包含一
个数据文件，逻辑文件名为 HX_DATA,物理文件名为 HX_DATA.MDF,文件的初始容量为
5MB，最大容量为 15MB，文件容量递增值为 2MB
事务日志文件的逻辑文件名为 HX_LOG,物理文件名为 HX_LOG.LDF,初始容量为
3MB，最大容量为 10MB，文件容量递增值为 1MB;

**实验任务 2**
利用 SQL Server Management Studio 平台，T-SQL 语句两种方式修改数据库，按
要求对数据库进行修改在数据库 db_HX 中添加一个数据文件，逻辑文件名为 HX_DATA1,
文件的初始容量为 3MB，最大容量为 15MB，文件容量递增值为 2MB;
将事务日志文件的最大容量改为 20MB，文件容量递增值为 2MB;

**实验任务 3**
利用 SQL Server Management Studio 平台，T-SQL 语句两种方式修改数据库，按
要求对数据库文件进行删除，将数据库 db_HX 中刚添加的 HX_DATA1 数据库文件删除。

**实验任务 4**
利用 SQL Server Management Studio 平台，T-SQL 语句两种方式，将数据库 db_HX
进行分离和附加操作。

**实验任务 5**
使用 T-SQL 语句删除数据库 db_HX

**任务拓展**
创建一个包含多个数据文件和日志文件的数据库 db_MNS，该数据库包含两个初始大小
为 15MB 的数据文件和两个 5MB 的日志文件。

## Query.sql

```sql
--任务1
create database db_hx
on
(
name=hx_data,
filename='D:\Data\hx_data.mdf',
size=5,
maxsize=15,
filegrowth=2
)
log on
(
name=hx_log,
filename='D:\Data\hx_log.ldf',
size=3,
maxsize=10,
filegrowth=1
)

--任务2
alter database db_hx
add file
(
name=hx_data1,
filename='D:\Data\hx_data1.ndf',
size=3,
maxsize=15,
filegrowth=2
)
alter database db_hx
modify file
(
name=hx_log,
filename='D:\Data\hx_log.ldf',
maxsize=20,
filegrowth=2
)

--任务3
alter database db_hx
remove file hx_data1

--任务4
execute sp_detach_db db_hx
execute sp_attach_db db_hx,'D:\Data\hx_data.mdf'

--任务5
drop database db_hx

--拓展
create database db_mns
on primary --创建多个数据文件(但仅有一个主数据文件)
(
name=mns_data1,
filename='D:\Data\mns_data1.mdf', --主数据文件
size=15
),
(
name=mns_data2,
filename='D:\Data\mns_data2.ndf', --主文件组,次数据库文件
size=15
)
log on
(
name=mns_log1,
filename='D:\Data\mns_log1.ldf',
size=5
),
(
name=mns_log2,
filename='D:\Data\mns_log2.ldf',
size=5
)
```

Tips：

> 选中代码，点击执行可以执行 **部分指令**

![](https://img-blog.csdnimg.cn/761a06b51a7e4ba88ed337fe15c205af.png)



