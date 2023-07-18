package com.spring.javaweb11S.vo;

import lombok.Data;

@Data
public class CouponVO {
	int idx;
	int member_Idx;
	String name;
	int dcPercentage;
	String issuedDate;
	String usageDate;
	boolean status;
	String usedDate;
}