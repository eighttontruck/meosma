package com.spring.javaweb11S.vo;

import lombok.Data;

@Data
public class Goods_StockVO {
	int goods_Idx;
	int option_Idx;
	int stock;
	String goods_Option;
}