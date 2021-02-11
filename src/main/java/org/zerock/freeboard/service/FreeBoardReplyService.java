package org.zerock.freeboard.service;

import java.util.List;

import org.zerock.freeboard.domain.FreeBoardCriteria;
import org.zerock.freeboard.domain.FreeBoardReplyVO;

public interface FreeBoardReplyService {

	public int register(FreeBoardReplyVO vo);

	public FreeBoardReplyVO get(int reply_seq);

	public int modify(FreeBoardReplyVO vo);

	public int remove(int reply_seq);

	public List<FreeBoardReplyVO> getList(FreeBoardCriteria cri, int reply_boardseq);

}
