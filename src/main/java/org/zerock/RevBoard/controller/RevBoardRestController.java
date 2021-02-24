package org.zerock.RevBoard.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.RevBoard.domain.ReplyVO;
import org.zerock.RevBoard.service.ReplyService;
import org.zerock.user.domain.UserVO;

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
	public ResponseEntity<String> create(@RequestBody ReplyVO vo, HttpSession session) {
		UserVO user = (UserVO) session.getAttribute("authUser");
		int insertCount = 0;
		vo.setReply_writer(user.getUser_nickname());
		if (!vo.getReply_content().trim().isEmpty()) {
			insertCount = service.register(vo);
		}
		
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
	@GetMapping(value = "/{reply_seq}",
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<ReplyVO> get(@PathVariable("reply_seq") int reply_seq) {
		
		ReplyVO vo = service.get(reply_seq);
		
		
		return new ResponseEntity<ReplyVO>(vo, HttpStatus.OK);
	}
	
	
	@RequestMapping(
			method = { RequestMethod.PUT, RequestMethod.PATCH },
			value = "/{reply_seq}",
			consumes = MediaType.APPLICATION_JSON_VALUE , // 우리가 값을 넣어주는 mediatype
			produces = MediaType.TEXT_PLAIN_VALUE
			)
	public ResponseEntity<String> modify(@RequestBody ReplyVO vo, @PathVariable("reply_seq") int reply_seq) {
		
		
		
		vo.setReply_seq(reply_seq);
		int cnt = 0;
		
		log.info("reply_seq : " + reply_seq);
		
		if (!vo.getReply_content().trim().isEmpty()) {
		cnt = service.modify(vo);
		}
		
		if(cnt == 1) {
			return new ResponseEntity<String> ("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<String> (HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@DeleteMapping(value = "/{reply_seq}",
			produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> remove(@PathVariable("reply_seq") int reply_seq) {
		int cnt = service.remove(reply_seq);
		
		log.info(cnt);
		
		if (cnt == 1) {
			return new ResponseEntity<String> ("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<String> (HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}