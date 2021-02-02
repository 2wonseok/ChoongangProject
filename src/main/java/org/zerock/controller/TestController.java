package org.zerock.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/main/*") // 예전 list.do -> List.handler가 일하라고 했던 역할
@AllArgsConstructor
@Log4j
public class TestController {
	
	@GetMapping("/index")
	public String testmethod() {
		return "index";
	}
}
