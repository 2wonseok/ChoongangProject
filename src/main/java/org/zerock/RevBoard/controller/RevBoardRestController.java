package org.zerock.RevBoard.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.RevBoard.domain.Criteria;
import org.zerock.RevBoard.domain.ReplyVO;
import org.zerock.RevBoard.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/replies")
@Log4j
@AllArgsConstructor
public class RevBoardRestController {
	
	private ReplyService service;
	
	@PostMapping(value="/new",
				consumes = MediaType.APPLICATION_JSON_UTF8_VALUE,
				produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> create(@RequestBody ReplyVO vo) {
		
		int insertCount = service.register(vo);
		
		if (insertCount == 1) {
			return new ResponseEntity<String> ("success!", HttpStatus.OK );
		} else {
			return new ResponseEntity<String> (HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@GetMapping (value = "/pages"
				)
	public @ResponseBody List<ReplyVO> getList(int reply_boardseq){
		
		
		List<ReplyVO> list = service.getList(reply_boardseq);
		
		return list;
		
	}
	
	@GetMapping()
	public @ResponseBody int modify(ReplyVO vo) {
		
		return service.modify(vo);
	}
	
}