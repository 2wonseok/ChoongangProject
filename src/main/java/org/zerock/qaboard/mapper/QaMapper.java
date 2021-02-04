package org.zerock.qaboard.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.qaboard.domain.Criteria;
import org.zerock.qaboard.domain.QaVO;

public interface QaMapper {
	
	public int getTotalCount(Criteria cri);
	//	SELECT conut(*) FROM tbl_board
	
	public List<QaVO> getList();
	
	public List<QaVO> getListWithPaging(Criteria cri);
	
	public void insert(QaVO board);
	
	public void insertSelectKey(QaVO board);
	// 1. seq_board의 nextval을 먼저 조회(select)
	// 2. 조회된 nextval을 insert에서 사용
	
	public QaVO read(int seq);
	
	public int delete(int seq);
	
	public int update(QaVO board);
	
	public void updateReplyCnt(@Param("seq") int seq, @Param("amount") int amount);

	public void addCnt(int qa_seq);
	
	public int readCnt(int qa_seq);
}
