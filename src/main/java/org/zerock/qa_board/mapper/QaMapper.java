package org.zerock.qa_board.mapper;

import java.util.List;

import org.zerock.qa_board.domain.Criteria;
import org.zerock.qa_board.domain.QaVO;

public interface QaMapper {

	public List<QaVO> getlist();
	
	public int getTotalCount(Criteria cri);
	
}
