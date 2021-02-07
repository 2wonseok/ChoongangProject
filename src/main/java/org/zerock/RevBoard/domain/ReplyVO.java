package org.zerock.RevBoard.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {
	
	private int reply_seq;
	private String reply_content;
	private String reply_writer;
	private Date reply_regdate;
	private Date reply_updatedate;
	private String reply_boardname;
	private int reply_boardseq;
}
