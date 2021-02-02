package org.zerock.qa_board.domain;

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
	//	qa_secret NUMBER(1) NOT NULL,
	//	qa_status NUMBER(1) NOT NULL,
	//	qa_filename VARCHAR2(3000),
	//	qa_regdate DATE,
	//	qa_updatedate DATE	
	
	// 칼럼의 데이터를 @Data(lombok 라이브러리) 어노테이션을 이용해 
	// get, set 메소드를 생성.
	
	private int qa_Seq;	
	private String qa_Category;
	private String qa_Title;
	private String qa_Writer;
	private String qa_ReadCnt;
	private String qa_Content;
	private int qa_Secret;
	private int qa_Status;
	private String qa_FileName;
	private Date qa_RegDate;
	private Date qa_UpdateDate;
	
	
	
}
