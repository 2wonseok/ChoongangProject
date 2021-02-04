package org.zerock.product.domain;

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
		
		//          startPage    endPage
		// 1~10 ->      1          10
		//11~20 ->     11          20
		//   n  ->            ceil(n/10)*10
		
		// 1~5 ->       1           5
		// 6~10 ->      6          10
		//   n  ->            (ceil(abs(n/5)-1)+1)*5
		
		/*
		this.endPage = (int) Math.ceil(cri.getPageNum() /10.0) *10;
		this.startPage = endPage-9;
		*/
		
		this.endPage = (int) (Math.ceil(Math.abs(cri.getPageNum()/5.0)-1)+1) *5;
		this.startPage = endPage-4;
		
		
		int realEnd = (int) Math.ceil(total*1.0 /cri.getAmount());
		//마지막 페이지가 10단위로 안끝날경우 마지막페이지를 결정

		endPage = Math.min(realEnd, endPage);
		
		this.prev = this.startPage > 1;
		this.next = endPage < realEnd;
	}
}
