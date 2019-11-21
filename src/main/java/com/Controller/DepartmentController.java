package com.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.Bean.Department;
import com.Bean.Msg;
import com.Service.DepartmentService;


@Controller
public class DepartmentController {
	@Autowired
	private DepartmentService service;
	//涉及到jackson数据时，需要使用@ResponseBody
	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDepts() {
		List<Department> list = service.getDepts();
		return Msg.sucess().add("depts", list);
	}
}
