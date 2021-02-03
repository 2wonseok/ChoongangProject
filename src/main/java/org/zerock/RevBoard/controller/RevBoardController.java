package org.zerock.RevBoard.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	public String register(RevVO revVo) {
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
	public String modify(RevVO revVo) {
		
		service.moidfy(revVo);
		
		return "redirect:/rev/list";
		
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("rev_seq") int rev_seq) {
		service.remove(rev_seq);
		
		return "redirect:/rev/list";
	}
	
	@GetMapping("/get/like")
	public String addGood(@RequestParam("rev_seq") int rev_seq) {
		service.addGood(rev_seq);
		
		return "redirect:/rev/get?rev_seq="+ rev_seq;
	}
	
	@GetMapping("/get/hate")
	public String addHate(@RequestParam("rev_seq") int rev_seq) {
		service.addHate(rev_seq);
		
		return "redirect:/rev/get?rev_seq="+ rev_seq;
	}
	
}
