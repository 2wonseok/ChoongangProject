package org.zerock.qaboard.service;

import java.util.List;

import org.zerock.qaboard.domain.Criteria;
import org.zerock.qaboard.domain.ReplyVO;

public interface ReplyService {

	public int register(ReplyVO reply);
	public ReplyVO get(int seq);
	public int modify(ReplyVO reply);
	public int remove(int seq);
	public List<ReplyVO> getList(
			Criteria cri, 
			String reply_boardname, 
			int qa_seq);
}
