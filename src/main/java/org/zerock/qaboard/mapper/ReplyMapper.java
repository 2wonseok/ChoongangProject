package org.zerock.qaboard.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.qaboard.domain.Criteria;
import org.zerock.qaboard.domain.ReplyVO;

public interface ReplyMapper {
		
	public ReplyVO read(int seq);
	
	public int delete(int seq);
	
	public int insert(ReplyVO reply);		
	
	public int update(ReplyVO reply);
	
	public List<ReplyVO> getListWithPaging(
			@Param("cri") Criteria cri,	
			@Param("boardname") String boardname, 
			@Param("seq") int seq); 
}
