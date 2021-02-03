package org.zerock.RevBoard.service;

import java.util.List;

import org.zerock.RevBoard.domain.RevVO;

public interface RevBoardService {
	
	public void register(RevVO revVo);
	
	public List<RevVO> getList();
	
	public RevVO get(int rev_seq);
	
	public boolean moidfy(RevVO revVo);
	
	public boolean remove(int rev_seq);
}
