package com.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Bean.Department;
//service省略了impl接口
import com.Dao.DepartmentMapper;
@Service
public class DepartmentService {
	@Autowired
	DepartmentMapper departmentMapper;
	
	public List<Department> getDepts() {
		return departmentMapper.selectByExample(null);
	}

	
}
