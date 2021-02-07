package org.zerock.qaboard.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.qaboard.domain.Criteria;
import org.zerock.qaboard.domain.ReplyVO;


public interface ReplyMapper {

	public List<ReplyVO> getList(
			Criteria cri, 
			@Param("reply_boardseq") int qa_seq);
	

	
}
