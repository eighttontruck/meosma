package com.spring.javaweb11S.service;


import java.util.List;

import com.spring.javaweb11S.vo.MemberVO;
import com.spring.javaweb11S.vo.OrderHistoryVO;
import com.spring.javaweb11S.vo.OrderHistory_DetailVO;

public interface MemberService {

	public void setMemberJoinOk(MemberVO vo);

	public MemberVO getMemberEmailIdCheck(String emailId);

	public void setMemberVisitProcess(MemberVO vo);

	public MemberVO getMemberIdFind(String name, String telNum);

	public MemberVO getMemberPwdFind(String name, String telNum, String emailId);

	public void setMemberPwdUpdate(String updatePwd, String emailIdForm);

	public MemberVO getMemberIdxCheck(int sIdx);

	public List<OrderHistoryVO> getMemberOrderHistory(int sIdx);

	public List<OrderHistory_DetailVO> getMemberOrderHistory_Detail(int sIdx);

	public void setMemberGoodsConfirmAJAX(int orderHistory_Detail_Idx);


}