package com.atguigu.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.bean.Emplovee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.DepartmentService;


@Controller
public class DepartmentController {

	@Autowired
	DepartmentService departmentService;

	
	
	/**
	 * 
	 * @return 返回所有部门信息
	 */
	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDepts(){
		List<Department> list = departmentService.getDepts();
		
		return Msg.success().add("depts", list);
	}
}
