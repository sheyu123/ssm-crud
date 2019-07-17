package com.atguigu.crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.bean.Emplovee;
import com.atguigu.crud.dao.DepartmentMapper;
import com.atguigu.crud.dao.EmploveeMapper;

/**
 * 测试dao层的工作
 * @author shu
 * 推荐Spring的项目就可以使用Spring的单元测试
 * 1.导入springTest模块
 * 2.@ContextConfiguration指定spring配置文件的位置
 * 3.@Autowired要使用的组件
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapperTest {
	@Autowired
	DepartmentMapper departmentMapper;
	
	@Autowired
	EmploveeMapper emploveeMapper;
	
	@Autowired
	SqlSession sqlsession;
	
	/**
	 * 测试DepartmentMapper
	 */
	@Test
	public void testCRUD(){
		/*//1.创建SpringIOC容器
		ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
		//2.从容器中获取mapper
		DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);*/
		
		System.out.println(departmentMapper);
	
		//1.插入几个部门
		
		/*departmentMapper.insertSelective(new Department(1,"开发部"));*/
		
		
		//2.生成员工数据，测试员工插入
		/*emploveeMapper.insertSelective(new Emplovee(1,"草原猪","M","caoyuanzhu@qq.com",1));*/
		
		//3.批量插入员工数据
		/*for(){
			emploveeMapper.insertSelective(new Emplovee(1,"草原猪","M","caoyuanzhu@qq.com",1));
		}*/
		EmploveeMapper mapper = sqlsession.getMapper(EmploveeMapper.class);
		
		for(int i=0;i<=20;i++){
			String uuid = UUID.randomUUID().toString().substring(0,5)+i;
			mapper.insertSelective(new Emplovee(i,uuid,"M",uuid+"caoyuanzhu@qq.com",1));
		}
		System.out.println("完成");
		
		//批量删除
		/*for(int i=0;i<100;i++){
			mapper.deleteByPrimaryKey(i);
		}*/
	}
}
