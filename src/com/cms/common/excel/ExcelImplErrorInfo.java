package com.cms.common.excel;

public class ExcelImplErrorInfo {

	private int errorRowIndex;
	private int errorCellIndex;
	private String errorCellCode;
	private String errorDesc;
	private String errorValue;
	
	public ExcelImplErrorInfo(){
		
	}
	
	public ExcelImplErrorInfo(int errorRow,int errorCell,String errCellCode,String desc,String value){
		this.errorRowIndex=errorRow;
		this.errorCellIndex=errorCell;
		this.errorCellCode=errCellCode;
		this.errorDesc=desc;
		this.errorValue=value;
	}
	
	public int getErrorRowIndex() {
		return errorRowIndex;
	}
	public void setErrorRowIndex(int errorRowIndex) {
		this.errorRowIndex = errorRowIndex;
	}
	public int getErrorCellIndex() {
		return errorCellIndex;
	}
	public void setErrorCellIndex(int errorCellIndex) {
		this.errorCellIndex = errorCellIndex;
	}
	public String getErrorCellCode() {
		return errorCellCode;
	}
	public void setErrorCellCode(String errorCellCode) {
		this.errorCellCode = errorCellCode;
	}
	public String getErrorDesc() {
		return errorDesc;
	}
	public void setErrorDesc(String errorDesc) {
		this.errorDesc = errorDesc;
	}
	public String getErrorValue() {
		return errorValue;
	}
	public void setErrorValue(String errorValue) {
		this.errorValue = errorValue;
	}
}
