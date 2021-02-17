package org.zerock.freeboard.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.freeboard.domain.FreeBoardCriteria;
import org.zerock.freeboard.domain.FreeBoardVO;

public interface FreeBoardMapper {

	public int getTotalCount(FreeBoardCriteria cri);
	
	public List<FreeBoardVO> getListWithPaging(FreeBoardCriteria cri);

	public void insert(FreeBoardVO freeboard);
	
	public void insertSelectKey(FreeBoardVO freeboard);

	public FreeBoardVO read(int free_seq);

	public int delete(int free_seq);

	public int update(FreeBoardVO freeboard);

	public void updateReplyCnt(@Param("free_seq") int free_seq, @Param("amount") int amount);

	public int readCnt(int free_seq);
	
	public void addCnt(int free_seq);
	
	public void noticeRegister(FreeBoardVO freeboard);

	public List<FreeBoardVO> readNotice(FreeBoardCriteria cri);
}