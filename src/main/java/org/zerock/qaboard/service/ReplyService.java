package org.zerock.qaboard.service;

import java.util.List;

import org.zerock.qaboard.domain.Criteria;
import org.zerock.qaboard.domain.ReplyVO;

public interface ReplyService {

	public List<ReplyVO> getList(Criteria cri, int qa_seq);
	

}
