package org.zerock.freeboard.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

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
import org.zerock.user.domain.UserVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
//Client는 URI 형식으로 웹 서비스에 요청을 보낸다.
//Mapping되는 Handler와 그 Type을 찾는 DispatcherServlet이 요청을 인터셉트한다.
//Controller가 요청을 처리한 후에 응답을 DispatcherServlet으로 반환하고, DispatcherServlet은 View를 사용자에게 반환한다.
@AllArgsConstructor
//모든 필드에 대한 생성자 생성
@RequestMapping("/freeboard")
@Log4j
public class FreeBoardController {

	private FreeBoardService service;

	@GetMapping("/list")
	public void list(@ModelAttribute("cri") FreeBoardCriteria cri, Model model,HttpServletRequest request) {
		// DB에서 list를 받아온다
		
		List<FreeBoardVO> list = service.getList(cri);
//		UserVO user = (UserVO) request.getSession(false).getAttribute("authUser");
//		System.out.println(user.getUser_nickname());
		int total = service.getTotal(cri);

		FreeBoardPageDTO dto = new FreeBoardPageDTO(cri, total);
		
		// jsp에서 받을 이름
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", dto);
		log.info(dto);
	}

	@GetMapping("/register")
	public void register(@ModelAttribute("cri") FreeBoardCriteria cri, Model model, HttpServletRequest request) {
		try {
			UserVO user = (UserVO) request.getSession(false).getAttribute("authUser");
			System.out.println("user nick name : "+user.getUser_nickname());
			model.addAttribute("user", user);
			
		} catch (NullPointerException e) {
			// TODO: handle exception
			System.out.println("Session 정보 없음");
			e.printStackTrace();
		}
	}

	@PostMapping("/register")
	public String reegister(FreeBoardVO freeVO, RedirectAttributes rttr, HttpServletRequest request) {
		
		UserVO user = (UserVO) request.getSession(false).getAttribute("authUser");
		
		String anonmyous=request.getParameter("anonmyous");
		System.out.println("POST anonmyous : "+anonmyous);
		
		try {
			if(anonmyous.equals("y")) {
				freeVO.setFree_nickname("익명");
			}
		} catch (NullPointerException e) {
			// TODO: handle exception
			System.out.println("선택없음");
			e.printStackTrace();
		}
		
		freeVO.setFree_writer(user.getUser_nickname());
		freeVO.setFree_writer(user.getUser_name());
		System.out.println("freeVO : "+freeVO.toString());
		service.register(freeVO);

		rttr.addFlashAttribute("result", freeVO.getFree_seq());
		rttr.addFlashAttribute("message", freeVO.getFree_seq());

		return "redirect:/freeboard/list";
	}

	@GetMapping({ "/get", "/modify" })
	public void get(@RequestParam("free_seq") Long free_seq, @ModelAttribute("cri") FreeBoardCriteria cri,
			Model model) {

		log.info("get method - free_seq: " + free_seq);
		log.info(cri);
		FreeBoardVO freeVO = service.get(free_seq);

		model.addAttribute("freeVO", freeVO);
//		model.addAttribute("cri", cri);
	}

	@PostMapping("/modify")
	public String modify(FreeBoardVO freeVO, RedirectAttributes rttr) {
		if (service.modify(freeVO)) {
			rttr.addFlashAttribute("result", "success");
			rttr.addFlashAttribute("message", freeVO.getFree_seq() + "번 글이 수정되었습니다.");
		}
		return "redirect:/freeboard/list";
	}

	@PostMapping("/remove")
	public String remove(@RequestParam("free_seq") Long free_seq, FreeBoardCriteria cri, RedirectAttributes rttr) {

		if (service.remove(free_seq)) {
			rttr.addFlashAttribute("result", "success");
			rttr.addFlashAttribute("message", free_seq + "번 글이 삭제되었습니다.");
		}

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());

		return "redirect:/freeboard/list";
	}
}
