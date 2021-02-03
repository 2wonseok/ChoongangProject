package org.zerock.RevBoard.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.zerock.RevBoard.domain.RevVO;
import org.zerock.RevBoard.service.RevBoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import oracle.jdbc.proxy.annotation.Post;

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
<<<<<<< HEAD
	public void list(Model model) {
		List<RevVO> list = service.getList();
=======
	public void list(@ModelAttribute("cri") Criteria cri, Model model) {
		List<RevVO> list = service.getListWithPaging(cri);
		
		int total = service.getTotal(cri);
		
		PageDTO dto = new PageDTO(cri, total);
		 
>>>>>>> 9646102... 0203minju1909
		model.addAttribute("list", list);
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
	
}
