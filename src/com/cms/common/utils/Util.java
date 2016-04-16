package com.cms.common.utils;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.GZIPInputStream;
import java.util.zip.GZIPOutputStream;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang.StringUtils;

public class Util {

	private static final double EARTH_RADIUS = 6378.137;   
	private static double rad(double d){   
	     return d * Math.PI / 180.0;   
	}
	
	/**
	 * 根据两点经纬度计算距离
	 * @param lat1
	 * @param lng1
	 * @param lat2
	 * @param lng2
	 * @return
	 */
	public static double getDistance(double lat1, double lng1, double lat2, double lng2){
	   double radLat1 = rad(lat1);
	   double radLat2 = rad(lat2);
	   double a = radLat1 - radLat2;
	   double b = rad(lng1) - rad(lng2);

	   double s = 2 * Math.asin(Math.sqrt(Math.pow(Math.sin(a/2),2) +
	    Math.cos(radLat1)*Math.cos(radLat2)*Math.pow(Math.sin(b/2),2)));
	   s = s * EARTH_RADIUS;
	   s = Math.round(s * 10000) / 10000.0;
	   return s;
	}
	
	/** 
     * 身份证 加权因子
     */
 	private static final int power[] = {7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2};
 	/**
 	 * 身份证 第18位校检码
 	 */
 	private static final String verifyCode[] = {"1", "0", "X", "9", "8", "7", "6", "5", "4", "3", "2"};

 	/**
 	 * 验证18位身份证，验证最后一位的效验码
 	 * @param idcard
 	 * @return
 	 */
 	public static boolean isValidateIdcard(String idcard) { // 非18位为假
 		if (idcard.length() != 18) {
 			return false;
 		} // 获取前17位
 		String idcard17 = idcard.substring(0, 17); // 获取第18位
 		String idcard18Code = idcard.substring(17, 18);
 		char[] c = null;
 		String checkCode = ""; // 是否都为数字
 		c = idcard17.toCharArray();
 		if (null != c) {
 			int sum17 = 0;
 			sum17 = getPowerSum(c); // 将和值与11取模得到余数进行校验码判断
 			checkCode = verifyCode[sum17 % 11];
 			if (null == checkCode) {
 				return false;
 			}
 			// 将身份证的第18位与算出来的校码进行匹配，不相等就为假
 			if (!idcard18Code.equalsIgnoreCase(checkCode)) {
 				return false;
 			}
 		}
 		return true;
 	}
 	
 	private static int getPowerSum(char[] bit) {
		int sum = 0;
		if (power.length != bit.length) {
			return sum;
		}
		for (int i = 0; i < bit.length; i++) {
			for (int j = 0; j < power.length; j++) {
				if (i == j) {
					sum = sum + Integer.parseInt(String.valueOf(bit[i])) * power[j];
				}
			}
		}
		return sum;
	}
 	
 	/**
	 * 压缩后，用base64加密
	 * @param str
	 * @return
	 * @throws IOException
	 */
	public static String compress(String str) throws IOException {
		if (str == null || str.length() == 0) {
			return str;
		}
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		GZIPOutputStream gzip = new GZIPOutputStream(out);
		gzip.write(str.getBytes("utf-8"));
		gzip.close();
//		out.toString("ISO-8859-1");
		return Base64.encodeBase64String(out.toByteArray());
	}

	/**
	 * base64解密后再解压缩
	 * @param str
	 * @return
	 * @throws IOException
	 */
	public static String uncompress(String str) throws IOException {
		if (str == null || str.length() == 0) {
			return str;
		}
//		str=new String(Base64.decode(str,Base64.DEFAULT));
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		ByteArrayInputStream in = new ByteArrayInputStream(Base64.decodeBase64(str));
		GZIPInputStream gunzip = new GZIPInputStream(in);
		byte[] buffer = new byte[256];
		int n;
		while ((n = gunzip.read(buffer)) >= 0) {
			out.write(buffer, 0, n);
		}
		return out.toString("utf-8");
	}
	
	public static String getIP(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}
	
	/**
	 * 将参数连接后取得MD5的签名
	 * @param param
	 * @return
	 */
	public static String getSignByMD5(Map<String,String> param,String securityKey){
		List<String> keyList=new ArrayList<String>();
		keyList.addAll(param.keySet());
		Collections.sort(keyList, new Comparator<String>(){
			@Override
			public int compare(String o1, String o2) {
				return o1.compareToIgnoreCase(o2);
			}
		});
		StringBuffer str=new StringBuffer();
		for(String key:keyList){
			str.append(param.get(key));
		}
		str.append(securityKey);
		return DigestUtils.md5Hex(str.toString()).toLowerCase();
	}
	
	/**
	 * 解密
	 * @param content
	 * @param password
	 * @return
	 */
	public static String decrypt(String content, String password) {
		try {
			if (content.length() < 1)
				return null;
			byte[] result = new byte[content.length() / 2];
			for (int i = 0; i < content.length() / 2; i++) {
				int high = Integer.parseInt(content.substring(i * 2, i * 2 + 1), 16);
				int low = Integer.parseInt(content.substring(i * 2 + 1, i * 2 + 2), 16);
				result[i] = (byte) (high * 16 + low);
			}
			KeyGenerator kgen = KeyGenerator.getInstance("AES");
			SecureRandom secureRandom = SecureRandom.getInstance("SHA1PRNG");
			secureRandom.setSeed(password.getBytes()); 
			kgen.init(128, secureRandom);
			SecretKey secretKey = kgen.generateKey();
			byte[] enCodeFormat = secretKey.getEncoded();
			SecretKeySpec key = new SecretKeySpec(enCodeFormat, "AES");
			Cipher cipher = Cipher.getInstance("AES");// 创建密码器
			cipher.init(Cipher.DECRYPT_MODE, key);// 初始化
			return new String(cipher.doFinal(result),"utf-8");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 加密
	 * @param content  需要加密的内容
	 * @param password 加密密码
	 * @return
	 */
	public static String encrypt(String content, String password) {
		try {
			KeyGenerator kgen = KeyGenerator.getInstance("AES");
			SecureRandom secureRandom = SecureRandom.getInstance("SHA1PRNG");
			secureRandom.setSeed(password.getBytes());     
            kgen.init(128, secureRandom);
			SecretKey secretKey = kgen.generateKey();
			byte[] enCodeFormat = secretKey.getEncoded();
			SecretKeySpec key = new SecretKeySpec(enCodeFormat, "AES");
			Cipher cipher = Cipher.getInstance("AES");// 创建密码器
			byte[] byteContent = content.getBytes("utf-8");
			cipher.init(Cipher.ENCRYPT_MODE, key);// 初始化
			byte[] result = cipher.doFinal(byteContent);
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < result.length; i++) {
				String hex = Integer.toHexString(result[i] & 0xFF);
				if (hex.length() == 1) {
					hex = '0' + hex;
				}
				sb.append(hex.toUpperCase());
			}
			return sb.toString();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 将url格式的参数转换成map
	 * @param str 字符串格式a=b&c=d
	 * @return map
	 */
	public static Map<String,String> getUrlParam(String str){
		HashMap<String ,String> map=new HashMap<String ,String>();
		if(StringUtils.isNotEmpty(str)){
			for(String s:str.split("&")){
				String[] arr = s.split("=");
				map.put(arr[0], arr[1]);
			}
		}
		return map;
	}
}
