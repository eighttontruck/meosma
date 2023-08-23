package com.spring.javaweb11S.vo;

import lombok.Data;

@Data
public class InquiryVO {
	private int idx;
	private int goods_Idx;
	private int member_Idx;
	private String title;
	private String content;
	private String category;
	private String wdate;
	private String fsname;
	private String fname;
	private String ans_status;
	private String lock_status;
	private String master_ans;
	private String master_wdate;
}