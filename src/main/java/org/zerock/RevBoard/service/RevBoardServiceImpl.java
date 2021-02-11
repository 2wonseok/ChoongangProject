package org.zerock.RevBoard.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.RevBoard.domain.Criteria;
import org.zerock.RevBoard.domain.GoodCheck;
import org.zerock.RevBoard.domain.HateCheck;
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
		return mapper.countReadCnt(rev_seq);
	}
	
	@Override
	public int addReadCnt(int rev_seq) {
		return mapper.addReadCnt(rev_seq);
	}
	
	@Override
	public int countGood(int rev_seq) {
		return mapper.countGood(rev_seq);
	}
	
	@Override
	public int addGood(int rev_seq) {
		return mapper.addGood(rev_seq);
	}
	
	@Override
	public int addHate(int rev_seq) {
		return mapper.addHate(rev_seq);
	}
	
	@Override
	public int boardSelect(String rev_writer) {
		return mapper.boardSelect(rev_writer);
	}
	
	@Override
	public void pointUpdate(String user_id) {
		mapper.pointUpdate(user_id);
		
	}
	
	@Override
	public void goodCheck(int rev_seq, int user_seq) {
		mapper.goodCheck(rev_seq, user_seq);
		
	}
	//goodcheck 테이블 읽어오기
	@Override
	public int checkread(int user_seq, int rev_seq) {
		return mapper.checkread(user_seq, rev_seq);
	}
	
	@Override
	public void insertCheck(GoodCheck goodCheck) {
		mapper.insertCheck(goodCheck);
	}
	
	@Override
	public void hateCheck(int user_seq, int rev_seq) {
		mapper.hateCheck(user_seq, rev_seq);
	}
	
	@Override
	public int hatecheckread(int user_seq, int rev_seq) {
		return mapper.hatecheckread(user_seq, rev_seq);
	}
	
	@Override
	public void hateinsertCheck(HateCheck hateCheck) {
		mapper.hateinsertCheck(hateCheck);
	}
}