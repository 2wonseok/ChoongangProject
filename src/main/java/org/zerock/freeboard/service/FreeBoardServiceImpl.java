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
	
	/*
	//@Autowired
	public BoardServiceImpl(BoardMapper mapper) {
		this.mapper = mapper;
	}
	*/
	
	// mapper.read(33);
	
	@Override
	public void register(FreeBoardVO freeboard) {
		mapper.insertSelectKey(freeboard);
	}
	
	
	@Override
	public List<FreeBoardVO> getList() {
		return mapper.getList();
	}

	
//	@Override
//	public List<FreeBoardVO> getList(FreeBoardCriteria cri) {
//		return mapper.getListWithPaging(cri);
//	}
	
	@Override
	public FreeBoardVO get(Long seq) {
		return mapper.read(seq);
	}
//	
//	@Override
//	public boolean remove(Long seq) {
//		return mapper.delete(seq) == 1;
//	}
//	
	@Override
	public boolean modify(FreeBoardVO freeboard) {
		return mapper.update(freeboard) == 1;
	}
//	
//	@Override
//	public int getTotal(FreeBoardCriteria cri) {
//		return mapper.getTotalCount(cri);
//	}
}
