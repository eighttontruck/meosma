package com.spring.javaweb11S.vo;

import lombok.Data;

@Data
public class SecondCategoryVO {
	int secondCategory_Idx;
	String secondCategory_Name;
	int subCategory_Idx;
	
	int mainCategory_Idx;
	String mainCategory_Name;
	String subCategory_Name;
}