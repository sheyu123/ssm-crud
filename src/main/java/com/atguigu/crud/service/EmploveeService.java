package com.atguigu.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.atguigu.crud.bean.Emplovee;
import com.atguigu.crud.bean.EmploveeExample;
import com.atguigu.crud.bean.EmploveeExample.Criteria;
import com.atguigu.crud.dao.EmploveeMapper;

@Service
public class EmploveeService {

	@Autowired
	EmploveeMapper emploveeMapper;
	
	/**
	 * 查询所有员工
	 * @return
	 */
	public List<Emplovee> getAll() {
		return emploveeMapper.findAll();
	}

	/**
	 * 保存员工
	 */
	public void saveEmp(Emplovee emplovee) {
		emploveeMapper.insertSelective(emplovee);	
	}

	/**
	 * 检查员工
	 * @param empName
	 * @return
	 */
	public boolean checkUser(String empName) {
		EmploveeExample example = new EmploveeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count = emploveeMapper.countByExample(example);	
		return count == 0;
	}

	/**
	 * 根据id查询员工
	 * @param id
	 * @return
	 */
	public Emplovee getEmp(Integer id) {
		Emplovee emplovee = emploveeMapper.selectByPrimaryKey(id);
		return emplovee;
	}
	
	
	/**
	 * 修改员工
	 * @param emplovee
	 * @return
	 */
	public EmploveeService updateEmp(Emplovee emplovee) {
		 emploveeMapper.updateByPrimaryKeySelective(emplovee);
		return null;
	}

	
	 
	/**
	 * 删除员工
	 */
	public void deleteEmp(Integer id) {
		emploveeMapper.deleteByPrimaryKey(id);
	}
 
	public void deleteBatch(List<Integer> del_ids) {
		EmploveeExample example = new EmploveeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpIdIn(del_ids);
		emploveeMapper.deleteByExample(example);
	}
	

	
}
