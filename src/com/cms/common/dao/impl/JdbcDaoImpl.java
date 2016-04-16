package com.cms.common.dao.impl;

import java.io.InputStream;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.concurrent.ConcurrentHashMap;

import net.sf.cglib.beans.BeanMap;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.objectweb.asm.ClassReader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.JdbcUtils;
import org.springframework.stereotype.Repository;

import com.cms.common.cache.GlobalCache;
import com.cms.common.dao.IJdbcDao;
import com.cms.common.utils.MapUtils;

/**
 * @author lansb
 * 
 */
@Repository("jdbcDao")
public class JdbcDaoImpl implements IJdbcDao {

	private Log logger = LogFactory.getLog(JdbcDaoImpl.class);

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public String queryForString(String sql, final Object[] objarr, String defaultVal) {
		logger.debug("sql=>" + sql);
		logger.debug("param=>" + Arrays.toString(objarr));
		String str = null;
		try{
			str = jdbcTemplate.queryForObject(sql, String.class, objarr);
		}catch(EmptyResultDataAccessException ex){
			
		}
		return str != null ? str : defaultVal;
	}
	public String queryForString(String sql, final Object[] objarr) {
		return queryForString(sql, objarr, "");
	}

	public Map<String,Object> queryForMap(String sql, final Object[] objarr) {
		List<Map<String,Object>> list = query(sql, objarr);
		if (list != null && list.size() > 0) {
			return list.get(0);
		} else {
			return new LinkedHashMap<String,Object>();
		}
	}

	public List<Map<String,Object>> queryForList(String sql, final Object[] objarr) {
		return query(sql, objarr);
	}

	private List<Map<String,Object>> query(String sql, final Object[] objarr) {
		logger.debug("sql=>" + sql);
		logger.debug("param=>" + Arrays.toString(objarr));
		return jdbcTemplate.query(sql, objarr, new RowMapper<Map<String,Object>>() {
			public Map<String,Object> mapRow(final ResultSet rs, final int rowNum) throws SQLException {
				// 实现如下:
				final ResultSetMetaData rsmd = rs.getMetaData();
				final int columnCount = rsmd.getColumnCount();
				final Map<String,Object> mapOfColValues = new LinkedHashMap<String,Object>(columnCount);
				for (int i = 1; i <= columnCount; i++) {
					final String key = JdbcUtils.lookupColumnName(rsmd, i);
					final Object obj = JdbcUtils.getResultSetValue(rs, i);
					mapOfColValues.put(key.toUpperCase(), obj);
				}
				return mapOfColValues;
			}
		});
	}

	public int execute(String sql, final Object[] objarr) {
		logger.debug("sql=>" + sql);
		logger.debug("param=>" + Arrays.toString(objarr));
		return jdbcTemplate.update(sql, objarr);
	}

}
