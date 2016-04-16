package com.cms.common.excel;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class ExcelImplMessge {

	private boolean isSuccess=true;//解析是否成功
	private List<ExcelImplErrorInfo> errorInfoList;//错误信息集合
	private List<Map<String,String>> resultList;//解析结果
	
	public ExcelImplMessge(){
		errorInfoList=new ArrayList<ExcelImplErrorInfo>();
	}
	
	public boolean isSuccess() {
		return isSuccess;
	}
	public void setSuccess(boolean isSuccess) {
		this.isSuccess = isSuccess;
	}
	public List<ExcelImplErrorInfo> getErrorInfoList() {
		return errorInfoList;
	}
	public void setErrorInfoList(List<ExcelImplErrorInfo> errorInfoList) {
		this.errorInfoList = errorInfoList;
	}
	
	public void appendError(ExcelImplErrorInfo errorInfo){
		this.errorInfoList.add(errorInfo);
	}
	
	public void appendError(int errorRow,int errorCell,String errCellCode,String desc,String value){
		this.errorInfoList.add(new ExcelImplErrorInfo(errorRow,errorCell,errCellCode,desc,value));
	}
	
	public void appendError(List<ExcelImplErrorInfo> list){
		this.errorInfoList.addAll(list);
	}
	
	public List<Map<String, String>> getResultList() {
		return resultList;
	}

	public void setResultList(List<Map<String, String>> resultList) {
		this.resultList = resultList;
	}
}
