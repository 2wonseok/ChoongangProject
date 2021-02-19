package org.zerock.RevBoard.service;

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
	
	// 글 생성
	@Override
	public void register(RevVO revVo) {
		mapper.insertSelectKey(revVo);
		
	}
	
	// 글의 총 갯수
	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}
	 
	// 글 리스트 페이징
	@Override
	public List<RevVO> getListWithPaging(Criteria cri) {
		return mapper.getListWithPaging(cri);
	}
	
	// 글 하나 읽어옴
	@Override
	public RevVO get(int rev_seq) {
		
		return mapper.read(rev_seq);
	}
	
	// 글 수정하기
	@Override
	public boolean moidfy(RevVO revVo) {
		return mapper.update(revVo) == 1;
	}
	
	// 글 삭제하기
	@Override
	public boolean remove(int rev_seq) {
		
		return mapper.delete(rev_seq) == 1;
	}
	
	// 조회수 총 수
	@Override
	public int countReadCnt(int rev_seq) {
		return mapper.countReadCnt(rev_seq);
	}
	
	// 조회수 증가
	@Override
	public int addReadCnt(int rev_seq) {
		return mapper.addReadCnt(rev_seq);
	}
	
	// 좋아요 총 수
	@Override
	public int countGood(int rev_seq) {
		return mapper.countGood(rev_seq);
	}
	
	// 좋아요 증가
	@Override
	public int addGood(int rev_seq) {
		return mapper.addGood(rev_seq);
	}
	
	// 싫어요 증가
	@Override
	public int addHate(int rev_seq) {
		return mapper.addHate(rev_seq);
	}
	
	// 이용자가 후기게시판에 글을 몇개썻는지
	@Override
	public int boardSelect(String rev_writer) {
		return mapper.boardSelect(rev_writer);
	}
	
	// 포인트 50만원 증정
	@Override
	public void pointUpdate(String user_id) {
		mapper.pointUpdate(user_id);
	}
	
	// 좋아요시 like_check 컬럼에 +1 을 해서 이미 좋아요를 했다고 표시
	@Override
	public void goodCheck(int rev_seq, int user_seq) {
		mapper.goodCheck(rev_seq, user_seq);
		
	}
	//goodcheck 테이블 읽어오기
	@Override
	public int checkread(int user_seq, int rev_seq) {
		return mapper.checkread(user_seq, rev_seq);
	}
	
	// 좋아요 체크 행 생성 (중복 체크 )
	@Override
	public void insertCheck(GoodCheck goodCheck) {
		mapper.insertCheck(goodCheck);
	}
	
	// 싫어요 시 그 글의 hate_check행에 +1 을해서 이미 싫어요를 했다고 체크
	@Override
	public void hateCheck(int user_seq, int rev_seq) {
		mapper.hateCheck(user_seq, rev_seq);
	}
	
	// 싫어요 체크 행 읽어옴 ( 중복 방지 )
	@Override
	public int hatecheckread(int user_seq, int rev_seq) {
		return mapper.hatecheckread(user_seq, rev_seq);
	}
	
	// 싫어요 체크 행 생성 (싫어요 중복 체크 )
	@Override
	public void hateinsertCheck(HateCheck hateCheck) {
		mapper.hateinsertCheck(hateCheck);
	}
	
	// 글 삭제시 함께 삭제하기위함 ( 글만 삭제시에 부모 컬럼이 걸림)
	@Override
	public int goodCheckremove(int rev_seq) {
		return mapper.goodCheckremove(rev_seq);
	}
	
	// 글 삭제시 함께 삭제하기위함 ( 글만 삭제시에 부모 컬럼이 걸림)
	@Override
	public int hateCheckremove(int rev_seq) {
		return mapper.hateCheckremove(rev_seq);
	}
	// 좋아요 취소시 행삭제 
	@Override
	public void goodCheck_cancel(int user_seq, int rev_seq) {
		mapper.goodCheck_cancel(user_seq, rev_seq);
		
	}
	// 좋아요 취소시 reviewboard 에 good - 1
	@Override
	public int goodCancel(int rev_seq) {
		
		return mapper.goodCancel(rev_seq);
	}
	
	// 싫어요 취소시 reviceboard 에 hate - 1
	@Override
	public int hateCancel(int rev_seq) {
		return mapper.hateCancel(rev_seq);
	}
	
	// 싫어요 취소시 행삭제
	@Override
	public void hateCheck_cancel(int user_seq, int rev_seq) {
		mapper.hateCheck_cancel(user_seq, rev_seq);
	}
	
}