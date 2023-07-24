package com.spring.javaweb11S.vo;

import lombok.Data;

@Data
public class ExchangeVO {
	private int idx;
	private int orderHistory_Detail_Idx;
	private String applicationDate;
	private String reason;
	private int shipping_Num;
	private String recipient_Name;
	private String recipient_TelNum;
	private String recipient_Address;
	private String status;
}
