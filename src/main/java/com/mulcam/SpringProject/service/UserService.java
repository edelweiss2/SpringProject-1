package com.mulcam.SpringProject.service;

import java.util.List;

import com.mulcam.SpringProject.entity.User;


public interface UserService {
	public static final int CORRECT_LOGIN=0;
	public static final int WRONG_PASSWORD=1;
	public static final int UID_NOT_EXIST=2;


	void register(User u);

	int login(String uid, String pwd);

	List<User> getList();

	User getUser(String uid);


	void updateUser(User u);

	void deleteUser(String uid);
	

	int withdrawConfirm(String uid, String pwd);

	void withdraw(String uid);

	List<User> getWithdrawList(String isDeleted);


}
