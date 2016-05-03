package com.cms.service;

import java.awt.Label;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONArray;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.cms.common.dao.impl.JdbcDaoImpl;
import com.cms.common.form.RequestDataForm;
import com.cms.common.form.ResponseDataForm;
import com.cms.common.service.IService;
import com.cms.common.utils.DateUtil;
import com.cms.controller.DatatablesController;

@Service("indexDataService")
public class IndexDataService implements IService{

	protected static Logger logger = Logger.getLogger(DatatablesController.class);
	
	@Resource
	private JdbcDaoImpl jdbcDao;
	
	@Override
	public ResponseDataForm service(RequestDataForm requestDataForm)
			throws Exception {
		
		ResponseDataForm rdf = new ResponseDataForm();
		
		logger.debug("----------------- start indexDataService --------------------");

		
		Map<String , Object> map = new HashMap<String, Object>();
		
		String roomCnt = jdbcDao.queryForString("select count(1) from sys_room_tab where is_del = 'N'",null);
		map.put("roomCnt", roomCnt);
		
		String moveInCnt = jdbcDao.queryForString("select count(1) from sys_user_tab where is_move_in = 1 and is_move_out = 0 and is_del = 'N'", null);
		map.put("moveInCnt", moveInCnt);
		
		StringBuffer mSql = new StringBuffer();
		mSql.append("SELECT ");
		mSql.append("	SUM(spt.total_price) monthFee ");
		mSql.append("FROM ");
		mSql.append("	sys_pay_tab spt ");
		mSql.append("WHERE ");
		mSql.append("	1 = 1 ");
		mSql.append("AND spt.pay_date >= ? ");
		mSql.append("AND spt.pay_date <= ? ");
		
		String firstDayOfCurrentMonth = DateUtil.getMonthFirstDayStr() + " 00:00:00";
		String lastDayOfCurrentMonth = DateUtil.getMonthLastDayStr() + " 24:59:59";
		String mPay = jdbcDao.queryForString(mSql.toString(), new Object[]{firstDayOfCurrentMonth,lastDayOfCurrentMonth});
		if("".equals(mPay)){
			mPay = "0";
		}
		map.put("mPay", mPay);
		
		String firstDayOfYear = DateUtil.getCurrentYear() + "-01-01 00:00:00";
		String lastDayOfYear = DateUtil.getCurrentYear() + "-12-31 24:59:59";
		String yPay = jdbcDao.queryForString(mSql.toString(), new Object[]{firstDayOfYear,lastDayOfYear});
		map.put("yPay", yPay);
		
		map.put("RoomLegendData",getRoomStateItem()); // 获取小区住房情况饼图数据项
		map.put("RoomSeriesData", getRoomStateData()); // 获取小区住房使用情况饼图数据
		
		map.put("PayLegendData", getPayStateItem()); // 获取小区当月缴费情况饼图数据项
		map.put("PaySeriesData", getPayStateData()); // 获取小区当月缴费情况饼图数据
		
		System.out.println(map.toString());
		rdf.setResult(ResponseDataForm.SESSFUL);
		rdf.setResultObj(map);
		
		logger.debug("----------------- end indexDataService --------------------");

		
		return rdf;
	}
	
	/**
	 * 获取小区住房情况饼图数据项
	 * @author lxh
	 * @date 2016 下午2:48:29
	 * @return String
	 */
	public String getRoomStateItem(){
		
		StringBuffer legendData = new StringBuffer();
		legendData.append("SELECT ");
		legendData.append("	dc.text name ");
		legendData.append("FROM ");
		legendData.append("	sys_room_tab srt ");
		legendData.append("LEFT JOIN dict_common dc ON dc.`code` = srt.room_state ");
		legendData.append("AND dc.type = 'ROOM_STATE' ");
		legendData.append("GROUP BY ");
		legendData.append("	srt.room_state ");
		
		return getLegendData(legendData.toString());
	}
	/**
	 * 获取小区住房使用情况饼图数据
	 * @author lxh
	 * @date 2016 下午2:48:40
	 * @return String
	 */
	public String getRoomStateData(){
		
		StringBuffer seriesData = new StringBuffer();
		seriesData.append("SELECT ");
		seriesData.append("	COUNT(srt.room_state) value, ");
		seriesData.append("	dc.text name ");
		seriesData.append("FROM ");
		seriesData.append("	sys_room_tab srt ");
		seriesData.append("LEFT JOIN dict_common dc ON dc.`code` = srt.room_state ");
		seriesData.append("AND dc.type = 'ROOM_STATE' ");
		seriesData.append("WHERE srt.is_del = 'N' ");
		seriesData.append("GROUP BY ");
		seriesData.append("	srt.room_state ");
		
		return getSeriesData(seriesData.toString());
	}
	
