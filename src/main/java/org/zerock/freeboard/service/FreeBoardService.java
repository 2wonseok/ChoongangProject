package org.zerock.freeboard.service;

import java.util.List;

import org.zerock.freeboard.domain.FreeBoardCriteria;
import org.zerock.freeboard.domain.FreeBoardVO;


public interface FreeBoardService {

//public void register(FreeBoardVO freeboard);
	
	 public List<FreeBoardVO> getList();
	
//	public List<FreeBoardVO> getList(FreeBoardCriteria cri);
//	
//	public FreeBoardVO get(Long seq);
//	
//	public boolean remove(Long seq);
//	
//	public boolean modify(FreeBoardVO freeboard);
//	
//	public int getTotal(FreeBoardCriteria cri);
	
}
