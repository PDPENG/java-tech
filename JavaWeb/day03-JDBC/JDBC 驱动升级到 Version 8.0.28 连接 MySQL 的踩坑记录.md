> 👲👲<font color=#a2a837 size=3>作者主页</font>：🔗[杰森的博客](https://blog.csdn.net/m0_51269961)
📒📒<font color=#20b9cd size=3>本文摘要</font>：<strong>升级驱动到 mysql-connector-java 8.0.28 的注意事项</strong>
💖💖如果本文对您有帮助的话，还请各位小伙伴👍点赞➕收藏⭐➕评论💭支持杰森呀✌️

![](https://img-blog.csdnimg.cn/a7dead605e9643a58a286a77bd691970.png#pic_cennter)

___
# 🐛问题描述
升级驱动到 `mysql-connector-java 8.0.28` 后，部署执行各种报错，但是把连接器切换到 `mysql-connector-java-5.1.48` 又没有问题，很是疑惑！

报错的信息大都是无法找到该类、无法连接

主要是配置好了，就没有留截图，大家主要注意和旧版本不同的地方就好

[官方下载地址](https://dev.mysql.com/downloads/connector/j/)

![](https://img-blog.csdnimg.cn/2d32b303c6b14e89b312f73a8a96f934.png)

历经种种艰难险阻，终于是解决了，成功连接，下面给出解决方案
# 💡解决方案
第一种是菜鸟的示例，较为全面；如果感觉比较麻烦，可以使用第二种方案
## 1.🔎完整版
> 这里引用**菜鸟教程**示例

### 📡1.数据库环境搭建

```sql
-- 建立数据库 demo1
CREATE DATABASE IF NOT EXISTS demo1;

-- 建立 websites 表
CREATE TABLE websites (
  id int(11) NOT NULL AUTO_INCREMENT,
  name char(20) NOT NULL DEFAULT '' COMMENT '站点名称',
  url varchar(255) NOT NULL DEFAULT '',
  alexa int(11) NOT NULL DEFAULT '0' COMMENT 'Alexa 排名',
  country char(10) NOT NULL DEFAULT '' COMMENT '国家',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- 写入数据
INSERT INTO websites
VALUES ('1', 'Google', 'https://www.google.cm/', '1', 'USA'), 
('2', '淘宝', 'https://www.taobao.com/', '13', 'CN'), 
('3', '菜鸟教程', 'http://www.runoob.com', '5892', ''), 
('4', '微博', 'http://weibo.com/', '20', 'CN'), 
('5', 'Facebook', 'https://www.facebook.com/', '3', 'USA');
```

### 📡2.测试类连接

> 这里最最重要的就是 MySQL 版本的问题，新版更新了驱动类的名称为 `com.mysql.cj.jdbc.Driver`


```java
import java.sql.*;

public class JDBCTest {

    // MySQL 8.0 以下版本 - JDBC 驱动名及数据库 URL
    // static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    // static final String DB_URL = "jdbc:mysql://localhost:3306/RUNOOB";

    // MySQL 8.0 以上版本 - JDBC 驱动名及数据库 URL
    static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost:3306/demo1?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC&useServerPrepStmts=true";
                                                            // 注意修改数据库名 

    // 数据库的用户名与密码，需要根据自己的设置
    static final String USER = "your db login name";
    static final String PASS = "your db password";

    public static void main(String[] args) {
        Connection conn = null;
        Statement stmt = null;
        try {
            // 注册 JDBC 驱动
            Class.forName(JDBC_DRIVER);

            // 打开链接
            System.out.println("连接数据库...");
            conn = DriverManager.getConnection(DB_URL, USER, PASS);

            // 执行查询
            System.out.println(" 实例化Statement对象...");
            stmt = conn.createStatement();
            String sql;
            sql = "SELECT id, name, url FROM websites";
            ResultSet rs = stmt.executeQuery(sql);

            // 展开结果集数据库
            while (rs.next()) {
                // 通过字段检索
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String url = rs.getString("url");

                // 输出数据
                System.out.print("ID: " + id);
                System.out.print(", 站点名称: " + name);
                System.out.print(", 站点 URL: " + url);
                System.out.print("\n");
            }
            // 完成后关闭
            rs.close();
            stmt.close();
            conn.close();
        } catch (SQLException se) {
            // 处理 JDBC 错误
            se.printStackTrace();
        } catch (Exception e) {
            // 处理 Class.forName 错误
            e.printStackTrace();
        } finally {
            // 关闭资源
            try {
                if (stmt != null) stmt.close();
            } catch (SQLException se2) {
            }// 什么都不做
            try {
                if (conn != null) conn.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
        System.out.println("Goodbye!");
    }
}
```

执行结果，连接成功

![](https://img-blog.csdnimg.cn/78091ccf167c4cc5a6f3a8560fd620e9.png)

## 2.🔎精简版

> 上例考虑全面，使用异常较多，为了方便理解，我们简化下代码量

### 📡1.数据库环境搭建

```sql
-- 建立数据库 demo1
CREATE DATABASE IF NOT EXISTS demo1;

-- 建立数据表 accounts
CREATE TABLE accounts (
			id int(3) NOT NULL PRIMARY KEY auto_increment,
			name varchar(5),
			money FLOAT(4,2)
			);

-- 写入数据
INSERT INTO accounts VALUES('1','jason','10000'),('2','you','99999');
```

### 📡2.测试类连接

> 注意版本、资源释放的顺序（最先调用，最后释放，释放顺序和调用顺序相反）

```sql
package com.jason.jdbc;

import java.sql.*;

public class JDBCDemo {
    public static void main(String[] args) throws Exception { //psvm 快速生成
        //1. 注册驱动
        Class.forName("com.mysql.cj.jdbc.Driver");
        //2. 获取连接
        String url = "jdbc:mysql://localhost:3306/demo1?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC&useServerPrepStmts=true";
        String username = "your db login name";
        String password = "your db password";
        Connection conn = DriverManager.getConnection(url, username, password);
        //3. 定义sql
        String sql = "update accounts set money = 1000 where id = 2";
        //4. 获取执行sql的对象 Statement
        Statement stmt = conn.createStatement();
        //5. 执行sql
        int count = stmt.executeUpdate(sql);//受影响的行数
        //6. 处理结果
        System.out.println("Affected rows: "+count);
        //7. 释放资源 Statement 和 Connection 注意释放顺序
        stmt.close();
        conn.close();
    }
}
```

执行结果，连接成功

![](https://img-blog.csdnimg.cn/592143e72c284f479d3e4ddd19ea99c5.png)

# 📒总结
毕竟是更新，多少会有一些改动，我们要学会去看更新了什么、学会去官方找解决方案

比如这次的报错就可以从最新的 jar 包中找到

![](https://img-blog.csdnimg.cn/0b7e6fa61ee14f7cb058813ae22cda22.png)

在 `5.x` 版本之后，注册驱动的代码可以省略不写，就是这一段

```java
//1. 注册驱动
//Class.forName("com.mysql.cj.jdbc.Driver");
```

原因是：驱动 `jar` 包下，默认 `META-INF  services` 目录下记录了对应驱动类名，无需再次书写

![](https://img-blog.csdnimg.cn/99621f3f15a941ac876e212d7dbea355.png)

___

可能是我用的版本太老了，跟不上时代的发展辽~~

![](https://img-blog.csdnimg.cn/e49ab973b2f04dfda6df8723346227af.gif)

