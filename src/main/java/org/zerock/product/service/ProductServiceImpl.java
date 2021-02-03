package org.zerock.product.service;

import java.util.List;

import org.springframework.stereotype.Service;
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
		
	
	/*
	 * 
	 * @Override public List<BoardVO> getList() { return mapper.getList(); }
	 * 
	 * 
	 * @Override public List<BoardVO> getList(Criteria cri) { return
	 * mapper.getListWithPaging(cri); }
	 * 
	 * @Override public BoardVO get(Long bno) { return mapper.read(bno); }
	 * 
	 * @Override public boolean remove(Long bno) { return mapper.delete(bno) == 1; }
	 * 
	 * @Override public boolean modify(BoardVO board) { return mapper.update(board)
	 * ==1; }
	 * 
	 * @Override public int getTotal(Criteria cri) { return
	 * mapper.getTotalCount(cri); }
	 */

}
