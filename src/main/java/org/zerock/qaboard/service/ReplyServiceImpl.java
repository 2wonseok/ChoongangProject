package org.zerock.qaboard.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.qaboard.domain.Criteria;
import org.zerock.qaboard.domain.ReplyVO;
import org.zerock.qaboard.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class ReplyServiceImpl implements ReplyService{

	private ReplyMapper mapper;
	
	@Override
	public List<ReplyVO> getList(Criteria cri, int qa_seq) {

		return mapper.getList(cri, qa_seq);
	}
	

}
