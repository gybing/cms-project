package com.cms.common.web.utils;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.UUID;

public class CommonUtils {
	
	/**
	 * 生成全球唯一标识码GUID
	 * @return
	 */
	public static String getGuit(){
		return UUID.randomUUID().toString();
	}
	/**
	 * 解码
	 * @param src
	 * @return
	 */
	public static String  unescape (String src){
		StringBuffer tmp = new StringBuffer();
		if(src!=null){
			tmp.ensureCapacity(src.length());
			int  lastPos=0,pos=0;
			char ch;
			while (lastPos<src.length()){
				pos = src.indexOf("%",lastPos);
				if (pos == lastPos){
					if (src.charAt(pos+1)=='u'){
						ch = (char)Integer.parseInt(src.substring(pos+2,pos+6),16);
						tmp.append(ch);
						lastPos = pos+6;
					}else{
						ch = (char)Integer.parseInt(src.substring(pos+1,pos+3),16);
						tmp.append(ch);
						lastPos = pos+3;
					}
				}else{
					if (pos == -1){
						tmp.append(src.substring(lastPos));
						lastPos=src.length();
					}else{
						tmp.append(src.substring(lastPos,pos));
						lastPos=pos;
					}
				}
			}
		}
		return tmp.toString();
	}
	
	/**
	  * 把中文字符转成unicode编码如%u6859
	  * @param s 要转的中文
	  * @return
	  */
	 public static String ChineseToUnicode(String   s){   
		  StringBuffer   bu   =   new   StringBuffer(s);   
		  String   unicode   =   "";   
		  for(int   i   =   0;   i   <   bu.length();   i++)   {   
			  //String   tmp   =   Integer.toHexString((int)bu.charAt(i));   
			  int   tmp   =   bu.charAt(i);//Integer.toHexString((int)bu.charAt(i)); 
			  if((tmp   >>   8)>0){//判断是否为中文
				  unicode   =   unicode   +   "%u"   +Integer.toHexString(tmp);//unicode   =   unicode   +   "$$u"   +Integer.toHexString(tmp);//因为dwr不支持%所有换成$$
			  }else{
				  unicode   =   unicode   +bu.charAt(i);
			  }
			  //tmp   =   (tmp   >>   8)   |   ((tmp   <<   8)   &   0xff00) ;
			  // unicode   =   unicode   +   "%u"   +   tmp;   
		  }   
		  return   unicode;   
	 }
	
	/**
	 * 字符串转日期
	 * @param str
	 * @param fmt
	 * @return
	 */
	public static Date stringToDate(String str,String fmt){
		try {
			//后期要改成SimpleDateFormat,传入格式字符串
			SimpleDateFormat sdf = new SimpleDateFormat(fmt); //用这种方法，则转换的日期格式必须相同
			Date date = sdf.parse(str);			
			return date;
		} catch(Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * 日期转字符串
	 * @param date
	 * @param fmt
	 * @return
	 */
	public static String getFormatDate(Date date, String fmt) {
		try {
			SimpleDateFormat sdf = new SimpleDateFormat(fmt);
			String str = sdf.format(date);
			return str;
		} catch(Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 生成固定长度的字符串
	 * @param str: 原数值
	 * @param len: 总长度
	 * @param supplement: 补充字符 如:"0"
	 * @param orientation: 补充的方向(左边:0,右边1)
	 * @return String 如:"000000001"
	 */
	public static String getConstancyStr(String str, int len, char supplement, int orientation) {
		if (str.length()>=len) return str;
		StringBuffer returnStr = new StringBuffer();
		StringBuffer tmp = new StringBuffer("");
		for (int i=str.length(); i<len; i++) {
			tmp.append(supplement);
		}
		if (orientation==0) {
			returnStr.append(tmp.toString());
			returnStr.append(str);
		} else if (orientation==1) {
			returnStr.append(str); 
			returnStr.append(tmp.toString());
		} 
		return returnStr.toString();
	}
	
	/* 将当前日期加减n天数。 
	* 如传入整型-3 意为将当前日期减去3天的日期 
	* 如传入整型3 意为将当前日期加上3天后的日期 
	* 返回字串 例(1999-02-03) 
	*/ 
	public static String dateEditToString(int days) { 
		//日期处理模块 (将日期加上某些天或减去天数)返回字符串 
		Calendar canlendar = Calendar.getInstance(); //java.util包 
		canlendar.add(Calendar.DATE, days); //日期减 如果不够减会将月变动 
		String result = 
		(new SimpleDateFormat("yyyy-MM-dd")).format(canlendar.getTime()); 
		return result; 
	} 
	
	public static Date dateEditToDate(int days){
		Calendar canlendar = Calendar.getInstance(); //java.util包 
		canlendar.add(Calendar.DATE, days); //日期减 如果不够减会将月变动 
		return canlendar.getTime();
	}
}
