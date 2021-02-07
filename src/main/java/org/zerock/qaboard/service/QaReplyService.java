package org.zerock.qaboard.service;

import java.util.List;

import org.zerock.qaboard.domain.Criteria;
import org.zerock.qaboard.domain.QaReplyVO;

public interface QaReplyService {

	public List<QaReplyVO> getList(Criteria cri, int qa_seq);
	

}
