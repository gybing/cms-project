package com.cms.common.web.httpobjects;

import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;

import com.cms.common.form.RequestDataForm;
import com.cms.common.utils.Environment;


/**
 * @author lansb
 * 解析Form提交的流
 */
public class ServletInputStreamParse {


	private HttpServletRequest request;

	private ServletInputStream sis;

	private String boundary;

	public ServletInputStreamParse(HttpServletRequest arequest)
			throws IOException {
		this.request = arequest;
		this.sis = arequest.getInputStream();
		this.boundary = this.extractBoundary(arequest);
	}

	public HttpServletRequest getRequest() {
		return this.request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	/**
	 * 获取http请求对象信息，map包括简单的key和value对应以及HttpRequestObject
	 *@throws Exception
	 */
	public void getHttpRequestInfo(RequestDataForm requestDataForm)
			throws Exception {
		String line = this.extractFirstBoundary();
		Map<String, String> map = new HashMap<String, String>();
		
//		Map<String, List<HttpRequestObject>> multipleRequestMap = new LinkedHashMap<String, List<HttpRequestObject>>();
//		Map<String, String> simpleRequestMap = new HashMap<String, String>();
		while (true) { 
			map = this.extractDataHead(line);
			if (map == null)
				break;
			// 将取得参数放到对象里面
			HttpRequestObject hro = new HttpRequestObject();
			hro.setContentType(map.get("contenttype"));
			hro.setDisposition(map.get("disposition"));
			hro.setFilename(map.get("filename"));
			String name = map.get("name");
			hro.setName(name);
			hro.setOriginFilename(map.get("origname"));
			String paramtype = map.get("paramtype");
			hro.setParamType(paramtype);
			this.readLine(sis);//表单提交的描述和内容有个空行
			ParamPart pp = new ParamPart(sis, boundary, Environment.ENCODING);
			hro.setValue(pp.getValue());
			if(!"file".equalsIgnoreCase(paramtype)) {//非文件时编码转换,存入普通的请求Map
//				simpleRequestMap.put(name, new String(pp.getValue(), Environment.ENCODING));
				requestDataForm.addString(name, new String(pp.getValue(), Environment.ENCODING));
			} else {
				if(hro.getFilename() == null || "".equals(hro.getFilename())) continue;//附件类型为文件，并且附件为空的话，不处理该文件
				List<HttpRequestObject> list = new LinkedList<HttpRequestObject>();
				list.add(hro);
				requestDataForm.put(name, list);
			}
//			if(requestDataForm.containsKey(name)) {
//				List<HttpRequestObject> list = multipleRequestMap.get(name);
//				list.add(hro);
//				multipleRequestMap.put(name, list);
//				requestDataForm.put(name, list);
//			} else {
//				List<HttpRequestObject> list = new LinkedList<HttpRequestObject>();
//				list.add(hro);
//				multipleRequestMap.put(name, list);
//				requestDataForm.put(name, list);
//			}
		}
//		requestDataForm.setSimpleRequestMap(simpleRequestMap);
//		requestDataForm.setMultipleRequestMap(multipleRequestMap);
	}

	private String extractFirstBoundary() throws IOException {
		String line = this.readLine(sis);
		return line;
	}

	/**
	 * 解析每行信息，返回行信息Map
	 *@param line
	 *@return
	 *@throws Exception
	 */
	private Map<String, String> extractDataHead(String line) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		if (this.isBoundary(line, this.boundary)) {
			line = this.readLine(this.sis);//Content-Despostioion信息
			if (line == null)
				return null;
			map = extracDispositionInfo(line);
			String paramtype = (String) map.get("paramtype");//通过是否有文件名来判定
			if (paramtype.equalsIgnoreCase("file")) {
				line = this.readLine(this.sis);//提交的文件类型
				//line = new String(line.getBytes(Environment.ENCODING), this.encoding);
				String contentType = this.extractContentType(line);//如 image/gif等
				//contentType = new String(contentType.getBytes(Environment.ENCODING), this.encoding);
				map.put("contenttype", contentType);
			} else {
				map.put("contenttype", null);
			}
			// printMap(map);
			return map;
		} else {
			return null;
		}

	}

	/**
	 * 得到数据流的分隔符号 extractBoundary
	 * 
	 * @param request
	 *            WEB请求
	 * @return 分隔符号
	 * @throws IOException
	 * 
	 */
	private String extractBoundary(HttpServletRequest request)
			throws IOException {
		String type = this.extractType(request);
		return this.extractBoundary(type);
	}

	private String extractContentType(String line) {
		line = line.toLowerCase();
		int end = line.indexOf(";");
		if (end == -1) {
			end = line.length();
		}
		line = line.substring(13, end).trim();
		return line; // "content-type:" is 13
	}

