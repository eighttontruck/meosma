package com.spring.javaweb11S.vo;

import lombok.Data;

@Data
public class BrandVO {
	int idx;
	String name;
	String content;
	int brand_like;
	
	int goods_Count;
}