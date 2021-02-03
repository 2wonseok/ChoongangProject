package org.zerock.RevBoard.mapper;

import java.util.List;

import org.zerock.RevBoard.domain.RevVO;

public interface RevBoardMapper {
	
	public void insertSelectKey(RevVO rev);
	
<<<<<<< HEAD
	public List<RevVO> getList();
	
=======
	public List<RevVO> getListWithPaging(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	 
>>>>>>> 9646102... 0203minju1909
	public RevVO read(int rev_seq);
	
	public int delete(int rev_seq);
	
	public int update(RevVO revVo);
	
	public int countGood(int rev_seq);
	
	public int AddGood(int rev_seq);
	
	public int countReadCnt(int rev_seq);
	
	public void addReadCnt(int rev_seq);
}