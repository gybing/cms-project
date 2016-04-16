package com.cms.common.dao;

import java.util.List;
import java.util.Map;

/**
 * @author lansb ��ݿ����dao�ӿ�
 */
public interface IJdbcDao {

	/**
	 * return single record and single field
	 * 
	 * @param sql
	 * @return
	 */
	public abstract String queryForString(final String sql,
			final Object[] objarr, String defaultVal);
	
	public abstract String queryForString(final String sql,
			final Object[] objarr);

	/**
	 * query map by sql
	 * 
	 * @param sql
	 * @return
	 */
	public abstract Map<String, Object> queryForMap(final String sql,
			final Object[] objarr);

	/**
	 * query list by sql
	 * 
	 * @param sql
	 * @return list
	 */
	public abstract List<Map<String, Object>> queryForList(final String sql, final Object[] objarr);

	/**
	 * execute sql
	 * 
	 * @param sql
	 * @return
	 */
	public abstract int execute(final String sql, final Object[] objarr);

}