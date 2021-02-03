package org.zerock.RevBoard.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@ToString
public class Criteria {
		
		private int pageNum;
		private int amount;
		
		private String type;
		private String keyword;
		
		public Criteria() { // 기본생성자.
			this(1, 5); // 1번페이지에 10개를 보여준다는뜻.
		}
		
		public Criteria(int pageNum, int amount) {
			this.pageNum = pageNum;
			this.amount = amount;
		}
		
		public String[] getTypeArr() {
			if (this.type == null) {
				return new String[] {};
			} else {
				return type.split("");		// split은  type이 TWC 일경우 [T, W, C] 로 배열타입으로 각각을 나눠줌
			}
		}
	 
}
