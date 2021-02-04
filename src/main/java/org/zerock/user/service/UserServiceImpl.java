package org.zerock.user.service;

import java.util.HashMap;
import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.zerock.user.domain.Criteria;
import org.zerock.user.domain.Message;
import org.zerock.user.domain.UserVO;
import org.zerock.user.mapper.UserMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class UserServiceImpl implements UserService {
	
	@Setter(onMethod_ = @Autowired)
	private UserMapper mapper;

	@Override
	public void register(UserVO user) {
		mapper.insert(user);
	}

	@Override
	public List<UserVO> getList(Criteria cri) {
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}

	@Override
	public UserVO read(int seq) {
		return mapper.read(seq);
	}

	@Override
	public boolean update(UserVO user) {
		return mapper.update(user) == 1;
	}

	@Override
	public boolean delete(int seq) {
		return mapper.delete(seq) > 0;
	}

	@Override
	public int idCheck(String user_id) {
		return mapper.idCheck(user_id);
	}

}