	/**
	 * 获取小区缴费情况数据项
	 * @author lxh
	 * @date 2016 下午2:48:45
	 * @return String
	 */
	public String getPayStateItem(){
		String sql = "SELECT spt.fee_name name FROM sys_pay_tab spt where spt.pay_date >= ? and spt.pay_date <= ? AND spt.is_del = 'N' GROUP BY spt.fee_name";
		String firstDayOfCurrentMonth = DateUtil.getMonthFirstDayStr() + " 00:00:00";
		String lastDayOfCurrentMonth = DateUtil.getMonthLastDayStr() + " 24:59:59";
		return getLegendData(sql,new Object[]{firstDayOfCurrentMonth,lastDayOfCurrentMonth});
	}
	
	public String getPayStateData(){
		StringBuffer sb = new StringBuffer();
		sb.append("SELECT ");
		sb.append("	spt.fee_name name, ");
		sb.append("	SUM(spt.total_price) value ");
		sb.append("FROM ");
		sb.append("	sys_pay_tab spt ");
		sb.append("WHERE ");
		sb.append("	1 = 1 ");
		sb.append("AND spt.pay_date >= ? ");
		sb.append("AND spt.pay_date <= ? ");
		sb.append("AND spt.is_del = 'N' ");
		sb.append("GROUP BY ");
		sb.append("	spt.fee_name ");
		
		String firstDayOfCurrentMonth = DateUtil.getMonthFirstDayStr() + " 00:00:00";
		String lastDayOfCurrentMonth = DateUtil.getMonthLastDayStr() + " 24:59:59";
		
		return getSeriesData(sb.toString(),new Object[]{firstDayOfCurrentMonth,lastDayOfCurrentMonth});
	}
	
	/**
	 * 获取饼图数据项
	 * @author lxh
	 * @date 2016 下午2:48:53
	 * @param sql
	 * @return String
	 */
	public String getLegendData(String sql){
		List<Map<String, Object>> list = jdbcDao.queryForList(sql, null);
		JSONArray j = JSONArray.fromObject(list);
		return j.toString();
	}
	
	/**
	 * 获取饼图数据项
	 * @author lxh
	 * @date 2016 下午11:35:44
	 * @param sql 查询语句
	 * @param o 参数 object[]{}
	 * @return String
	 */
	public String getLegendData(String sql,Object[] o){
		List<Map<String, Object>> list = jdbcDao.queryForList(sql, o);
		JSONArray j = JSONArray.fromObject(list);
		return j.toString();
	}
	/**
	 * 获取饼图数据
	 * @author lxh
	 * @date 2016 下午2:48:58
	 * @param sql 查询语句
	 * @return String
	 */
	public String getSeriesData(String sql){
		List<Map<String, Object>> list = jdbcDao.queryForList(sql, null);
		JSONArray j = JSONArray.fromObject(list);
		return j.toString();
	}
	
	/**
	 * 获取饼图数据
	 * @author lxh
	 * @date 2016 下午11:34:42
	 * @param sql 查询语句
	 * @param o 参数 object[]{}
	 * @return String
	 */
	public String getSeriesData(String sql,Object[] o){
		List<Map<String, Object>> list = jdbcDao.queryForList(sql, o);
		JSONArray j = JSONArray.fromObject(list);
		return j.toString();
	}
	
	

}
