package org.zerock.qaboard.controller;


import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import org.zerock.qaboard.domain.Criteria;
import org.zerock.qaboard.domain.QaReplyVO;
import org.zerock.qaboard.service.QaReplyService;


import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@RestController
@RequestMapping("/reply/*")
@Log4j
@AllArgsConstructor
public class ReplyController {
	
	private QaReplyService reply_service;
	
	// 댓글의 리스트 가져오기
	
	@GetMapping(path = "/pages/{qa_seq}/{page}", 
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<QaReplyVO>> getList(
			@PathVariable("page") int page,
			@PathVariable("qa_seq") int qa_seq) {
		Criteria cri = new Criteria(page, 5);

		List<QaReplyVO> list = reply_service.getList(cri, qa_seq);

		log.info(list);

		return new ResponseEntity<List<QaReplyVO>>(list, HttpStatus.OK);
	}
	
	// 댓글 등록 
	
	@PostMapping(path = "/register", 
			consumes = MediaType.APPLICATION_JSON_VALUE, 
			produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> create(@RequestBody QaReplyVO vo) {

		log.info("vo : " + vo);

		int insertCount = reply_service.register(vo);

		log.info("count : " + insertCount);

		if (insertCount == 1) {
			return new ResponseEntity<String>("success /new", HttpStatus.OK);
		} else {
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	
	// 댓글 삭제
	
	
	@DeleteMapping(path = "/{reply_seq}", 
			produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> remove(@PathVariable("reply_boardseq") int reply_boardseq) {
		
		int cnt = reply_service.delete(reply_boardseq);
		
		log.info(cnt);
		
		if(cnt == 1) {
			return new ResponseEntity<String>("success /rno delete", HttpStatus.OK);
		} else {
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}	
		
	}
}
