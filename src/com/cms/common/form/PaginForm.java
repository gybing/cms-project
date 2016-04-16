package com.cms.common.form;

import java.util.List;
import java.util.Map;

/**
 * @author lansb
 *分页相关信息
 */
public class PaginForm {
	private int totalCount;//总数
	private int numPerPage;//每页显示数量
	private int pageNum;//当前页数
	private List<Map<String, Object>> dataList;//数据集合
	private int pageNumShown;//展示直接点击的数字
	private int startNum;//开始条数
	
	
	public int getStartNum() {
		return startNum;
	}
	public void setStartNum(int startNum) {
		this.startNum = startNum;
	}
	public int getPageNumShown() {
		return pageNumShown;
	}
	public void setPageNumShown(int pageNumShown) {
		this.pageNumShown = pageNumShown;
	}
	
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	public List<Map<String, Object>> getDataList() {
		return dataList;
	}
	public void setDataList(List<Map<String, Object>> dataList) {
		this.dataList = dataList;
	}
	public int getNumPerPage() {
		return numPerPage;
	}
	public void setNumPerPage(int numPerPage) {
		this.numPerPage = numPerPage;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	
}
