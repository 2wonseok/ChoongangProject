package org.zerock.freeboard.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class FreeBoardPageDTO {

		
		private int startPage;
		private int endPage;
		
		private boolean prev;
		private boolean next;
		
		private int total;
		
		private FreeBoardCriteria cri;
		
		public FreeBoardPageDTO(FreeBoardCriteria cri, int total) {
			this.cri =cri;
			this.total = total;
			
			this.endPage = (int) Math.ceil(cri.getPageNum() / 10.0) * 10;
			this.startPage = endPage - 9;
			
			int realEnd = (int) Math.ceil(total * 1.0 / cri.getAmount());
			
			endPage = Math.min(realEnd, endPage);
			
			this.prev = this.startPage > 1;
			this.next = endPage < realEnd;
		}
	}







