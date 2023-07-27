package com.spring.javaweb11S.vo;

import lombok.Data;

@Data
public class OrderVO {
	int idx;
	String order_ThumbNail;
	String order_Brand;
	String order_Name;
	String order_Option;
	int order_Stock;
	int order_Price;
	int expectPoint;
	int goodsStockPrice;
	int goods_Idx;
	int option_Idx;
	
	int idxChecked;
}