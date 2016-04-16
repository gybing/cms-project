package com.cms.pojo;

/**
 * 短信来源
 * (对应字典表: SYS_DICT_TAB 中的 typeName = APPLY_SOURCE 申请来源)
 * 
 * @author lihw
 * @created 2015年10月12日 下午3:16:19
 *
 */
public enum SourceWay {
    
    /** 集运 - 管理平台 */
    JyManagePlat(0,"管理平台WEB"),
    /** 集运 - 司机版   安卓*/
    JyDriverApp(1, "司机版APP"),
    /** 集运 - 车队版   安卓*/
    JyTeamApp(2, "车队版APP"),
    /** UNKNOWN, 未知 */
    Unknown(99, "未知来源");
    ;
    
    /** code, 编码 */
    int code;
    /** desc, 说明 */
    String desc;
    
    private SourceWay(int code, String desc) {
        this.code = code;
        this.desc = desc;
    }
    
    public int code() {
        return this.code;
    }
    
    public String desc() {
        return this.desc;
    }
    
    public static SourceWay codeOf(int code) {
        for (SourceWay way : SourceWay.values()) {
            if (way.code() == code) {
                return way;
            }
        }
        return Unknown;
    }
}
