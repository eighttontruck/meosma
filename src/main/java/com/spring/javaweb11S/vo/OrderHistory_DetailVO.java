package com.spring.javaweb11S.vo;

import lombok.Data;

@Data
public class OrderHistory_DetailVO {
	int idx;
	int orderHistory_Idx;
	int goods_Idx;
	int option_Idx;
	int goods_Stock;
	int totalPrice;
	String complainStatus;
	
	String goods_ThumbNail;
	String goods_Name;
	String goods_Option;
	String orderDate;
	String goods_Brand;
	String returns_status;
	String status;
	int shipping_Num;
	int goods_Price;
	
	String recipient_Name;
	String recipient_telNum;
	String recipient_Address;
}