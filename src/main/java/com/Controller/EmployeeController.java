package com.Controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.Bean.Employee;
import com.Bean.Msg;
import com.Service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class EmployeeController {
	
	@Autowired
	EmployeeService employeservice;
	//使用jackson字符串进行传输数据,ajax方法，返回jackson数据。方便多平台
	//查询数据
	
	@RequestMapping(value="/emps")
	@ResponseBody
	public Msg getDatJackson(@RequestParam(value="pn",defaultValue="1")Integer pn) {
		PageHelper.startPage(pn, 5);
		//startPage后面紧跟一个查询就是分页查询
		List<Employee> employees = employeservice.getAll();
		//使用PageInfo包装查询完的数据，只需要将pageinfo交给页面
		//封装了详细的分页信息，包括查询的数据,5代表页面每次连续显示的页数是5，例如1-5 2-6
		PageInfo page = new PageInfo<>(employees,5);
		//返回msg消息带着数据
		return Msg.sucess().add("pageInfo",page);
	}
	//保存数据
	@Validated//要添加校验注释
	@RequestMapping(value="/emp",method = RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result) {//@Valid代表需要后端校验
		//判断校验是否有错误
		if (result.hasErrors()) {
			//获取错误信息,封装错误信息
			Map<String, Object> map = new HashMap<String, Object>();
			List<FieldError> fieldErrors = result.getFieldErrors();
			for (FieldError fieldError : fieldErrors) {
				System.out.println("错误字段名:"+fieldError.getField());
				System.out.println("错误字段信息:"+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFieds", map);
		}else {
			employeservice.saveEmp(employee);
			return Msg.sucess();
		}
		
	}
	
	
	
	//查询新增数据记录,以备校验，校验分为js前端校验，ajax查询用户名校验，后端校验（JSR303）需要导入包Hibret
	@RequestMapping("/checkUser")
	@ResponseBody
	public Msg checkUser( String empName) {	
		//先判断用户名是否是合法的表达式
		String regx = "(^[a-zA-Z0-9_-]{3,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)";
		//match验证是否符合格式
		if (!empName.matches(regx)) {
			return Msg.fail().add("val_msg", "用户名应为3-16位英文或者2-5位中文名");
		}
		boolean b = employeservice.checkUser(empName);
		if (b) {
			return Msg.sucess();
		}else {
			return Msg.fail().add("val_msg", "用户名已存在");
		}
		
	}
	
	//restful风格，使用占位符
	@RequestMapping(value="/emp/{id}",method = RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id") Integer id) {
		Employee employee =  employeservice.getEmp(id);
		return Msg.sucess().add("emp", employee);
		
	}
	
	
	//更新数据
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	@ResponseBody
	public Msg updateEmps(Employee employee) {
		System.out.println(employee);
		employeservice.updateEmp(employee);
		return Msg.sucess();
	}
	
	//可以删除多条数据如：1-2-3，或者单条数据
	//删除数据@PathVariable代表从路径中取出id
		@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
		@ResponseBody
		public Msg deleteEmp(@PathVariable("ids") String ids) {
			if (ids.contains("-")) {
				List<Integer> list = new ArrayList<Integer>();
				String[] i_ids = ids.split("-");
				for (String string : i_ids) {
					list.add(Integer.parseInt(string));
				}
				System.out.println(list);
				employeservice.deleteEmpBatch(list);
				return Msg.sucess();
			}else {
				Integer id = Integer.parseInt(ids);
				employeservice.deleteEmp(id);
				return Msg.sucess();
			}
			
			
		}
/*	@RequestMapping("/emps")
	public String getemps(@RequestParam(value="pn",defaultValue="1") Integer pn,Model model ) {
		//引入pageHelper插件
		//startPage(pn, 5)从pn页，每页5条数据
		PageHelper.startPage(pn, 5);
		//startPage后面紧跟一个查询就是分页查询
		List<Employee> employees = employeservice.getAll();
		//使用PageInfo包装查询完的数据，只需要将pageinfo交给页面
		//封装了详细的分页信息，包括查询的数据,5代表页面每次连续显示的页数是5，例如1-5 2-6
		PageInfo page = new PageInfo<>(employees,5);
		//将数据传给前台
		model.addAttribute("pageInfo", page);
		return "list";
	}*/
}
