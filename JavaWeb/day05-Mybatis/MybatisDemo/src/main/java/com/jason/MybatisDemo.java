package com.jason;

import com.jason.pojo.User;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;
/*
* mybatis 入门
* */
public class MybatisDemo {
    public static void main(String[] args) throws IOException {
        //加载mybatis核心配置文件(https://mybatis.org/mybatis-3/zh/getting-started.html 访问官网)
        String resource = "mybatis-config.xml";//注意路径信息
        InputStream inputStream = Resources.getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);

        //获取sqlsession对象(用于执行sql)
        SqlSession sqlsession = sqlSessionFactory.openSession();

        //执行sql (查全部)
        List<User> users = sqlsession.selectList("test.selectAll");//命名空间+唯一ID

        System.out.println(users);
        //资源释放
        sqlsession.close();
    }
}
