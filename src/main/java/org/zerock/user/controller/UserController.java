package org.zerock.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.user.domain.Criteria;
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
	
	@GetMapping("/register")
	public void register(@ModelAttribute("cri") Criteria cri) {
		log.info("zzzzzz");
	}
	
	@PostMapping("/register")
	public String register(UserVO user, Model model, RedirectAttributes rttr) {
		service.register(user);
//		rttr.addFlashAttribute("result", board.getBno());
//		rttr.addFlashAttribute("message", board.getBno()+"번 글이 등록되었습니다.");
		return "redirect:/main/index";
	}
}
