# 前言
开始链接前，请确保本机上安装的 idea 是 Ultimate 专业版，[点我下载](https://www.jetbrains.com/zh-cn/idea/download/#section=windows)。JetBrains 旗下 Community 社区版本并未集成数据库开发工具，这一点我们从官网两个版本的下载介绍上也能看到
![在这里插入图片描述](https://img-blog.csdnimg.cn/90999657caf84e5a980dbc08d4dd6ec7.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5pS75Z-O54uu5p2w5qOu,size_20,color_FFFFFF,t_70,g_se,x_16)
# 配置 MySQL
## 安装

一般来说，安装V5左右的版本就足够，版本号越大占用后台资源会更多，我们根据实际开发需求，选择合适的就好，这里演示 5.7 版本的安装过程（其他版本基本一致，按钮位置可能有所不同）

进入[官方网站](https://dev.mysql.com/downloads/installer/)后，点击 Looking for previous GA versions 切换到早期版本
![在这里插入图片描述](https://img-blog.csdnimg.cn/e108c33c8acf4af1acb35569bfb5ff66.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5pS75Z-O54uu5p2w5qOu,size_20,color_FFFFFF,t_70,g_se,x_16)
在线安装就看你的网速质量了，第二个是完整安装文件，直接下载就好（如果需要验证，登陆 Oracle 账号校验即可）
![在这里插入图片描述](https://img-blog.csdnimg.cn/e9f3349c85744e848847c253d3abe751.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5pS75Z-O54uu5p2w5qOu,size_20,color_FFFFFF,t_70,g_se,x_16)
详细的安装教程[请看这里](https://zhuanlan.zhihu.com/p/188416607)，这里主要讲下配置过程

## 添加环境变量
>右键【此电脑】->【属性】->【高级系统设置】->【环境变量】

添加  ==MYSQL_HOME== 变量，变量值为电脑 MySQL 的安装位置
![在这里插入图片描述](https://img-blog.csdnimg.cn/1f70e66fd28e4e51b486021b1190eef7.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5pS75Z-O54uu5p2w5qOu,size_20,color_FFFFFF,t_70,g_se,x_16)
添加 Path 系统变量
![在这里插入图片描述](https://img-blog.csdnimg.cn/e4bea0bc3dde48a3a0d07b07c5526a1e.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5pS75Z-O54uu5p2w5qOu,size_20,color_FFFFFF,t_70,g_se,x_16)
## 检查配置
<kbd>Windows</kbd>+<kbd>R</kbd> 打开命令行，键入 `cmd` 打开命令行，输入

```bash
my sql -uroot -p //root表示用户名，-p表示输入用户密码
```
输入安装 MySQL 时的账户密码，出现图示信息则配置正确
![在这里插入图片描述](https://img-blog.csdnimg.cn/f09c0f1c0da44c2592c9759dbba45fb5.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5pS75Z-O54uu5p2w5qOu,size_20,color_FFFFFF,t_70,g_se,x_16)
# MysQL服务状态
以==管理员身份==打开命令行，分别输入以下命令
## 开启
```bash
net start mysql	//开启服务
```
## 关闭
```bash
net stop mysql  //关闭服务
```
![请添加图片描述](https://img-blog.csdnimg.cn/4e33172853414cbf824ebd9e67bdc08f.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5pS75Z-O54uu5p2w5qOu,size_15,color_FFFFFF,t_70,g_se,x_16)
# 在idea Ultimate中建立连接
## 引入 Drivers 驱动
建立项目后，添加 MysQL数据源
![在这里插入图片描述](https://img-blog.csdnimg.cn/0a2d856ba370412b99c25dc771a7c2ab.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5pS75Z-O54uu5p2w5qOu,size_20,color_FFFFFF,t_70,g_se,x_16)
找到驱动路径
![在这里插入图片描述](https://img-blog.csdnimg.cn/2ff951992f364082a794f4e611b1b0eb.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5pS75Z-O54uu5p2w5qOu,size_20,color_FFFFFF,t_70,g_se,x_16)
引入外部库中
![在这里插入图片描述](https://img-blog.csdnimg.cn/f99953fac0c64d318181847251dfcaa1.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5pS75Z-O54uu5p2w5qOu,size_20,color_FFFFFF,t_70,g_se,x_16)
成功后，项目结构中也会显示
![在这里插入图片描述](https://img-blog.csdnimg.cn/9959bcf45fb04a4f9802514530150cad.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5pS75Z-O54uu5p2w5qOu,size_13,color_FFFFFF,t_70,g_se,x_16)
## 添加表
### 创建 schema 架构
![](https://img-blog.csdnimg.cn/18cace6a270741588183484b882d4735.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5pS75Z-O54uu5p2w5qOu,size_20,color_FFFFFF,t_70,g_se,x_16)
![在这里插入图片描述](https://img-blog.csdnimg.cn/1f566f2e3e464ae6bf95d504a60e3885.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5pS75Z-O54uu5p2w5qOu,size_11,color_FFFFFF,t_70,g_se,x_16)
### 创建 Table 表
![在这里插入图片描述](https://img-blog.csdnimg.cn/234df321fdec4b4fa898d805856ce3e6.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5pS75Z-O54uu5p2w5qOu,size_20,color_FFFFFF,t_70,g_se,x_16)
添加属性
![在这里插入图片描述](https://img-blog.csdnimg.cn/7ebd2bdaf4f348a589b92fc8ad61b355.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5pS75Z-O54uu5p2w5qOu,size_20,color_FFFFFF,t_70,g_se,x_16)
## 写入数据信息
方式1：可视化，图形界面操作
![在这里插入图片描述](https://img-blog.csdnimg.cn/f8244f091ec945bdbdfa0aaea1243897.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5pS75Z-O54uu5p2w5qOu,size_20,color_FFFFFF,t_70,g_se,x_16)
方式2：sql 语句添加
![在这里插入图片描述](https://img-blog.csdnimg.cn/a288d0e71dc04bba8e40805ae113e258.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5pS75Z-O54uu5p2w5qOu,size_20,color_FFFFFF,t_70,g_se,x_16)
执行结果
![在这里插入图片描述](https://img-blog.csdnimg.cn/bab61d00a26a447abc8e48f99d6094c3.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5pS75Z-O54uu5p2w5qOu,size_18,color_FFFFFF,t_70,g_se,x_16)
# 测试类
请根据注释位置，修改配置信息后再 Execute 执行

```java
import java.sql.*;

public class Test {
    // MySQL 8.0 以下版本 - JDBC 驱动名称及数据库 URL
    static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost:3306/your schema"; // ‘/’后写入你的架构名称
    // 数据库的用户名与密码
    static final String USER = "your sql account"; //你的数据库“用户名”
    static final String PASS = "your sql password";//你的数据库密码

    public static void main(String[] args) {
        Connection conn = null;
        Statement stmt = null;
        try{
            // 注册 JDBC 驱动
            Class.forName(JDBC_DRIVER);

            // 打开链接
            System.out.println("数据库建立链接中...");
            conn = DriverManager.getConnection(DB_URL,USER,PASS);

            // 执行查询
            System.out.println("正在实例化Statement对象...");
            stmt = conn.createStatement();
            String sql;
            sql = "SELECT * FROM information";
            ResultSet rs = stmt.executeQuery(sql);

            // 展开结果集数据库
            while(rs.next()){
                // 通过字段检索
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String age = rs.getString("age");

                // 输出数据
                System.out.print("ID: " + id);
                System.out.print(", 姓名: " + name);
                System.out.print(", 年龄: " + age);
                System.out.println("");
            }
            // 操作完成后关闭
            rs.close();
            stmt.close();
            conn.close();
        }catch(SQLException se){
            // 处理 JDBC 错误
            se.printStackTrace();
        }catch(Exception e){
            // 处理 Class.forName 错误
            e.printStackTrace();
        }finally{
            // 释放资源
            try{
                if(stmt!=null) stmt.close();
            }catch(SQLException se2){
            }// 不进行任何操作
            try{
                if(conn!=null) conn.close();
            }catch(SQLException se){
                se.printStackTrace();
            }
        }
        System.out.println("数据库链接释放!");
    }
}
```
测试类执行结果
![在这里插入图片描述](https://img-blog.csdnimg.cn/816f8113ae29458d95c980ee532dec57.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5pS75Z-O54uu5p2w5qOu,size_20,color_FFFFFF,t_70,g_se,x_16)
___
参考资料：

- [MySQL的详细安装教程](https://zhuanlan.zhihu.com/p/188416607)

- [Mysql启动后停止的解决方法](https://www.cnblogs.com/pandaly/p/11738789.html#:~:text=Mysql%E5%90%AF%E5%8A%A8%E5%90%8E%E5%81%9C%E6%AD%A2%E7%9A%84%E8%A7%A3%E5%86%B3%E6%96%B9%E6%B3%95%20%E5%AE%89%E8%A3%85mysql%E5%90%8E%EF%BC%8C%E6%9C%8D%E5%8A%A1%E6%97%A0%E6%B3%95%E6%AD%A3%E5%B8%B8%E5%90%AF%E5%8A%A8%EF%BC%8C%E6%8A%A5%E9%94%99%E5%A6%82%E4%B8%8B%EF%BC%9A%20%E8%A7%A3%E6%B3%95%E6%96%B9%E6%B3%95%EF%BC%9A%201%20%E4%BB%A5%E7%AE%A1%E7%90%86%E5%91%98%E8%BA%AB%E4%BB%BD%E8%BF%90%E8%A1%8C%E5%91%BD%E4%BB%A4%E6%8F%90%E7%A4%BA%E7%AC%A6%202%20%E7%94%A8%E5%91%BD%E4%BB%A4%E8%BF%9B%E8%A1%8Cmysql%E5%AE%89%E8%A3%85%E7%9B%AE%E5%BD%95%E7%9A%84bin%E7%9B%AE%E5%BD%95%EF%BC%9A%20cd,%E8%BF%90%E8%A1%8C%E5%88%9D%E5%A7%8B%E5%8C%96mysql%E6%9C%8D%E5%8A%A1%E5%91%BD%E4%BB%A4%EF%BC%9A%201%20mysqld%20--initialize-insecure%20--user%3Dmysql%206%20%E8%BF%90%E8%A1%8C%E6%9B%B4%E6%96%B0%E9%85%8D%E7%BD%AE%E6%96%87%E4%BB%B6%E5%91%BD%E4%BB%A4%EF%BC%9A%201)

- [MySQL修改root密码的4种方法](https://blog.csdn.net/th_num/article/details/71402801)

- [姓名 性别 密码等在mysql中都保存为什么类型](https://bbs.csdn.net/topics/370089669)

- [通过IntelliJ IDEA软件实现Java项目连接MySQL的详细过程](https://www.w3cschool.cn/article/4523407.html)
