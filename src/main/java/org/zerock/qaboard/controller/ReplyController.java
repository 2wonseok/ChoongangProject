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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
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
			@PathVariable("qa_seq") int qa_seq,
			Model model) {
		Criteria cri = new Criteria(page, 5);

		List<QaReplyVO> list = reply_service.getList(cri, qa_seq);

		log.info(list);

		return new ResponseEntity<List<QaReplyVO>>(list, HttpStatus.OK);
	}
	
	// 댓글 등록 (유저)
	
	@PostMapping(path = "/register", 
			consumes = MediaType.APPLICATION_JSON_VALUE, 
			produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> create(@RequestBody QaReplyVO vo) {

		int insertCount = reply_service.register(vo);

		if (insertCount == 1) {
			return new ResponseEntity<String>("success /new", HttpStatus.OK);
		} else {
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	// 댓글 등록 (관리자)
	
	@PostMapping(path = "/register_admin", 
			consumes = MediaType.APPLICATION_JSON_VALUE, 
			produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> create_admin(@RequestBody QaReplyVO vo) {

		int insertCount = reply_service.register_admin(vo);

		if (insertCount == 1) {
			return new ResponseEntity<String>("success /new", HttpStatus.OK);
		} else {
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	

	
	// 댓글 삭제	(관리자)
	
	@DeleteMapping(path = "/delete/{reply_seq}", 
			produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> remove_admin(@PathVariable("reply_seq") int reply_seq) {
		
		int cnt = reply_service.delete_admin(reply_seq);
		
		log.info(cnt);
		
		if(cnt == 1) {
			return new ResponseEntity<String>("success /reply_seq delete", HttpStatus.OK);
		} else {
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}	
		
	}
	
	// 댓글 삭제 ( 일반)
	@DeleteMapping(path = "/{reply_seq}", 
			produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> remove(@PathVariable("reply_seq") int reply_seq) {
		
		int cnt = reply_service.delete(reply_seq);
		
		log.info(cnt);
		
		if(cnt == 1) {
			return new ResponseEntity<String>("success /reply_seq delete", HttpStatus.OK);
		} else {
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}	
		
	}
	
	@GetMapping(path = "/{reply_seq}",
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<QaReplyVO> get(@PathVariable("reply_seq") int reply_seq) {
		QaReplyVO vo = reply_service.get(reply_seq);
		
		log.info(vo);
		
		return new ResponseEntity<QaReplyVO> (vo, HttpStatus.OK);
	}
	
	// 댓글 수정 테스트
	@GetMapping("/modify")
	public @ResponseBody int modifyTest(QaReplyVO vo) {
		
		int cnt = reply_service.update(vo);
		
		System.out.println("성공 여부:" + cnt);
		
		return cnt;
	}
	
	
	// 댓글 수정
	
	@RequestMapping(path = "/{reply_seq}", 
			method = { RequestMethod.PUT, RequestMethod.PATCH }, 
			consumes = MediaType.APPLICATION_JSON_VALUE, 
			produces = MediaType.TEXT_PLAIN_VALUE)

	public ResponseEntity<String> modify(
			@RequestBody QaReplyVO vo, 
			@PathVariable("reply_seq") int reply_seq) {
		
		vo.setReply_seq(reply_seq);

		int cnt = reply_service.update(vo);

		log.info(cnt);

		if (cnt == 1) {
			return new ResponseEntity<String>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	

}
