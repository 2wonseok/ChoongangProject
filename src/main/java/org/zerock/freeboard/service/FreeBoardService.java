package org.zerock.freeboard.service;

import java.util.List;

import org.zerock.freeboard.domain.FreeBoardVO;


public interface FreeBoardService {

public void register(FreeBoardVO board);
	
	// public List<BoardVO> getList();
	
//	public List<FreeBoardVO> getList(Criteria cri);
	
	public FreeBoardVO get(Long bno);
	
	public boolean remove(Long bno);
	
	public boolean modify(FreeBoardVO board);
	
//	public int getTotal(Criteria cri);
	
}
