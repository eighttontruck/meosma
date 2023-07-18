package com.spring.javaweb11S.vo;

import lombok.Data;

@Data
public class CategoryVO {
	int category_Idx;
	int subCategory_Idx;
	int secondeCategory_Idx;
	String category_Name;
	String subCategory_Name;
	String secondCategory_Name;
}