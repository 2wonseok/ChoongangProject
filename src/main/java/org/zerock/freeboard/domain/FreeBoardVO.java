package org.zerock.freeboard.domain;

import java.util.Date;

import lombok.Data;

@Data
public class FreeBoardVO {
	private String free_title;
	private String free_content;
	private String free_writer;
	private int free_notice;
	private int free_readcnt;
	private Date regdate;
	private Date updatedate;
	
}
