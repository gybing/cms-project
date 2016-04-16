package com.cms.common.utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
/**
 * 菜单生成类
 *
 */
public class MenuUtil {
	
	private static final String MAIN_MENU_ID = "0";  // 主菜单ID
	
	private static final String CHILD_NODE_NAME = "childs"; // 子菜单名

	/**
	 * 创建菜单树(主菜单)
	 * @param menuList菜单列表
	 * @param userPrivsList用户权限列表
	 * @param usercode用户登录名
	 * @return
	 */
	public static Map<String, Object> buildMenuTree(List<Map<String, Object>> menuList,List<String> userPrivsList, String usercode){
		
		LinkedHashMap<String, Map<String, Object>> menuMap = new LinkedHashMap<String, Map<String, Object>>();
				
		for(Map<String, Object> menu: menuList){			
			String priv = MapUtils.getString(menu, "PRIV_ID");  // 权限id
			String id = MapUtils.getString(menu, "MENU_ID");  // 菜单id
			String pid = MapUtils.getString(menu, "PARENT_MENU_ID");  // 父菜单id 
			String mType = MapUtils.getString(menu, "MENU_TYPE");  // 菜单类型
			
			if(StringUtils.isEmpty(priv) && "0".equals(mType)){
				if(menuMap.containsKey(id)){
					menu.put(CHILD_NODE_NAME, menuMap.get(id).get(CHILD_NODE_NAME));
				}
				menuMap.put(id, menu);
				buildChildMenu(menuMap,pid,menu);
			}else{
//				if(Environment.ADMIN_USER_CODE.equals(usercode)) {
//					if(menuMap.containsKey(id)){
//						menu.put(CHILD_NODE_NAME, menuMap.get(id).get(CHILD_NODE_NAME));
//					}
//					menuMap.put(id, menu);
//					buildChildMenu(menuMap,pid,menu);
//				} else {
				// 根据用户权限 创建菜单
//				if(userPrivsList.contains(priv)){
//					if(menuMap.containsKey(id)){
//						menu.put(CHILD_NODE_NAME, menuMap.get(id).get(CHILD_NODE_NAME));
//					}
//					menuMap.put(id, menu);
//					buildChildMenu(menuMap,pid,menu);
//				}
					menuMap.put(id, menu);
					buildChildMenu(menuMap,pid,menu);
			}
		}
		cleanEmptyMenu(menuMap.get(MAIN_MENU_ID));
		return menuMap.get(MAIN_MENU_ID);
	}
	
	/**
	 * 创建子菜单
	 * @param menuMap
	 * @param pid
	 * @param childMenu
	 */
	private static void buildChildMenu(Map<String, Map<String, Object>> menuMap,String pid,Map<String, Object> childMenu){
//		if(!Environment.PRIV_ROOT_VAL.equals(pid)){
			if(menuMap.containsKey(pid)){
				Map<String, Object> tmp=menuMap.get(pid);
				ArrayList<Map<String, Object>> childs=null;
				if(!tmp.containsKey(CHILD_NODE_NAME) || tmp.get(CHILD_NODE_NAME)==null){
					childs=new ArrayList<Map<String, Object>>();
				}else{
					childs=(ArrayList<Map<String, Object>>)tmp.get(CHILD_NODE_NAME);
				}
				childs.add(childMenu);
				tmp.put(CHILD_NODE_NAME, childs);
			}else{
				Map<String, Object> tmp=new HashMap<String,Object>();
				ArrayList<Map<String, Object>> childs=new ArrayList<Map<String, Object>>();
				childs.add(childMenu);
				tmp.put(CHILD_NODE_NAME, childs);
				menuMap.put(pid, tmp);
			}
//		}
	}
	
