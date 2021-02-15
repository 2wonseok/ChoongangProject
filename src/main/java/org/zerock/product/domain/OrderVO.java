package org.zerock.product.domain;

import java.util.Date;

import lombok.Data;

@Data
public class OrderVO {
	/* 생성시시퀀스항목 */
	private int order_seq;
	/* 디폴트값이있는항목 */
	private int order_status;
	private Date order_date;
	
	private int order_productseq;
	/* 구매시 리스트로 들어오는것(참조용) */
	private int order_poseq;
	private String order_poname;
	private int order_poprice;
	private int order_quantity;
	
	private int order_userseq;
	private String order_username;
	private String order_useraddress;
	private String order_userphone;
}
