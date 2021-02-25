package org.zerock.user.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;
import org.zerock.product.domain.OrderVO;
import org.zerock.product.domain.ProductVO;
import org.zerock.user.domain.Criteria;
import org.zerock.user.domain.UserVO;

public interface UserMapper {
	
	public void insert(UserVO user);
	
	public List<UserVO> getListWithPaging(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	
	public int update(UserVO user);
	
	public int delete(int seq);
	
	public int idCheck(String user_id);
	
	public int nickCheck(String user_nickname);
	
	public UserVO getUser(String user_id);
	
	public UserVO getUserSeq(int user_seq);
	
	public UserVO findUser(String user_phone);
	
	public void gradeUpdate(UserVO user);
	
	public void userRemove(String user_id);
	
	public int modifyPw(UserVO user);
	
	public List<OrderVO> orderList(@Param("order_userseq") int order_userseq, @Param("cri") Criteria cri);
	
	public List<OrderVO> cartList(@Param("order_userseq") int order_userseq, @Param("cri") Criteria cri);
	
	public List<ProductVO> productList(@Param("user_nickname") String user_nickname, @Param("cri") Criteria cri);

	public List<OrderVO> orderInfo(int order_productseq);
	
	public List<OrderVO> sendList(int order_productseq);

	public int getTotalOrderList(@Param("order_userseq") int order_userseq, @Param("cri") Criteria cri);

	public int getTotalCartList(@Param("order_userseq") int order_userseq, @Param("cri") Criteria cri);
	
	public int getTotalProductList(@Param("user_nickname") String user_nickname, @Param("cri") Criteria cri);
	
	public int getTotalOrderInfoList(@Param("order_productseq") int order_productseq, @Param("cri") Criteria cri);

	public void productSend(@Param("order_seq") int order_seq, @Param("cir") Criteria cri);
	
	public OrderVO getOrderInfo(int order_seq);
	
	public ProductVO getProductInfo(int product_seq);
	
	public void orderDel(int order_seq);
	
	public void deleteGoodCheck(int user_seq);
	
	public void deleteHateCheck(int user_seq);
	
}
