package org.zerock.freeboard.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.freeboard.domain.FreeBoardReplyVO;
import org.zerock.freeboard.mapper.FreeBoardMapper;
import org.zerock.freeboard.mapper.FreeBoardReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class FreeBoardReplyServiceImpl implements FreeBoardReplyService {


		@Setter(onMethod_ = @Autowired)
		private FreeBoardReplyMapper mapper;
		
		@Setter(onMethod_ = @Autowired)
		private FreeBoardMapper boardMapper;

		@Override
		@Transactional
		public int register(FreeBoardReplyVO vo) {
			
			//조회수
//			boardMapper.updateReplyCnt(vo.getBno(), 1);
			
			return mapper.insert(vo);
		}

		@Override
		public FreeBoardReplyVO get(int reply_seq) {
			return mapper.read(reply_seq);
		}

//		@Override
//		public int modify(ReplyVO vo) {
//			return mapper.update(vo);
//		}
//
//		@Override
//		@Transactional
//		public int remove(Long rno) {
//			ReplyVO vo = mapper.read(rno);
//			boardMapper.updateReplyCnt(vo.getBno(), -1);
//			return mapper.delete(rno);
//		}

//		@Override
//		public List<FreeBoardReplyVO> getList(FreeBoardCriteria cri, Long free_seq) {
//			return mapper.getListWithPaging(cri, free_seq);
//		}
	
}
