package com.nhomjava.controller;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.nhomjava.admin.controller.ShopCKCController;
import com.nhomjava.model.Customer;

@Controller
@Transactional
@RequestMapping(value = "user")
public class UserAccountController extends ShopCKCController {

	@Autowired
	ServletContext application;
	@Autowired
	JavaMailSender mailSender;
	@Autowired
	HttpSession httpSession;
	
	

	// Mở form đăng nhập
	@RequestMapping(method = RequestMethod.GET)
	public String formLogin(ModelMap model, @CookieValue(defaultValue = "") String id,
			@CookieValue(defaultValue = "") String pw) {
		Customer user = new Customer();
		user.setId(id);
		user.setPassword(pw);
		model.addAttribute("user", user);
		return "user/login";
	}

	// Thực hiện đăng nhập
	@RequestMapping(method = RequestMethod.POST)
	public String login(ModelMap model, @ModelAttribute("user") Customer user,
			@RequestParam(defaultValue = "false") boolean remember, HttpServletResponse response) {

		Customer customer = new Customer();
		customer.setId(user.getId());

		Session session = sessionFactory.getCurrentSession();
		try {
			session.refresh(customer);

			if (user.getPassword().equals(customer.getPassword())) {
				
					httpSession.setAttribute("user", customer);
					// Ghi nhớ tài khoản bằng cookie
					Cookie ckUser = new Cookie("id", user.getId());
					Cookie ckPass = new Cookie("pw", user.getPassword());
					int expiry = 30 * 24 * 60 * 60;
					if (!remember) {
						expiry = 0;
					}
					ckUser.setMaxAge(expiry);
					ckPass.setMaxAge(expiry);

					response.addCookie(ckUser);
					response.addCookie(ckPass);

					return "user/index";
				
			} else {
				model.addAttribute("message", "Mật khẩu không đúng !");
			}
		} catch (Exception ex) {
			model.addAttribute("message", "Tài khoản không đúng !");
		}
		return "user/login";
	}

	//Mở form dk
	
	
		@RequestMapping(value="register",method =RequestMethod.GET)	
		public String formRegister(ModelMap model) {
			model.addAttribute("register" ,new Customer());
		
			
			return "user/register";
		}
		//Thuc hien DK
		@RequestMapping(value = "register",method = RequestMethod.POST)
		public String register(ModelMap model,@ModelAttribute("register") Customer customer, HttpServletResponse request) {
			Session session=sessionFactory.getCurrentSession();
			session.save(customer);
			
			
			model.addAttribute("message","Đăng ký thành công");
			
			return "user/register";
		}
	

	// Đăng xuất
	@RequestMapping("logout")
	public String logout(ModelMap model) {
		httpSession.removeAttribute("user");
		return "redirect:/user";
	}
}
