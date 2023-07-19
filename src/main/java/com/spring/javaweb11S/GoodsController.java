package com.spring.javaweb11S;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaweb11S.service.GoodsService;
import com.spring.javaweb11S.vo.BrandVO;
import com.spring.javaweb11S.vo.CategoryVO;
import com.spring.javaweb11S.vo.CouponVO;
import com.spring.javaweb11S.vo.GoodsVO;
import com.spring.javaweb11S.vo.Goods_StockVO;
import com.spring.javaweb11S.vo.MemberVO;
import com.spring.javaweb11S.vo.Member_ShippingAddressVO;
import com.spring.javaweb11S.vo.OrderHistoryVO;
import com.spring.javaweb11S.vo.OrderHistory_DetailVO;
import com.spring.javaweb11S.vo.OrderVO;
import com.spring.javaweb11S.vo.SecondCategoryVO;
import com.spring.javaweb11S.vo.SubCategoryVO;

@Controller
@RequestMapping("/goods")
public class GoodsController {
	@Autowired
	GoodsService goodsService;
	
	@RequestMapping(value="/goodsList", method=RequestMethod.GET)
	public String goodsListGet(Model model) {
		List<GoodsVO> vos= goodsService.getGoodsList();
		model.addAttribute("vos",vos);
		return "home";
	}
	
	@RequestMapping(value="/goodsViews",method=RequestMethod.GET)
	public String goodsViewGet(Model model,
			@RequestParam(name="idx", defaultValue="", required=false) int Goods_Idx,
			@RequestParam(name="secCate_Idx", defaultValue="", required=false) int secCate_Idx) {
		
		List<Goods_StockVO> stockVos = goodsService.getGoodsStock(Goods_Idx);
		GoodsVO goodsVo = goodsService.getGoodsDetail(Goods_Idx);
		CategoryVO categoryVo = goodsService.getGoodsCategory(secCate_Idx);
		BrandVO brandVo = goodsService.getBrandContent(Goods_Idx);
		
		model.addAttribute("stockVos",stockVos);
		model.addAttribute("goodsVo",goodsVo);
		model.addAttribute("categoryVo",categoryVo);
		model.addAttribute("brandVo",brandVo);
		return "goods/goodsViews";
	}
	
	@RequestMapping(value="/inquiryPopUp", method=RequestMethod.GET)
	public String inquiryPopUpGet() {
		return "goods/inquiryPopUp";
	}
	
	@RequestMapping(value="/goodsPayment", method=RequestMethod.POST)
	public String goodsPaymentGet(Model model,
			@RequestParam(name = "order_ThumbNail", defaultValue="", required=false) String[] order_ThumbNail,
			@RequestParam(name = "order_Name", defaultValue="", required=false) String[] order_Name,
			@RequestParam(name = "order_Option", defaultValue="", required=false) String[] order_Option,
			@RequestParam(name = "order_Stock", defaultValue="", required=false) int[] order_Stock,
			@RequestParam(name = "order_Price", defaultValue="", required=false) int[] order_Price,
			@RequestParam(name = "goods_Idx", defaultValue="", required=false) int[] goods_Idx,
			@RequestParam(name = "option_Idx", defaultValue="", required=false) int[] option_Idx,
			@RequestParam(name = "sIdx", defaultValue="", required=false) int sIdx,
			@RequestParam(name = "totalPrice", defaultValue="", required=false) int totalPrice
			) {
		
		List<OrderVO> vos = new ArrayList<>();
		
		MemberVO memberVo = goodsService.getOrderMemberInfo(sIdx);
		List<CouponVO> couponVos = goodsService.getMemberCouponList(sIdx);
		List<Member_ShippingAddressVO> member_ShipAddVos = goodsService.getMemberShipAddList(sIdx);
		
		OrderVO vo;
		for(int i = 0; i < order_ThumbNail.length; i++) {
			int goodsStockPrice=order_Stock[i]*order_Price[i];
			int expectPrice= goodsStockPrice * 5 / 100;
			vo = new OrderVO();
			vo.setOrder_ThumbNail(order_ThumbNail[i]);
			vo.setOrder_Name(order_Name[i]);
			vo.setOrder_Option(order_Option[i]);
			vo.setOrder_Stock(order_Stock[i]);
			vo.setOrder_Price(order_Price[i]);
			vo.setExpectPoint(expectPrice);
			vo.setGoodsStockPrice(goodsStockPrice);
			vo.setGoods_Idx(goods_Idx[i]);
			vo.setOption_Idx(option_Idx[i]);
			vos.add(vo);
		}
		
		model.addAttribute("sIdx",sIdx);
		model.addAttribute("couponVos",couponVos);
		model.addAttribute("memberVo",memberVo);
		model.addAttribute("member_ShipAddVos",member_ShipAddVos);
		model.addAttribute("totalPrice",totalPrice);
		model.addAttribute("vos",vos);
		return "goods/goodsPayment";
	}
	
