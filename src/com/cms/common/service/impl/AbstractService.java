package com.cms.common.service.impl;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.cms.common.dao.IJdbcDao;
import com.cms.common.service.IService;
import com.cms.common.sqlparse.ISqlParse;


/**
 * @author lansb
 *  
 */
public abstract class AbstractService implements IService {
	protected Log logger = LogFactory.getLog(this.getClass());
	@Autowired   
	protected ISqlParse sqlParse;
	@Autowired
	protected IJdbcDao jdbcDao;
	/**
	 * 数据验证，特殊验证请重写该方法；
	 * 
	 * @return
	 */
	protected boolean validate() {
		
		return true;
	}
}
