package org.zerock.RevBoard.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.RevBoard.domain.Criteria;
import org.zerock.RevBoard.domain.GoodCheck;
import org.zerock.RevBoard.domain.HateCheck;
import org.zerock.RevBoard.domain.RevVO;

public interface RevBoardService {
	
	// 글 생성
	public void register(RevVO revVo);
	
	// 글 리스트 페이징
	public List<RevVO> getListWithPaging(Criteria cri);
	
	// 글의 총 갯수
	public int getTotal(Criteria cri);
	
	// 글 하나 읽어옴
	public RevVO get(int rev_seq);
	
	// 글 수정하기
	public boolean moidfy(RevVO revVo);
	
	// 글 삭제하기
	public boolean remove(int rev_seq);
	
	// 조회수 총 수
	public int countReadCnt(int rev_seq);
	
	// 조회수 증가
	public int addReadCnt(int rev_seq);
	
	// 좋아요 총 수
	public int countGood(int rev_seq);
	
	// 좋아요 증가
	public int addGood(int rev_seq);
	
	// 좋아요 취소
	public int goodCancel(int rev_seq);
	
	// 싫어요 증가
	public int addHate(int rev_seq);
	
	// 싫어요 취소
	public int hateCancel(int rev_seq);
	
	// 이용자가 후기게시판에 글을 몇개썻는지 
	public int boardSelect(String rev_writer);
	
	// 포인트 50만원 증정 중복체크까지
	public void pointUpdate(String user_id);
	
	// 좋아요시 like_check 컬럼에 +1 을 해서 이미 좋아요를 했다고 표시
	public void goodCheck(@Param("user_seq")int user_seq, @Param("rev_seq")int rev_seq );
	
	// 좋아요 체크행을 읽어옴 ( 중복 방지 )
	public int checkread(@Param("user_seq")int user_seq, @Param("rev_seq")int rev_seq);
	
	// 좋아요 체크 행 생성 (중복 체크 )
	public void insertCheck(GoodCheck goodCheck);
	
	// 싫어요 시 그 글의 hate_check행에 +1 을해서 이미 싫어요를 했다고 체크
	public void hateCheck(@Param("user_seq")int user_seq,@Param("rev_seq") int rev_seq );
	
	// 싫어요 체크 행 읽어옴 ( 중복 방지 )
	public int hatecheckread (@Param("user_seq")int user_seq,@Param("rev_seq") int rev_seq);
	
	// 싫어요 체크 행 생성 (싫어요 중복 체크 )
	public void hateinsertCheck(HateCheck hateCheck);
	
	// 글 삭제시 함께 삭제하기위함 ( 글만 삭제시에 부모 컬럼이 걸림)
	public int goodCheckremove(int rev_seq);
	
	// 글 삭제시 함께 삭제하기위함 ( 글만 삭제시에 부모 컬럼이 걸림)
	public int hateCheckremove(int rev_seq);
	
	// 좋아요 취소시 행삭제 
	public void goodCheck_cancel(@Param("user_seq")int user_seq,@Param("rev_seq") int rev_seq ); 
	
	// 싫어요 취소시 행삭제 
	public void hateCheck_cancel(@Param("user_seq")int user_seq,@Param("rev_seq") int rev_seq );
}