package com.cms.common.service;

import org.springframework.transaction.annotation.Transactional;

import com.cms.common.form.RequestDataForm;
import com.cms.common.form.ResponseDataForm;

/**
 * @author lansb
 * Service统一入口
 * Transactional 注释事务
 */
public interface IService {
	@Transactional 
	public ResponseDataForm service(RequestDataForm requestDataForm) throws Exception;
}
