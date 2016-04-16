package com.cms.common.form;

import java.util.ArrayList;
import java.util.List;

/**
 * @author lansb
 * 执行返回结果form
 */
public class ResponseDataForm {
	public final static String SESSFUL = "1";
	public final static String FAULAIE = "2";
	public final static String EXCEPTION = "3";
	public final static String RAND_FAULAIE = "5";
	//执行结果，1：SESSFUL，2：FAULAIE，3：EXCEPTION
	private String result; 
	//执行结果显示信息
	private String resultInfo;
	//校验错误列表
	private List<String> errorList;
	
	//返回结果，可能是list，map，string,PaginForm
	private Object resultObj;
	
	private String page;
	
	public ResponseDataForm() {
		errorList = new ArrayList<String>();
	}

	public List<String> getErrorList() {
		return errorList;
	}

	public void setErrorList(List<String> errorList) {
		this.errorList = errorList;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getResultInfo() {
		return resultInfo;
	}

	public void setResultInfo(String resultInfo) {
		this.resultInfo = resultInfo;
	}

	public Object getResultObj() {
		return resultObj;
	}

	public void setResultObj(Object resultObj) {
		this.resultObj = resultObj;
	}

	public String getPage() {
		return page;
	}

	public void setPage(String page) {
		this.page = page;
	}
}
