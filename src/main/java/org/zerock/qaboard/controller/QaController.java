package org.zerock.qaboard.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.qaboard.domain.Criteria;
import org.zerock.qaboard.domain.PageDTO;
import org.zerock.qaboard.domain.QaVO;
import org.zerock.qaboard.domain.QaReplyVO;
import org.zerock.qaboard.service.QaService;
import org.zerock.qaboard.service.QaReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/qa/*")
@Log4j
@AllArgsConstructor
public class QaController {
	
	private QaService service;	

	
//	@RequestMapping(value="/list", method = RequestMethod.GET)
//	@GetMapping("/list") 
	// 메소드가 void 타입의 경우 return 경로가 view(jsp)가 됨
	// 이 메소드는 (/board/list) -> /board/list.jsp
//	public void list(Model model) {
//		log.info("***** list, 누군가 접속 or 새로고침 *****");
//		List<BoardVO> list = service.getlist();
//		model.addAttribute("list", list);		
//	}
	
	@GetMapping("/list")
	public void list(@ModelAttribute("criteria") Criteria cri,
			Model model) {
		
		// 게시물 리스트 가져오기
		List<QaVO> list = service.getList(cri);		
		int total = service.getTotal(cri);		
		PageDTO dto = new PageDTO(cri, total);		
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", dto);
		
		
	}
	
	
//	@RequestMapping(value="/register", method = RequestMethod.POST)
	
	@GetMapping("/register")
	public void register(@ModelAttribute("criteria") Criteria cri) {
		
	}
	
	@PostMapping("/register")
	public String register(QaVO board, RedirectAttributes rttr, 
			MultipartFile[] upload, HttpServletRequest request) {
		
		Map<String, Boolean> errors = new HashMap<String, Boolean>();
		
		if (board.getQa_title().isEmpty() || board.getQa_title() == null) {
			errors.put("noTitle" , Boolean.TRUE);
		} 
		if (board.getQa_secret() == null) {
			errors.put("noSecret", Boolean.TRUE);
		} 
		if (board.getQa_category().isEmpty() || board.getQa_category() == null) {
			errors.put("noCategory", Boolean.TRUE);
		} 
		if (board.getQa_content().isEmpty() || board.getQa_content() == null) {
			errors.put("noContent", Boolean.TRUE);
		}
		
		if(!errors.isEmpty()) {
			rttr.addFlashAttribute("errors", errors);
			rttr.addFlashAttribute("category", board.getQa_category());
			rttr.addFlashAttribute("secret", board.getQa_secret());
			rttr.addFlashAttribute("title",board.getQa_title());
			rttr.addFlashAttribute("content", board.getQa_content());
			rttr.addFlashAttribute("filename", board.getQa_filename());
			
			return "redirect:/qa/register";
		}
		
		//파일이 업로드 될 경로 설정 
		String saveDir = request.getSession().getServletContext().getRealPath("/resources/qaboard/upload"); 
		
		//위에서 설정한 경로의 폴더가 없을 경우 생성 
		System.out.println(saveDir);
		File dir = new File(saveDir); 
		if(!dir.exists()) { 
			dir.mkdirs(); 
		}
		// 파일 업로드
		List<String> reNames = new ArrayList<String>();
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
				

			reNames.add(reName);
			} 
		}
		if (!reNames.isEmpty()) {
			board.setQa_filename(reNames.get(0));			
		} else {
			board.setQa_filename("");	
		}


	
				
		System.out.println(board.getQa_filename());
				
		service.register(board);
		
		
		rttr.addFlashAttribute("result", board.getQa_seq());

		return "redirect:/qa/list";
	}
	
	//
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("qa_seq") int qa_seq,  
			@ModelAttribute("criteria") Criteria cri, 
			Model model) {
		
		// 게시물 가져오기
		// 쿼리문으로 붙어서 감
		QaVO vo = service.get(qa_seq);
		service.addCnt(qa_seq);
		model.addAttribute("board", vo);

	}
	
	@RequestMapping("/remove")
	public String remove(@RequestParam("qa_seq") int qa_seq) {
		service.remove(qa_seq);
		
		return "redirect:/qa/list";
	}
	
	@PostMapping("/modify")
	public String modify(QaVO board, Criteria cri, RedirectAttributes rttr, 
			MultipartFile[] upload, HttpServletRequest request) {
		
		Map<String, Boolean> errors = new HashMap<String, Boolean>();
		
		if (board.getQa_title().isEmpty() || board.getQa_title() == null) {
			errors.put("noTitle" , Boolean.TRUE);
		} 
		if (board.getQa_secret() == null) {
			errors.put("noSecret", Boolean.TRUE);
		} 
		if (board.getQa_category().isEmpty() || board.getQa_category() == null) {
			errors.put("noCategory", Boolean.TRUE);
		} 
		if (board.getQa_content().isEmpty() || board.getQa_content() == null) {
			errors.put("noContent", Boolean.TRUE);
		}
		
		if(!errors.isEmpty()) {
			rttr.addFlashAttribute("errors", errors);
			rttr.addFlashAttribute("category", board.getQa_category());
			rttr.addFlashAttribute("secret", board.getQa_secret());
			rttr.addFlashAttribute("title",board.getQa_title());
			rttr.addFlashAttribute("content", board.getQa_content());
			rttr.addFlashAttribute("filename", board.getQa_filename());
			
			return "redirect:/qa/modify?qa_seq=" + board.getQa_seq(); 
		}
		
		
		// 파일이 업로드 될 경로 설정
		String saveDir = request.getSession().getServletContext().getRealPath("/resources/qaboard/upload");

		// 위에서 설정한 경로의 폴더가 없을 경우 생성
		System.out.println(saveDir);
		File dir = new File(saveDir);
		if (!dir.exists()) {
			dir.mkdirs();
		}
		// 파일 업로드
		List<String> reNames = new ArrayList<String>();
		for (MultipartFile f : upload) {
			if (!f.isEmpty()) {
				// 기존 파일 이름을 받고 확장자 저장
				String orifileName = f.getOriginalFilename();
				String ext = orifileName.substring(orifileName.lastIndexOf("."));
				// 이름 값 변경을 위한 설정
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd-HHmmssSSS");
				int rand = (int) (Math.random() * 1000);
				// 파일 이름 변경
				String reName = sdf.format(System.currentTimeMillis()) + "_" + rand + ext;
				// 파일 저장
				try {
					f.transferTo(new File(saveDir + "/" + reName));
				} catch (IOException e) {
					e.printStackTrace();
				}

				reNames.add(reName);
			}
		}
		if (!reNames.isEmpty()) {
			board.setQa_filename(reNames.get(0));
		} else {
			board.setQa_filename("");
		}

				
		if(service.modify(board)) {
			rttr.addFlashAttribute("resultModify", board.getQa_seq());		
		}		
		
		log.info(cri);
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/qa/list";
	}
	
	

	// test 추가본/////////////////////////////////////////
	@GetMapping("/listTest")
    public void list_test(@ModelAttribute("criteria") Criteria cri,
            Model model) {

        // 게시물 리스트 가져오기
        List<QaVO> list = service.getList(cri);
        int total = service.getTotal(cri);
        PageDTO dto = new PageDTO(cri, total);
        model.addAttribute("list", list);
        model.addAttribute("pageMaker", dto);


    }
	
	@GetMapping("/getTest")
	public void get_test(@RequestParam("qa_seq") int qa_seq,
			@ModelAttribute("criteria") Criteria cri, 
		            Model model) {

		QaVO vo = service.get(qa_seq);
		service.addCnt(qa_seq);
		model.addAttribute("board", vo);

	}
	

}
