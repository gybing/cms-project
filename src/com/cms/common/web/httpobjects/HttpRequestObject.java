package com.cms.common.web.httpobjects;

import com.cms.common.utils.Environment;


/**
 * @author lansb parameter 对象
 */
public class HttpRequestObject {

	private String contentType; // 上传文件类型

	private String disposition; // 部署

	private String filename = ""; // 上传文件名

	private String name; // 名字

	private String originFilename = ""; // 上传源文件名

	private String paramtype; // 是files还是param

	private byte[] value; // 文件的字节或者参数的字节

	public HttpRequestObject() {
	}

	public void setContentType(String contentType) {
		this.contentType = contentType;
	}

	public String getContentType() {
		return contentType;
	}

	public void setDisposition(String disposition) {
		this.disposition = disposition;
	}

	public String getDisposition() {
		return disposition;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getFilename() {
		return filename;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public void setOriginFilename(String originFilename) {
		this.originFilename = originFilename;
	}

	public String getOriginFilename() {
		return originFilename;
	}

	/**
	 * 
	 * @param paramtype
	 *            files/param
	 */
	public void setParamType(String paramtype) {
		this.paramtype = paramtype;
	}

	public String getParamType() {
		return this.paramtype;
	}

	public void setValue(byte[] value) {
		this.value = value;
	}

	public byte[] getValue() {
		return value;
	}
	
	public String getValue(String encoding){
		String v="";
		try {
			v=new String(this.value,encoding);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return v;
	}

	public String toString() {
		String str = null;
		try {
			str = "contentType--->" + contentType + "\r\n";
			str = str + "disposition--->" + disposition + "\r\n";
			str = str + "filename--->" + filename + "\r\n";
			str = str + "name--->" + name + "\r\n";
			str = str + "originFilename--->" + originFilename + "\r\n";
			str = str + "paramtype--->" + paramtype + "\r\n";
			str = str + "value--->" + new String(value, Environment.ENCODING)
					+ "\r\n";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return str;
	}

}
