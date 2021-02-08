package org.zerock.qaboard.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.qaboard.domain.Criteria;
import org.zerock.qaboard.domain.QaReplyVO;
import org.zerock.qaboard.domain.QaVO;


public interface QaReplyMapper {

	public List<QaReplyVO> getList(
			Criteria cri, 
			@Param("reply_boardseq") int qa_seq);
	
	public void insert(QaReplyVO board);

	public void insertSelectKey(QaReplyVO board);
}
