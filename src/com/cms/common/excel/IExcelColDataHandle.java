package com.cms.common.excel;

import java.util.Map;

public interface IExcelColDataHandle {

	/**
	 * 处理读取某列的信息
	 * @param map 当前行已读取的数据
	 * @param colName 列名
	 * @param value 读取到的值
	 * @return 处理后的值，请被保存到map的colName中
	 * @throws Exception 值属于异常数据，请抛出异常，如：throw new Exception("类型不存在");
	 */
	public String handle(Map<String,String> map,String colName,String value) throws Exception;
	
	/**
	 * 追加数据，当一行的数据读取完后，执行该方法
	 * @param map
	 */
	public void appendDatas(Map<String,String> map);
}
