package com.hong.entity;

public class User {
	
	private int userId;
	
	private String username;
	
	private String account;
	
	private String birth;
	
	private String address;
	
	private String mobile;

	public int getUserId() {
		return userId;
	}

	public String getUsername() {
		return username;
	}

	public String getAccount() {
		return account;
	}

	public String getBirth() {
		return birth;
	}

	public String getAddress() {
		return address;
	}

	public String getMobile() {
		return mobile;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	@Override
	public String toString() {
		return "User [userId=" + userId + ", username=" + username + ", account=" + account + ", birth=" + birth
				+ ", address=" + address + ", mobile=" + mobile + "]";
	}
	
	

	
	
}
