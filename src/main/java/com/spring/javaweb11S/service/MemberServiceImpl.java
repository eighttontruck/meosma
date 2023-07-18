package com.spring.javaweb11S.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb11S.dao.MemberDAO;
import com.spring.javaweb11S.vo.MemberVO;
import com.spring.javaweb11S.vo.OrderHistoryVO;
import com.spring.javaweb11S.vo.OrderHistory_DetailVO;

@Service
public class MemberServiceImpl implements MemberService{
	@Autowired
	MemberDAO memberDAO;

	@Override
	public void setMemberJoinOk(MemberVO vo) {
		memberDAO.setMemberJoinOk(vo);
		
	}

	@Override
	public MemberVO getMemberEmailIdCheck(String emailId) {
		return memberDAO.getMemberEmailIdCheck(emailId);
	}

	@Override
	public void setMemberVisitProcess(MemberVO vo) {
		memberDAO.setMemberVisitProcess(vo);
		
	}

	@Override
	public MemberVO getMemberIdFind(String name, String telNum) {
		return memberDAO.getMemberIdFind(name,telNum);
	}

	@Override
	public MemberVO getMemberPwdFind(String name, String telNum, String emailId) {
		return memberDAO.getMemberPwdFind(name,telNum,emailId);
	}

	@Override
	public void setMemberPwdUpdate(String updatePwd, String emailIdForm) {
		memberDAO.setMemberPwdUpdate(updatePwd,emailIdForm);
		
	}

	@Override
	public MemberVO getMemberIdxCheck(int sIdx) {
		return memberDAO.getMemberIdxCheck(sIdx);
	}

	@Override
	public List<OrderHistoryVO> getMemberOrderHistory(int sIdx) {
		return memberDAO.getMemberOrderHistory(sIdx);
	}

	@Override
	public List<OrderHistory_DetailVO> getMemberOrderHistory_Detail(int sIdx) {
		return memberDAO.setMemberOrderHistory_Detail(sIdx);
	}
}