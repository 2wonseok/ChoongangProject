package org.zerock.RevBoard.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.RevBoard.service.RevBoardService;


import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/rev")
@Log4j
@AllArgsConstructor
public class RevBoardRestController {
	
	private RevBoardService service;
	
	@GetMapping(value = "/get/like/" ,
				consumes = MediaType.APPLICATION_JSON_VALUE,
				produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> goodAdd(@PathVariable("rev_seq") int rev_seq ) {
		service.addGood(rev_seq);
		
		return new ResponseEntity<String>(HttpStatus.OK);
	}
}
