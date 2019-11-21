package com.Test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.Bean.Employee;
import com.github.pagehelper.PageInfo;

//使用springtest提供的测试请求来测试crud的正确性


@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations= {"classpath:applicationContext.xml","classpath:springServlet.xml"})
public class MVCTest {
	//传入springmvc的ioc
	@Autowired
	WebApplicationContext context;
	//虚拟mvc请求
	MockMvc mockMvc;
	@Before
	public void initMockMvc() {
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
	@Test
	public void TestPage() throws Exception {
		//模拟请求拿到返回值
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1")).andReturn();
		//请求成功后，请求域中会有pageinfo，我们取出pageInfo进行验证
		MockHttpServletRequest request = result.getRequest();
		PageInfo pi = (PageInfo) request.getAttribute("pageInfo");
		System.out.println("当前页码"+pi.getPageNum());
		System.out.println("总页码:"+pi.getPages());
		System.out.println("总记录数"+pi.getTotal());
		System.out.println("在页面连续取出的页码数");
		int[] nums = pi.getNavigatepageNums();
		for (int i : nums) {
			System.out.println(" "+i);
		}
		//获取员工数据
		List<Employee> employees = pi.getList();
		for (Employee employee : employees) {
			System.out.println("id:"+employee.getEmpId()+"  name:"+employee.getEmpName());
		}
	}
}