	/**
	 * 得到请求form提交的content-type 不为流提交方式抛出异常
	 * 
	 * @param request
	 *            WEB请求
	 * @return 类型
	 * @throws IOException
	 */
	private String extractType(HttpServletRequest request) throws IOException {
		String type = null;
		String type1 = request.getHeader("Content-Type");
		String type2 = request.getContentType();
		if (type1 == null && type2 != null) {
			type = type2;
		} else if (type2 == null && type1 != null) {
			type = type1;
		} else if (type1 != null && type2 != null) {
			type = (type1.length() > type2.length() ? type1 : type2);
		}
		if (type == null
				|| !type.toLowerCase().startsWith("multipart/form-data")) {
			throw new IOException(
					"Posted content type isn't multipart/form-data");
		}
		return type;
	}

	/**
	 * 获取数据分割符号
	 * @param aType
	 *            form类型
	 * @return 数据分隔符
	 */
	private String extractBoundary(String aType) {
		int index = aType.lastIndexOf("boundary=");
		int end=aType.length();
		if (index == -1) {
			return null;
		}
		
		if(aType.indexOf(";", index)!=-1){
			end=aType.indexOf(";", index);
		}
		
		String boundary = aType.substring(index + 9,end); // 9 for "boundary="
		if (boundary.charAt(0) == '"') {
			index = boundary.lastIndexOf('"');
			boundary = boundary.substring(1, index);
		}
		boundary = "--" + boundary;
		return boundary;
	}

	/**
	 * 从输入流中读取一行信息，并去掉换行字符
	 * 
	 * @param sis
	 *            request.getInputStream
	 * @return 一行的字符串
	 * @throws IOException
	 */
	private String readLine(ServletInputStream sis) throws IOException {
		byte[] buf = new byte[8 * 1024];
		StringBuffer sbuf = new StringBuffer();
		int result;
		// String line;
		do {
			result = sis.readLine(buf, 0, buf.length); // does +=
			if (result != -1) {
				sbuf.append(new String(buf, 0, result, Environment.ENCODING));
			}
		} while (result == buf.length);
		if (sbuf.length() == 0) {
			return null;
		}
		int len = sbuf.length();
		if (len >= 2 && sbuf.charAt(len - 2) == '\r') {
			sbuf.setLength(len - 2); // cut \r\n
		} else if (len >= 1 && sbuf.charAt(len - 1) == '\n') {
			sbuf.setLength(len - 1); // cut \n
		}
		return sbuf.toString();
	}

	/**
	 * 判断是否是数据分隔符号
	 * 
	 * @param aLine
	 *            行字符串
	 * @param aBoundary
	 *            数据分隔符号
	 * @return
	 */
	private boolean isBoundary(String aLine, String aBoundary) {
		if (aLine != null && aLine.startsWith(aBoundary)) {
			return true;
		} else
			return false;
	}

	/**
	 * 
	 * @param line
	 *            行字符串 
	 * @return 包含上传参数的信息
	 *         <p>
	 *         disposition 描述
	 *         </p>
	 *         <p>
	 *         name 名字
	 *         </p>
	 *         <p>
	 *         filename 文件名
	 *         </p>
	 *         <p>
	 *         origname 源文件名
	 *         </p>
	 * @throws IOException
	 */
	private Map<String, String> extracDispositionInfo(String line) throws IOException {
		Map<String, String> retval = new HashMap<String, String>();
		String disposition = null;
		String name = null;
		String filename = null;
		String origname = null;
		String paramtype = "param";

		String origline = line;
		line = origline.toLowerCase();
		int start = line.indexOf("content-disposition: ");
		int end = line.indexOf(";");
		if (start == -1 || end == -1) {
			throw new IOException("Content disposition corrupt: " + origline);
		}
		disposition = line.substring(start + 21, end); 
		if (!disposition.equals("form-data")) {
			throw new IOException("Invalid content disposition: " + disposition);
		}
		// Get the field name
		start = line.indexOf("name=\"", end); // start at last semicolon
		end = line.indexOf("\"", start + 7); // skip name=\"
		int startOffset = 6;
		if (start == -1 || end == -1) {
			start = line.indexOf("name=", end);
			end = line.indexOf(";", start + 6);
			if (start == -1) {
				throw new IOException("Content disposition corrupt: "
						+ origline);
			} else if (end == -1) {
				end = line.length();
			}
			startOffset = 5; // without quotes we have one fewer char to skip
		}
		name = origline.substring(start + startOffset, end);
		start = line.indexOf("filename=\"", end + 2);
		end = line.indexOf("\"", start + 10);
		if (start != -1 && end != -1) {
			filename = origline.substring(start + 10, end);
			origname = filename;
			paramtype = "file";
			int slash = Math.max(filename.lastIndexOf('/'), filename
					.lastIndexOf('\\'));
			if (slash > -1) {
				filename = filename.substring(slash + 1); // past last slash
			}
		}
		retval.put("disposition", disposition);
		retval.put("name", name);
		retval.put("filename", filename);
		retval.put("origname", origname);
		retval.put("paramtype", paramtype);
		return retval;
	}

	/**
	 * 打印Map中的Key和Value
	 * 
	 * @param map
	 */
	public void printMap(Map<String, String> map) {
		for (Entry<String, String> entry : map.entrySet()) {  
			System.out.println(entry.getKey() + "=" + entry.getValue());
		}
	}
	// end---------------------------------------------------------------------------
}