package org.zerock.freeboard.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.freeboard.domain.FreeBoardCriteria;
import org.zerock.freeboard.domain.FreeBoardPageDTO;
import org.zerock.freeboard.domain.FreeBoardVO;
import org.zerock.freeboard.service.FreeBoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
//Client는 URI 형식으로 웹 서비스에 요청을 보낸다.
//Mapping되는 Handler와 그 Type을 찾는 DispatcherServlet이 요청을 인터셉트한다.
//Controller가 요청을 처리한 후에 응답을 DispatcherServlet으로 반환하고, DispatcherServlet은 View를 사용자에게 반환한다.
@AllArgsConstructor
//모든 필드에 대한 생성자 생성
@RequestMapping("/freeboard/*")
@Log4j
public class FreeBoardController {
	
	private FreeBoardService service;
	
	
	@GetMapping("/list")
	public void list( Model model) {
		//DB에서 list를 받아온다
		List<FreeBoardVO> list = service.getList();
		
//		int total = service.getTotal(cri);
//		
//		FreeBoardPageDTO dto = new FreeBoardPageDTO(cri, total);
		
		//jsp에서 받을 이름 
		model.addAttribute("list", list);
//		model.addAttribute("pageMaker", dto);
	}
	
//	@GetMapping("/register")
//	public void register(@ModelAttribute("cri") FreeBoardCriteria cri) {
//		
//	}
	//get으로 요청이왔을경우
	@GetMapping("/register")
	public void  register() {
		
	}
	//post방식으로 요청이왔을경우
	@PostMapping("/register")
	public String reegister(FreeBoardVO freeboard ,RedirectAttributes rttr) {
		
		service.register(freeboard);
		
		rttr.addFlashAttribute("result",freeboard.getFree_seq());
		
		return "redirect:/freeboard/list";
	}
//	
////	@RequestMapping(value = "/register", method = RequestMethod.POST)
//	@PostMapping("/register")
//	public String register(FreeBoardVO freeboard, RedirectAttributes rttr) {
//		
//		/*
//		BoardVO board = new BoardVO();
//		board.setTitle(request.getParameter("title"));
//		board.setContent(request.getParameter("content"));
//		board.setWriter(request.getParameter("writer"));
//		*/
//		
//		service.register(freeboard);
//		
//		rttr.addFlashAttribute("result", freeboard.getFree_seq());
//		rttr.addFlashAttribute("message", freeboard.getFree_seq() + "번 글이 등록되었습니다.");
//		
////		return "board/list";
//		return "redirect:/freeboard/list";
//	}
	
	// 표: /board/read, 코드: /board/get
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("seq") Long seq,Model model) {
//		/** 예전 코드 (스프링 없이) 
//		String boardNum = request.getParameter("num");
//		int num = Integer.parseInt(boardNum);
//		
//		BoardVO vo = service.get((long) num);
//		
//		request.setAttribute("board", vo);
//		
//		request.getRequestDispatcher(".jsp").forward();
//		*/
//		
		log.info("get method - seq: " + seq);
//		log.info(cri);
		FreeBoardVO vo = service.get(seq);
		
		//시퀀스값을 가져와서 
		
		model.addAttribute("freeboard", vo);
//		model.addAttribute("cri", cri);
	}
//	
	/*
	@GetMapping("/modify")
	public void modify(Long bno, Model model) {
		BoardVO vo = service.get(bno);
		model.addAttribute("board", vo);
	}
	*/
	
	@PostMapping("/modify")
	public String modify(FreeBoardVO freeboard) {
		
		service.modify(freeboard);
		
		
		
		return "redirect:/freeboard/list";
	}
	
//	@PostMapping("/modify2")
//	public String modify2(FreeBoardVO freeboard, RedirectAttributes rttr) {
//		/** 스프링 없이
//		BoardVO board = new BoardVO();
//		board.setBno(request.getParameter("bno"));
//		board.setTitle(request.getParameter("title"));
//		board.setContent(request.getParameter("content"));
//		*/
//		
//		if (service.modify(freeboard)) {
//			rttr.addFlashAttribute("result", "success");
//			rttr.addAttribute("bno", freeboard.getFree_seq());
//			rttr.addAttribute("a", "a");
//			rttr.addFlashAttribute("b", "b");
//		}
//		
//		return "redirect:/board/get";
//	}
//	
	@GetMapping("/remove")
	public String remove(@RequestParam("seq") Long seq,
			 RedirectAttributes rttr) {
//		
		if (service.remove(seq)) {
			rttr.addFlashAttribute("result", "success");
			rttr.addFlashAttribute("message", seq + "번 글이 삭제되었습니다.");
		}
//		
//		rttr.addAttribute("pageNum", cri.getPageNum());
//		rttr.addAttribute("amount", cri.getAmount());
//		rttr.addAttribute("type", cri.getType());
//		rttr.addAttribute("keyword", cri.getKeyword());
//		
		return "redirect:/freeboard/list";
	}
}
	
	

// servlet/jsp
// ControllerUsingURI(Servlet) ....properties
//   /list.do -> ListHandler 