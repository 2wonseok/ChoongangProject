package org.zerock.user.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.user.domain.Criteria;
import org.zerock.user.domain.PageDTO;
import org.zerock.user.domain.UserVO;
import org.zerock.user.service.UserService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@AllArgsConstructor
@Log4j
@RequestMapping("/user/*")
public class UserController {
	
	private UserService service;
	
	@GetMapping("/userRegister")
	public void register() {
	
	}
	
	@PostMapping("/userRegister")
	public String register(UserVO user, Model model, RedirectAttributes rttr) {
		service.register(user);
//		rttr.addFlashAttribute("result", board.getBno());
//		rttr.addFlashAttribute("message", board.getBno()+"번 글이 등록되었습니다.");
		return "redirect:/main/index";
	}
	
	@GetMapping("/userList")
	public void getList(@ModelAttribute("cri") Criteria cri, Model model) {
		log.info(cri.getType() + "=" + cri.getKeyword());
		List<UserVO> list = service.getList(cri);
		
		int total = service.getTotal(cri);
		
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
	}
	
	@GetMapping({"/userRead", "/userModify"})
	public void read(@RequestParam int seq, @ModelAttribute("cri") Criteria cri, Model model) {
		model.addAttribute("read", service.read(seq));
	}
	
	@PostMapping("/userModify")
	public String modify(UserVO user, Criteria cri, RedirectAttributes rttr) {
		if (service.update(user)) {
			rttr.addFlashAttribute("result", "modifySuccess");
			rttr.addFlashAttribute("message", user.getUser_seq()+"번 회원 정보가 수정되었습니다.");
		}

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/user/userList";
	}
	
	@PostMapping("/userDelete")
	public String remove(@RequestParam int user_seq, Criteria cri, RedirectAttributes rttr) {
		if (service.delete(user_seq)) {
			rttr.addFlashAttribute("result", "deleteSuccess");
			rttr.addFlashAttribute("message", user_seq+"번 회원이 삭제되었습니다.");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/user/userList";
	}
	
	@PostMapping("/userCheckDel")
	public String checkDel(@RequestParam("seq") ArrayList<Integer> seq, RedirectAttributes rttr) {
		for (int no : seq) {
			if (service.delete(no)) {
				rttr.addFlashAttribute("result", "deleteSuccess");
				rttr.addFlashAttribute("message", seq+"번 회원이 삭제되었습니다.");
			}
		}
		return "redirect:/user/userList";
	}
	
	@RequestMapping("/jusoPopup")
	public void address() {
		
	}
	
	
	@GetMapping("/idCheck")
	public void idCheck() {
		
	}
	
	@RequestMapping("/searchIdCheck")
	public String searchIdCheck(@RequestParam("user_id") String user_id, RedirectAttributes rttr) {
		int check = service.idCheck(user_id);
		
		if (check == 1) {
			rttr.addFlashAttribute("user_id", user_id);
			rttr.addFlashAttribute("checkResultN", "이미 사용중인 아이디 입니다.");
		} else {
			rttr.addFlashAttribute("user_id", user_id);
			rttr.addFlashAttribute("checkResultY", "사용 가능합니다.");
		}
		
		return "redirect:/user/idCheck";
	}
	
	@GetMapping("/login")
	public void login() {
		
	}
	
	@PostMapping("/login")
	public String login(UserVO user, RedirectAttributes rttr) {
		UserVO vo = service.getUser(user.getUser_id());
		
		if (vo == null || !user.getUser_id().equals(vo.getUser_id()) || 
				!user.getUser_password().equals(vo.getUser_password())) {
			rttr.addFlashAttribute("noUser", "일치하는 정보가 없습니다.");
			return "redirect:/user/login";
		}
		
		return "redirect:/main/index";
	}
}
