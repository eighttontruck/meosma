package com.spring.javaweb11S.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb11S.vo.BrandVO;

public interface BrandDAO {
	
	public void setBrandRegister(@Param("vo") BrandVO vo);

	public List<BrandVO> getBrandList();

}