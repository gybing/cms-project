package com.cms.common.utils;


import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

public class ImageUtil {
	protected static Logger logger = Logger.getLogger(ImageUtil.class);
	/**
	 * 二进制存为图片
	 * @param image 图片的二进制
	 * @param path 物理路径
	 */
	public static void saveFile(byte[] image,String filePath){
		try {
			FileOutputStream fos = new FileOutputStream(filePath);
			 fos.write(image);    
             fos.close();  
		
		} catch (IOException e) {
			e.printStackTrace();
			logger.debug("存储文件失败");
		}  
	}
	
	public static String saveImage(byte[] image,String dir,String fileName){
		String path=getImagesPath();
		String filePath=getImagesPath();
		if(StringUtils.isNotEmpty(dir)){
			filePath+=File.separatorChar+dir;
			path+=File.separatorChar+dir;
		}
		path+=File.separatorChar+fileName;
		File d=new File(filePath);
		if(!d.exists()){
			d.mkdirs();
		}
		saveFile(image, path);
		return dir+"/"+fileName;
	}
	
	/**
	 * 获取项目根目录
	 * @return
	 */
	public static String getRootPath(){
		StringBuffer buffer=new StringBuffer();
		buffer.append("WEB-INF").append("/").append("classes");
		return new ImageUtil().getClass().getResource("/").getPath().replace(buffer.toString(), "").replace("%20", " ");
	}
	
	public static String getImagesPath(){
		String path=getRootPath()+java.io.File.separatorChar+Environment.IMAGE_SAVE_PATH;
		File dir=new File(path);
		if(!dir.exists()){
			dir.mkdirs();
		}
		return path;
	}
	
}
