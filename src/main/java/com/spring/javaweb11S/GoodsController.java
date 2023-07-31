package com.spring.javaweb11S;

import java.util.ArrayList;
import java.util.List;

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

import com.spring.javaweb11S.pagination.PageProcess;
import com.spring.javaweb11S.pagination.PageVO;
import com.spring.javaweb11S.service.GoodsService;
import com.spring.javaweb11S.vo.BrandVO;
import com.spring.javaweb11S.vo.CartVO;
import com.spring.javaweb11S.vo.CategoryVO;
import com.spring.javaweb11S.vo.CouponVO;
import com.spring.javaweb11S.vo.ExchangeVO;
import com.spring.javaweb11S.vo.Exchange_DetailVO;
import com.spring.javaweb11S.vo.GoodsVO;
import com.spring.javaweb11S.vo.Goods_ImageVO;
import com.spring.javaweb11S.vo.Goods_StockVO;
import com.spring.javaweb11S.vo.MainCategoryVO;
import com.spring.javaweb11S.vo.MemberVO;
import com.spring.javaweb11S.vo.Member_ShippingAddressVO;
import com.spring.javaweb11S.vo.OrderHistoryVO;
import com.spring.javaweb11S.vo.OrderHistory_DetailVO;
import com.spring.javaweb11S.vo.OrderVO;
import com.spring.javaweb11S.vo.RefundVO;
import com.spring.javaweb11S.vo.ReviewVO;
import com.spring.javaweb11S.vo.SecondCategoryVO;
import com.spring.javaweb11S.vo.SubCategoryVO;

@Controller
@RequestMapping("/goods")
public class GoodsController {
	@Autowired
	GoodsService goodsService;
	
	@Autowired
	PageProcess pageProcess;
	
