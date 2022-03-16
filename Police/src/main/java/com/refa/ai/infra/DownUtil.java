package com.refa.ai.infra;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;

public class DownUtil {
    public void download(HttpServletRequest request
            ,HttpServletResponse response
            ,String realfilepath
            ,String realfilename
            ,String originalfilename) {
		String defaultfilepath = "C:\\Users\\jhlee\\Desktop\\";
		
		//�ش� realfilepath ������ �� ���ϰ�δ� "/���1/���2/ << �̷������� ����츦 ����
		//���� ���1/���2 �̷������� �ٰ�� if���� ���� �Ǵ� �ּ�ó��
		
		
		//���� ���ҽ� ���� �������� �ʴ� ������ ���
		//defaultfilepath + realfilepath �κ��� ���� ��ηθ� �������ָ� ��
		File downloadfile = new File(defaultfilepath + realfilepath + realfilename);
		if (downloadfile.exists() && downloadfile.isFile()) {
			response.setContentType("application/octet-stream; charset=utf-8");
			response.setContentLength((int) downloadfile.length());
			OutputStream outputstream = null;
			FileInputStream inputstream = null;
			try {
			    response.setHeader("Content-Disposition", getDisposition(originalfilename, check_browser(request)));
			    response.setHeader("Content-Transfer-Encoding", "binary");
			    outputstream = response.getOutputStream();
			    inputstream = new FileInputStream(downloadfile);
			    //Spring framework ����� ���
			    FileCopyUtils.copy(inputstream, outputstream);
			     
			    //�Ϲ� �ڹ�/JSP ���ϴٿ�ε�
				/*
				 * byte[] buffer = new byte[1024]; int length = 0; while((length =
				 * inputstream.read(buffer)) > 0) { outputstream.write(buffer,0,length); }
				 */
			   
			} catch (Exception e) {
			    e.printStackTrace();
			} finally {
			    try {
			        if (inputstream != null){
			            inputstream.close();
			        }
			        outputstream.flush();
			        outputstream.close();  
			    } catch (Exception e2) {}
			}
		} else {
			System.out.println("������������ ����");
		}
	}
	
	private String check_browser(HttpServletRequest request) {
		String browser = "";
		String header = request.getHeader("User-Agent");
		//�ű��߰��� indexof : Trident(IE11) �Ϲ� MSIE�δ� üũ �ȵ�
		if (header.indexOf("MSIE") > -1 || header.indexOf("Trident") > -1){
			browser = "ie";
		}
		//ũ���� ���
		else if (header.indexOf("Chrome") > -1){
			browser = "chrome";
		}
		//������ϰ��
		else if (header.indexOf("Opera") > -1){
			browser = "opera";
		}
		//���ĸ��� ���
		else if (header.indexOf("Apple") > -1){
			browser = "sarari";
		} else {
			browser = "firfox";
		}
			return browser;
	}
	
	private String getDisposition(String down_filename, String browser_check) throws UnsupportedEncodingException {
		String prefix = "attachment;filename=";
		String encodedfilename = null;
		System.out.println("browser_check:"+browser_check);
		if (browser_check.equals("ie")) {
			encodedfilename = URLEncoder.encode(down_filename, "UTF-8").replaceAll("\\+", "%20");
		} else if (browser_check.equals("chrome")) {
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < down_filename.length(); i++){
			    char c = down_filename.charAt(i);
			    if (c > '~') {
			        sb.append(URLEncoder.encode("" + c, "UTF-8"));
			    } else {
			        sb.append(c);
			    }
			}
			encodedfilename = sb.toString();
		} else {
			encodedfilename = "\"" + new String(down_filename.getBytes("UTF-8"), "8859_1") + "\"";
		}
	
		return prefix + encodedfilename;
	}
}
