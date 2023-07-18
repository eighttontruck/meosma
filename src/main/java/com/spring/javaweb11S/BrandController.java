package com.spring.javaweb11S;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaweb11S.service.BrandService;
import com.spring.javaweb11S.vo.BrandVO;

@Controller
@RequestMapping("/brand")
public class BrandController {
	@Autowired
	BrandService brandService;
	
	@RequestMapping(value="/brandRegister", method=RequestMethod.GET)
	public String brandRegisterGet() {
		return "brand/brandRegister";
	}
	
	@RequestMapping(value="/brandRegister", method=RequestMethod.POST)
	public String brandRegisterPost(BrandVO vo) {
		brandService.setBrandRegister(vo);
		
		return "brand/brandRegister";
	}
	
	@RequestMapping(value="/brandList", method=RequestMethod.GET)
	public String brandListGet(Model model) {
		List<BrandVO> brandVos = brandService.getBrandList();
		
		model.addAttribute("brandVos",brandVos);
		return "brand/brandList";
	}

}
