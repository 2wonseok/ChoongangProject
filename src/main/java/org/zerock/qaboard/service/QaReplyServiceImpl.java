package org.zerock.qaboard.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.qaboard.domain.Criteria;
import org.zerock.qaboard.domain.QaReplyVO;
import org.zerock.qaboard.mapper.QaMapper;
import org.zerock.qaboard.mapper.QaReplyMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class QaReplyServiceImpl implements QaReplyService{

	private QaReplyMapper mapper;
	private QaMapper qaMapper;
	
	@Override
	public List<QaReplyVO> getList(Criteria cri, int qa_seq) {
		return mapper.getList(cri, qa_seq);
	}
	
	@Override
	@Transactional
	public int register(QaReplyVO reply) {		
		qaMapper.updateReplyCnt(reply.getReply_boardseq(), 1);
		return mapper.insertSelectKey(reply);
	}	
	
	@Override
	@Transactional
	public int register_admin(QaReplyVO reply) {		
		qaMapper.updateReplyCnt_admin(reply.getReply_boardseq(), 1);
		return mapper.insertSelectKey_admin(reply);
	}	
	
	@Override
	@Transactional
	public int delete(int reply_seq) {
		QaReplyVO reply = mapper.get(reply_seq);
		qaMapper.updateReplyCnt(reply.getReply_boardseq(), -1);		
		return mapper.delete(reply_seq);
	}
	
	@Override
	@Transactional
	public int delete_admin(int reply_seq) {
		QaReplyVO reply = mapper.get(reply_seq);
		qaMapper.updateReplyCnt_admin(reply.getReply_boardseq(), -1);		
		return mapper.delete_admin(reply_seq);
	}

	@Override
	public int update(QaReplyVO reply) {
		return mapper.update(reply);
	}
	
	@Override
	public QaReplyVO get(int reply_seq) {

		return mapper.get(reply_seq);
	}
}
