package com.spring.javaweb11S.vo;

import lombok.Data;

@Data
public class MemberVO {
	private int idx;
	private String emailId;
	private String pwd;
	private String name;
	private String gender;
	private String birthday;
	private String telNum;
	private int level;
	private int totVisitCnt;
	private String firstJoinDay;
	private String lastVisitDay;
	private int todayVisitCnt;
	private String memberDel;
	private int point;
	
	private int order_Count;
}