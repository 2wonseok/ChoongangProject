package org.zerock.qaboard.service;

import java.util.List;

import org.zerock.qaboard.domain.Criteria;
import org.zerock.qaboard.domain.QaVO;

public interface QaService {
	
	public void register(QaVO board);
	
//	public List<BoardVO> getlist();
	
	public List<QaVO> getList(Criteria cri);
	
	public QaVO get(int seq);
	
	public boolean remove (int seq);
	
	public boolean modify (QaVO board);
	
	public int getTotal(Criteria cri);

	public void addCnt(int qa_seq);
		
	public int readCnt(int qa_seq);	
	

}
