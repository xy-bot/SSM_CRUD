package com.Test;

import java.util.List;
import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.Bean.Department;
import com.Bean.Employee;
import com.Dao.DepartmentMapper;
import com.Dao.EmployeeMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class MapperTest {
	@Autowired
	SqlSession sqlSession;
	//ֱ��ʹ��ע���õ����
	@Autowired
	DepartmentMapper departmapper;
	@Autowired
	EmployeeMapper employmapper;
	@Test
	public void departmapperTest() {
//		 System.out.println(departmapper);
//		 departmapper.insertSelective(new Department(null, "������"));
//		 departmapper.insertSelective(new Department(null, "���Բ�"));
		 
		 List<Department> list =departmapper.selectByExample(null);
		 for (Department department : list) {
			System.out.println(department);
		}
	}
	@Test
	public void employmapperTest() {
//		employmapper.insertSelective(new Employee(null, "Jerry", "M", "Jerry@163.com", 1));
		
		//������������
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		for(int i=0;i<1000;i++) {
			String uuid = UUID.randomUUID().toString().substring(0, 5)+i;
			mapper.insertSelective(new Employee(null, uuid, "M", uuid+"@163.com", 1));
		}
		System.out.println("�����������");
		
		
//		
//		List<Employee> employees = employmapper.selectByExampleWithDept(null);
//		for (Employee employee : employees) {
//			System.out.println(employee);
//		}
	}
}
