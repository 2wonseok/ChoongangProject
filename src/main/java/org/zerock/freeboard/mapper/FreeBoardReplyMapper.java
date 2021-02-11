package org.zerock.freeboard.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.freeboard.domain.FreeBoardCriteria;
import org.zerock.freeboard.domain.FreeBoardReplyVO;

public interface FreeBoardReplyMapper {
	public int insert(FreeBoardReplyVO vo);

	public FreeBoardReplyVO read(int reply_seq);

	public int delete(int reply_seq);

	public int update(FreeBoardReplyVO vo);

	public List<FreeBoardReplyVO> getListWithPaging(@Param("cri") FreeBoardCriteria cri,
			@Param("free_seq") int free_seq);

}
