package com.spring.javaweb11S;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/review")
public class ReviewController {
	@RequestMapping(value="/reviewInput", method=RequestMethod.POST)
	public String reviewInputGet() {
		return "";
	}
}
