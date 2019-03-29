package com.hong.controller;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hong.entity.User;
import com.hong.service.UserService;
import com.sun.media.jfxmedia.logging.Logger;

@Controller
@RequestMapping("/userController")
public class UserController {
	
	 private final static org.slf4j.Logger logger = LoggerFactory.getLogger(UserService.class);
	
	@Resource
	private UserService userService;

	@RequestMapping(value="/showUsers")
	public String showUsers(Model model) {
		List<User> user = userService.loadUsers();
		model.addAttribute("user",user);
		return "showusers";
	}
	
	@RequestMapping(value="/checkUser.action")
	@ResponseBody
	public void checkUser(HttpServletRequest request,HttpServletResponse response) throws IOException{
		
		response.setContentType("application/json;charset=UTF-8");
		if(request.getParameter("username").equals("admin")&&request.getParameter("password").equals("318622")) {
			response.getWriter().write("{'success':true}");
		}else {
			response.getWriter().write("{'failure':true}");
		}
		
	}
	
	@RequestMapping(value="getAllUsers.action")
	@ResponseBody
	public List<User> getAllUsers(HttpServletResponse response) throws IOException {
		List<User> user = userService.loadUsers();
		return user;
	}
	
	@RequestMapping(value="addUser.action")
	@ResponseBody
	public void addUser(User user,HttpServletRequest request,HttpServletResponse response) throws IOException {
		user.setUserId(Integer.parseInt(request.getParameter("userId")));
		user.setUsername(request.getParameter("username"));
		user.setAccount(request.getParameter("account"));
		user.setBirth(request.getParameter("birth"));
		user.setAddress(request.getParameter("address"));
		user.setMobile(request.getParameter("mobile"));
		userService.addUser(user);
		System.out.println(request.getParameter("account"));
		response.getWriter().write("{'success':true}");
	}
	
	@RequestMapping(value="modifyUser.action")
	@ResponseBody
	public void modifyUser(User user,HttpServletRequest request,HttpServletResponse response) throws IOException {
		user.setUserId(Integer.parseInt(request.getParameter("userId")));
		user.setUsername(request.getParameter("username"));
		user.setAccount(request.getParameter("account"));
		user.setBirth(request.getParameter("birth"));
		user.setAddress(request.getParameter("address"));
		user.setMobile(request.getParameter("mobile"));
		userService.modifyUser(user);
		System.out.println(request.getParameter("userId")+"-----"+request.getParameter("username"));
		response.getWriter().write("{'success':true}");
	}
	
	@RequestMapping(value="/deleteUser.action")
	@ResponseBody
	public void deleteUser(HttpServletRequest request,HttpServletResponse response) throws IOException {
		String userIds = request.getParameter("userIds");
		String[] userId = userIds.split(",");
		for(int i=0;i<userId.length;i++) {
			userService.deleteUser(Integer.parseInt(userId[i]));
		}
		System.out.println(request.getParameter("userIds"));
		response.getWriter().write("{'success':true}");
	}
	
	@RequestMapping(value="findUser.action")
	@ResponseBody
	public List<User> findUser(HttpServletRequest request,HttpServletResponse response) throws IOException {

		System.out.println(request.getRequestURI());
		//System.out.println(request.getQueryString());
		System.out.println(request.getParameter("param"));
		System.out.println(request.getParameterMap().toString());
		List<User> user = userService.findUser(request.getParameter("param"));
		
		return user;
	}
}
