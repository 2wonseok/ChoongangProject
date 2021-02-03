package org.zerock.freeboard.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.freeboard.domain.FreeBoardVO;

public interface FreeBoardMapper {

//	public int getTotalCount(Criteria cri);
	// SELECT count(*) FROM tbl_board

	public List<FreeBoardVO> getList();

//	public List<FreeBoardVO> getListWithPaging(Criteria cri);

	public void insert(FreeBoardVO board);
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

	public void insertSelectKey(FreeBoardVO board);
	// 1. seq_board의 nextval을 먼저 조회(select)
	// 2. 조회된 nextval을 insert에서 사용

	public FreeBoardVO read(Long bno);

	public int delete(Long bno);

	public int update(FreeBoardVO board);

	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);

}