package org.zerock.RevBoard.mapper;

import java.util.List;

import org.zerock.RevBoard.domain.Criteria;
import org.zerock.RevBoard.domain.RevVO;

public interface RevBoardMapper {
	
	public void insertSelectKey(RevVO rev);
	
	public List<RevVO> getListWithPaging(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	 
	public RevVO read(int rev_seq);
	
	public int delete(int rev_seq);
	
	public int update(RevVO revVo);
	
	public int countGood(int rev_seq);
	
	public int addGood(int rev_seq);
	
	public int countReadCnt(int rev_seq);
	
	public int addReadCnt(int rev_seq);
	
	public int addHate(int rev_seq);
	
	public int boardSelect(String rev_writer);
}