package com.Bean;

import java.util.HashMap;
import java.util.Map;

//����jackson���ݵĸ�ʽ
public class Msg {
	//״̬�� 100�ɹ���200ʧ��
	private int code1;
	//��ʾ��Ϣ
	private String Msg;
	//�û����ص�����jackson
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
		result.setMsg("����ɹ�");
		return result;
	}
	
	public static Msg fail() {
		Msg result = new Msg();
		result.setCode1(200);
		result.setMsg("����ʧ��");
		return result;
	}
	
	public Msg add(String key,Object value) {
		this.getExtend().put(key, value);
		return this;
	}
	
}
