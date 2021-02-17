package org.zerock.freeboard.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FreeBoardCriteria {
	
	//페이지넘버
	private int pageNum;
	//페이지당 갯수
	private int amount;
	private String type;
	private String keyword;

	public FreeBoardCriteria() {
		this(1, 10);		
	}

	public FreeBoardCriteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public String[] getTypeArr() {
		if (this.type == null) {
			return new String[] {};
		} else {
			return type.split("");
		}
	}

	public FreeBoardCriteria(int pageNum, int amount, String type, String keyword) {
		super();
		this.pageNum = pageNum;
		this.amount = amount;
		this.type = type;
		this.keyword = keyword;
	}
}
