package org.zerock.qaboard.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.qaboard.domain.Criteria;
import org.zerock.qaboard.domain.ReplyVO;
import org.zerock.qaboard.mapper.QaMapper;
import org.zerock.qaboard.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;


@Service
@Log4j
public class ReplyServiceImpl implements ReplyService {

	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private QaMapper qaMapper;
	
	@Override
	public ReplyVO get(int seq) {
		return mapper.read(seq);
	}
	
	@Override
	public List<ReplyVO> getList(
			Criteria cri, 
			String reply_boardname, 
			int qa_seq) {
		return mapper.getListWithPaging(cri, reply_boardname, qa_seq);
	}
	
	@Override
	public int modify(ReplyVO reply) {
		return mapper.update(reply);
	}
	
	@Override
	@Transactional
	public int register(ReplyVO reply) {
		qaMapper.updateReplyCnt(reply.getReply_boardseq(), 1);
		return mapper.insert(reply);
	}
	
	@Override
	@Transactional
	public int remove(int seq) {
		ReplyVO vo = mapper.read(seq);
		qaMapper.updateReplyCnt(vo.getReply_boardseq(), -1);
		return mapper.delete(seq);
	}
}
