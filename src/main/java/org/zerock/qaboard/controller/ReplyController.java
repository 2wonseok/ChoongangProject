package org.zerock.qaboard.controller;

import java.util.HashMap;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import org.zerock.qaboard.domain.QaReplyVO;
import org.zerock.qaboard.service.QaReplyService;


import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Controller
@RequestMapping("/reply/*")
@Log4j
@AllArgsConstructor
public class ReplyController {
	
	private QaReplyService reply_service;
	
	@PostMapping(path = "/register", consumes = MediaType.APPLICATION_JSON_VALUE, 
			produces = MediaType.TEXT_PLAIN_VALUE)
	public @ResponseBody void register(@RequestBody QaReplyVO board, RedirectAttributes rttr, 
			HttpServletRequest request) {
		System.out.println(board.getReply_boardseq());
		System.out.println(board.getReply_content());
		System.out.println(board.getReply_writer());
		Map<String, Boolean> errors = new HashMap<String, Boolean>();
		
		if (board.getReply_content().isEmpty() || board.getReply_content() == null) {
			errors.put("reply_noContent" , Boolean.TRUE);
		}
		
		if(!errors.isEmpty()) {
			rttr.addFlashAttribute("errors", errors);
			rttr.addFlashAttribute("category", board.getReply_content());
			
		}
		
		board.setReply_filename("zzzzz");
//		
//		//파일이 업로드 될 경로 설정 
//		String saveDir = request.getSession().getServletContext().getRealPath("/resources/qareply/upload"); 
//		
//		//위에서 설정한 경로의 폴더가 없을 경우 생성 
//		System.out.println(saveDir);
//		File dir = new File(saveDir); 
//		if(!dir.exists()) { 
//			dir.mkdirs(); 
//		}
//		// 파일 업로드
//		List<String> reNames = new ArrayList<String>();
//		for(MultipartFile f : upload) { 
//			if(!f.isEmpty()) { 
//				// 기존 파일 이름을 받고 확장자 저장 
//				String orifileName = f.getOriginalFilename(); 
//				String ext = orifileName.substring(orifileName.lastIndexOf("."));
//				// 이름 값 변경을 위한 설정 
//				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd-HHmmssSSS"); 
//				int rand = (int)(Math.random()*1000); 
//				// 파일 이름 변경 
//				String reName = sdf.format(System.currentTimeMillis()) + "_" + rand + ext; 
//				// 파일 저장 
//				try { 
//					f.transferTo(new File(saveDir + "/" + reName)); 
//				} catch (IOException e) { 
//					e.printStackTrace(); 
//				}
//				
//
//			reNames.add(reName);
//			} 
//		}
//		if (!reNames.isEmpty()) {
//			board.setReply_filename(reNames.get(0));			
//		} else {
//			board.setReply_filename("");	
//		}
//

	
				
		System.out.println(board.getReply_filename());
				
		reply_service.register(board);
		
		
		rttr.addFlashAttribute("result", board.getReply_seq());


	}

}
