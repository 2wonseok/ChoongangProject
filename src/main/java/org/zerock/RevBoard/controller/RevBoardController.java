package org.zerock.RevBoard.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.RevBoard.domain.Criteria;
import org.zerock.RevBoard.domain.PageDTO;
import org.zerock.RevBoard.domain.RevVO;
import org.zerock.RevBoard.service.RevBoardService;


import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Controller
@RequestMapping("/rev/*")
@AllArgsConstructor
@Log4j
public class RevBoardController {

	private RevBoardService service;
	
	@GetMapping("/register")
	public void register() {
		
	}
	
	@PostMapping("/register")
	public String register(RevVO revVo,  RedirectAttributes rttr, MultipartFile[] uploda , HttpServletRequest request) {
		Map<String, Boolean> errors = new HashMap<String, Boolean>();
		
		if (revVo.getRev_title().isEmpty() || revVo.getRev_title() == null) {
			errors.put("noTitle" , Boolean.TRUE);
		} 
		if (revVo.getRev_category().isEmpty() || revVo.getRev_category() == null) {
			errors.put("noCategory", Boolean.TRUE);
		} 
		if (revVo.getRev_content().isEmpty() || revVo.getRev_content() == null) {
			errors.put("noContent", Boolean.TRUE);
		}
		if (revVo.getRev_writer().isEmpty() || revVo.getRev_writer() == null) {
			errors.put("noWriter", Boolean.TRUE);
		}
		
		//파일이 업로드 될 경로 설정 
				String saveDir = request.getSession().getServletContext().getRealPath("/resources/upload"); 
				//위에서 설정한 경로의 폴더가 없을 경우 생성 
				System.out.println(saveDir);
				File dir = new File(saveDir); 
				
				if(!dir.exists()) { 
					dir.mkdirs(); 
				} // 파일 업로드 
				
				for(MultipartFile f : uploda) { 
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
			
				
			
		

		if(!errors.isEmpty()) {
			rttr.addFlashAttribute("errors", errors);
			rttr.addFlashAttribute("category", revVo.getRev_category());
			rttr.addFlashAttribute("title",revVo.getRev_title());
			rttr.addFlashAttribute("content", revVo.getRev_content());
			rttr.addFlashAttribute("writer", revVo.getRev_writer());
			return "redirect:/rev/register";
		}
		
		
		service.register(revVo);
		
		return "redirect:/rev/list";
	}
	
	@GetMapping("/list")
	public void list(@ModelAttribute("cri") Criteria cri, Model model) {
		List<RevVO> list = service.getListWithPaging(cri);
		
		int total = service.getTotal(cri);
		
		PageDTO dto = new PageDTO(cri, total);
		 
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", dto);
	}
	
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("rev_seq") int rev_seq, Model model) {
		RevVO vo = service.get(rev_seq);
		
		
		service.addReadCnt(rev_seq);
		
		
		model.addAttribute("RevBoard", vo);
		
	}
	
	@PostMapping("/modify")
	public String modify(RevVO revVo, RedirectAttributes rttr) {
		Map<String, Boolean> errors = new HashMap<String, Boolean>();
		
		
		
		if (revVo.getRev_title().isEmpty() || revVo.getRev_title() == null) {
			errors.put("noTitle" , Boolean.TRUE);
		} 
		if (revVo.getRev_category().isEmpty() || revVo.getRev_category() == null) {
			errors.put("noCategory", Boolean.TRUE);
		} 
		if (revVo.getRev_content().isEmpty() || revVo.getRev_content() == null) {
			errors.put("noContent", Boolean.TRUE);
		}
		
		if(!errors.isEmpty()) {
			rttr.addFlashAttribute("errors", errors);
			rttr.addFlashAttribute("RevBoard", revVo);
			
			return "redirect:/rev/modify?rev_seq=" + revVo.getRev_seq();
		}
		
		service.moidfy(revVo);
		
		return "redirect:/rev/list";
		
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("rev_seq") int rev_seq) {
		service.remove(rev_seq);
		
		return "redirect:/rev/list";
	}
	@GetMapping(value = "/get/like",
				produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String addGood(int rev_seq) {
		log.info("rev_seq");
		service.addGood(rev_seq);
		
		/* return new ResponseEntity<RevVO>(HttpStatus.OK); */
		return "redirect:/rev/get?rev_seq=" + rev_seq;
		
	}
	
	@GetMapping("/get/hate")
	public String addHate(@RequestParam("rev_seq") int rev_seq) {
		service.addHate(rev_seq);
		
		return "redirect:/rev/get?rev_seq=" + rev_seq;
	}
	
}
