package org.zerock.qaboard.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.qaboard.domain.Criteria;
import org.zerock.qaboard.domain.PageDTO;
import org.zerock.qaboard.domain.QaVO;
import org.zerock.qaboard.service.QaService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@AllArgsConstructor
@RequestMapping("/qa/*")
@Log4j
public class QaController {
	
	private QaService service;	

	// 211 page 표
	
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
	public void list(@ModelAttribute("criteria") Criteria cri, Model model) {
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
	public String register(QaVO board, RedirectAttributes rttr) {
		
//		BoardVO board = new BoardVO();
//		board.setTitle(request.getParameter("title"));
//		board.setContent(request.getParameter("content"));
//		board.setWriter(request.getParameter("writer"));		
		
		service.register(board);
		
		
		rttr.addFlashAttribute("result", board.getQa_seq());
//		return "/board/list";
		return "redirect:/qa/list";
	}
	
	//
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("qa_seq") int qa_seq, 
			@ModelAttribute("criteria") Criteria cri, Model model) {
		// 
		/** 예전 코드 (스프링 없이) 
		String boardNum = request.getParameter("num");
		int num = Integer.parseInt(boardNum);
		
		BoardVO vo = service.get((long) num);
		
		request.setAttribute("board", vo);
		
		request.getRequestDispatcher(".jsp").forward();
		*/

		QaVO vo = service.get(qa_seq);
		
		// 쿼리문으로 붙어서 감
		model.addAttribute("board", vo);
//		model.addAttribute("cri", cri);
	}
	
	@RequestMapping("/remove")
	public String remove(@RequestParam("qa_seq") int qa_seq) {
		service.remove(qa_seq);
		
		return "redirect:/qa/list";
	}
	
	@PostMapping("/modify")
	public String modify(QaVO board, Criteria cri, RedirectAttributes rttr) {
		
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
	
	

}
