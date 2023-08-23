package com.spring.javaweb11S.service;


import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb11S.pagination.PageVO;
import com.spring.javaweb11S.vo.MemberVO;
import com.spring.javaweb11S.vo.OrderHistoryVO;
import com.spring.javaweb11S.vo.OrderHistory_DetailVO;
import com.spring.javaweb11S.vo.ReviewVO;

public interface MemberService {

	public void setMemberJoinOk(MemberVO vo);

	public MemberVO getMemberEmailIdCheck(String emailId);

	public void setMemberVisitProcess(MemberVO vo);

	public MemberVO getMemberIdFind(String name, String telNum);

	public MemberVO getMemberPwdFind(String name, String telNum, String emailId);

	public void setMemberPwdUpdate(String updatePwd, String emailIdForm);

	public MemberVO getMemberIdxCheck(int sIdx);

	public List<OrderHistoryVO> getMemberOrderHistory(PageVO pageVO, int sIdx);

	public List<OrderHistory_DetailVO> getMemberOrderHistory_Detail(PageVO pageVO, int sIdx);

	public void setMemberGoodsConfirmAJAX(int orderHistory_Detail_Idx);

	public int getTodayMemberVisitCheck(MemberVO vo);

	public void setMemberVisitPoint(MemberVO vo);

	public void setInsertMemberCoupon(MemberVO vo, String coupon_Name, int percentage);

	public List<MemberVO> getBirthdayMemberList();

	public void setInsertMemberBirthdayCoupon(List<MemberVO> vos, String string, int i);

	public OrderHistory_DetailVO getMemberOrderHistory_DetailVO(int orderHistory_Detail_Idx);

	public String fileUpload(MultipartFile file, ReviewVO vo);

	public void setInsertGoodsReview(ReviewVO vo);

	public void setUpdateReviewOrderHistory_Detail(int orderHistory_Detail_Idx);

	public String fileUpload(MultipartFile file, MemberVO vo);

	public void setDeleteOrderHistory_DetailAJAX(int orderHistory_Detail_Idx);

	public int getSeleteOrderHistory_DetailCnt(int orderHistory_Idx);

	public void setDeleteOrderHistoryAJAX(int orderHistory_Idx);


}