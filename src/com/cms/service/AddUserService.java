package com.cms.service;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cms.common.dao.impl.JdbcDaoImpl;
import com.cms.common.form.RequestDataForm;
import com.cms.common.form.ResponseDataForm;
import com.cms.common.service.IService;
import com.cms.common.utils.MapUtils;

@Transactional
@Service("addUserService")
public class AddUserService implements IService{

	@Resource
	private JdbcDaoImpl jdbcDao;
	
	@Override
	public ResponseDataForm service(RequestDataForm requestDataForm)
			throws Exception {
		ResponseDataForm rdf = new ResponseDataForm();
		Map<String, Object> usb = requestDataForm.getUserSession().getUserInfo();
	
		String userCode = requestDataForm.getString("USER_CODE");
		String userName = requestDataForm.getString("USER_NAME");
		String tel = requestDataForm.getString("TEL");
		String sex = requestDataForm.getString("SEX");
		String company = requestDataForm.getString("COMPANY");
		String department = requestDataForm.getString("DEPARTMENT");
		String scheduleCenter = requestDataForm.getString("SCHEDULE_CENTER");
		String pic = requestDataForm.getString("PIC");
		String tag = MapUtils.getString(usb, "TAG");
		
		String sql1="select count(1) from user_tab where USER_CODE=? and IS_DEL='N' and tag = ?";
		String existUserCode = jdbcDao.queryForString(sql1, new Object[]{userCode,tag}, "0");
		if(!"0".equals(existUserCode)){
			rdf.setResult(ResponseDataForm.FAULAIE);
			rdf.setResultInfo("用户账户已经存在！");
			return rdf;
		}
		String sql2="select count(1) from user_tab where TEL=? and IS_DEL='N' and tag = ?";
		String existTel = jdbcDao.queryForString(sql2, new Object[]{tel,tag}, "0");
		if(!"0".equals(existTel)){
			rdf.setResult(ResponseDataForm.FAULAIE);
			rdf.setResultInfo("电话号码已经存在！");
			return rdf;
		}
		
		String sql = "  insert into user_tab(tag,USER_CODE, USER_NAME, USER_PWD, TEL, SEX,CREATE_DATE,COMPANY,DEPARTMENT,PIC,SCHEDULE_CENTER)  "
				+ "values (?,?,?, md5('123456'), ?,?, now(),?,?,?,?)   ";
		try {
			jdbcDao.execute(sql, new Object[]{tag,userCode,userName,tel,sex,company,department,pic,scheduleCenter});
			rdf.setResult(ResponseDataForm.SESSFUL);
			rdf.setResultInfo("操作成功!");
		} catch (Exception e) {
			e.printStackTrace();
			rdf.setResult(ResponseDataForm.FAULAIE);
			rdf.setResultInfo("操作失败！");
		}
		
		
		return rdf;
	}

}
