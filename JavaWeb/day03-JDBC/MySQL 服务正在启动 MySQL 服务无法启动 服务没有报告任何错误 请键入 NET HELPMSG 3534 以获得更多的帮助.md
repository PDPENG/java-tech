# 序
有关 Mysql 的详细安装过程，请[参考这里](https://blog.csdn.net/m0_51269961/article/details/121800580)

启动 MySQL 服务时，遇到无法启动的报错信息，最后发现是输入命令`mysqld --initialize-insecure` 进行初始化时的问题，data 目录初始化错误

特此记录下解决方案
# 问题描述
控制台输入命令 `net start mysql` 控制台输出信息：

> MySQL 服务正在启动 . MySQL 服务无法启动。 服务没有报告任何错误。 请键入 NET HELPMSG 3534 以获得更多的帮助。

# 解决方案
`WIN` + `R` 输入 `cmd` 打开命令行

![](https://img-blog.csdnimg.cn/38b8796418a24ef6a46e73d4ee3fe7f1.png)

切入到 Mysql 安装目录

![](https://img-blog.csdnimg.cn/258d662c81094569ae07cd22d65696b7.png)

进入到 `bin` 目录下，依次执行下列命令

```bash
# 注册服务
mysqld -install 
# 初始化 Mysql
mysqld --initialize-insecure 
# 启动服务
net start mysql 
```

如果报错**拒绝访问**，那就是权限不够

![](https://img-blog.csdnimg.cn/713f7b72b3a44a4da408b70205f978a8.png)

我们使用管理员身份打开即可

![](https://img-blog.csdnimg.cn/15b68812ecb14097a03b717cab9533eb.png)

以后可以当做一个小技巧，一般 Windows cmd 中关于类似问题首先考虑下权限不够，管理员打开，再思考其他方面的错误

使用**管理员身份**打开后，控制台显示

![](https://img-blog.csdnimg.cn/066ab37a104040318bbd353d8c03e5cf.png)

问题解决，服务正常启动




