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
	//ʹ��jackson�ַ������д�������,ajax����������jackson���ݡ������ƽ̨
	//��ѯ����
	
	@RequestMapping(value="/emps")
	@ResponseBody
	public Msg getDatJackson(@RequestParam(value="pn",defaultValue="1")Integer pn) {
		PageHelper.startPage(pn, 5);
		//startPage�������һ����ѯ���Ƿ�ҳ��ѯ
		List<Employee> employees = employeservice.getAll();
		//ʹ��PageInfo��װ��ѯ������ݣ�ֻ��Ҫ��pageinfo����ҳ��
		//��װ����ϸ�ķ�ҳ��Ϣ��������ѯ������,5����ҳ��ÿ��������ʾ��ҳ����5������1-5 2-6
		PageInfo page = new PageInfo<>(employees,5);
		//����msg��Ϣ��������
		return Msg.sucess().add("pageInfo",page);
	}
	//��������
	@Validated//Ҫ���У��ע��
	@RequestMapping(value="/emp",method = RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result) {//@Valid������Ҫ���У��
		//�ж�У���Ƿ��д���
		if (result.hasErrors()) {
			//��ȡ������Ϣ,��װ������Ϣ
			Map<String, Object> map = new HashMap<String, Object>();
			List<FieldError> fieldErrors = result.getFieldErrors();
			for (FieldError fieldError : fieldErrors) {
				System.out.println("�����ֶ���:"+fieldError.getField());
				System.out.println("�����ֶ���Ϣ:"+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFieds", map);
		}else {
			employeservice.saveEmp(employee);
			return Msg.sucess();
		}
		
	}
	
	
	
	//��ѯ�������ݼ�¼,�Ա�У�飬У���Ϊjsǰ��У�飬ajax��ѯ�û���У�飬���У�飨JSR303����Ҫ�����Hibret
	@RequestMapping("/checkUser")
	@ResponseBody
	public Msg checkUser( String empName) {	
		//���ж��û����Ƿ��ǺϷ��ı��ʽ
		String regx = "(^[a-zA-Z0-9_-]{3,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)";
		//match��֤�Ƿ���ϸ�ʽ
		if (!empName.matches(regx)) {
			return Msg.fail().add("val_msg", "�û���ӦΪ3-16λӢ�Ļ���2-5λ������");
		}
		boolean b = employeservice.checkUser(empName);
		if (b) {
			return Msg.sucess();
		}else {
			return Msg.fail().add("val_msg", "�û����Ѵ���");
		}
		
	}
	
	//restful���ʹ��ռλ��
	@RequestMapping(value="/emp/{id}",method = RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id") Integer id) {
		Employee employee =  employeservice.getEmp(id);
		return Msg.sucess().add("emp", employee);
		
	}
	
	
	//��������
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	@ResponseBody
	public Msg updateEmps(Employee employee) {
		System.out.println(employee);
		employeservice.updateEmp(employee);
		return Msg.sucess();
	}
	
	//����ɾ�����������磺1-2-3�����ߵ�������
	//ɾ������@PathVariable�����·����ȡ��id
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
		//����pageHelper���
		//startPage(pn, 5)��pnҳ��ÿҳ5������
		PageHelper.startPage(pn, 5);
		//startPage�������һ����ѯ���Ƿ�ҳ��ѯ
		List<Employee> employees = employeservice.getAll();
		//ʹ��PageInfo��װ��ѯ������ݣ�ֻ��Ҫ��pageinfo����ҳ��
		//��װ����ϸ�ķ�ҳ��Ϣ��������ѯ������,5����ҳ��ÿ��������ʾ��ҳ����5������1-5 2-6
		PageInfo page = new PageInfo<>(employees,5);
		//�����ݴ���ǰ̨
		model.addAttribute("pageInfo", page);
		return "list";
	}*/
}
