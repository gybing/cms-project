package com.cms.common.utils;

import java.io.File;
import java.io.FileInputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.cms.common.exception.CustomException;

/**
 * @author lansb
 *正则表达式验证
 */
public class RegexUtils {
	public static Map<String, String> regexMap = null;
	public static void init() throws Exception {
		regexMap = new HashMap<String, String>();
		String path = RegexUtils.class.getClassLoader().getResource("").toURI().getPath();
		String aa = path.replace("classes/", "conf/regex.properties");
		FileInputStream fis = new FileInputStream(new File(aa));     
		Properties props = new Properties();
		props.load(fis);
		for(Object key : props.keySet()) {
			regexMap.put(key.toString(), props.getProperty(key.toString()));
		}
	}
	public static boolean match(String regexName, String value) throws Exception {
		if(regexMap == null) init();
		if(regexMap.get(regexName) == null) {
			throw new CustomException("\t\r\n正则表达式：" + regexName + "不存在！");
		}
		Pattern pattern = Pattern.compile(regexMap.get(regexName));
		Matcher matcher = pattern.matcher(value);
		return !matcher.matches();
	}
}
