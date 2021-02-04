package org.zerock.freeboard.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.freeboard.domain.FreeBoardCriteria;
import org.zerock.freeboard.domain.FreeBoardVO;
import org.zerock.freeboard.mapper.FreeBoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


//@Component
@Service
@AllArgsConstructor
@Log4j
public class FreeBoardServiceImpl implements FreeBoardService {

private FreeBoardMapper mapper;
	
	@Override
	public void register(FreeBoardVO freeVO) {
		mapper.insertSelectKey(freeVO);
	}
	
	
//	@Override
//	public List<FreeBoardVO> getList() {
//		return mapper.getList();
//	}

	
	@Override
	public List<FreeBoardVO> getList(FreeBoardCriteria cri) {
		return mapper.getListWithPaging(cri);
	}
	
	@Override
	public FreeBoardVO get(Long free_seq) {
		return mapper.read(free_seq);
	}
	
	@Override
	public boolean remove(Long free_seq) {
		return mapper.delete(free_seq) == 1;
	}
	
	@Override
	public boolean modify(FreeBoardVO freeVO) {
		return mapper.update(freeVO) == 1;
	}
	
	@Override
	public int getTotal(FreeBoardCriteria cri) {
		return mapper.getTotalCount(cri);
	}
	
}
