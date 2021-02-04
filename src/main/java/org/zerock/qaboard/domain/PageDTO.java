package org.zerock.qaboard.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	
	private int total;
	
	private Criteria cri;
	
	public PageDTO(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;
		
//		this.endPage = (int) Math.ceil(cri.getPageNum() / 10.0) * 10;
//		this.startPage = this.endPage - 9;
		
		this.endPage = (int) Math.ceil(cri.getPageNum() / 5.0) * 5;
		this.startPage = this.endPage - 4;
		
		int realEnd = (int) Math.ceil(total * 1.0 / cri.getAmount());
		
		endPage = Math.min(realEnd, endPage);
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
	}
	
}
