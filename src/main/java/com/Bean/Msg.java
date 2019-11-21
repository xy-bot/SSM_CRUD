package com.Bean;

import java.util.HashMap;
import java.util.Map;

//返回jackson数据的格式
public class Msg {
	//状态码 100成功，200失败
	private int code1;
	//提示信息
	private String Msg;
	//用户返回的数据jackson
	private Map<String, Object> extend = new HashMap<String, Object>();
	
	
	public Integer getCode1() {
		return code1;
	}
	public void setCode1(Integer code1) {
		this.code1 = code1;
	}
	public String getMsg() {
		return Msg;
	}
	public void setMsg(String msg) {
		Msg = msg;
	}
	public Map<String, Object> getExtend() {
		return extend;
	}
	public void setExtend(Map<String, Object> extend) {
		this.extend = extend;
	}
	
	public static Msg sucess() {
		Msg result = new Msg();
		result.setCode1(100);
		result.setMsg("处理成功");
		return result;
	}
	
	public static Msg fail() {
		Msg result = new Msg();
		result.setCode1(200);
		result.setMsg("处理失败");
		return result;
	}
	
	public Msg add(String key,Object value) {
		this.getExtend().put(key, value);
		return this;
	}
	
}
