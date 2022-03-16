package com.refa.ai.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.refa.ai.dto.UserDto;

@Repository
public class LoginDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public UserDto login(UserDto userDto) {
		return sqlSession.selectOne("sql.login", userDto);
	}
}
