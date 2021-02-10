package org.zerock.qaboard.service;

import java.util.List;

import org.zerock.qaboard.domain.Criteria;
import org.zerock.qaboard.domain.QaReplyVO;
import org.zerock.qaboard.domain.QaVO;

public interface QaReplyService {

	public List<QaReplyVO> getList(Criteria cri, int qa_seq);
	
	public int register(QaReplyVO reply);
	
	public int register_admin(QaReplyVO reply);
	
	public int delete(int reply_seq);
	
	public int delete_admin(int reply_seq);
	
	public int update(QaReplyVO reply);
	
	public QaReplyVO get(int reply_seq);	
	
}