	@RequestMapping(value="/goodsList", method=RequestMethod.GET)
	public String goodsListGet(Model model,
		@RequestParam(name="brand_Idx", defaultValue="0", required=false) int brand_Idx,
		@RequestParam(name="mainCategory_Idx", defaultValue="0", required=false) int mainCategory_Idx,
		@RequestParam(name="subCategory_Idx", defaultValue="0", required=false) int subCategory_Idx,
		@RequestParam(name="secondCategory_Idx", defaultValue="0", required=false) int secondCategory_Idx,
		@RequestParam(name="pag", defaultValue="1",required=false) int pag,
		@RequestParam(name="pagSize", defaultValue="30",required=false) int pagSize
			) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pagSize, brand_Idx, mainCategory_Idx, subCategory_Idx, secondCategory_Idx);
		
		//List<MainCategoryVO> vos1 = goodsService.getMainCateArrayList();
		if(brand_Idx!=0&&mainCategory_Idx==0) {
			List<MainCategoryVO> mainCategory = goodsService.getMainCateArrayList();
			model.addAttribute("mainCategory",mainCategory);
		} else if(mainCategory_Idx != 0 && subCategory_Idx==0) {
			List<SubCategoryVO> subCategory = goodsService.getSubCateArrayList(mainCategory_Idx);
			model.addAttribute("subCategory",subCategory);
		} else if(subCategory_Idx!=0) {
			List<SecondCategoryVO> secondCategory = goodsService.getSecondCateArrayList(subCategory_Idx);
			model.addAttribute("secondCategory",secondCategory);
			
		}
		BrandVO brandVO = goodsService.getBrandVO(brand_Idx);
		
		List<GoodsVO> vos= goodsService.getGoodsList(pageVO);
		model.addAttribute("mainCategory_Idx",mainCategory_Idx);
		model.addAttribute("subCategory_Idx",subCategory_Idx);
		model.addAttribute("secondCategory_Idx",secondCategory_Idx);
		model.addAttribute("vos",vos);
		model.addAttribute("brandVO",brandVO);
		model.addAttribute("brand_Idx",brand_Idx);
		model.addAttribute("pageVO",pageVO);
		return "goods/goodsList";
	}
	
	@RequestMapping(value="/goodsViews",method=RequestMethod.GET)
	public String goodsViewGet(Model model,
			@RequestParam(name="idx", defaultValue="", required=false) int Goods_Idx,
			@RequestParam(name="pag", defaultValue="1",required=false) int pag,
			@RequestParam(name="pageSize", defaultValue="10",required=false) int pageSize
			) {
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "goods", Goods_Idx);
		
		List<Goods_StockVO> stockVos = goodsService.getGoodsStock(Goods_Idx);
		List<Goods_ImageVO> imageVos = goodsService.getGoodsImages(Goods_Idx);
		List<ReviewVO> reviewVos = goodsService.getReviewList(pageVO, Goods_Idx);
		GoodsVO goodsVo = goodsService.getGoodsDetail(Goods_Idx);
		CategoryVO categoryVo = goodsService.getGoodsCategory(goodsVo.getSecondCategory_Idx());
		BrandVO brandVo = goodsService.getBrandContent(Goods_Idx);
		
		model.addAttribute("stockVos",stockVos);
		model.addAttribute("imageVos",imageVos);
		model.addAttribute("reviewVos",reviewVos);
		model.addAttribute("goodsVo",goodsVo);
		model.addAttribute("categoryVo",categoryVo);
		model.addAttribute("brandVo",brandVo);
		model.addAttribute("pageVO",pageVO);
		return "goods/goodsViews";
	}
	
	@RequestMapping(value="/inquiryPopUp", method=RequestMethod.GET)
	public String inquiryPopUpGet(Model model, HttpSession session,
			@RequestParam(name="idx", defaultValue="", required=false) int idx,
			@RequestParam(name="goods_Idx", defaultValue="", required=false) int goods_Idx,
			@RequestParam(name="orderHistory_Idx", defaultValue="", required=false) int orderHistory_Idx
			) {
		System.out.println(idx);
		int sIdx = (int) session.getAttribute("sIdx");
		List<Goods_StockVO> stockVos = goodsService.getGoodsStock(goods_Idx);
		OrderHistory_DetailVO vo = goodsService.getIdxOrderHistory_Detail(idx);
		MemberVO memberVO = goodsService.getOrderMemberInfo(sIdx);
		model.addAttribute("vo",vo);
		model.addAttribute("stockVos",stockVos);
		model.addAttribute("memberVO",memberVO);
		model.addAttribute("goods_Idx",goods_Idx);
		session.setAttribute("sOhdIdx", idx);
		session.setAttribute("sGoods_Idx", goods_Idx);
		session.setAttribute("sOhIdx", orderHistory_Idx);
		
		return "goods/inquiryPopUp";
	}
	
	@Transactional
	@RequestMapping(value="/inquiryPopUp", method=RequestMethod.POST)
	public String inquiryPopUpPost(HttpSession session, Model model, RefundVO refundVO, ExchangeVO exchangeVO, Exchange_DetailVO exchange_DetailVO,
			@RequestParam(name="category", defaultValue="", required=false) String category,
			@RequestParam(name="goods_Idx", defaultValue="", required=false) int goods_Idx,
			@RequestParam(name="exchangeOption_Idx", defaultValue="0", required=false) int[] exchangeOption_Idx,
			@RequestParam(name="refundOption_Idx", defaultValue="0", required=false) int refundOption_Idx,
			@RequestParam(name="order_Stock", defaultValue="", required=false) int[] order_Stock,
			@RequestParam(name="idx", defaultValue="", required=false) int orderHistory_Detail_Idx
			) {
		int sIdx = (int) session.getAttribute("sIdx");
		int sOhdIdx = (int) session.getAttribute("sOhdIdx");
		int sGoods_Idx = (int) session.getAttribute("sGoods_Idx");
		int sOhIdx = (int) session.getAttribute("sOhIdx");
		OrderHistory_DetailVO ohdVO = goodsService.getIdxOrderHistory_Detail(sOhdIdx);
		GoodsVO goodsVO = goodsService.getGoodsDetail(goods_Idx);
		
		System.out.println(sOhdIdx+""+sGoods_Idx+""+sOhIdx);
		
		if(category.equals("exchange")) {
			exchangeVO.setMember_Idx(sIdx);
			List<OrderVO> vos = new ArrayList<>();
			OrderVO vo;
			int totalStock=0;
			for(int i=0; i<exchangeOption_Idx.length; i++) {
				vo = new OrderVO();
				vo.setOrder_Stock(order_Stock[i]);
				vo.setGoods_Idx(goods_Idx);
				vo.setOption_Idx(exchangeOption_Idx[i]);
				totalStock += order_Stock[i];
				vos.add(vo);
			}
			exchangeVO.setIdx(sOhdIdx);
			goodsService.setInsertExchangeOrderHistory(exchangeVO);
			goodsService.setInsertExchangeOrderHistory_Detail(vos);
			
//			List<Exchange_DetailVO> edVos = new ArrayList<>();
//			Exchange_DetailVO edVo;
//			for(int i=0; i<exchangeOption_Idx.length; i++) {
//				edVo = new Exchange_DetailVO();
//				edVo.setGoods_Idx(sGoods_Idx);
//				edVo.setOption_Idx(exchangeOption_Idx[i]);
//				edVo.setStock(order_Stock[i]);
//				edVos.add(edVo);
//			}
//			goodsService.setExchangeGoods(exchangeVO);
//			goodsService.setExchange_DetailGoods(exchange_DetailVO, edVos);
			
			if(ohdVO.getGoods_Stock()==totalStock) {
				int cnt = goodsService.getOrderHistory_DetailCnt(sOhIdx);
				goodsService.setDeleteOrderHistory_Detail(sOhdIdx);
				if(cnt==1) {
					goodsService.setDeleteOrderHistory(sOhIdx);
				} else {
					goodsService.setUpdateOrderHistory(sOhIdx, sOhdIdx, totalStock, goodsVO.getPrice()*totalStock);
				}
			} else {
				goodsService.setUpdateOrderHistory_Detail(sOhdIdx, totalStock);
				goodsService.setUpdateOrderHistory(sOhIdx, sOhdIdx, totalStock, goodsVO.getPrice()*totalStock);
			}
		
		} else if(category.equals("refund")) {
			refundVO.setMember_Idx(sIdx);
			refundVO.setRefund_Price(goodsVO.getPrice()*order_Stock[0]-3000);
			OrderVO vo = new OrderVO();
			vo.setOrder_Stock(order_Stock[0]);
			vo.setGoods_Idx(goods_Idx);
			vo.setOption_Idx(refundOption_Idx);
			
			refundVO.setIdx(sOhdIdx);
			goodsService.setInsertRefundOrderHistory(refundVO);
			goodsService.setInsertRefundOrderHistory_Detail(vo);
//			goodsService.setRefundGoods(refundVO, order_Stock[0]);
			//기존 주문내역 수정 or 삭제하기
			if(ohdVO.getGoods_Stock()==order_Stock[0]) { //만약 기존 주문내역에서 모두 환불을 했을 시 
				int cnt = goodsService.getOrderHistory_DetailCnt(sOhIdx); //주문내역의 상세 개수를 가져온다.
				goodsService.setDeleteOrderHistory_Detail(sOhdIdx); //기존 주문내역에서 모두 환불 했기 때문에 삭제 처리 
				
				if(cnt==1) {
					goodsService.setDeleteOrderHistory(sOhIdx); //주문 내역의 상세내역이 없기 때문에 주문내역 삭제 처리
				} else {
					goodsService.setUpdateOrderHistory(sOhIdx, sOhdIdx, order_Stock[0], goodsVO.getPrice()*order_Stock[0]); //하나라도 남아있다면 정보만 반경
				}
			} else { //일부만 했을 시
				goodsService.setUpdateOrderHistory_Detail(sOhdIdx, order_Stock[0]); //일부만 환불 했을 경우 기존 주문내역 일부만 수정
				goodsService.setUpdateOrderHistory(sOhIdx, sOhdIdx, order_Stock[0], goodsVO.getPrice()*order_Stock[0]); //이하 동문
			}
		}
		session.removeAttribute("sOhdIdx");
		session.removeAttribute("sGoods_Idx");
		session.removeAttribute("sOhIdx");
		return "redirect:/member/memberMyPage";
	}
	
	//결제창으로 들어오기
	@RequestMapping(value="/goodsPayment", method=RequestMethod.POST)
	public String goodsPaymentPost(Model model, HttpServletRequest request, HttpSession session,
			@RequestParam(name = "order_Stock", defaultValue="", required=false) int[] order_Stock,
			@RequestParam(name = "goods_Idx", defaultValue="", required=false) int[] goods_Idx,
			@RequestParam(name = "option_Idx", defaultValue="", required=false) int[] option_Idx,
			@RequestParam(name = "order_Option", defaultValue="", required=false) String[] order_Option,
			@RequestParam(name = "sIdx", defaultValue="", required=false) int sIdx,
			@RequestParam(name = "finalPrice", defaultValue="", required=false) int finalPrice,
			@RequestParam(name = "buyStatus", defaultValue="", required=false) String buyStatus
			) {
		
		List<OrderVO> vos = new ArrayList<>();
		
		MemberVO memberVo = goodsService.getOrderMemberInfo(sIdx);
		List<CouponVO> couponVos = goodsService.getMemberCouponList(sIdx);
		List<Member_ShippingAddressVO> member_ShipAddVos = goodsService.getMemberShipAddList(sIdx);
		
		OrderVO vo;
		if(buyStatus.equals("direct")) {
			for(int i = 0; i<order_Option.length; i++) {
				//GoodsVO goodsVo = goodsService.getGoodsDetail(Integer.parseInt(idxChecked[i]));
				GoodsVO goodsVo = goodsService.getGoodsDetail(goods_Idx[0]);

				vo = new OrderVO();
				vo.setOrder_ThumbNail(goodsVo.getThumbNail());
				vo.setOrder_Name(goodsVo.getName());
				vo.setOrder_Price(goodsVo.getPrice());
				vo.setOrder_Brand(goodsVo.getBrand_Name());
				vo.setOrder_Option(order_Option[i]);
				vo.setOrder_Stock(order_Stock[i]);
				vo.setGoods_Idx(goods_Idx[i]);
				vo.setOption_Idx(option_Idx[i]);
				
				vos.add(vo);
			}
		} else if(buyStatus.equals("cart")) { //장바구니는 db에 정보가 있으니 가져오기만 하면 된다.
			String[] idxChecked = request.getParameterValues("idxChecked");
			for(int i = 0; i<idxChecked.length; i++) {
				System.out.println("장바구니번호"+idxChecked[i]);
				OrderVO vo2 = goodsService.getCart(Integer.parseInt(idxChecked[i]));
				vos.add(vo2);
			}
		}
		
		model.addAttribute("sIdx",sIdx);
		model.addAttribute("couponVos",couponVos);
		model.addAttribute("memberVo",memberVo);
		model.addAttribute("member_ShipAddVos",member_ShipAddVos);
		model.addAttribute("finalPrice",finalPrice);
		model.addAttribute("buyStatus",buyStatus);
		model.addAttribute("vos",vos);
		session.setAttribute("sVos", vos);
		return "goods/goodsPayment";
	}
	
	//결제창에서 결제하기 눌렀을 때 가는 곳
	@SuppressWarnings("unchecked")
	@Transactional
	@RequestMapping(value="/goodsPaymentOk", method=RequestMethod.POST)
	public String goodsPaymentLoadingPost(Model model, OrderHistoryVO vo, HttpSession session,
			@RequestParam(name = "cart_Idx", defaultValue="",required=false) int[] cart_Idx,
			@RequestParam(name = "coupon_Idx", defaultValue="",required=false) int coupon_Idx,
			@RequestParam(name = "usedPoint", defaultValue="",required=false) int usedPoint,
			@RequestParam(name = "buyStatus", defaultValue="",required=false) String buyStatus,
			@RequestParam(name = "finalPrice", defaultValue="",required=false) int finalPrice,
			@RequestParam(name = "payMentInfo1", defaultValue="",required=false) String payMentInfo1,
			@RequestParam(name = "payMentInfo2", defaultValue="",required=false) String payMentInfo2,
			@RequestParam(name = "payMentInfo3", defaultValue="",required=false) String payMentInfo3,
			@RequestParam(name = "payMentInfo4", defaultValue="",required=false) String payMentInfo4
			) {
		int sIdx = (int) session.getAttribute("sIdx");
		
		List<OrderVO> vos = (List<OrderVO>) session.getAttribute("sVos");
		
		vo.setMember_Idx(sIdx);
		
		if(buyStatus.equals("cart")) {
			goodsService.setDeleteCart(cart_Idx); //카트에서 주문한거면 처리해야
		}
		
		goodsService.setUpdateGoodsStock(vos); //수량 감소 처리
		goodsService.setOrderHistory(vo); //주문 내역 작성
		goodsService.setOrderHistory_Detail(vos); //주문 세부내역 작성
		
		int res = goodsService.getSelectSameMemberAddress(vo);
		if(res==0) {
			goodsService.setInsertMemberAddress(vo);
		}
		
		if(usedPoint != 0) {
			goodsService.setMinusPoint(sIdx, usedPoint); //포인트 사용처리
		}
		
		if(coupon_Idx!=0) {
			goodsService.setUsedCoupon(coupon_Idx); //쿠폰 사용처리
		}
		
		model.addAttribute("vos",vos);
		model.addAttribute("payMentInfo1",payMentInfo1);
		model.addAttribute("payMentInfo2",payMentInfo2);
		model.addAttribute("payMentInfo3",payMentInfo3);
		model.addAttribute("payMentInfo4",payMentInfo4);
//		session.removeAttribute("sVos");
		 
		return "goods/goodsPayMentOk";
	}
	
	@RequestMapping(value="/cart", method=RequestMethod.GET)
	public String goodsCartGet(Model model, HttpSession session) {
		int sIdx = (int) session.getAttribute("sIdx");
		List<CartVO> vos = goodsService.getCartList(sIdx);
	    //System.out.println(sIdx);
	    model.addAttribute("vos",vos);
		return "goods/goodsCart";
	}
	
	@RequestMapping(value="/brandList", method=RequestMethod.GET)
	public String goodsBrandListGet(Model model) {
		List<BrandVO> vos = goodsService.getBrandList();
		
		model.addAttribute("vos",vos);
		return "goods/goodsBrandList";
	}
	
	@RequestMapping(value="/drawList", method=RequestMethod.GET)
	public String goodsDrawListGet() {
		
		return "goods/goodsDrawList";
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
	@RequestMapping(value="/updateCartStockAJAX", method=RequestMethod.POST)
	public String updateCartStockAJAXPost(int cart_Idx, String str) {
		
		System.out.println(str);
		goodsService.setUpdateCartStock(cart_Idx, str);
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