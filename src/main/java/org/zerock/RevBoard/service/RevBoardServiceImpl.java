package org.zerock.RevBoard.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.RevBoard.domain.RevVO;
import org.zerock.RevBoard.mapper.RevBoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class RevBoardServiceImpl implements RevBoardService{
	
	private RevBoardMapper mapper;
	
	@Override
	public void register(RevVO revVo) {
		mapper.insertSelectKey(revVo);
		
	}
	
	@Override
	public List<RevVO> getList() {
		return mapper.getList();
	}
}