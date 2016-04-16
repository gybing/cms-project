package com.cms.common.excel;

import java.io.InputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ExcelPOIUtil {

	private static final String XLS="xls";
	private static final String XLSX="xlsx";
	
	/**
	 * 解析execl
	 * @param sheet 
	 * @param templateName 导入模板名称
	 * @param startRow 开始行
	 * @param startCol 开始列
	 * @param handler  处理方法
	 * @param errorNumTop 检测到有几个错误就返回,不继续解析。0为解析完再返回所有错误
	 * @return
	 * @throws Exception
	 */
//	public ExcelImplMessge readExeclData(Sheet sheet,String templateName,int startRow,int startCol,IExcelColDataHandle handler,int errorNumTop) throws Exception{
//	
//		String sql="select * from T_CM_EXCEL_TEMPLATE where template_name='"+templateName+"' order by seq_order asc";
//		List<HashMap<String, String>> list = dbutil.executeQuery(sql);
//		if(list.isEmpty()){
//			throw new Exception("未配置模板["+templateName+"]");
//		}
//		List<ExcelRule> ruleList=new ArrayList<ExcelRule>();
//		for(HashMap<String, String> map:list){
//			String name=map.get("cell_name");
//			boolean isRequired="Y".equals(map.get("is_required"));
//			int length=map.get("data_length")==null?0:Integer.parseInt(map.get("data_length"));
//			String expression=map.get("expression")==null?"":map.get("expression");
//			ruleList.add(new ExcelRule(name,isRequired,length,expression));
//		}
//		return readExeclData(sheet,ruleList,startRow,startCol,handler,errorNumTop);
//		
//	}
	
	/**
	 * 解析execl
	 * @param sheet 
	 * @param ruleList 解析规则列表
	 * @param startRow 开始行
	 * @param startCol 开始列
	 * @param handler  处理方法
	 * @param errorNumTop 检测到有几个错误就返回,不继续解析。0为解析完再返回所有错误
	 * @return
	 * @throws Exception
	 */
	public ExcelImplMessge readExeclData(Sheet sheet,List<ExcelRule> ruleList,int startRow,int startCol,IExcelColDataHandle handler,int errorNumTop) throws Exception{
		ExcelImplMessge message=new ExcelImplMessge();
		message.setSuccess(true);
		List<Map<String,String>> data=new ArrayList<Map<String,String>>();
		for (int j = startRow; j <= sheet.getLastRowNum(); j++) {
			ConcurrentHashMap<String,String> map=new ConcurrentHashMap<String, String>();
			Row row = sheet.getRow(j);
			int cellNullCount=0;//空单元格计数
			if(row!=null){
				ExcelImplMessge tempMsg=new ExcelImplMessge();
				for (int k = 0; k < ruleList.size(); k++) {
					Cell cell = row.getCell(k+startCol);
					String value="";
					if(cell!=null){
						value= this.getCellValue(cell).trim();
					}
					if(value.isEmpty()){
						cellNullCount++;
					}
					ExcelRule rule=ruleList.get(k);
					if(rule!=null){//预定义的验证
						int code=validation(rule,value);
						switch (code) {
						case 1:
							tempMsg.setSuccess(false);
							tempMsg.appendError(j+1, k+startCol+1, getColumnName(k+startCol+1), "数据为空", value);
							break;
						case 2:
							tempMsg.setSuccess(false);
							tempMsg.appendError(j+1, k+startCol+1, getColumnName(k+startCol+1), "数据长度不能超过"+rule.getLength(), value);
							break;
						case 3:
							tempMsg.setSuccess(false);
							tempMsg.appendError(j+1, k+startCol+1, getColumnName(k+startCol+1), "数据不符合导入规则", value);
							break;
						default:
							break;
						}
					}
					if(handler!=null && tempMsg.isSuccess()){
						try {
							String temp=handler.handle(map,rule.getName(), value);
							if(temp!=null){
								value=temp;
							}
						} catch (Exception e) {
							//e.printStackTrace();
							tempMsg.setSuccess(false);
							tempMsg.appendError(j+1, k+startCol+1, getColumnName(k+startCol+1), e.getMessage(), value);
						}
					}
					map.put(rule.getName(), value);
				}
				if(cellNullCount==ruleList.size()){//跳过空行
					continue;
				}
				if(!tempMsg.isSuccess()){//非空行的话才把错误加到列表里
					message.setSuccess(tempMsg.isSuccess());
					message.appendError(tempMsg.getErrorInfoList());
				}
				if(errorNumTop>0){//错误数量超过定义的数量就返回
					if(message.getErrorInfoList().size()>=errorNumTop){
						return message;
					}
				}
				if(handler!=null && tempMsg.isSuccess()){
					handler.appendDatas(map);
				}
				data.add(map);
			}
		}
		message.setResultList(data);
		return message;
	}
	
	/**
	 * 将流转换成对象
	 * @param in 输入流
	 * @param fileName 文件名（完整的文件名，带后缀，用来判断是2003，还是2007的文件） 
	 * @return
	 * @throws Exception
	 */
	public Workbook getExcelWorkbook(InputStream in,String fileName) throws Exception{
		Workbook wb=null;
		String suffix=fileName.substring(fileName.lastIndexOf(".")+1);
		if(XLS.equalsIgnoreCase(suffix)){
			wb=new HSSFWorkbook(in);
		}else if(XLSX.equalsIgnoreCase(suffix)){
			wb=new XSSFWorkbook(in);
		}else{
			throw new Exception("请检查导入文件格式");
		}
		return wb;
	}
	
	/**
	 * 导出execl2007格式
	 * @param outputStream
	 * @param sheetname
	 * @param titleMap 列名，key=code，value=中文标题
	 * @param list
	 * @throws Exception
	 */
	public void writeExecl2007(OutputStream outputStream,String sheetname,LinkedHashMap<String, String> titleMap,List<Object> list) throws Exception{
		XSSFWorkbook xssfwb=new XSSFWorkbook();
		SXSSFWorkbook sfb=new SXSSFWorkbook(xssfwb,500);
		Sheet sheet=sfb.createSheet(sheetname);
		int rowIndex=0;
		Row row=sheet.createRow(rowIndex++);
		int cellIndex=0;
		Font f=sfb.createFont();
		f.setBoldweight(Font.BOLDWEIGHT_BOLD);//字体加粗
		CellStyle style=sfb.createCellStyle();
		style.setFont(f);
		style.setAlignment(CellStyle.ALIGN_CENTER);//居中
		for(Map.Entry<String, String> entry : titleMap.entrySet()){
			Cell cell=row.createCell(cellIndex++);
			cell.setCellType(Cell.CELL_TYPE_STRING);
			cell.setCellStyle(style);
			cell.setCellValue(entry.getValue());
		}
		for(Object object:list){
			row=sheet.createRow(rowIndex++);
			cellIndex=0;
			for(Map.Entry<String, String> entry : titleMap.entrySet()){
				Cell cell=row.createCell(cellIndex++);
				Object objValue=BeanUtils.getProperty(object,entry.getKey());
				if(objValue instanceof Double){
					cell.setCellType(Cell.CELL_TYPE_NUMERIC);
					cell.setCellValue((Double)objValue);
				}else if(objValue instanceof Integer){
					cell.setCellType(Cell.CELL_TYPE_NUMERIC);
					cell.setCellValue((Integer)objValue);
				}else{
					cell.setCellType(Cell.CELL_TYPE_STRING);
					String value=objValue==null?"":String.valueOf(objValue);
					cell.setCellValue(value);
				}
			}
		}
		sfb.write(outputStream);
		sfb.close();
	}
	
	/**
	 * 导出CSV
	 * @param outputStream
	 * @param sheetname
	 * @param titleMap 列名，key=code，value=中文标题
	 * @param list
	 * @throws Exception
	 */
	public void writeCsv(OutputStream outputStream,String sheetname,LinkedHashMap<String, String> titleMap,List<Object> list) throws Exception{
		StringBuffer sb=new StringBuffer();
		for(Map.Entry<String, String> entry : titleMap.entrySet()){
			sb.append("\"").append(entry.getValue()).append("\",");
		}
		sb.setLength(sb.length()-1);
		for(Object object:list){
			sb.append("\r\n");
			for(Map.Entry<String, String> entry : titleMap.entrySet()){
				Object obj=BeanUtils.getProperty(object,entry.getKey());
				String value=obj==null?"":String.valueOf(obj);
				sb.append("\"").append(value).append("\",");
			}
			sb.setLength(sb.length()-1);
		}
//		String str=new String(sb.toString().getBytes("utf-8"),"iso-8859-1");
		OutputStreamWriter osw = new OutputStreamWriter(outputStream, "gbk");
		osw.write(sb.toString());
		osw.close();
	}
	
	/**
	 * 获取cell的值
	 * @param cell
	 * @return cell的值，Object类型
	 */
	private String getCellValue(Cell cell) {
		String value = null;
		switch (cell.getCellType()) {
		case Cell.CELL_TYPE_NUMERIC: // 数字
			if(DateUtil.isCellDateFormatted(cell)){
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
				value=sdf.format(cell.getDateCellValue());
			}else{
				cell.setCellType(Cell.CELL_TYPE_STRING);
				value =  cell.getStringCellValue();
			}
			break;
		case Cell.CELL_TYPE_STRING: // 字符串
			value =  cell.getStringCellValue();
			break;
		case Cell.CELL_TYPE_BOOLEAN: // Boolean
			value = String.valueOf(cell.getBooleanCellValue());
			break;
		case Cell.CELL_TYPE_FORMULA: // 公式
			value = cell.getCellFormula();
			break;
		case Cell.CELL_TYPE_BLANK: // 空值
			value = "";
			break;
		case Cell.CELL_TYPE_ERROR: // 故障
			value = "";
			break;
		default:
			value = "";
			break;
		}
		return value;
	}
	
	/**
	 * 获取列号
	 * @param columnNum 列数
	 * @return
	 */
	private String getColumnName(int columnNum) {
		int first;
		int last;
		String result = "";
		if (columnNum > 256)
			columnNum = 256;
		first = columnNum / 27;
		last = columnNum - (first * 26);
		if (first > 0)
			result = String.valueOf((char) (first + 64));
		if (last > 0)
			result = result + String.valueOf((char) (last + 64));
		return result;
	}
	
	/**
	 * 验证数据
	 * @param rule
	 * @param value
	 * @param rowIndex
	 * @param colIndex
	 * @return 0:验证通过;1:非空验证;2:长度验证；3：正则判断
	 */
	private int validation(ExcelRule rule,String value){
		if(rule.isRequired()){//判断必填
			if(value==null || "".equals(value)){
				return 1;
			}
		}
		if(value!=null && !"".equals(value)){//值非空的情况下验证
			if(rule.getLength()>0){//判断长度
				if(value.length()>rule.getLength()){
					return 2;
				}
			}
			if(rule.getExpression()!=null && !"".equals(rule.getExpression())){//正则验证
				if(!value.matches(rule.getExpression())){
					return 3;
				}
			}
		}
		return 0;
	}
	
}
