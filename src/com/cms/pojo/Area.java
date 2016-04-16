package com.cms.pojo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Area implements Serializable{

	private static final long serialVersionUID = 3306089004386331154L;
	private String code;
	private String text;
	private String cityText;
	private String fullText;
	private String py;
	private int level;
	private List<Area> childArea;
	private StringBuilder childAreaStr;
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getCityText() {
		return cityText;
	}
	public void setCityText(String cityText) {
		this.cityText = cityText;
	}
	public String getFullText() {
		return fullText;
	}
	public void setFullText(String fullText) {
		this.fullText = fullText;
	}
	public String getPy() {
		return py;
	}
	public void setPy(String py) {
		this.py = py;
	}
	
	/**
	 * 鑾峰彇鍦板尯绛夌骇
	 * @return 0涓哄尯鍩燂紝1鐪侊紝2甯傦紝3鍘垮尯
	 */
	public int getLevel() {
		return level;
	}
	
	/**
	 * 璁剧疆鍦板尯绛夌骇
	 * @param level 0涓哄尯鍩燂紝1鐪侊紝2甯傦紝3鍘垮尯
	 */
	public void setLevel(int level) {
		this.level = level;
	}
	public List<Area> getChildArea() {
		return childArea;
	}
	public void setChildArea(List<Area> childArea) {
		this.childArea = childArea;
	}
	public String getChildAreaStr() {
		return childAreaStr==null?"":childAreaStr.toString();
	}
	public void setChildAreaStr(String childAreaStr) {
		this.childAreaStr = new StringBuilder(childAreaStr);
	}
	
	public void addChildArea(Area area){
		if(this.childArea==null){
			this.childArea=new ArrayList<Area>();
			this.childAreaStr = new StringBuilder();
		}else{
			childAreaStr.append(",");
		}
		this.childArea.add(area);
		childAreaStr.append(area.getCode());
	}
}
