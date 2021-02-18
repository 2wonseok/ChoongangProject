package org.zerock.freeboard.controller;

import java.util.ArrayList;

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
		List<FreeBoardVO> totalList = new ArrayList<FreeBoardVO>();
		totalList.addAll(service.getNoticeList(cri));
		totalList.addAll(service.getList(cri));
		int total = service.getTotal(cri);
		//notice list
		FreeBoardPageDTO dto = new FreeBoardPageDTO(cri, total);
		// jsp에서 받을 이름
		model.addAttribute("list", totalList);
		model.addAttribute("pageMaker", dto);
	}

	@GetMapping("/register")
	public void register(@ModelAttribute("cri") FreeBoardCriteria cri, Model model, 
			HttpServletRequest request) {
		
		try {
			UserVO user = (UserVO) request.getSession(false).getAttribute("authUser");
			System.out.println("user nick name : "+user.getUser_nickname());
			//authUser 이름 
			model.addAttribute("authUser", user);
			
		} catch (NullPointerException e) {
			//로그인하지않았을경우 글쓰기 불가처리
			System.out.println("Session 정보 없음");
			e.printStackTrace();
		}
	}

	@PostMapping("/register")
	public String reegister(FreeBoardVO freeVO, RedirectAttributes rttr, 
			HttpServletRequest request) {
		
		UserVO user = (UserVO) request.getSession(false).getAttribute("authUser");
		
		String anonmyous = request.getParameter("anonmyous");
		String notice = request.getParameter("notice");
		System.out.println("POST anonmyous : "+anonmyous);
		// 익명일 때
		if("y".equals(anonmyous)) {
			freeVO.setFree_nickname("익명");
		}
		// 공지일 때
		if("n".equals(notice)) {
			freeVO.setFree_notice(2);
		} else {
			freeVO.setFree_notice(1);
		}
		freeVO.setFree_writer(user.getUser_id());
		System.out.println("freeVO : "+freeVO.toString());
		service.register(freeVO);

		rttr.addFlashAttribute("result", freeVO.getFree_seq());
		rttr.addFlashAttribute("message", freeVO.getFree_seq());

		return "redirect:/freeboard/list";
	}

	@GetMapping({ "/get", "/modify" })
	public void get(@RequestParam("free_seq") int free_seq, @ModelAttribute("cri") 
	FreeBoardCriteria cri,Model model) {

		log.info("get method - free_seq: " + free_seq);
		log.info(cri);
		FreeBoardVO freeVO = service.get(free_seq);
		// 댓글에 대한 조회
		service.addCnt(free_seq);
		model.addAttribute("freeVO", freeVO);
		System.out.println(freeVO.getFree_readCnt());
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
	public String remove(@RequestParam("free_seq") int free_seq, FreeBoardCriteria cri, 
			RedirectAttributes rttr) {

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
