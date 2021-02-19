package org.zerock.product.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.zerock.product.domain.Criteria;
import org.zerock.product.domain.OrderVO;
import org.zerock.product.domain.ProductLikeVO;
import org.zerock.product.domain.ProductOptionVO;
import org.zerock.product.domain.ProductVO;

public interface ProductMapper {
	
	/* product */
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
	
		public int updateProductLike(@Param("product_seq") int product_seq, @Param("product_like") int product_like);
	
	/* ProductOpition */
		public List<ProductOptionVO> getProductOptionList(int product_seq);
		
		public void insertProductOption(ProductOptionVO productOption);
	
		public int insertOrder(OrderVO orderVO);
	
	/* ProductLike */
		public void insertProductLike(ProductLikeVO productLikeVO);
	
		public int countUserSeqByProductSeq(int product_seq);
	
		public int checkProductLike(ProductLikeVO productLikeVO);
		
		public void deleteProductLike(ProductLikeVO productLikeVO);
		
	/* order */
		public OrderVO readOrderbyOrderSeq(int order_seq);

		public int updateOrder(String[] order_seq);
	
	
}
