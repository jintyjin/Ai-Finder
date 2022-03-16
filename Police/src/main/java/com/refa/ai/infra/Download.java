package com.refa.ai.infra;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.net.URLConnection;

import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;

public class Download {
	public void downloadFile(File file, HttpServletResponse response) throws Throwable {

		InputStream inputStream = new BufferedInputStream(new FileInputStream(file));
		String mimeType = URLConnection.guessContentTypeFromStream(inputStream);

		if(mimeType == null) { 
			mimeType = "application/octet-stream";
		}
		
		response.setContentType(mimeType);
		response.setContentLength((int)file.length());
		response.setHeader("Content-Disposition", String.format("attachment; filename=\"%s\"", file.getName()));

		System.out.println("다운 완료");
		FileCopyUtils.copy(inputStream, response.getOutputStream());
	}
}
