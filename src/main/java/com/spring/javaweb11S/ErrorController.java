package com.spring.javaweb11S;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/errorPage")
public class ErrorController {
		// 404에러 발생폼 호출...
		@RequestMapping(value = "/error404", method = RequestMethod.GET)
		public String error404Get() {
			return "errorPage/error404";
		}
		
		// 500에러 발생폼 호출...
		@RequestMapping(value = "/error500", method = RequestMethod.GET)
		public String error500Get() {
			return "errorPage/error500";
		}
}
