package org.zerock.product.mapper;

import org.zerock.product.domain.ProductVO;

public interface ProductMapper {

	public void insert(ProductVO product);
	
	public ProductVO read(int productSeq);
	
	public int delete(int productSeq);
	
	//수정 시 영향받는 항목
	//product_name, product_filename, product_info
	public int update(ProductVO product);
	
	
	/*
	 * public int getTotalCount(Criteria cri); // SELECT count(*) FROM tbl_board
	 * 
	 * @Select("select * from tbl_board where bno > 0") public List<BoardVO>
	 * getList();
	 * 
	 * public List<BoardVO> getListWithPaging(Criteria cri);
	 * 
	 * 
	 * 
	 * public void insertSelectKey(BoardVO board); //1. seq_board의 nextval을 먼저
	 * 조회(select) //2. 조회된 nextval을 insert에서 사용
	 * 
	 * 
	 * 
	 * 
	 * 
	 * public int update(BoardVO board);
	 * 
	 * //reply수가 업데이트 될때 변경 public void updateReplyCnt(@Param("bno") Long
	 * bno, @Param("amount") int amount);
	 */
}
