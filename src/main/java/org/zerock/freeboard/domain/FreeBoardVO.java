package org.zerock.freeboard.domain;

import java.util.Date;

import lombok.Data;

@Data
public class FreeBoardVO {
	//게시글 번호
	private long free_seq;
	//게시판 제목
	private String free_title;
	//게시판 내용
	private String free_content;
	//작성자
	private String free_writer;
	//공지사항
	private int free_notice;
	//조회수
	private int free_readcnt;
	//작성일
	private Date regdate;
	//수정일
	private Date updatedate;
	
}
