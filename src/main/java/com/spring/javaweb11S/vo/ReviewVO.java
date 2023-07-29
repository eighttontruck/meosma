package com.spring.javaweb11S.vo;

import lombok.Data;

@Data
public class ReviewVO {
	private int idx;
	private int goods_Idx;
	private int member_Idx;
	private int orderHistory_Detail_Idx;
	private String FSname;
	private String FName;
	private String content;
	private int score;
	private String WDate;
	private String confirm;
	
	//리뷰를 보여주기 위한 정보
	private String member_Name;
	private String goods_Name;
	private String option_Name;
	private String brand_Name;
	private int review_Cnt;
}