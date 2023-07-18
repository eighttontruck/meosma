package com.spring.javaweb11S.service;

import java.util.List;

import com.spring.javaweb11S.vo.BrandVO;


public interface BrandService {
	
	public void setBrandRegister(BrandVO vo);

	public List<BrandVO> getBrandList();

}