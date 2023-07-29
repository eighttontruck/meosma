package com.spring.javaweb11S.vo;

import lombok.Data;

@Data
public class OrderHistory_DetailVO {
	private int idx;
	private int orderHistory_Idx;
	private int goods_Idx;
	private int option_Idx;
	private int goods_Stock;
	private int totalPrice;
	private String complainStatus;
	private String review_Status;
	
	private String goods_ThumbNail;
	private String goods_Name;
	private String goods_Option;
	private String orderDate;
	private String goods_Brand;
	private String status;
	private int shipping_Num;
	private int goods_Price;
	
	private String recipient_Name;
	private String recipient_telNum;
	private String recipient_Address;
}