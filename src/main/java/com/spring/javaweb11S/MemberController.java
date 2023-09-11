package com.spring.javaweb11S;


import java.util.List;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb11S.pagination.PageProcess;
import com.spring.javaweb11S.pagination.PageVO;
import com.spring.javaweb11S.service.MemberService;
import com.spring.javaweb11S.vo.MemberVO;
import com.spring.javaweb11S.vo.OrderHistoryVO;
import com.spring.javaweb11S.vo.OrderHistory_DetailVO;
import com.spring.javaweb11S.vo.ReviewVO;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	MemberService memberService;
	
	@Autowired
	JavaMailSender mailSender;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	PageProcess pageProcess;
	
	@RequestMapping(value="/memberLogin",method=RequestMethod.GET)
	public String memberLoginGet(HttpServletRequest request, Model model) {
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for(int i=0;i<cookies.length;i++) {
				if(cookies[i].getName().equals("cMid")) {
					request.setAttribute("eamilId", cookies[i].getValue());
				}
			}
		}
		
		return "member/memberLogin";
	}
	
	@RequestMapping(value="/memberLogin",method=RequestMethod.POST)
	public String memberLoginPost(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(name="emailId", defaultValue="",required=false) String emailId,
			@RequestParam(name="pwd", defaultValue="",required=false) String pwd,
			@RequestParam(name="idSave", defaultValue="",required=false) String idSave,
			HttpSession session) {
		MemberVO vo = memberService.getMemberEmailIdCheck(emailId);
		
		
		if(vo!=null&&vo.getMemberDel().equals("NO")&&passwordEncoder.matches(pwd, vo.getPwd())) {
			String strLevel="";
			if(vo.getLevel()==0) strLevel="관리자";
			else if(vo.getLevel()==1) strLevel="브론즈";
			else if(vo.getLevel()==2) strLevel="실버";
			else if(vo.getLevel()==3) strLevel="골드";
			
			session.setAttribute("sLevel", vo.getLevel());
			session.setAttribute("strLevel", strLevel);
			session.setAttribute("sEmailId", vo.getEmailId());
			session.setAttribute("sName", vo.getName());
			session.setAttribute("sIdx", vo.getIdx());
			
			if(idSave.equals("on")) {
				Cookie cookie = new Cookie("cEmailId",emailId);
				cookie.setMaxAge(60*60*24*7);
				response.addCookie(cookie);
			} else {
				Cookie[] cookies = request.getCookies();
				for(int i=0;i<cookies.length;i++) {
					if(cookies[i].getName().equals("cEmailId")) {
						cookies[i].setMaxAge(0);
						response.addCookie(cookies[i]);
						break;
					}
				}
			}
			int res = memberService.getTodayMemberVisitCheck(vo);
			System.out.println(res);
			if(res==0) {
				memberService.setMemberVisitPoint(vo);
			}
			memberService.setMemberVisitProcess(vo);
			return "redirect:/goods/goodsList";
			
		} else {
			return "member/memberLogin";
		}
	}
	
	@RequestMapping(value="/memberLogOut", method=RequestMethod.GET)
	public String memberLogOutGet(HttpSession session) {
		session.invalidate();
		return "home";
	}
	
	@RequestMapping(value="/memberJoin",method=RequestMethod.GET)
	public String memberJoinGet() {
		return "member/memberJoin";
	}
	
	@Transactional
	@RequestMapping(value="/memberJoin", method=RequestMethod.POST)
	public String memberJoinPost(MemberVO vo, MultipartFile file) {
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		
		String fileName = memberService.fileUpload(file,vo);
		
		vo.setFName(file.getOriginalFilename());
		vo.setFSname(fileName);
	
		memberService.setMemberJoinOk(vo);
		memberService.setInsertMemberCoupon(vo,"가입기념",5); //가입기념 쿠폰 발급
		return "member/memberLogin";
	}
	
	@Scheduled(cron = "0 0 0 * * *")
	public void memberBirthdayCoupon() {
		List<MemberVO> vos = memberService.getBirthdayMemberList();
		memberService.setInsertMemberBirthdayCoupon(vos,"생일쿠폰",10);
	}
	
	@RequestMapping(value="/memberIdFind",method=RequestMethod.GET)
	public String memberIdFindGet() {
		return "member/memberIdFind";
	}
	
	@ResponseBody
	@RequestMapping(value="/memberIdFind",method=RequestMethod.POST)
	public String memberIdFindPost(
			@RequestParam(name="name", defaultValue="", required=false) String name,
			@RequestParam(name="telNum", defaultValue="", required=false) String telNum) {
		
		MemberVO vo = memberService.getMemberIdFind(name,telNum);
		
		return vo.getEmailId();
	}
	
	@RequestMapping(value="/memberPwdFind",method=RequestMethod.GET)
	public String memberPwdFindGet() {
		return "member/memberPwdFind";
	}
	
	@ResponseBody
	@RequestMapping(value="/memberPwdFind",method=RequestMethod.POST)
	public String memberPwdFindPost(
			@RequestParam(name="name", defaultValue="", required=false) String name,
			@RequestParam(name="telNum", defaultValue="", required=false) String telNum,
			@RequestParam(name="emailId", defaultValue="", required=false) String emailId) {
		MemberVO vo = memberService.getMemberPwdFind(name,telNum,emailId);
		
		String res="0";
		if(vo!=null) {
			res="1";
		}
		return res;
	}
	
	@RequestMapping(value="/memberPwdUpdate",method=RequestMethod.POST)
	public String memberPwdUpdatePost(
			@RequestParam(name="updatePwd", defaultValue="", required=false) String updatePwd,
			@RequestParam(name="emailIdForm", defaultValue="", required=false) String emailIdForm
			) {
		System.out.print(updatePwd+""+emailIdForm);
		updatePwd=passwordEncoder.encode(updatePwd);
		memberService.setMemberPwdUpdate(updatePwd,emailIdForm);
		
		return "redirect:memberLogin";
	}
	
	@RequestMapping(value="/memberMyPage",method=RequestMethod.GET)
	public String memberMyPageGet(Model model, HttpSession session,
		@RequestParam(name="pag", defaultValue="1",required=false) int pag,
		@RequestParam(name="pageSize", defaultValue="15",required=false) int pageSize
			) {
		int sIdx = (int) session.getAttribute("sIdx");
		MemberVO vo = memberService.getMemberIdxCheck(sIdx);
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "orderHistory", sIdx);
		List<OrderHistoryVO> vos=memberService.getMemberOrderHistory(pageVO, sIdx);
		model.addAttribute("vo",vo);
		model.addAttribute("vos",vos);
		model.addAttribute("pageVO",pageVO);
		return "member/memberMyPage";
	}
	
	@RequestMapping(value="/orderHistory_Detail",method=RequestMethod.GET)
	public String memberOrderHistory_DetailGet(Model model, HttpSession session,
		@RequestParam(name="filter", defaultValue="",required=false) String filter,
		@RequestParam(name="pag", defaultValue="1",required=false) int pag,
		@RequestParam(name="pageSize", defaultValue="5",required=false) int pageSize
			) {
		int sIdx = (int) session.getAttribute("sIdx");
		MemberVO vo = memberService.getMemberIdxCheck(sIdx);
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, sIdx, filter);
		
		List<OrderHistory_DetailVO> ohVos=memberService.getMemberOrderHistory_Detail(pageVO, sIdx);
		
		model.addAttribute("vo",vo);
		model.addAttribute("ohVos",ohVos);
		model.addAttribute("pageVO",pageVO);
		return "member/memberOrderHistory_DetailList";
	}
	
	@RequestMapping(value="/review",method=RequestMethod.GET)
	public String memberReviewGet(Model model,
		@RequestParam(name="orderHistory_Detail_Idx", defaultValue="", required=false) int orderHistory_Detail_Idx
			) {
		OrderHistory_DetailVO vo = memberService.getMemberOrderHistory_DetailVO(orderHistory_Detail_Idx);
		
		model.addAttribute("vo", vo);
		model.addAttribute("orderHistory_Detail_Idx", orderHistory_Detail_Idx);
		return "member/memberReview";
	}
	
	@RequestMapping(value="/review",method=RequestMethod.POST)
	public String memberReviewPost(HttpSession session, ReviewVO vo, MultipartFile file) {
		
		int sIdx = (int) session.getAttribute("sIdx");
		
		String fileName = memberService.fileUpload(file,vo);
		
		vo.setMember_Idx(sIdx);
		vo.setFName(file.getOriginalFilename());
		vo.setFSname(fileName);
		
		memberService.setInsertGoodsReview(vo); //점수 수정해야됨
		memberService.setUpdateReviewOrderHistory_Detail(vo.getOrderHistory_Detail_Idx()); //구매 후기 작성완료 처리
		
		return "redirect:/member/memberMyPage";
	}
	
	@ResponseBody
	@RequestMapping(value="/cancelOrderAJAX",method=RequestMethod.POST)
	public String memberCancelOrderAJAXPost(int orderHistory_Detail_Idx, int orderHistory_Idx) {
		
		int cnt = memberService.getSeleteOrderHistory_DetailCnt(orderHistory_Idx);
		memberService.setDeleteOrderHistory_DetailAJAX(orderHistory_Detail_Idx);
		if(cnt==1) {
			memberService.setDeleteOrderHistoryAJAX(orderHistory_Idx);
		}
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value="/goodsConfirmAJAX",method=RequestMethod.POST)
	public String memberGoodsConfirmAJAXPost(int orderHistory_Detail_Idx) {
		
		memberService.setMemberGoodsConfirmAJAX(orderHistory_Detail_Idx);
		//세션 넣어서 레벨을 매퍼까지 끌고 가서 거기서 계산하자 if문으로
		//goodsService.setPlusPoint(sIdx, savePoint);
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value="/mailSendAJAX",method=RequestMethod.POST)
	public String mailSendAJAXPost(@RequestParam(name="emailId", defaultValue="", required=false) String emailId) {
		int serti = (int)((Math.random()*(99999-10000+1))+10000);
		
		String toMail=emailId;
		String title="[머스마]인증번호 발송";
		String content="[인증번호]" + serti +"입니다. <br/> 인증번호 확인란에 기입해주십시오.";
		
		String num="";
		
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message,true,"UTF-8");
			
			messageHelper.setTo(toMail);
			messageHelper.setSubject(title);
			messageHelper.setText(content,true);
			
			mailSender.send(message);
			num = Integer.toString(serti);
		} catch (Exception e) {
			num="error";
		}
		
		return num;
	}
}