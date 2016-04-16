package com.cms.common.service.impl;

import java.util.HashMap;

import org.springframework.stereotype.Service;

import com.cms.common.cache.GlobalCache;
import com.cms.common.form.RequestDataForm;
import com.cms.common.form.ResponseDataForm;
import com.cms.common.service.IService;

@Service("refreshCacheService")
public class RefreshCacheService implements IService{

	@Override
	public ResponseDataForm service(RequestDataForm requestDataForm) throws Exception {
		ResponseDataForm responseDataForm=new ResponseDataForm();
		HashMap<String, String> map=new HashMap<String, String>();
		String cacheName=requestDataForm.getString("cacheName");
		try{
			Class clazz=Class.forName(cacheName);
			GlobalCache.refreshCache(clazz);
			responseDataForm.setResult(ResponseDataForm.SESSFUL);
			map.put("result", String.valueOf(ResponseDataForm.SESSFUL));
		}catch(Exception e){
			e.printStackTrace();
			responseDataForm.setResult(ResponseDataForm.FAULAIE);
			responseDataForm.setResultInfo("刷新缓存失败："+e.getMessage());
			map.put("result", String.valueOf(ResponseDataForm.FAULAIE));
			map.put("resultInfo", "刷新缓存失败："+e.getMessage());
		}
		responseDataForm.setResult(ResponseDataForm.SESSFUL);
		responseDataForm.setResultInfo("刷新成功！");
		responseDataForm.setResultObj(map);
		return responseDataForm;
	}

}
