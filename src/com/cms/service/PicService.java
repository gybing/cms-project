package com.cms.service;

import java.io.File;
import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.jstl.core.Config;
import javax.xml.ws.Response;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cms.common.dao.impl.JdbcDaoImpl;
import com.cms.common.form.RequestDataForm;
import com.cms.common.form.ResponseData;
import com.cms.common.form.ResponseDataForm;
import com.cms.common.service.IService;
import com.cms.common.utils.DateUtil;
import com.cms.common.utils.ImageUtil;
import com.cms.common.web.httpobjects.HttpRequestObject;
import com.cms.pojo.SourceWay;

@Service("picService")
public class PicService implements IService {

    @Autowired
    JdbcDaoImpl daoHelp;
    
    @Autowired
    ImageService imageService;

    
	@Override
	@Transactional
	public ResponseDataForm service(RequestDataForm requestDataForm) throws Exception {
		ResponseDataForm rdf = new ResponseDataForm();
		HashMap<String,Object> resultMap=new HashMap<String, Object>();
		String defualt_prefix = requestDataForm.getString("defualt_prefix");
		int maxFileNum = requestDataForm.getInteger(defualt_prefix+"_"+"maxFileNum");
		for(int i=0;i<=maxFileNum;i++){
			HashMap<String,Object> map=new HashMap<String, Object>();
			//过滤掉删除掉的那一行的select 
			if(!"".equals(requestDataForm.getString(defualt_prefix+"_"+"imgtype"+i)) && requestDataForm.getString(defualt_prefix+"_"+"imgtype"+i)!=null){
				String code = requestDataForm.getString(defualt_prefix+"_"+"imgtype"+i);
				HttpRequestObject httpRequestObject = requestDataForm.get(defualt_prefix+"_"+"imgtype_img"+i);
				String path = saveFile(httpRequestObject);
				if(!"jiyun".equals(path.substring(0, 5))){ 
					if(maxFileNum!=1 || httpRequestObject.getValue().length>0){//上传了一张不合格图片（maxFileNum=1）
						rdf.setResult(ResponseDataForm.FAULAIE);
						rdf.setResultInfo(path);
						return rdf;
					}
				}else if("jiyun".equals(path.substring(0, 5))){
				}
			}
		}
		rdf.setResult(ResponseDataForm.SESSFUL);
		rdf.setResultObj(resultMap);
		return rdf;
	}

	/**
	 * 
	 * TODO 保存文件到本地
	 * 作者：黄廷柳
	 * 2016年2月25日上午9:55:40
	 */
	private String saveFile(HttpRequestObject httpRequestObject){
		
		byte[] fileByte = httpRequestObject.getValue();
		String fileName=httpRequestObject.getFilename();
		if (fileByte == null) {
			return "上传的照片不能为空！";
		}
		if(!fileName.contains(".")){
			return "上传格式不正确";
		}
		String suffix = fileName.substring(fileName.lastIndexOf("."));
		if(!suffix.equalsIgnoreCase(".jpg") && !suffix.equalsIgnoreCase(".png") 
				&& !suffix.equalsIgnoreCase(".bmp") && !suffix.equalsIgnoreCase(".JPEG")){
			return "上传文件格式只能是jpg,png,jpeg,bmp！";
		}
		fileName=DigestUtils.md5Hex(fileName)+"_"+DateUtil.getCurrDateStr("yyyyMMddHHmmss")+fileName.substring(fileName.lastIndexOf("."));
		String path=ImageUtil.saveImage(fileByte,"jiyun", fileName);
		
		return path;
	}
	
	
}
