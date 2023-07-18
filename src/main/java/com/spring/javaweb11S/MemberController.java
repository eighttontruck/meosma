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
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaweb11S.service.MemberService;
import com.spring.javaweb11S.vo.MemberVO;
import com.spring.javaweb11S.vo.OrderHistoryVO;
import com.spring.javaweb11S.vo.OrderHistory_DetailVO;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	MemberService memberService;
	
	@Autowired
	JavaMailSender mailSender;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
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
	
	@RequestMapping(value="/memberJoin", method=RequestMethod.POST)
	public String memberJoinPost(MemberVO vo) {
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		
		System.out.println(vo.toString());
		vo.toString();
		memberService.setMemberJoinOk(vo);
		return "member/memberLogin";
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
	public String memberPwdUpdateGet(Model model,
			@RequestParam(name="sIdx", defaultValue="", required=false) int sIdx) {
		MemberVO vo = memberService.getMemberIdxCheck(sIdx);
		
		List<OrderHistoryVO> ohVos=memberService.getMemberOrderHistory(sIdx);
		model.addAttribute("vo",vo);
		model.addAttribute("vos",ohVos);
		
		return "member/memberMyPage";
	}
	
	@RequestMapping(value="/memberGoodsOrderList",method=RequestMethod.GET)
	public String memberGoodsOrderListGet(Model model,
			@RequestParam(name="sIdx", defaultValue="", required=false) int sIdx) {
		List<OrderHistoryVO> ohVos=memberService.getMemberOrderHistory(sIdx);
		
		model.addAttribute("ohVos",ohVos);
		
		return "member/memberOrderHistoryList";
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