	/**
	 * 清除空菜单
	 * @param menu
	 */
	private static void cleanEmptyMenu(Map<String, Object> menu){
		if(menu != null && menu.containsKey(CHILD_NODE_NAME)){
			ArrayList<Map<String, Object>> childs = (ArrayList<Map<String, Object>>)menu.get(CHILD_NODE_NAME);
			for(int i=childs.size()-1;i>=0;i--){
				Map<String, Object> child=childs.get(i);
				if("0".equals(MapUtils.getString(child, "MENU_TYPE"))){
					if(!child.containsKey(CHILD_NODE_NAME)){
						childs.remove(child);
					}else{
						cleanEmptyMenu(child);
						if(!child.containsKey(CHILD_NODE_NAME)){
							childs.remove(child);
						}
					}
				}
			}
			if(childs.size()==0){
				menu.remove(CHILD_NODE_NAME);
			}
		}
	}
	
	
	/**
	 * 创建菜单html
	 * @param ctxPath项目路径/cdbsm
	 * @param menuList菜单列表
	 * @param privs权限ids
	 * @param usercode用户登录名
	 * @return菜单html
	 */
	public static String createMenu(String ctxPath,List<Map<String, Object>> menuList,List<String> privs, String usercode){
		
		StringBuffer html = new StringBuffer();
		Map<String, Object> menuTree = buildMenuTree(menuList,privs, usercode);
		
		if(menuTree!=null && menuTree.get(CHILD_NODE_NAME)!=null){
			ArrayList<Map<String, Object>> list=(ArrayList<Map<String, Object>>) menuTree.get(CHILD_NODE_NAME);
			String menuName = "";
			String menuIcon = "";
			for(Map<String, Object> menu:list){
				html.append("<li>");
				html.append("<a href=\"#\">");
				menuName = MapUtils.getString(menu, "MENU_NAME");
				menuIcon = MapUtils.getString(menu, "MENU_ICON");
				
				if(menuIcon!=null && !"".equals(menuIcon)){
						html.append("<i class=\""+menuIcon+"\"></i>");
				}else{
					html.append("<i class=\"fa fa-edit\"></i>");
				}				
				html.append("<span class=\"nav-label\">").append(menuName).append("</span>");
			    html.append("<span class=\"fa arrow\"></span>");
			    html.append("</a>");
				html.append("<ul class=\"nav nav-second-level\">");								
				if(menu.get(CHILD_NODE_NAME)!=null){
					ArrayList<Map<String, Object>> childlist=(ArrayList<Map<String, Object>>) menu.get(CHILD_NODE_NAME);
					for(Map<String, Object> childMenu:childlist){
						html.append(createChildMenu(ctxPath,childMenu));
					}
				}
				html.append("</ul></li>");
			}			
		}
		return html.toString();
	}
	
	/**
	 * 创建子菜单html
	 * @param ctxPath地址
	 * @param menu菜单map
	 * @return子菜单html
	 */
	private static String createChildMenu(String ctxPath,Map<String, Object> menu){
		StringBuffer html = new StringBuffer();
		String isFolder = MapUtils.getString(menu, "IS_FOLDER");
		if("0".equals(isFolder) && menu.get(CHILD_NODE_NAME) != null){
			html.append("<li><a href=\"#\">").append(MapUtils.getString(menu, "MENU_NAME")).append("<span class=\"fa arrow\"></span></a><ul class=\"nav nav-third-level\">");
			ArrayList<Map<String, Object>> list = (ArrayList<Map<String, Object>>) menu.get(CHILD_NODE_NAME);
			for(Map<String, Object> childMenu:list){
				html.append(createChildMenu(ctxPath,childMenu));
			}
			html.append("</ul></li>");
		}else{
			String url=MapUtils.getString(menu, "MENU_PATH");
			if(StringUtils.isEmpty(url)){
				url="javascript:void(0);";
			}else{
				if(url.indexOf("/")!=0){
					url = ctxPath+"/"+url;
				}else{
					url = ctxPath+url;
				}
			}
			html.append("<li>");
			html.append("<a class=\"J_menuItem\" href=\"").append(url).append("\">");
			html.append(MapUtils.getString(menu, "MENU_NAME"));
			html.append("</a></li>");			
		}
		return html.toString();
	}
}