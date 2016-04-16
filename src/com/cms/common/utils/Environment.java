package com.cms.common.utils;

/**
 * @author lansb 静态环境变量
 */
public class Environment {
	
	public static final String ADMIN_USER_CODE = "admin";//开发专用账号
	public static final String LOGIN_NO_PRIV = "-100";//登录后可访问
	public static final String ADMIN_PRIV = "-200";//admin专属权限，开发组专用
	public static final String NO_PRIV = "-300";//无需登录即可反问，比如LED
	
	public static final String ENCODING = "UTF-8";
	public static final String URL_SQL_MAP = "SYS_URL_SQL_VIEW";
	public static final String SESSION_USER_LOGIN_INFO = "SESSION_USER_LOGIN_INFO";//登录信息
	public static final String CTRL_NUMPERPAGE = "numPerPage";//每页数量
	public static final String DEFAULT_NUMPERPAGE = "20";//默认每页数量
	public static final String CTRL_PAGENUM = "pageNum";//当前页数
	public static final String DEFAULT_PAGENUM = "1";
	public static final String CTRL_QUERYCOUNT = "query_count";
	public static final String CTRL_PAGESTART = "page_start";
	public static final String CTRL_PAGEEND = "page_end";
	public static final String CTRL_PAGENUMSHOWN = "pageNumShown";
	public static final String DEFAULT_PAGENUMSHOWN = "20";
	public static final String LOGIN_INFO = "LOGIN_INFO_OBJECT";
	public static final String QUERY_SESSFUL = "查询成功";
	public static final String SAVE_SESSFUL = "操作成功";
	public static final String SAVE_FAULAIE = "操作失败";
	public static final String LOAD_SESSFUL = "加载成功";
	public static final String DEL_SESSFUL = "删除成功";
	public static final String USER_CODE = "$_CRU_USER_CODE_$";//租户ID
	public static final String UUID = "$_UUID_$";//UUID
	public static final String USER_NAME = "$_CRU_USER_NAME_$";//用户账号
	public static final String USER_ID = "$_CRU_USER_ID_$";//用户ID
	public static final String REAL_NAME = "$_CRU_REAL_NAME_$";//用户ID
	public static final String FILE_FILE_INPUTNAME = "_FILE_";
	public static final String FILE_FILENAME = "_UP_FILE_NAME_";
	public static final String FILE_ATT_ID = "_ATT_ID_";
	public static final String FILE_ATT_IS_DEL = "_ATT_IS_DEL_";
	public static final String PUBLIC_SYS_CODE_MARK="base";//公用url标识

	/**
	 * 图片保存路径
	 */
	public final static String IMAGE_SAVE_PATH="pic";
	
	/**
	 * 全国的区域编码
	 */
	public static final String ALL_AREA_CODE = "D000000";
	
	/**
	 * 默认密码
	 */
	public static final String DEFALUT_PWD="123456";
}
