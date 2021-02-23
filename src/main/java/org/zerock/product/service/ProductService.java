package org.zerock.product.service;

import java.util.List;

import org.zerock.product.domain.CategoryVO;
import org.zerock.product.domain.Criteria;
import org.zerock.product.domain.OrderVO;
import org.zerock.product.domain.ProductLikeVO;
import org.zerock.product.domain.ProductOptionVO;
import org.zerock.product.domain.ProductVO;


public interface ProductService {
	
	public void register(ProductVO product);

	public void registerReturn(ProductVO product, String[] po_name, String[] po_quantity, String[] po_price);
	
	public List<ProductVO> getList(Criteria cri);
	 
	public ProductVO get(int product_seq);

	public ProductVO getCountUp(int product_seq);
	 
	public boolean remove(int product_seq);

	public boolean finish(int product_seq);
		 
	public int getTotal(Criteria cri);

	public List<ProductOptionVO> getProductOption(int product_seq);

	public int makeCart(List<OrderVO> list);
	
	public int changeProductLike(ProductLikeVO productLikeVO);
	
	public int checkProductLike(ProductLikeVO productLikeVO);
	
	public List<OrderVO> getOrderList(String[] order_seq);

	public int makeOrder(List<OrderVO> orderVOList);

	public int directOrder(List<OrderVO> orderVOList);

	public List<String> getCategoryMainList();

	public List<String> getCategorySubList(String categoryMain);

	public int getCategorySeq(CategoryVO categoryVO);

	public CategoryVO getCategoryMainAndSub(int category_seq);

	public int updateUserPoint(int user_seq, String usePoint);

	public boolean modify(ProductVO product, String[] deletePo_seqArray,
		String[] productOption_seq, String[] po_name,
		String[] po_quantity, String[] po_price);

}
