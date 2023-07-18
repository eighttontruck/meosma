package com.spring.javaweb11S.vo;

import lombok.Data;

@Data
public class Member_ShippingAddressVO {
	int idx;
	int member_Idx;
	String ship_Name;
	String ship_TelNum;
	String ship_Address;
}