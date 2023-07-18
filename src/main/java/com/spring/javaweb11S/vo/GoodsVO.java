package com.spring.javaweb11S.vo;

import lombok.Data;

@Data
public class GoodsVO {
	int idx;
	int brand_Idx;
	String name;
	int price;
	String thumbNail;
	int goods_Like;
	int secondCatagory_Idx;
	String option;
	String brand_Name;
}