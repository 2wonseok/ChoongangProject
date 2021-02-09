package org.zerock.product.service;

import java.util.List;

import org.zerock.product.domain.Criteria;
import org.zerock.product.domain.ProductVO;


public interface ProductService {
	
	public void register(ProductVO product);
	
	public List<ProductVO> getList(Criteria cri);
	 
	public ProductVO get(int product_seq);

	public ProductVO getCountUp(int product_seq);
	 
	public boolean remove(int product_seq);

	public boolean finish(int product_seq);
	
	public boolean modify(ProductVO product);
	 
	public int getTotal(Criteria cri);
	
}
