package org.zerock.qaboard.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.qaboard.domain.Criteria;
import org.zerock.qaboard.domain.QaVO;
import org.zerock.qaboard.mapper.QaMapper;


import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class QaServiceImpl implements QaService {

	private QaMapper mapper;
	
//	@Autowired
//	public BoardServiceImpl(BoardMapper mapper) {
//		this.mapper = mapper;
//	}
	@Override
	public void register(QaVO board) {
		mapper.insertSelectKey(board);
	}	

	
	@Override
	public List<QaVO> getList(Criteria cri) {
		return mapper.getListWithPaging(cri);
	}
	
	@Override
	public QaVO get(int seq) {
		return mapper.read(seq);
	}
	
	@Override
	public boolean remove(int seq) {
		
		return mapper.delete(seq) == 1;
	}
	
	@Override
	public boolean modify(QaVO board) {
		
		return mapper.update(board) == 1;
	}
	
	@Override
	public int getTotal(Criteria cri) {		
		return mapper.getTotalCount(cri);
	}
}
