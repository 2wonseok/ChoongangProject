package org.zerock.user.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;
import org.zerock.product.domain.OrderVO;
import org.zerock.product.domain.ProductVO;
import org.zerock.user.domain.Criteria;
import org.zerock.user.domain.UserVO;

public interface UserService {
	
	public void register(UserVO user);
	
	public List<UserVO> getList(Criteria cri);
	
	public int getTotal(Criteria cri);
	
	public boolean update(UserVO user);
	
	public boolean delete(int seq);
	
	public int idCheck(String user_id);
	
	public int nickCheck(String user_nickname);
	
	public UserVO getUser(String user_id);
	
	public UserVO getUserSeq(int user_seq);
	
	public UserVO findUser(String user_phone);
	
	public void gradeUpdate(UserVO user);
	
	public void pointUpdate(UserVO user);
	
	public void smsService(String user_phone, String cerNum);
	
	public void smsSubmit(String user_phone, String smsContent);
	
	public void userRemove(String user_id);
	
	public int modifyPw(UserVO user);
	
	public List<OrderVO> orderList(@Param("order_userseq") int order_userseq, @Param("cri") Criteria cri);
	
	public List<OrderVO> cartList(@Param("order_userseq") int order_userseq, @Param("cri") Criteria cri);
	
	public List<ProductVO> productList(@Param("user_nickname") String user_nickname, @Param("cri") Criteria cri);
	
}
