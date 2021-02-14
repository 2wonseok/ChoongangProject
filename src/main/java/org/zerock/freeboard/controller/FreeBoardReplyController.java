package org.zerock.freeboard.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

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
import org.springframework.web.bind.annotation.RestController;
import org.zerock.freeboard.domain.FreeBoardCriteria;
import org.zerock.freeboard.domain.FreeBoardReplyVO;
import org.zerock.freeboard.service.FreeBoardReplyService;
import org.zerock.user.domain.UserVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/freeboard/replies")
@Log4j
@AllArgsConstructor
public class FreeBoardReplyController {

	private FreeBoardReplyService service;
	//댓글 등록
	@PostMapping(value = "/new", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> create(@RequestBody FreeBoardReplyVO vo) {

		
		
		
		log.info("vo: " + vo);

		int insertCount = service.register(vo);

		log.info("count: " + insertCount);

		
		if (insertCount == 1) {
			return new ResponseEntity<String>("success9999", HttpStatus.OK);
		} else {
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	//댓글 리스트
	@GetMapping(value = "/pages/{free_seq}/{page}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<FreeBoardReplyVO>> getList(@PathVariable("page") int page,
			@PathVariable("free_seq") int free_seq) {

		FreeBoardCriteria cri = new FreeBoardCriteria(page, 5);

		List<FreeBoardReplyVO> list = service.getList(cri, free_seq);

		log.info(list);

		return new ResponseEntity<List<FreeBoardReplyVO>>(list, HttpStatus.OK);
	}

	@GetMapping(value = "/{reply_seq}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<FreeBoardReplyVO> get(@PathVariable("reply_seq") int reply_seq) {
		
		FreeBoardReplyVO vo = service.get(reply_seq);

		log.info(vo);

		return new ResponseEntity<FreeBoardReplyVO>(vo, HttpStatus.OK);
	}
	//댓글 삭제
	@DeleteMapping(value = "/{reply_seq}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> remove(@PathVariable("reply_seq") int reply_seq) {

		int cnt = service.remove(reply_seq);

		log.info(cnt);

		if (cnt == 1) {
			return new ResponseEntity<String>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	//댓글 수정
	//value값이 중복됨
	@RequestMapping(value = "/{reply_seq}", method = { RequestMethod.PUT,
			RequestMethod.PATCH }, consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> modify(@RequestBody FreeBoardReplyVO vo, @PathVariable int reply_seq, HttpServletRequest request) {

		int cnt = service.modify(vo);
		
		log.info(cnt);
		if (cnt == 1) {
			return new ResponseEntity<String>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}

	}
}
