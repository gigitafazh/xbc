package xbc.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class XBCController {
	@RequestMapping("/index")
	public String index() {
		return "index";
	}
	
	@RequestMapping("/login")
	public String login() {
		return "login";
	}
	
	@RequestMapping("/secure/home")
	public String home() {
		return "home";
	}
	
	@RequestMapping("/secure/user")
	public String user() {
		return "user";
	}
	
	@RequestMapping("/secure/role")
	public String role() {
		return "role";
	}
	
	@RequestMapping("/secure/office")
	public String office() {
		return "office";
	}
	
	@RequestMapping("/secure/menu")
	public String menu() {
		return "menu";
	}
	
	@RequestMapping("/secure/menu-access")
	public String menuAccess() {
		return "menu-access";
	}
	
	@RequestMapping("forgot-password")
	public String forgotPassword() {
		return "forgot-password";
	}
}