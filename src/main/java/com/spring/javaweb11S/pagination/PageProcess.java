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
		else if(section.equals("exchange")) totRecCnt = adminDAO.exchangeTotRecCnt(filter, searchKeyword, searchString);
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

	public PageVO totRecCnt(int pag, int pageSize, int brand_Idx, int mainCategory_Idx, int subCategory_Idx, int secondCategory_Idx) {
		PageVO pageVO = new PageVO();
		
		int totRecCnt = 0;
		totRecCnt = goodsDAO.goodsTotRecCnt(pag, pageSize, brand_Idx, mainCategory_Idx, subCategory_Idx, secondCategory_Idx);
		
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
		
		pageVO.setMainCategory_Idx(mainCategory_Idx);
		pageVO.setSubCategory_Idx(subCategory_Idx);
		pageVO.setSecondCategory_Idx(secondCategory_Idx);
		pageVO.setBrand_Idx(brand_Idx);
		
		return pageVO;
	}

	public PageVO totRecCnt(int pag, int pageSize, String category, int idx) {
		PageVO pageVO = new PageVO();
		
		int totRecCnt = 0;
		if(category.equals("goods")) totRecCnt = goodsDAO.reviewTotRecCnt(pag, pageSize, idx);
		else if(category.equals("orderHistory")) totRecCnt = memberDAO.orderHistoryTotRecCnt(pag, pageSize, idx);
		
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
		
		return pageVO;
	}

	public PageVO totRecCnt(int pag, int pageSize, int sIdx, String filter) {
PageVO pageVO = new PageVO();
		
		int totRecCnt = 0;
		totRecCnt = memberDAO.orderHistory_DetailTotRecCnt(pag, pageSize, sIdx, filter);
		
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
		pageVO.setFilter(filter);
		
		return pageVO;
	}
}