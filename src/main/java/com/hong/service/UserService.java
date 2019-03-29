package com.hong.service;

import java.util.List;

import com.hong.entity.User;

public interface UserService {
	
	List<User> loadUsers();
	
	void addUser(User user);
	
	void modifyUser(User user);
	
	void deleteUser(int userId);
	
	List<User> findUser(String param);
}
