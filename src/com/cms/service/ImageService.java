package com.cms.service;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Service;

import com.cms.pojo.SourceWay;

/**
 * 图片处理服务类
 * @author lihw
 * @created 2015年10月14日 下午2:17:29
 *
 */
@Service("imageService")
public class ImageService {
    
    /** 图片文件保存路径 */
    //static final String PIC_DIR = "/service-api/pic";
    
    /** 临时文件夹 */
    //static final String TEMP_DIR = "/service-api/temp";
    
    /** 图片访问的项目路径 */
    static final String WEB_URL = "http://192.168.193.177:8080/service-api";
    
    /**
     * 创建文件夹
     * @author lihw
     * @created 2015年10月14日 下午3:57:13
     *
     * @param dir
     * @return
     */
    private File mkDir(String dir) {
        File file = new File(dir);
        if (!file.exists()) {
            file.mkdirs();
        }
        return file;
    }
    
    /**
     * 获取保存图片的基本文件夹
     * 
     * @author lihw
     * @created 2015年10月14日 下午2:17:17
     *
     * @return
     */
    public File getPicDir(HttpServletRequest req) {
        String picDir = req.getSession().getServletContext().getRealPath("/pic/");
        return mkDir(picDir);
    }
    
    /**
     * 获取临时文件夹
     * @author lihw
     * @created 2015年10月14日 下午3:57:36
     *
     * @return
     */
    public File getTempDir(HttpServletRequest req) {
        String tempDir =  req.getSession().getServletContext().getRealPath("/temp/");
        return mkDir(tempDir);
    }
    
    /**
     * 获取保存不同来源图片的文件夹
     * @author lihw
     * @created 2015年10月14日 下午2:18:55
     *
     * @param sourceWay
     * @return
     */
    public File getPicDir(SourceWay sourceWay, HttpServletRequest req) {
        String dir =  req.getSession().getServletContext().getRealPath("/pic/") + File.separator + sourceWay;
        return mkDir(dir);
    }
    
    /**
     * 移动图片到目标文件夹, 并删除原图片
     * @author lihw
     * @created 2015年10月14日 下午2:46:10
     *
     * @param sourceWay
     * @param file
     * @return
     * @throws IOException
     */
    public File movePic(SourceWay sourceWay, HttpServletRequest req, File file) throws IOException {
        File dir = getPicDir(sourceWay, req);
        File newFile = new File(dir.getPath() + File.separator + file.getName());
        FileUtils.copyFile(file, newFile);
        FileUtils.forceDelete(file);
        return newFile;
    }
    
    /**
     * 获取图片访问的项目路径
     * 
     * @author lihw
     * @created 2015年10月14日 下午4:12:21
     *
     * @return
     */
    public String getWebUrl() {
        return WEB_URL;
    }
    
}
