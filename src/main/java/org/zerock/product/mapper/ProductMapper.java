package org.zerock.product.mapper;

import java.util.List;

import org.zerock.product.domain.Criteria;
import org.zerock.product.domain.ProductOptionVO;
import org.zerock.product.domain.ProductVO;

public interface ProductMapper {
	
	public void insert(ProductVO product);
	
	public int insertReturnSeq(ProductVO product);

	public List<ProductVO> getListWithPaging(Criteria cri);
	
	public ProductVO read(int productSeq);

	public int readCountUp(int productSeq);
	
	public int delete(int productSeq);

	public int stopSelling(int productSeq);

	//수정 시 영향받는 항목
	//product_name, product_filename, product_info
	public int update(ProductVO product);
		
	public int getTotalCount(Criteria cri);

	public List<ProductOptionVO> getProductOptionList(int product_seq);
	
	public void insertProductOption(ProductOptionVO productOption);	
	


	
	
}
