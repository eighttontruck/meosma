package com.spring.javaweb11S.vo;

import lombok.Data;

@Data
public class Exchange_DetailVO {
	private int idx;
	private int exchange_Idx;
	private int goods_Idx;
	private int option_Idx;
	private int stock;
	
	private String goods_ThumbNail;
	private String goods_Name;
	private String goods_Brand;
	private String goods_Option;
	private String order_Option;
	private int total_Stock;
}