package com.cms.common.excel;

public class ExcelRule {

	private String name;//名称
	private boolean isRequired;//是否必填
	private int length;//长度
	private String expression;//正则表达式
	
	public ExcelRule(){
		
	}
	
	public ExcelRule(String name,boolean isRequired,int length,String expression){
		this.name=name;
		this.isRequired=isRequired;
		this.length=length;
		this.expression=expression;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public boolean isRequired() {
		return isRequired;
	}
	public void setRequired(boolean isRequired) {
		this.isRequired = isRequired;
	}
	public int getLength() {
		return length;
	}
	public void setLength(int length) {
		this.length = length;
	}
	public String getExpression() {
		return expression;
	}
	public void setExpression(String expression) {
		this.expression = expression;
	}
}