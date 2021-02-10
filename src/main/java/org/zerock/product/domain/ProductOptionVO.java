package org.zerock.product.domain;

import lombok.Data;

@Data
public class ProductOptionVO {
	private int productOption_seq;
	private int product_seq;
	private String po_name;
	private int po_quantity;
	private int po_price;
	
}
