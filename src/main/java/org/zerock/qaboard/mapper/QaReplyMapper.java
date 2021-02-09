package org.zerock.qaboard.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.qaboard.domain.Criteria;
import org.zerock.qaboard.domain.QaReplyVO;


public interface QaReplyMapper {

	public List<QaReplyVO> getList(
			Criteria cri, 
			@Param("reply_boardseq") int qa_seq);
	
	public int insertSelectKey(QaReplyVO board);
	
	public int delete(int reply_seq);
	
	public int update(QaReplyVO reply);
}
