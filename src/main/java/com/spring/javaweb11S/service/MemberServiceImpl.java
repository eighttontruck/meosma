package com.spring.javaweb11S.service;


import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb11S.dao.MemberDAO;
import com.spring.javaweb11S.pagination.PageVO;
import com.spring.javaweb11S.vo.MemberVO;
import com.spring.javaweb11S.vo.OrderHistoryVO;
import com.spring.javaweb11S.vo.OrderHistory_DetailVO;
import com.spring.javaweb11S.vo.ReviewVO;

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
	public List<OrderHistoryVO> getMemberOrderHistory(PageVO pageVO, int sIdx) {
		return memberDAO.getMemberOrderHistory(pageVO, sIdx);
	}

	@Override
	public List<OrderHistory_DetailVO> getMemberOrderHistory_Detail(PageVO pageVO, int sIdx) {
		return memberDAO.getMemberOrderHistory_Detail(pageVO, sIdx);
	}

	@Override
	public void setMemberGoodsConfirmAJAX(int orderHistory_Detail_Idx) {
		memberDAO.setMemberGoodsConfirmAJAX(orderHistory_Detail_Idx);
		
	}

	@Override
	public int getTodayMemberVisitCheck(MemberVO vo) {
		return memberDAO.getTodayMemberVisitCheck(vo);
	}

	@Override
	public void setMemberVisitPoint(MemberVO vo) {
		memberDAO.setMemberVisitPoint(vo);
	}

	@Override
	public void setInsertMemberCoupon(MemberVO vo, String coupon_Name, int percentage) {
		memberDAO.setInsertMemberCoupon(vo, coupon_Name, percentage);
	}

	@Override
	public List<MemberVO> getBirthdayMemberList() {
		return memberDAO.getBirthdayMemberList();
	}

	@Override
	public void setInsertMemberBirthdayCoupon(List<MemberVO> vos, String coupon_Name, int percentage) {
		memberDAO.setInsertMemberBirthdayCoupon(vos, coupon_Name, percentage);
	}

	@Override
	public OrderHistory_DetailVO getMemberOrderHistory_DetailVO(int orderHistory_Detail_Idx) {
		return memberDAO.getMemberOrderHistory_DetailVO(orderHistory_Detail_Idx);
		
	}

	@Override
	public String fileUpload(MultipartFile fName, ReviewVO vo) {
		String fileName="";
		
		System.out.println("파일저장 들어옴");
		UUID uid = UUID.randomUUID();
		String oFileName = fName.getOriginalFilename();
		String saveFileName = uid+"_"+oFileName;
		System.out.println("파일명:"+oFileName);
		
		if(oFileName!="") {
			try {
				writeFile(fName,saveFileName);
				fileName = saveFileName;
			} catch(IOException e) {
				e.printStackTrace();
			}
		}
		
		return fileName;
	}
	
	@Override
	public String fileUpload(MultipartFile fName, MemberVO vo) {
		String fileName="";
		
		System.out.println("파일저장 들어옴");
		UUID uid = UUID.randomUUID();
		String oFileName = fName.getOriginalFilename();
		String saveFileName = uid+"_"+oFileName;
		System.out.println("파일명:"+oFileName);
		
		if(oFileName!="") {
			try {
				writeFile(fName,saveFileName);
				fileName = saveFileName;
			} catch(IOException e) {
				e.printStackTrace();
			}
		}
		
		return fileName;
	}

	public void writeFile(MultipartFile fName, String saveFileName) throws IOException{
		byte[] data = fName.getBytes();
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/images/");
		
		FileOutputStream fos = new FileOutputStream(realPath + saveFileName);
		fos.write(data);
		fos.close();
	}

	@Override
	public void setInsertGoodsReview(ReviewVO vo) {
		memberDAO.setInsertGoodsReview(vo);
		
	}

	@Override
	public void setUpdateReviewOrderHistory_Detail(int orderHistory_Detail_Idx) {
		memberDAO.setUpdateReviewOrderHistory_Detail(orderHistory_Detail_Idx);
		
	}
}