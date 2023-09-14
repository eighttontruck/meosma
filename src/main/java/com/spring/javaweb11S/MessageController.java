package com.spring.javaweb11S;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MessageController {
	
	@RequestMapping(value = "/message/{msgFlag}", method = RequestMethod.GET)
	public String listGet(@PathVariable String msgFlag, Model model) {
		
		if(msgFlag.equals("adminNo")) {
			model.addAttribute("msg", "관리자만 이용가능합니다.");
			model.addAttribute("url", "/"); //초기화면
		}
		else if(msgFlag.equals("memberNo")) {
			model.addAttribute("msg", "로그인 후 이용해주세요.");
			model.addAttribute("url", "/member/memberLogin");
		}
		
		return "include/message";
	}
	
}
