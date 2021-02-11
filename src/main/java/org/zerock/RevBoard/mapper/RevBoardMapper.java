package org.zerock.RevBoard.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.RevBoard.domain.Criteria;
import org.zerock.RevBoard.domain.GoodCheck;
import org.zerock.RevBoard.domain.HateCheck;
import org.zerock.RevBoard.domain.RevVO;

public interface RevBoardMapper {
	
	public void insertSelectKey(RevVO rev);
	
	public List<RevVO> getListWithPaging(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	 
	public RevVO read(int rev_seq);
	
	public int delete(int rev_seq);
	
	public int update(RevVO revVo);
	
	public int countGood(int rev_seq);
	
	public int addGood(int rev_seq);
	
	public int countReadCnt(int rev_seq);
	
	public int addReadCnt(int rev_seq);
	
	public int addHate(int rev_seq);
	
	public int boardSelect(String rev_writer);
	
	public void pointUpdate(String user_id);
	
	public void updateReplyCnt(@Param("reply_boardseq") int reply_boardseq, @Param("amount") int amount);
	
	public void goodCheck(@Param("user_seq")int user_seq,@Param("rev_seq") int rev_seq );
	
	public int checkread (@Param("user_seq")int user_seq,@Param("rev_seq") int rev_seq);
	
	public void insertCheck(GoodCheck goodCheck);
	
	public void hateCheck(@Param("user_seq")int user_seq,@Param("rev_seq") int rev_seq );
	
	public int hatecheckread (@Param("user_seq")int user_seq,@Param("rev_seq") int rev_seq);
	
	public void hateinsertCheck(HateCheck hateCheck);
}