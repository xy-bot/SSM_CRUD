package com.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.Bean.Employee;
import com.Bean.EmployeeExample;
import com.Bean.EmployeeExample.Criteria;
import com.Bean.Msg;
import com.Dao.EmployeeMapper;

import net.sf.jsqlparser.statement.create.index.CreateIndex;


@Service
public class EmployeeService {
	@Autowired
	EmployeeMapper employeeMapper;
	public List<Employee> getAll(){
		return employeeMapper.selectByExampleWithDept(null);
		
	}
	@Transactional(readOnly=false,isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED)
	public void saveEmp(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.insertSelective(employee);
	}
	
	public boolean checkUser(String empName) {
		EmployeeExample example = new EmployeeExample();
		//查询empname相同的数据记录
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		//根据条件查询记录
		 long count = employeeMapper.countByExample(example);
		return count == 0;
		// TODO Auto-generated method stub
		
	}
	
	
	public Employee getEmp(Integer id) {
		return employeeMapper.selectByPrimaryKey(id);
	}
	public void updateEmp(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.updateByPrimaryKeySelective(employee);
	}
	public void deleteEmp(Integer id) {
		// TODO Auto-generated method stub
		employeeMapper.deleteByPrimaryKey(id);
	}
	public void deleteEmpBatch(List<Integer> list) {
		// TODO Auto-generated method stub
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpIdIn(list);
		employeeMapper.deleteByExample(example);
	}
	
}
