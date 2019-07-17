package com.atguigu.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.crud.bean.Emplovee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.EmploveeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 处理员工CRUD请求
 * 
 * @author shu
 *
 */
@Controller
public class EmploveeController {

	@Autowired
	EmploveeService emploveeSerive;	
	
	
	
	/**
	 * 删除用户（单个(1)/批量(1-2-3)）
	 * @return
	 */
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmpById(@PathVariable("ids")String ids){
		if(ids.contains("-")){
			List<Integer> del_ids = new ArrayList<Integer>();
			//获得多个用户的集合
			String[] str_ids = ids.split("-");
			//遍历转化为int类型
			for(String string:str_ids){
				del_ids.add(Integer.parseInt(string));
			}
			emploveeSerive.deleteBatch(del_ids);
		}else{
			//获得单个Id转化为int
			Integer id = Integer.parseInt(ids);
			emploveeSerive.deleteEmp(id);
		}
		return Msg.success();
		
	}
	
	
	/**
	 * 如果直接发送ajax=PUT形式的请求
	 * 封装的数据
	 * Emplovee
	 * Emplovee [empId=4, empName=null, gender=null, email=null, dId=null, department=null]
	 * 
	 * 问题：
	 * 请求中有数据
	 * 但是Emplovee对象封装不上，
	 * update tbl_emp where emp_id =101
	 * 
	 * 原因：
	 * Tomcat：
	 * 	1.将请求中的数据，封装一个map
	 * 	2.request.getParameter("empName")就会从这个map中取值
	 *  3.SpringMVC封装POJO对象的时候。
	 *  	会把POJO中每个属性的值，request.getParamter("email");
	 *  
	 * AJAX发送PUT请求引发的:
	 * 	PUT请求，请求体中的数据，request.getParameter("empName")拿不到
	 * 	Tomcat一看是PUT不会封装请求体中的数据位map，只有POST形式的请求才封装请求体为map
	 *
	 * 需要web.xml配置HttpPutFormContentFilter
	 * 
	 * 员工更新,修改
	 * @param emplovee
	 * @return
	 */
	
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	@ResponseBody
	public Msg saveEmp(Emplovee emplovee){
		
		emploveeSerive.updateEmp(emplovee);
		
		return Msg.success();
	}
	
	
	
	
	/**
	 * 根据id查询员工
	 * @param id
	 * @return
	 */
	
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id")Integer id){
		Emplovee emplovee = emploveeSerive.getEmp(id);
		return Msg.success().add("emp", emplovee);
		
	}
	
	/**
	 * 检验用户名是否可用
	 * @param empName
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/checkuser")
	public Msg checkuser(@RequestParam("empName")String empName){
		//正则表达式
		String empx = "(^[a-z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
		if(!empName.matches(empx)){
			return Msg.fail().add("va_msg", "用户名不规范");
		};
		
		boolean b = emploveeSerive.checkUser(empName);
		
		if(b){
			return Msg.success();
		}else{
			return Msg.fail().add("va_msg", "用户名重复或不正确");
		}
	}
	
	
	
	/**
	 * 员工保存
	 * @return
	 */
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Emplovee emplovee,BindingResult result,String empName){
		
		if(result.hasErrors()){
			//检验失败，返回失败信息并显示
			HashMap<String, Object> map = new HashMap<String,Object>();
			List<FieldError> errors = result.getFieldErrors();
			for(FieldError fieldError:errors){
				System.out.println("错误的字段名："+fieldError.getField());
				System.out.println("错误的信息："+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			
			return Msg.fail().add("errorFields", map);
		}else{
			emploveeSerive.saveEmp(emplovee);
			return Msg.success();
		}
		
	}
	
	
	/**
	 * 导入jackson包
	 * @param pn
	 * @return
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWitJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
		// 这不是一个分页查询
		// 引入PageHelper分页插件
		// 在查询之前只需要调用,传入页码，以及每页的大小
		PageHelper.startPage(pn, 5);
		// startPage后面紧跟的这个查询就是一个分页查询
		List<Emplovee> emps = emploveeSerive.getAll();
		// 使用PageInfo包装查询后的结果（封装了详细的分页信息，包括有我们查询出来的数据）

		PageInfo page = new PageInfo(emps, 5);
		
		return Msg.success().add("pageInfo",page);
	}
	

	/**	
	 * 查询员工数据(分页查询)
	 * 
	 * @return
	 */
	// @RequestMapping("/emps")
	public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
		// 这不是一个分页查询
		// 引入PageHelper分页插件
		// 在查询之前只需要调用,传入页码，以及每页的大小
		PageHelper.startPage(pn, 5);
		// startPage后面紧跟的这个查询就是一个分页查询
		List<Emplovee> emps = emploveeSerive.getAll();
		// 使用PageInfo包装查询后的结果（封装了详细的分页信息，包括有我们查询出来的数据）

		PageInfo page = new PageInfo(emps, 5);
		model.addAttribute("pageInfo", page);
		return "list";
	}
	
	
}
