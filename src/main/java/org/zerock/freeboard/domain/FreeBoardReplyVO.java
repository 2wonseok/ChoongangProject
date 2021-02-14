package org.zerock.freeboard.domain;

import java.util.Date;

import lombok.Data;

@Data
public class FreeBoardReplyVO {


//	PK 댓글번호
//	게시판 번호
//	댓글 내용
//	댓글 작성자
//	댓글 작성일
//	댓글 수정일
//	댓글 게시판이름
//  댓글 작성자의 닉네임
	private int reply_seq;
	private int reply_boardseq;
	private String reply_content;
	private String reply_writer;
	private Date reply_regdate;
	private Date reply_updatedate;
	private String reply_boardname;
	private String reply_nickname;
	
}
