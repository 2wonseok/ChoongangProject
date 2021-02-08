package org.zerock.freeboard.domain;

import java.util.Date;

import lombok.Data;

@Data
public class FreeBoardReplyVO {


	//PK
	private int reply_seq;
	private int reply_boardseq;
	private String reply_content;
	private String reply_writer;
	private Date reply_regdate;
	private Date reply_updatedate;
	private String reply_boardname;
	
}
