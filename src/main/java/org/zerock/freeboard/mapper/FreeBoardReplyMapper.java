package org.zerock.freeboard.mapper;

import org.zerock.freeboard.domain.FreeBoardReplyVO;

public interface FreeBoardReplyMapper {
	public int insert(FreeBoardReplyVO vo);
	public FreeBoardReplyVO read(int reply_seq);
//	public int delete(int reply_seq);
//	public int update(FreeBoardReplyVO reply_seq);
//	public List<FreeBoardReplyVO> getListWithPaging(
//			@Param("cri") FreeBoardCriteria cri,
//			@Param("free_seq") Long free_seq);
	
}
