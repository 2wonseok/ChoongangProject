package org.zerock.product.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.product.domain.Criteria;
import org.zerock.product.domain.ProductOptionVO;
import org.zerock.product.domain.ProductVO;
import org.zerock.product.mapper.ProductMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class ProductServiceImpl implements ProductService {

	private ProductMapper mapper;
	
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
		
		/* 상품옵션등록-서비스로트랜잭션 */
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
	
	@Override
	public List<ProductVO> getList(Criteria cri) {
		return mapper.getListWithPaging(cri);
	}
	
	@Override
	public ProductVO get(int product_seq) {
		return mapper.read(product_seq);
	}
	
	@Override
	@Transactional
	public ProductVO getCountUp(int product_seq) {
		ProductVO vo = mapper.read(product_seq);
		mapper.readCountUp(product_seq);
		return vo;
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
