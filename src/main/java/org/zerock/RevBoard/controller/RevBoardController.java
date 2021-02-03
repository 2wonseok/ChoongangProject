package org.zerock.RevBoard.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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
	
	@PostMapping("/register")
	public String register(RevVO revVo) {
		service.register(revVo);
		
		return "redirect:/rev/list";
	}
	
	@GetMapping("/list")
	public void list(Model model) {
		List<RevVO> list = service.getList();
		model.addAttribute("list", list);
	}
}
