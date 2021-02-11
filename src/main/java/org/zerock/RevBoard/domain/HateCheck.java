package org.zerock.RevBoard.domain;

import lombok.Data;

@Data
public class HateCheck {
	private int hateno;
	private int rev_seq;
	private int user_seq;
	private int hate_check;
}
