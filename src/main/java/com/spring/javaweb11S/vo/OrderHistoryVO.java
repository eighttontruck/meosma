package com.spring.javaweb11S.vo;

import lombok.Data;

@Data
public class OrderHistoryVO {
	int idx;
	int member_Idx;
	String orderDate;
	int finalPrice;
	String status;
	String recipient_Name;
	String recipient_TelNum;
	String recipient_Address;
}