	@Transactional
	@RequestMapping(value="/goodsPaymentOk", method=RequestMethod.POST)
	public String goodsPaymentGet(Model model, OrderHistoryVO vo,
			//@RequestParam(name = "coupon_Idx", defaultValue="",required=false) int coupon_Idx,
			@RequestParam(name = "goods_Idx", defaultValue="",required=false) int[] goods_Idx,
			@RequestParam(name = "option_Idx", defaultValue="",required=false) int[] option_Idx,
			@RequestParam(name = "goods_Stock", defaultValue="",required=false) int[] goods_Stock,
			@RequestParam(name = "totalPrice", defaultValue="",required=false) int[] totalPrice
			
			) {
		
		List<OrderHistory_DetailVO> vos = new ArrayList<>();
		
		OrderHistory_DetailVO ohdVo;
		for(int i = 0; i < goods_Idx.length; i++) {
			ohdVo = new OrderHistory_DetailVO();
			ohdVo.setGoods_Idx(goods_Idx[i]);
			ohdVo.setOption_Idx(option_Idx[i]);
			ohdVo.setGoods_Stock(goods_Stock[i]);
			ohdVo.setTotalPrice(totalPrice[i]);
			vos.add(ohdVo);
		}
		
		goodsService.setOrderHistory(vo);
		goodsService.setOrderHistory_Detail(vos);
		//적립금 주고
		//쿠폰 사용처리
		//적립금 감소처리
		
		return "goods/goodsPayMentOk";
	}
	
	@RequestMapping(value="/cart", method=RequestMethod.GET)
	public String goodsCartGet(Model model, HttpSession session) {
		int sIdx = (int) session.getAttribute("sIdx");
		List<OrderVO> vos = goodsService.getCartList(sIdx);
	    System.out.println(sIdx);
	    model.addAttribute("vos",vos);
		return "goods/goodsCart";
	}
	
	
	// 상품 뷰 창에서 옵션 장바구니에 넣기
	@ResponseBody
	@RequestMapping(value="/insertCartAJAX", method=RequestMethod.POST)
	public String insertCartAJAXPost(
			@RequestParam(name = "goods_Idx[]", defaultValue="",required=false) int[] goods_Idx,
			@RequestParam(name = "option_Idx[]", defaultValue="",required=false) int[] option_Idx,
			@RequestParam(name = "stock[]", defaultValue="",required=false) int[] stock,
			@RequestParam(name = "member_Idx", defaultValue="",required=false) String member_Idx
			) {
		List<OrderVO> vos = new ArrayList<>();
		
		OrderVO vo;
		for(int i = 0; i < goods_Idx.length; i++) {
			vo = new OrderVO();
			vo.setOrder_Stock(stock[i]);
			vo.setGoods_Idx(goods_Idx[i]);
			vo.setOption_Idx(option_Idx[i]);
			vos.add(vo);
		}
		goodsService.setInsertCart(vos,member_Idx);
		return "가즈아~";
	}
	
	@ResponseBody
	@RequestMapping(value="/deleteCartAJAX", method=RequestMethod.POST)
	public String deleteCartAJAXPost(@RequestParam(name = "cartArray[]", defaultValue="",required=false) int[] cartArray) {
		
		goodsService.setDeleteCart(cartArray);
		return "굿";
	}
	
	@ResponseBody
	@RequestMapping(value="/goodsStockAJAX", method=RequestMethod.POST)
	public List<Goods_StockVO> goodsStockAJAXPost(int goods_Idx) {
		List<Goods_StockVO> vos= goodsService.getGoodsStockAJAX(goods_Idx);
		return vos;
	}
	
	@ResponseBody
	@RequestMapping(value="/subCategoryList", method=RequestMethod.POST)
	public ArrayList<SubCategoryVO> subCategoryListPost(int mainCategory) {
		ArrayList<SubCategoryVO> vos= goodsService.getSubCateArrayList(mainCategory);
		return vos;
	}
	
	@ResponseBody
	@RequestMapping(value="/secondCategoryList", method=RequestMethod.POST)
	public ArrayList<SecondCategoryVO> secondCategoryListPost(int subCategory) {
		ArrayList<SecondCategoryVO> vos= goodsService.getSecondCateArrayList(subCategory);
		return vos;
	}
}