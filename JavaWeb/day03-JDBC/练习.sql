SELECT * FROM websites;

-- 菜鸟教程JDBC连接测试表

-- 建立 websites 表
CREATE TABLE websites (
  id int(11) NOT NULL AUTO_INCREMENT,
  name char(20) NOT NULL DEFAULT '' COMMENT '站点名称',
  url varchar(255) NOT NULL DEFAULT '',
  alexa int(11) NOT NULL DEFAULT '0' COMMENT 'Alexa 排名',
  country char(10) NOT NULL DEFAULT '' COMMENT '国家',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- 添加数据
INSERT INTO `websites` VALUES ('1', 'Google', 'https://www.google.cm/', '1', 'USA'), ('2', '淘宝', 'https://www.taobao.com/', '13', 'CN'), ('3', '菜鸟教程', 'http://www.runoob.com', '5892', ''), ('4', '微博', 'http://weibo.com/', '20', 'CN'), ('5', 'Facebook', 'https://www.facebook.com/', '3', 'USA');

DELETE FROM websites WHERE id=5;

SELECT * FROM websites;

DROP TABLE IF EXISTS websites;

CREATE DATABASE IF NOT EXISTS demo1;

-- 精简版 db 环境部署

-- 建表
CREATE TABLE accounts (
			id int(3) NOT NULL PRIMARY KEY auto_increment,
			name varchar(5),
			money FLOAT(7,2)
			);
			
-- 写数据
INSERT INTO accounts VALUES('1','jason','10000'),('2','you','99999');


-- SQL Inject sql 注入演示

-- 创建数据库
CREATE DATABASE IF NOT EXISTS test;

-- 建表

DROP TABLE IF EXISTS tb_user; # 查看是否存在

CREATE TABLE tb_user (
			id INT,
			username VARCHAR(20),
			password VARCHAR(32)
);

-- 添加数据信息
INSERT INTO tb_user VALUES(1,'jasonpeng','123'),(2,'yiyi','456');

SELECT * FROM tb_user;


