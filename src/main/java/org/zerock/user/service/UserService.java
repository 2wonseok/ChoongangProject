package org.zerock.user.service;

import java.util.List;

import org.zerock.user.domain.Criteria;
import org.zerock.user.domain.UserVO;

public interface UserService {
	
	public void register(UserVO user);
	
	public List<UserVO> getList(Criteria cri);
	
	public int getTotal(Criteria cri);
	
	public UserVO read(int seq);
	
	public boolean update(UserVO user);
	
	public boolean delete(int seq);
}
