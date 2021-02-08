package org.zerock.RevBoard.service;

import java.util.List;

import org.zerock.RevBoard.domain.ReplyVO;


public interface ReplyService {
	
	public int register(ReplyVO vo);
	
	public ReplyVO get(int reply_seq);
	
	public int modify(ReplyVO vo);
	
	public int remove(int reply_seq);
	
	public List<ReplyVO> getList(int reply_boardseq);
}