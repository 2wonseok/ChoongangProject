package org.zerock.product.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.product.domain.Criteria;
import org.zerock.product.domain.ProductVO;
import org.zerock.product.mapper.ProductMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class ProductServiceImpl implements ProductService {

	private ProductMapper mapper;

	@Override
	public void register(ProductVO product) {
		mapper.insert(product);
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
	public boolean modify(ProductVO product) {
		return mapper.update(product) ==1;
	}
	
	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}

}
