package org.zerock.RevBoard.domain;

import java.time.temporal.ChronoUnit;
import java.util.Date;

import lombok.Data;

@Data
public class RevVO {
	private int rev_seq;
	private String rev_category;
	private String rev_title;
	private String rev_content;
	private String rev_writer;
	private int rev_readCnt;
	private String rev_filename;
	private int rev_good;
	private int rev_hate;
	private Date rev_regdate;
	private Date rev_updatedate;
	private int rev_replyCnt;
	
	public Date getRev_regdate() {
		return Date.from(rev_regdate.toInstant().plus(9, ChronoUnit.HOURS)); // rev_regdate의 시간 = oracle cloud의 시간 즉 현재와 9시간차이
	}																		 // 그래서 ChronoUnit.HOURS 는 oracle cloud의 시간을 가져와줌
																			 // 거기에 plus 9 를해줌으로 현재시간을 가져와주는듯함.
	public Date getRev_updatedateKST() {
		return Date.from(rev_updatedate.toInstant().plus(9, ChronoUnit.HOURS));
	}
}
