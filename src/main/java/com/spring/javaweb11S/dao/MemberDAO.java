package com.spring.javaweb11S.dao;


import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb11S.pagination.PageVO;
import com.spring.javaweb11S.vo.MemberVO;
import com.spring.javaweb11S.vo.OrderHistoryVO;
import com.spring.javaweb11S.vo.OrderHistory_DetailVO;
import com.spring.javaweb11S.vo.ReviewVO;

public interface MemberDAO {

	public void setMemberJoinOk(@Param("vo") MemberVO vo);

	public MemberVO getMemberEmailIdCheck(@Param("emailId") String emailId);

	public void setMemberVisitProcess(@Param("vo") MemberVO vo);

	public MemberVO getMemberIdFind(@Param("name") String name, @Param("telNum") String telNum);

	public MemberVO getMemberPwdFind(@Param("name") String name, @Param("telNum") String telNum, @Param("emailId") String emailId);

	public void setMemberPwdUpdate(@Param("updatePwd") String updatePwd, @Param("emailIdForm") String emailIdForm);

	public MemberVO getMemberIdxCheck(@Param("sIdx") int sIdx);

	public List<OrderHistoryVO> getMemberOrderHistory(@Param("pageVO") PageVO pageVO, @Param("sIdx") int sIdx);

	public List<OrderHistory_DetailVO> setMemberOrderHistory_Detail(@Param("sIdx") int sIdx);

	public int totRecCnt(String searchString);

	public List<OrderHistory_DetailVO> getMemberOrderHistory_Detail(@Param("pageVO") PageVO pageVO, @Param("sIdx") int sIdx);

	public void setMemberGoodsConfirmAJAX(@Param("orderHistory_Detail_Idx") int orderHistory_Detail_Idx);

	public int getTodayMemberVisitCheck(@Param("vo") MemberVO vo);

	public void setMemberVisitPoint(@Param("vo") MemberVO vo);

	public void setInsertMemberCoupon(@Param("vo") MemberVO vo, @Param("coupon_Name") String coupon_Name, @Param("percentage") int percentage);

	public List<MemberVO> getBirthdayMemberList();

	public void setInsertMemberBirthdayCoupon(@Param("vos") List<MemberVO> vos, @Param("coupon_Name") String coupon_Name, @Param("percentage") int percentage);

	public OrderHistory_DetailVO getMemberOrderHistory_DetailVO(@Param("orderHistory_Detail_Idx") int orderHistory_Detail_Idx);

	public void setInsertGoodsReview(@Param("vo") ReviewVO vo);

	public void setUpdateReviewOrderHistory_Detail(@Param("orderHistory_Detail_Idx") int orderHistory_Detail_Idx);

	public int orderHistory_DetailTotRecCnt(@Param("pag") int pag, @Param("pageSize") int pageSize, @Param("sIdx") int sIdx, @Param("filter") String filter);

	public int orderHistoryTotRecCnt(@Param("pag") int pag, @Param("pageSize") int pageSize, @Param("sIdx") int sIdx);

	public void setDeleteOrderHistory_DetailAJAX(@Param("orderHistory_Detail_Idx") int orderHistory_Detail_Idx);

	public int getSeleteOrderHistory_DetailCnt(@Param("orderHistory_Idx") int orderHistory_Idx);

	public void setDeleteOrderHistoryAJAX(@Param("orderHistory_Idx") int orderHistory_Idx);



}