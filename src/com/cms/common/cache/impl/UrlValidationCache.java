package com.cms.common.cache.impl;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import com.cms.common.cache.ICacheService;
import com.cms.common.utils.XmlUtils;

@Service("urlValidationCache")
public class UrlValidationCache implements ICacheService{
	
	protected static Logger logger = Logger.getLogger(UrlValidationCache.class);
	
	@Override
	public Object getCacheContext() {
		String path=this.getClass() .getProtectionDomain().getCodeSource().getLocation().getFile();
		path=path.substring(0,path.indexOf("/WEB-INF/")+"/WEB-INF/".length());
//		String path=this.getClass().getResource("/").getPath();
		String websiteUrl = path.replace("/classes","").replace("%20", " ")+"sysxml/validation/";
		HashMap<String, Map<String, Element>> urlExecMap=new HashMap<String, Map<String, Element>>();
		try {
			File dir = new File(websiteUrl);
			if(dir.exists()){
				File[] files = dir.listFiles();
				for(int i=0;i<files.length;i++){
					NodeList sqlNodes = XmlUtils.getNodeListByFileAndTag(files[i], "validation");
					Element element = null;
					File f=files[i];
					String fileName=f.getName();
					fileName=fileName.substring(0,fileName.indexOf("."));
					Map<String, Element> map=urlExecMap.get(fileName);
					if(map==null){
						map=new HashMap<String, Element>();
						urlExecMap.put(fileName, map);
					}
					for (int j = 0; j < sqlNodes.getLength(); j++) {
						element = (Element) sqlNodes.item(j);
						map.put(element.getAttribute("id"), element);
					}
				}
			}
			logger.debug("存入缓存 url validation map  length==="+urlExecMap.size());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return urlExecMap;
	}

	@Override
	public long getCacheLiveTime() {
		return 0;
	}

}
