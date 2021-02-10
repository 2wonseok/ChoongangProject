package org.zerock.freeboard.domain;

import java.util.Date;

import lombok.Data;

@Data
public class FreeBoardVO {
	//게시글 번호
	private int free_seq;
	//게시판 제목
	private String free_title;
	//게시판 내용
	private String free_content;
	//작성자
	private String free_writer;
	//닉네임
	private String free_nickname;
	//공지사항
	private int free_notice;
	//조회수
	private int free_readCnt;
	//작성일
	private Date free_regdate;
	//수정일
	private Date free_updatedate;
	
}
