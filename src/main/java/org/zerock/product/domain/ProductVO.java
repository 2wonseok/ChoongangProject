package org.zerock.product.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ProductVO {
	private int product_seq;
	private String product_name;
	private int product_price;
	private int product_quantity;
	private String product_seller;
	private String product_filename;
	private String product_info;
	private int product_readcnt;
	private String product_status;
	private Date product_regdate;
	
}
