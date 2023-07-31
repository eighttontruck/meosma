package com.spring.javaweb11S.vo;

import lombok.Data;

@Data
public class CartVO {
	private int idx;
	private int member_Idx;
	private int goods_Idx;
	private int option_Idx;
	private int stock;
	
	private String order_ThumbNail;
	private String order_Brand;
	private String order_Name;
	private String order_Option;
	private int order_Price;
	private int goods_Stock;
	
}
