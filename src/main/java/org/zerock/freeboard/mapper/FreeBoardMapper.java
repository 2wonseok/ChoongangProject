package org.zerock.freeboard.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.freeboard.domain.FreeBoardCriteria;
import org.zerock.freeboard.domain.FreeBoardVO;

public interface FreeBoardMapper {

//	public int getTotalCount(FreeBoardCriteria cri);
//	 SELECT count(*) FROM tbl_board

	public List<FreeBoardVO> getList();

//	public List<FreeBoardVO> getListWithPaging(FreeBoardCriteria cri);

//	public void insert(FreeBoardVO freeboard);
	/*
	 * { String sql = "INSERT INTO tbl_board" +
	 * " (bno, title, content, writer, regdate, updatedate) " +
	 * " VALUES (seq_board.nextval, ?, ?, ?, SYSDATE, SYSDATE)";
	 * 
	 * PreparedStatement pstmt = con.prepareStatement(sql);
	 * 
	 * pstmt.setString(1, board.getTitle()); pstmt.setString(2, board.getContent());
	 * pstmt.setString(3, board.getWriter());
	 * 
	 * pstmt.updateQuery();
	 * 
	 * close(); }
	 */
//
	
	public void insertSelectKey(FreeBoardVO freeboard);
	// 1. seq_board의 nextval을 먼저 조회(select)
	// 2. 조회된 nextval을 insert에서 사용


	public FreeBoardVO read(Long free_seq);

//	public int delete(Long free_seq);

	public int update(FreeBoardVO freeboard);

//	public void updateReplyCnt(@Param("seq") Long free_seq, @Param("amount") int amount);

	

}