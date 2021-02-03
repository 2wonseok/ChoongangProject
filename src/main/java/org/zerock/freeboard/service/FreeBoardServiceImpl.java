package org.zerock.freeboard.service;

import java.util.List;

import org.springframework.stereotype.Service;
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
	public void register(FreeBoardVO board) {
		mapper.insertSelectKey(board);
	}
	
	/*
	@Override
	public List<BoardVO> getList() {
		return mapper.getList();
	}
	*/
	
//	@Override
//	public List<FreeBoardVO> getList(Criteria cri) {
//		return mapper.getListWithPaging(cri);
//	}
	
	@Override
	public FreeBoardVO get(Long bno) {
		return mapper.read(bno);
	}
	
	@Override
	public boolean remove(Long bno) {
		return mapper.delete(bno) == 1;
	}
	
	@Override
	public boolean modify(FreeBoardVO board) {
		return mapper.update(board) == 1;
	}
	
//	@Override
//	public int getTotal(Criteria cri) {
//		return mapper.getTotalCount(cri);
//	}
}
