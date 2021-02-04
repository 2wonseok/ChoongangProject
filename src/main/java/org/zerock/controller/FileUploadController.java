package org.zerock.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/file/*") // 예전 list.do -> List.handler가 일하라고 했던 역할
@AllArgsConstructor
@Log4j
public class FileUploadController {
	
	@GetMapping("/fileUploadTest")
	public void upload() {
		
	}
	
	@PostMapping("/fileUploadTest")
	public String uploadFile(MultipartFile[] upload, HttpServletRequest request) { 
		//파일이 업로드 될 경로 설정 
		String saveDir = request.getSession().getServletContext().getRealPath("/resources/upload"); 
		//위에서 설정한 경로의 폴더가 없을 경우 생성 
		System.out.println(saveDir);
		File dir = new File(saveDir); 
		
		if(!dir.exists()) { 
			dir.mkdirs(); 
		} // 파일 업로드 
		
		for(MultipartFile f : upload) { 
			if(!f.isEmpty()) { 
				// 기존 파일 이름을 받고 확장자 저장 
				String orifileName = f.getOriginalFilename(); 
				String ext = orifileName.substring(orifileName.lastIndexOf("."));
				// 이름 값 변경을 위한 설정 
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd-HHmmssSSS"); 
				int rand = (int)(Math.random()*1000); 
				// 파일 이름 변경 
				String reName = sdf.format(System.currentTimeMillis()) + "_" + rand + ext; 
				// 파일 저장 
				try { 
					f.transferTo(new File(saveDir + "/" + reName)); 
				} catch (IOException e) { 
					e.printStackTrace(); 
				} 
			} 
		} 
		return "redirect:/file/fileUploadTest";
	}

}
