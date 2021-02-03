package org.zerock.RevBoard.mapper;

import java.util.List;

import org.zerock.RevBoard.domain.RevVO;

public interface RevBoardMapper {
	
	public void insertSelectKey(RevVO rev);
	
	public List<RevVO> getList();
}