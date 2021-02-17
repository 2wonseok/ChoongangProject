package org.zerock.freeboard.service;

import java.util.List;

import org.zerock.freeboard.domain.FreeBoardCriteria;
import org.zerock.freeboard.domain.FreeBoardVO;

public interface FreeBoardService {

	public void register(FreeBoardVO freeboard);

//	public List<FreeBoardVO> getList();

	public List<FreeBoardVO> getList(FreeBoardCriteria cri);

	public FreeBoardVO get(int free_seq);

	public boolean remove(int free_seq);

	public boolean modify(FreeBoardVO freeboard);

	public int getTotal(FreeBoardCriteria cri);
	
	public int readCnt(int free_seq);
	
	public void addCnt(int free_seq);

	public List<FreeBoardVO> getNoticeList(FreeBoardCriteria cri);
	
}
