package com.cms.common.cache.impl;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.cms.common.cache.ICacheService;
import com.cms.common.utils.XmlUtils;

@Service("urlExecSqlCache")
public class UrlExecSqlCache implements ICacheService{
	
	protected static Logger logger = Logger.getLogger(UrlExecSqlCache.class);
	
	@Override
	public Map<String,?> getCacheContext() {
		String path=this.getClass() .getProtectionDomain().getCodeSource().getLocation().getFile();
		path=path.substring(0,path.indexOf("/WEB-INF/")+"/WEB-INF/".length());
		String websiteUrl = path.replace("/classes","").replace("%20", " ")+"sysxml/execsql/";
		HashMap<String, Map<String, String>> urlExecMap=new HashMap<String, Map<String, String>>();
		try {
			File dir = new File(websiteUrl);
			if(dir.exists()){
				File[] files = dir.listFiles();
				for(int i=0;i<files.length;i++){
					File f=files[i];
					String fileName=f.getName();
					fileName=fileName.substring(0,fileName.indexOf("."));
					Map<String, String> map=urlExecMap.get(fileName);
					if(map==null){
						map=new HashMap<String, String>();
						urlExecMap.put(fileName, map);
					}
					NodeList sqlNodes = XmlUtils.getNodeListByFileAndTag(f, "mapper");
					Element element = null;
					for (int j = 0; j < sqlNodes.getLength(); j++) {
						Node node = sqlNodes.item(j);
						element=(Element) node;
						map.put(element.getAttribute("id"), XmlUtils.nodeToXmlString(node));
					}
				}
			}
			logger.debug("存入缓存 execUrl map  length==="+urlExecMap.size());
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
