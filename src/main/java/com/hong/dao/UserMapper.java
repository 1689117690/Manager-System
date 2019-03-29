package com.hong.dao;

import java.util.List;

import com.hong.entity.User;

public interface UserMapper {
	
	List<User> queryAll(); 
	
	void addUser(User user);
	
	void modifyUser(User user);
	
	void deleteByuserId(int userId);
	
	List<User> getUserListByNameOrAccount(String param);
}
