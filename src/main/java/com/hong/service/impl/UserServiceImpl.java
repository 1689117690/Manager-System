package com.hong.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hong.dao.UserMapper;
import com.hong.entity.User;
import com.hong.service.UserService;

@Service("userService")
public class UserServiceImpl implements UserService {
	@Resource
	private UserMapper userMapper;

	public List<User> loadUsers(){
		return userMapper.queryAll();
	}
	
	public void addUser(User user) {
		userMapper.addUser(user);
	}
	
	public void modifyUser(User user) {
		userMapper.modifyUser(user);
	}
	
	public void deleteUser(int userId) {
		userMapper.deleteByuserId(userId);
	}
	
	public List<User> findUser(String param){
		return userMapper.getUserListByNameOrAccount(param);
	}
}
