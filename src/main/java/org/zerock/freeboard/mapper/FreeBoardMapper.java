package org.zerock.freeboard.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.freeboard.domain.FreeBoardCriteria;
import org.zerock.freeboard.domain.FreeBoardVO;

public interface FreeBoardMapper {

	public int getTotalCount(FreeBoardCriteria cri);
	

	public List<FreeBoardVO> getList();

	public List<FreeBoardVO> getListWithPaging(FreeBoardCriteria cri);

	public void insert(FreeBoardVO freeboard);
	
	public void insertSelectKey(FreeBoardVO freeboard);

	public FreeBoardVO read(Long free_seq);

	public int delete(Long free_seq);

	public int update(FreeBoardVO freeboard);


	public void updateReplyCnt(@Param("free_seq") Long free_seq, @Param("amount") int amount);

	

}