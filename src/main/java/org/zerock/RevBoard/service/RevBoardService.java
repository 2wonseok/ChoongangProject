package org.zerock.RevBoard.service;

import java.util.List;

import org.zerock.RevBoard.domain.Criteria;
import org.zerock.RevBoard.domain.RevVO;

public interface RevBoardService {
	
	public void register(RevVO revVo);
	
	public List<RevVO> getList();
	
	public List<RevVO> getListWithPaging(Criteria cri);
	
	public int getTotal(Criteria cri);
	 
	public RevVO get(int rev_seq);
	
	public boolean moidfy(RevVO revVo);
	
	public boolean remove(int rev_seq);
	
	public int countReadCnt(int rev_seq);
	
	public void addReadCnt(int rev_seq);
	
	public void addGood(int rev_seq);
	
	public void addHate(int rev_seq); 
}
