package org.zerock.RevBoard.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.RevBoard.domain.Criteria;
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
		
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}
	 
	@Override
	public List<RevVO> getListWithPaging(Criteria cri) {
		return mapper.getListWithPaging(cri);
	}
	
	@Override
	public RevVO get(int rev_seq) {
		
		return mapper.read(rev_seq);
	}
	
	@Override
	public boolean moidfy(RevVO revVo) {
		return mapper.update(revVo) == 1;
	}
	
	@Override
	public boolean remove(int rev_seq) {
		
		return mapper.delete(rev_seq) == 1;
	}
	
	@Override
	public int countReadCnt(int rev_seq) {
		// TODO Auto-generated method stub
		return mapper.countReadCnt(rev_seq);
	}
	
	@Override
	public void addReadCnt(int rev_seq) {
		// TODO Auto-generated method stub
		mapper.addReadCnt(rev_seq);
	}

	@Override
	public List<RevVO> getList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void addGood(int rev_seq) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void addHate(int rev_seq) {
		// TODO Auto-generated method stub
		
	}
}