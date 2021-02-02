package org.zerock.qa_board.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import org.zerock.qa_board.domain.QaVO;
import org.zerock.qa_board.service.QaService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@AllArgsConstructor
@RequestMapping("/qa_board/*")
@Log4j
public class QaController {
	
	private QaService service;	


}
