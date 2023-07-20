package com.spring.javaweb11S.dao;


import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb11S.vo.MemberVO;
import com.spring.javaweb11S.vo.OrderHistoryVO;
import com.spring.javaweb11S.vo.OrderHistory_DetailVO;

public interface MemberDAO {

	public void setMemberJoinOk(@Param("vo") MemberVO vo);

	public MemberVO getMemberEmailIdCheck(@Param("emailId") String emailId);

	public void setMemberVisitProcess(@Param("vo") MemberVO vo);

	public MemberVO getMemberIdFind(@Param("name") String name, @Param("telNum") String telNum);

	public MemberVO getMemberPwdFind(@Param("name") String name, @Param("telNum") String telNum, @Param("emailId") String emailId);

	public void setMemberPwdUpdate(@Param("updatePwd") String updatePwd, @Param("emailIdForm") String emailIdForm);

	public MemberVO getMemberIdxCheck(@Param("sIdx") int sIdx);

	public List<OrderHistoryVO> getMemberOrderHistory(@Param("sIdx") int sIdx);

	public List<OrderHistory_DetailVO> setMemberOrderHistory_Detail(@Param("sIdx") int sIdx);

	public int totRecCnt(String searchString);

	public List<OrderHistory_DetailVO> getMemberOrderHistory_Detail(@Param("sIdx") int sIdx);

	public void setMemberGoodsConfirmAJAX(@Param("orderHistory_Detail_Idx") int orderHistory_Detail_Idx);


}