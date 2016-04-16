package com.cms.common.form;

/**
 * @author 郑霖
 * 执行返回结果
 */
public class ResponseData {
	public final static String SESSFUL = "1";
	public final static String FAULAIE = "2";
	public final static String EXCEPTION = "3";
	public final static String RAND_FAULAIE = "5";
	//执行结果，1：SESSFUL，2：FAULAIE，3：EXCEPTION
	private String result; 
	//执行结果显示信息
	private String info;
	
	//查询返回结果，可能是list，map，string,由调用者自行判断
	private Object rsObj;
	
	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String resultInfo) {
		this.info = resultInfo;
	}

	public Object getRsObj() {
		return rsObj;
	}

	public void setRsObj(Object rsObj) {
		this.rsObj = rsObj;
	}
}
