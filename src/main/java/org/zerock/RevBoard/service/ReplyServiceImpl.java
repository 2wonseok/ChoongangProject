package org.zerock.RevBoard.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.RevBoard.domain.ReplyVO;
import org.zerock.RevBoard.mapper.RevBoardMapper;
import org.zerock.RevBoard.mapper.RevReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImpl implements ReplyService {
		
	@Setter(onMethod_ = @Autowired)
	private RevReplyMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private RevBoardMapper boardMapper;
	
	// 댓글 생성
	@Override
	@Transactional
	public int register(ReplyVO vo) {
		
		boardMapper.updateReplyCnt(vo.getReply_boardseq(), 1);
		
		return mapper.insert(vo);
	}
	
	// 댓글 가져오기
	@Override
	public ReplyVO get(int reply_seq) {
		
		return mapper.read(reply_seq);
	}
	
	// 댓글 수정
	@Override
	public int modify(ReplyVO vo) {

		return mapper.update(vo);
	}
	
	// 댓글 삭제
	@Override
	@Transactional
	public int remove(int reply_seq) {
		ReplyVO vo = mapper.read(reply_seq);
		
		boardMapper.updateReplyCnt(vo.getReply_boardseq(), -1);
		
		return mapper.remove(reply_seq);
	}
	
	// 댓글 리스트가져오기 
	@Override
	public List<ReplyVO> getList(int reply_boardseq) {

		return mapper.getListWithPaging(reply_boardseq);
	}
}