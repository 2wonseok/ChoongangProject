package org.zerock.user.mapper;

import java.util.List;

import org.zerock.user.domain.Criteria;
import org.zerock.user.domain.UserVO;

public interface UserMapper {
	
	public void insert(UserVO user);
	
	public List<UserVO> getListWithPaging(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	
	public UserVO read(int seq);
	
	public int update(UserVO user);
	
	public int delete(int seq);
	
	public int idCheck(String user_id);
}
