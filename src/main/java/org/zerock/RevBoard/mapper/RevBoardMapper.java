package org.zerock.RevBoard.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.RevBoard.domain.Criteria;
import org.zerock.RevBoard.domain.GoodCheck;
import org.zerock.RevBoard.domain.HateCheck;
import org.zerock.RevBoard.domain.RevVO;

public interface RevBoardMapper {
	
	// 글 등록 하기
	public void insertSelectKey(RevVO rev);
	
	// 리스트 jsp 페이징처리
	public List<RevVO> getListWithPaging(Criteria cri);
	
	// 후기게시판 글 총 갯수
	public int getTotalCount(Criteria cri);
	 
	// 글 하나 읽어오기
	public RevVO read(int rev_seq);
	
	// 글 삭제
	public int delete(int rev_seq);
	
	// 글 수정
	public int update(RevVO revVo);
	
	// 좋아요 총 수 
	public int countGood(int rev_seq);
	
	// 좋아요 증가 
	public int addGood(int rev_seq);
	
	// 좋아요 취소
	public int goodCancel(int rev_seq);
	
	// 조회수 총 수 
	public int countReadCnt(int rev_seq);
	
	// 조회수 증가
	public int addReadCnt(int rev_seq);
	
	// 싫어요 증가
	public int addHate(int rev_seq);
	
	// 싫어요 취소
	public int hateCancel(int rev_seq);
	
	// 이용자가 후기게시판에 글을 몇개썻는지 확인.
	public int boardSelect(String rev_writer);
	
	// 만약에 글을 5개 썻을경우 포인트를 50만포인트증정.
	public void pointUpdate(String user_id);
	
	
	// 리플카운터를 리스트에서 몇개인지 업데이트해줌
	public void updateReplyCnt(@Param("reply_boardseq") int reply_boardseq, @Param("amount") int amount);
	
	// 좋아요 시 그 글의 like_check행에 +1 을해서 이미 좋아요를 했다고 체크
	public void goodCheck(@Param("user_seq")int user_seq,@Param("rev_seq") int rev_seq );
	
	// 좋아요 체크 행을 읽어옴 ( 좋아요 중복방지 체크)
	public int checkread (@Param("user_seq")int user_seq,@Param("rev_seq") int rev_seq);
	
	// 좋아요 체크 행 생성 (좋아요 중복 체크를 위함)
	public void insertCheck(GoodCheck goodCheck);
	
	// 싫어요 시 그 글의 hate_check행에 +1 을해서 이미 싫어요를 했다고 체크
	public void hateCheck(@Param("user_seq")int user_seq,@Param("rev_seq") int rev_seq );
	
	// 싫어요 체크 행을 읽어옴 ( 싫어요 중복방지 체크)
	public int hatecheckread (@Param("user_seq")int user_seq,@Param("rev_seq") int rev_seq);
	
	// 싫어요 체크 행 생성 (싫어요 중복 체크를 위함)
	public void hateinsertCheck(HateCheck hateCheck);

	// 좋아요 체크 행삭제 ( 글 삭제시 함께 삭제 )
	public int goodCheckremove(int rev_seq);
	
	// 싫어요 체크 행 삭제 ( 글 삭제시 함께 삭제 )
	public int hateCheckremove(int rev_seq);
	
	// 좋아요 취소시 행삭제 
	public void goodCheck_cancel(@Param("user_seq")int user_seq,@Param("rev_seq") int rev_seq );
	
	// 싫어요 취소시 행삭제 
	public void hateCheck_cancel(@Param("user_seq")int user_seq,@Param("rev_seq") int rev_seq );
}