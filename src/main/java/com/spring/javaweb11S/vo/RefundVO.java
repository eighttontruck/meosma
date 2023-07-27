package com.spring.javaweb11S.vo;

import lombok.Data;

@Data
public class RefundVO {
	private int idx;
	private int member_Idx;
	private int orderHistory_Detail_Idx;
	private int stock;
	private String reason;
	private int refund_Price;
	private String applicationDate;
	private String status;
}