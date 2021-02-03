package org.zerock.product.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ProductVO {
	//등록시하드코딩
	private int product_seq;
	//
	private String product_name;
	private int product_price;
	private int product_quantity;
	private String product_seller;
	private String product_filename;
	private String product_info;
	private int category_seq;
	//default가 정해져있는 컬럼
	private int product_readcnt;
	private int product_status;
	private Date product_regdate;
	private Date product_updatedate;
	
}
