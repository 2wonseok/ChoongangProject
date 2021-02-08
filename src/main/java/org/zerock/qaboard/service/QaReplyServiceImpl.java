package org.zerock.qaboard.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.qaboard.domain.Criteria;
import org.zerock.qaboard.domain.QaReplyVO;
import org.zerock.qaboard.mapper.QaReplyMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class QaReplyServiceImpl implements QaReplyService{

	private QaReplyMapper mapper;
	
	@Override
	public List<QaReplyVO> getList(Criteria cri, int qa_seq) {

		return mapper.getList(cri, qa_seq);
	}
	
	@Override
	public void register(QaReplyVO board) {
		mapper.insertSelectKey(board);
	}	

}
