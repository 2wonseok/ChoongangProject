package org.zerock.freeboard.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FreeBoardCriteria {

	private int pageNum;
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
}
