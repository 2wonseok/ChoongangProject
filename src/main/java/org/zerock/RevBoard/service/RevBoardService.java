package org.zerock.RevBoard.service;

import java.util.List;

import org.zerock.RevBoard.domain.RevVO;

public interface RevBoardService {
	
	public void register(RevVO revVo);
	
<<<<<<< HEAD
	public List<RevVO> getList();
	
=======
	public List<RevVO> getListWithPaging(Criteria cri);
	
	public int getTotal(Criteria cri);
	 
>>>>>>> 9646102... 0203minju1909
	public RevVO get(int rev_seq);
	
	public boolean moidfy(RevVO revVo);
	
	public boolean remove(int rev_seq);
	
	public int countReadCnt(int rev_seq);
	
	public void addReadCnt(int rev_seq);
}
