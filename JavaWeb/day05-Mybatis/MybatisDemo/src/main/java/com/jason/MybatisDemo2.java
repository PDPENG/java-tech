package com.jason;

import com.jason.mapper.UserMapper;
import com.jason.pojo.User;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

/*
* mybatis mapper 代理开发
* */
public class MybatisDemo2 {
    public static void main(String[] args) throws IOException {
        //加载mybatis核心配置文件(https://mybatis.org/mybatis-3/zh/getting-started.html 访问官网)
        String resource = "mybatis-config.xml";//注意路径信息
        InputStream inputStream = Resources.getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);

        //获取sqlsession对象(用于执行sql)
        SqlSession sqlsession = sqlSessionFactory.openSession();

        //获取UserMapper接口代理对象
        UserMapper userMapper = sqlsession.getMapper(UserMapper.class);
        List<User> users = userMapper.selectAll();

        System.out.println(users);
        //资源释放
        sqlsession.close();
    }
}
