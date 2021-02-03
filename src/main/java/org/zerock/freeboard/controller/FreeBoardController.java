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
@AllArgsConstructor
@RequestMapping("/freeboard/*")
@Log4j
public class FreeBoardController {
	
	private FreeBoardService service;
	
	/*
	public BoardController(BoardService service) {
		super();
		this.service = service;
	}
	*/

	/*
	// 211 page 표
//	@RequestMapping(value = "/list", method = RequestMethod.GET)
	@GetMapping("/list") 
	// handler 메소드의 return type이 void인 경우
	//   요청경로가 view(jsp)의 이름이 됨 
	//   이 메소드는 (/board/list) -> /board/list.jsp
	public void list(Model model) {
		log.info("******************** list *******************");
		List<BoardVO> list = service.getList();
		model.addAttribute("list", list);
	}
	*/
	
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
//	@GetMapping({"/get", "/modify"})
//	public void get(@RequestParam("seq") Long seq,
//			@ModelAttribute("cri") FreeBoardCriteria cri, Model model) {
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
//		log.info("get method - seq: " + seq);
//		log.info(cri);
//		FreeBoardVO vo = service.get(seq);
//		model.addAttribute("freeboard", vo);
////		model.addAttribute("cri", cri);
//	}
//	
	/*
	@GetMapping("/modify")
	public void modify(Long bno, Model model) {
		BoardVO vo = service.get(bno);
		model.addAttribute("board", vo);
	}
	*/
	
//	@PostMapping("/modify")
//	public String modify(FreeBoardVO board, FreeBoardCriteria cri, RedirectAttributes rttr) {
//		/** 스프링 없이
//		BoardVO board = new BoardVO();
//		board.setBno(request.getParameter("bno"));
//		board.setTitle(request.getParameter("title"));
//		board.setContent(request.getParameter("content"));
//		*/
//		
//		if (service.modify(board)) {
//			rttr.addFlashAttribute("result", "success");
//			rttr.addFlashAttribute("message", board.getFree_seq() + "번 글이 수정되었습니다.");
//		}
//		log.info(cri);
//		rttr.addAttribute("pageNum", cri.getPageNum());
//		rttr.addAttribute("amount", cri.getAmount());
//		rttr.addAttribute("type", cri.getType());
//		rttr.addAttribute("keyword", cri.getKeyword());
//		
//		return "redirect:/board/list";
//	}
//	
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
//	@PostMapping("/remove")
//	public String remove(@RequestParam("bno") Long bno,
//			FreeBoardCriteria cri, RedirectAttributes rttr) {
//		
//		if (service.remove(bno)) {
//			rttr.addFlashAttribute("result", "success");
//			rttr.addFlashAttribute("message", bno + "번 글이 삭제되었습니다.");
//		}
//		
//		rttr.addAttribute("pageNum", cri.getPageNum());
//		rttr.addAttribute("amount", cri.getAmount());
//		rttr.addAttribute("type", cri.getType());
//		rttr.addAttribute("keyword", cri.getKeyword());
//		
//		return "redirect:/board/list";
	}
	
	

// servlet/jsp
// ControllerUsingURI(Servlet) ....properties
//   /list.do -> ListHandler 