package com.spring.javaweb11S.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb11S.dao.BrandDAO;
import com.spring.javaweb11S.vo.BrandVO;

@Service
public class BrandServiceImpl implements BrandService {
	@Autowired
	BrandDAO brandDAO;

	@Override
	public void setBrandRegister(BrandVO vo) {
		brandDAO.setBrandRegister(vo);
		
	}

	@Override
	public List<BrandVO> getBrandList() {
		return brandDAO.getBrandList();
	}
}