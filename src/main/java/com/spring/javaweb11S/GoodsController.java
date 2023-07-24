package com.spring.javaweb11S;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import com.spring.javaweb11S.vo.ExchangeVO;
import com.spring.javaweb11S.vo.Exchange_DetailVO;
import com.spring.javaweb11S.vo.GoodsVO;
import com.spring.javaweb11S.vo.Goods_StockVO;
import com.spring.javaweb11S.vo.MemberVO;
import com.spring.javaweb11S.vo.Member_ShippingAddressVO;
import com.spring.javaweb11S.vo.OrderHistoryVO;
import com.spring.javaweb11S.vo.OrderHistory_DetailVO;
import com.spring.javaweb11S.vo.OrderVO;
import com.spring.javaweb11S.vo.RefundVO;
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
	public String inquiryPopUpGet(Model model,
			@RequestParam(name="idx", defaultValue="", required=false) int idx,
			@RequestParam(name="goods_Idx", defaultValue="", required=false) int goods_Idx
			) {
		System.out.println(idx);
		List<Goods_StockVO> stockVos = goodsService.getGoodsStock(goods_Idx);
		OrderHistory_DetailVO vo = goodsService.getIdxOrderHistory_Detail(idx);
		model.addAttribute("vo",vo);
		model.addAttribute("stockVos",stockVos);
		model.addAttribute("goods_Idx",goods_Idx);
		return "goods/inquiryPopUp";
	}
	
	@Transactional
	@RequestMapping(value="/inquiryPopUp", method=RequestMethod.POST)
	public String inquiryPopUpPost(Model model, RefundVO refundVO, ExchangeVO exchangeVO, Exchange_DetailVO exchange_DetailVO,
			@RequestParam(name="category", defaultValue="", required=false) String category,
			@RequestParam(name="goods_Stock", defaultValue="", required=false) int goods_Stock,
			@RequestParam(name="option_Idx", defaultValue="", required=false) int[] option_Idx,
			@RequestParam(name="order_Stock", defaultValue="", required=false) int[] order_Stock
			) {
		if(category.equals("exchange")) {
			List<Exchange_DetailVO> vos = new ArrayList<>();
			Exchange_DetailVO vo;
			
			for(int i=0; i<option_Idx.length; i++) {
				vo = new Exchange_DetailVO();
				vo.setOption_Idx(option_Idx[i]);
				vo.setStock(order_Stock[i]);
				vos.add(vo);
			}
			goodsService.setExchangeGoods(exchangeVO, vos);
			goodsService.setExchange_DetailGoods(exchange_DetailVO, vos);
		
		} else if(category.equals("refund")) {
			goodsService.setRefundGoods(refundVO,order_Stock[0]);
			if(goods_Stock==order_Stock[0]) {
				goodsService.setUpdateOrderHistory_Detail(refundVO.getIdx());
			} else {
				System.out.println(order_Stock[0]);
				goodsService.setUpdateOrderHistory_Detail2(refundVO.getIdx(), order_Stock[0]);
			}
		}
		
		return "home";
	}
	
	@RequestMapping(value="/goodsPayment", method=RequestMethod.POST)
	public String goodsPaymentGet(Model model, HttpServletRequest request, HttpSession session,
			@RequestParam(name = "order_Stock", defaultValue="", required=false) int[] order_Stock,
			@RequestParam(name = "goods_Idx", defaultValue="", required=false) int[] goods_Idx,
			@RequestParam(name = "option_Idx", defaultValue="", required=false) int[] option_Idx,
			@RequestParam(name = "order_Option", defaultValue="", required=false) String[] order_Option,
			@RequestParam(name = "sIdx", defaultValue="", required=false) int sIdx,
			@RequestParam(name = "totalPrice", defaultValue="", required=false) int totalPrice,
			@RequestParam(name = "buyStatus", defaultValue="", required=false) String buyStatus
			) {
		
		List<OrderVO> vos = new ArrayList<>();
		
		MemberVO memberVo = goodsService.getOrderMemberInfo(sIdx);
		List<CouponVO> couponVos = goodsService.getMemberCouponList(sIdx);
		List<Member_ShippingAddressVO> member_ShipAddVos = goodsService.getMemberShipAddList(sIdx);
		
		String[] idxChecked = request.getParameterValues("idxChecked");
		
		OrderVO vo;
		if(buyStatus.equals("direct")) {
			for(int i = 0; i<idxChecked.length; i++) {
				GoodsVO goodsVo = goodsService.getGoodsDetail(Integer.parseInt(idxChecked[i]));

				vo = new OrderVO();
				vo.setOrder_ThumbNail(goodsVo.getThumbNail());
				vo.setOrder_Name(goodsVo.getName());
				vo.setOrder_Price(goodsVo.getPrice());
				vo.setOrder_Option(order_Option[i]);
				vo.setOrder_Stock(order_Stock[i]);
				vo.setGoods_Idx(goods_Idx[i]);
				vo.setOption_Idx(option_Idx[i]);
				vos.add(vo);
			}
		} else if(buyStatus.equals("cart")) {
			for(int i = 0; i<idxChecked.length; i++) {
				OrderVO vo2 = goodsService.getCart(Integer.parseInt(idxChecked[i]));

				vos.add(vo2);
			}
		}
		
		System.out.println(totalPrice+"dddd");
		model.addAttribute("sIdx",sIdx);
		model.addAttribute("couponVos",couponVos);
		model.addAttribute("memberVo",memberVo);
		model.addAttribute("member_ShipAddVos",member_ShipAddVos);
		model.addAttribute("totalPrice",totalPrice);
		model.addAttribute("buyStatus",buyStatus);
		model.addAttribute("vos",vos);
		return "goods/goodsPayment";
	}
	
	@Transactional
	@RequestMapping(value="/goodsPaymentOk", method=RequestMethod.POST)
	public String goodsPaymentGet(Model model, OrderHistoryVO vo, HttpSession session,
			@RequestParam(name = "coupon_Idx", defaultValue="",required=false) int coupon_Idx,
			@RequestParam(name = "goods_Idx", defaultValue="",required=false) int[] goods_Idx,
			@RequestParam(name = "option_Idx", defaultValue="",required=false) int[] option_Idx,
			@RequestParam(name = "goods_Stock", defaultValue="",required=false) int[] goods_Stock,
			@RequestParam(name = "totalPrice", defaultValue="",required=false) int[] totalPrice,
			@RequestParam(name = "cart_Idx", defaultValue="",required=false) int[] cart_Idx,
			@RequestParam(name = "usedPoint", defaultValue="",required=false) int usedPoint,
			@RequestParam(name = "savePoint", defaultValue="",required=false) int savePoint,
			@RequestParam(name = "buyStatus", defaultValue="",required=false) String buyStatus
			
			) {
		int sIdx = (int) session.getAttribute("sIdx");
		
		List<OrderHistory_DetailVO> vos = new ArrayList<>();
		
		OrderHistory_DetailVO ohdVo;
		for(int i = 0; i < goods_Idx.length; i++) {
			ohdVo = new OrderHistory_DetailVO();
			ohdVo.setGoods_Idx(goods_Idx[i]);
			ohdVo.setOption_Idx(option_Idx[i]);
			ohdVo.setGoods_Stock(goods_Stock[i]);
			ohdVo.setTotalPrice(totalPrice[i]);
			vos.add(ohdVo);
			System.out.println(totalPrice[i]+"ddd");
		}
		if(buyStatus.equals("cart")) {
			goodsService.setDeleteCart(cart_Idx);
		}
		goodsService.setOrderHistory(vo);
		goodsService.setOrderHistory_Detail(vos);
		if(usedPoint != 0) {
			goodsService.setMinusPoint(sIdx, usedPoint);
		}
		goodsService.setPlusPoint(sIdx, savePoint);
		if(coupon_Idx!=0) {
			goodsService.setUsedCoupon(coupon_Idx);
		}
		
		return "goods/goodsPayMentOk";
	}
	
	@RequestMapping(value="/cart", method=RequestMethod.GET)
	public String goodsCartGet(Model model, HttpSession session) {
		int sIdx = (int) session.getAttribute("sIdx");
		List<OrderVO> vos = goodsService.getCartList(sIdx);
	    //System.out.println(sIdx);
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
			int res = goodsService.getCartDupliCheck(vo,member_Idx);
			if(res==0) {
				goodsService.setInsertCart(vo,member_Idx);
			} else {
				goodsService.setUpdateCart(vo,member_Idx);
			}
		}
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