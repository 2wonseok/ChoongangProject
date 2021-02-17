package org.zerock.qaboard.domain;

import java.time.temporal.ChronoUnit;
import java.util.Date;

import lombok.Data;

@Data
public class QaVO {
	
	// 테이블의 칼럼 구조를 반영. (테이블에 해당하는 필드 생성)
	
	// TBL_QABOARD 의 칼럼 
	
	//	qa_seq NUMBER(10) PRIMARY KEY,
	//	qa_category VARCHAR(50) NOT NULL,
	//	qa_title VARCHAR2(50) NOT NULL,
	//	qa_writer VARCHAR2(30) NOT NULL,
	//	qa_readcnt NUMBER(10) DEFAULT 0,
	//	qa_content VARCHAR2(3000) NOT NULL,
	//	qa_secret VARCHAR2(50) DEFAULT '공개',
	//	qa_status VARCHAR2(50) DEFAULT '답변 예정',
	//	qa_filename VARCHAR2(3000),
	//	qa_replycnt NUMBER(10) DEFAULT 0,
	//	qa_regdate DATE,
	//	qa_updatedate DATE
	
	// 칼럼의 데이터를 @Data(lombok 라이브러리) 어노테이션을 이용해 
	// get, set 메소드를 생성.
	
	private int qa_seq;	
	private String qa_category;
	private String qa_title;
	private String qa_writer;
	private int qa_readcnt;
	private String qa_content;
	private String qa_secret;
	private String qa_status;
	private String qa_filename;
	private Date qa_regdate;
	private Date qa_updatedate;	
	private int qa_replycnt;
	private int qa_replycnt_admin;
	private String qa_password;
	
	public Date getQa_regdateKST() {
		return Date.from(qa_regdate.toInstant().plus(9, ChronoUnit.HOURS));
	}
	
	public Date getQa_updatedateKST() {
		return Date.from(qa_updatedate.toInstant().plus(9, ChronoUnit.HOURS));
	}
}
