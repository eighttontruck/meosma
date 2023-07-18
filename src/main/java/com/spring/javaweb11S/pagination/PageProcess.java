package com.spring.javaweb11S.pagination;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb11S.dao.AdminDAO;
import com.spring.javaweb11S.dao.GoodsDAO;
import com.spring.javaweb11S.dao.MemberDAO;

@Service
public class PageProcess {
	@Autowired
	GoodsDAO goodsDAO;
	
	@Autowired
	MemberDAO memberDAO;
	
	@Autowired
	AdminDAO adminDAO;
	
	public PageVO totRecCnt(int pag, int pageSize, String section, String filter, String searchKeyword, String searchString, String startFilter, String endFilter) {
		PageVO pageVO = new PageVO();
		
		int totRecCnt = 0;
		if(section.equals("brand"))	totRecCnt = adminDAO.brandTotRecCnt(filter, searchKeyword, searchString);
		else if(section.equals("member")) totRecCnt = memberDAO.totRecCnt(searchString);
		else if(section.equals("orderHistory")) totRecCnt = adminDAO.orderHistoryTotRecCnt(filter, searchKeyword, searchString, startFilter, endFilter);

		System.out.println(totRecCnt);
		
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt /pageSize : (totRecCnt / pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 10;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		pageVO.setFilter(filter);
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setTotRecCnt(totRecCnt);
		pageVO.setTotPage(totPage);
		pageVO.setStartIndexNo(startIndexNo);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setCurBlock(curBlock);
		pageVO.setBlockSize(blockSize);
		pageVO.setLastBlock(lastBlock);
		pageVO.setSearchKeyword(searchKeyword);
		pageVO.setSearchString(searchString);
		
		pageVO.setStartFilter(startFilter);
		pageVO.setEndFilter(endFilter);
		return pageVO;
	}

	public PageVO totRecCnt(int pag, int pageSize, String section, String mainCategory, String subCategory, String secondCategory, String searchKeyword, String searchString, String startFilter, String endFilter) {
		PageVO pageVO = new PageVO();
		
		int totRecCnt = 0;
		if(section.equals("goods"))	{
			totRecCnt = adminDAO.goodsTotRecCnt(mainCategory, subCategory, secondCategory, searchKeyword, searchString, startFilter, endFilter);
			System.out.println(totRecCnt);
		}
		
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt /pageSize : (totRecCnt / pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 10;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setTotRecCnt(totRecCnt);
		pageVO.setTotPage(totPage);
		pageVO.setStartIndexNo(startIndexNo);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setCurBlock(curBlock);
		pageVO.setBlockSize(blockSize);
		pageVO.setLastBlock(lastBlock);
		pageVO.setSearchKeyword(searchKeyword);
		pageVO.setSearchString(searchString);
		
		pageVO.setStartFilter(startFilter);
		pageVO.setEndFilter(endFilter);
		
		pageVO.setMainCategory(mainCategory);
		pageVO.setSubCategory(subCategory);
		pageVO.setSecondCategory(secondCategory);
		
		
		return pageVO;
	}
}