package org.zerock.product.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.product.domain.Criteria;
import org.zerock.product.domain.OrderVO;
import org.zerock.product.domain.ProductLikeVO;
import org.zerock.product.domain.ProductOptionVO;
import org.zerock.product.domain.ProductVO;
import org.zerock.product.mapper.ProductMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class ProductServiceImpl implements ProductService {

	private ProductMapper mapper;
	
	public List<OrderVO> getOrderList(String[] order_seq) {
		
		List<OrderVO> list = new ArrayList<>();
		for (int i = 0; i<order_seq.length ;i++ ) {
			OrderVO orderVO = mapper.readOrderbyOrderSeq(Integer.parseInt(order_seq[i]));
			list.add(orderVO);
		}
		return list;
	}
	
	public int checkProductLike (ProductLikeVO productLikeVO) {
		return mapper.checkProductLike(productLikeVO);
	}
	
	@Override
	@Transactional
	public int changeProductLike(ProductLikeVO productLikeVO) {
		int check = mapper.checkProductLike(productLikeVO);
		
		if(check > 0) {
			mapper.deleteProductLike(productLikeVO);
		} else {
			mapper.insertProductLike(productLikeVO);
		}
		int product_like = mapper.countUserSeqByProductSeq(productLikeVO.getProduct_seq());
		int result = mapper.updateProductLike(productLikeVO.getProduct_seq(), product_like);
		return product_like;
	}

	@Override
	@Transactional
	public int makeCart(List<OrderVO> list) {
		int count = 0;
		for(OrderVO vo : list) {
			count += mapper.insertOrder(vo);
		}
		return count;
	}
	
	@Override
	public List<ProductOptionVO> getProductOption(int product_seq) {
		return mapper.getProductOptionList(product_seq);
	}

	@Override
	public void register(ProductVO product) {
		mapper.insert(product);
	}
	
	@Override
	@Transactional
	public void registerReturn(ProductVO product, String[] po_name, String[] po_quantity, String[] po_price) {
		mapper.insertReturnSeq(product);
		
		/* 상품옵션등록-서비스로 트랜잭션 */
		//List<ProductOptionVO> optionList= new ArrayList<ProductOptionVO>(); 
		for (int i = 0; i<po_name.length ;i++ ) {
			ProductOptionVO poVO = new ProductOptionVO();
			poVO.setProduct_seq(product.getProduct_seq());
			poVO.setPo_name(po_name[i]);
			poVO.setPo_quantity(Integer.parseInt(po_quantity[i]));
			poVO.setPo_price(Integer.parseInt(po_price[i]));
			//optionList.add(poVO);
			mapper.insertProductOption(poVO);
		}
		
	}
	
	//상품대표가격받아와서 수정+총재고량 업데이트하는 함수
	public void updateProductVOOnPriceQuantity (ProductVO pVO) {
		List<ProductOptionVO> poVOList = mapper.getProductOptionList(pVO.getProduct_seq());
		pVO.setProduct_price(poVOList.get(0).getPo_price());
		
		int total = 0;
		for(ProductOptionVO poVO : poVOList) {
			total +=poVO.getPo_quantity();
		}
		pVO.setProduct_quantity(total);
	}
	
	@Override
	@Transactional
	public List<ProductVO> getList(Criteria cri) {
		List<ProductVO> list  = mapper.getListWithPaging(cri);
		//상품대표가격받아와서 수정+총재고량 업데이트
		for(ProductVO pVO : list) {
			updateProductVOOnPriceQuantity(pVO);
		}
		return list;
	}
	
	
	@Override
	public ProductVO get(int product_seq) {
		ProductVO pVO= mapper.read(product_seq);
		updateProductVOOnPriceQuantity(pVO);
		
		return pVO;
	}
	
	@Override
	@Transactional
	public ProductVO getCountUp(int product_seq) {
		ProductVO pVO = mapper.read(product_seq);
		mapper.readCountUp(product_seq);
		updateProductVOOnPriceQuantity(pVO);

		return pVO;
	}
	
	
	@Override
	public boolean remove(int product_seq) {
		return mapper.delete(product_seq) == 1;
	}
	
	@Override
	public boolean finish(int product_seq) {
		return mapper.stopSelling(product_seq) == 1;
	}
	
	@Override
	public boolean modify(ProductVO product) {
		return mapper.update(product) ==1;
	}
	
	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}

}
