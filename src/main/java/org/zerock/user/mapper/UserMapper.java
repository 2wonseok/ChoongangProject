package org.zerock.user.mapper;

import java.util.List;

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
	
	public void pointUpdate(UserVO user);
	
	public void userRemove(String user_id);
}
