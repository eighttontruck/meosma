package com.spring.javaweb11S.pagination;

import lombok.Data;

@Data
public class PageVO {
	private int pag;
	private int pageSize;
	private int totRecCnt;
	private int totPage;
	private int startIndexNo;
	private int curScrStartNo;
	private int curBlock;
	private int blockSize;
	private int lastBlock;
	
	private String filter;
	
	private String part;
	private String searchKeyword;
	private String searchString;               //이전,다음버튼
	
	private String startFilter;               //이전,다음버튼
	private String endFilter;      
	
	private String mainCategory;
	private String subCategory;
	private String secondCategory;
	
	private int mainCategory_Idx;
	private int subCategory_Idx;
	private int secondCategory_Idx;
	private int brand_Idx;
}