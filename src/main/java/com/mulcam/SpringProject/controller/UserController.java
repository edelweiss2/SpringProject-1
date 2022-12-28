package com.mulcam.SpringProject.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mulcam.SpringProject.entity.User;
import com.mulcam.SpringProject.service.UserService;
import com.mulcam.SpringProject.session.UserSession;


@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private UserSession userSession;
	
	@Autowired
	private UserService service;
	
	
	
	@GetMapping("/login")
	public String loginform() {
		return "user/login";
	}
	
	@RequestMapping("/list")
	public String list(Model model) {
		List<User> list = service.getList();
		model.addAttribute("userList", list);
		model.addAttribute("sessionUid", userSession.getUid());
		model.addAttribute("sessionUname", userSession.getUname());
		return "user/list";
	}
	
	@PostMapping("/login")
	public String login(HttpServletRequest req, Model model) {
		String uid = req.getParameter("uid").strip();
		String pwd = req.getParameter("pwd").strip();
		int result = service.login(uid,pwd);
		switch (result) {
		case UserService.CORRECT_LOGIN :
			return "redirect:/board/list";
		case UserService.WRONG_PASSWORD :
			return "user/login";
		case UserService.UID_NOT_EXIST :
			return "redirect:/user/register";
		default:
			return "";
		}
	}
	
	
	@GetMapping("/register")
	public String registerForm() {
		
		return "user/register";
	}
	
	
	@PostMapping("/register")
	public String register(HttpServletRequest req) {
		String uid = req.getParameter("uid").strip();
		String pwd = req.getParameter("pwd").strip();
		String pwd2 = req.getParameter("pwd2").strip();
		String uname = req.getParameter("uname").strip();
		String email = req.getParameter("email").strip();
		String addr = req.getParameter("addr").strip();
		String phoneNum = req.getParameter("phoneNum").strip();
		
		if(pwd.equals(pwd2)) {
			User u = new User(uid,pwd,uname,email,addr,phoneNum);
			service.register(u);	
			return "redirect:/user/list";
		} else {
			System.out.println("패스워드 입력이 잘못되었습니다.");
			return "redirect:/user/register";
		}
	}
	
	@RequestMapping("/logout")
	public String logout() {
		userSession.setUid("");
		userSession.setUname("");
		return "redirect:/user/list";
	}

}
