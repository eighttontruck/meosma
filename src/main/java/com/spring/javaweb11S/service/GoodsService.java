package com.spring.javaweb11S.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb11S.vo.MainCategoryVO;
import com.spring.javaweb11S.vo.MemberVO;
import com.spring.javaweb11S.vo.Member_ShippingAddressVO;
import com.spring.javaweb11S.vo.OrderHistoryVO;
import com.spring.javaweb11S.vo.OrderHistory_DetailVO;
import com.spring.javaweb11S.vo.OrderVO;
import com.spring.javaweb11S.vo.RefundVO;
import com.spring.javaweb11S.vo.ReviewVO;
import com.spring.javaweb11S.pagination.PageVO;
import com.spring.javaweb11S.vo.BrandVO;
import com.spring.javaweb11S.vo.CartVO;
import com.spring.javaweb11S.vo.CategoryVO;
import com.spring.javaweb11S.vo.CouponVO;
import com.spring.javaweb11S.vo.ExchangeVO;
import com.spring.javaweb11S.vo.Exchange_DetailVO;
import com.spring.javaweb11S.vo.GoodsVO;
import com.spring.javaweb11S.vo.Goods_ImageVO;
import com.spring.javaweb11S.vo.Goods_StockVO;
import com.spring.javaweb11S.vo.SecondCategoryVO;
import com.spring.javaweb11S.vo.SubCategoryVO;

public interface GoodsService {

	public List<GoodsVO> getGoodsList(PageVO pageVO);

	public GoodsVO getGoodsDetail(int goods_Idx);
	
	public List<Goods_StockVO> getGoodsStock(int goods_Idx);

	public ArrayList<MainCategoryVO> getMainCateArrayList();
	
	public ArrayList<SubCategoryVO> getSubCateArrayList(int mainCategory);

	public ArrayList<SecondCategoryVO> getSecondCateArrayList(int subCategory);
	
	public void setGoodsStockRegister(Map<String, Integer> vos);

	public ArrayList<BrandVO> getBrandList();

	public void setGoodsRegister(GoodsVO vo);

	public String fileUpload(MultipartFile fName, GoodsVO vo);

	public CategoryVO getGoodsCategory(int secondCategory_Idx);

	public MemberVO getOrderMemberInfo(int sIdx);

	public List<CouponVO> getMemberCouponList(int sIdx);

	public BrandVO getBrandContent(int goods_Idx);

	public List<GoodsVO> getGoodsTableList();

	public List<Goods_StockVO> getGoodsStockAJAX(int goods_Idx);

	public List<Member_ShippingAddressVO> getMemberShipAddList(int sIdx);

	public void setOrderHistory(OrderHistoryVO vo);

	public void setOrderHistory_Detail(List<OrderVO> vos);

	public void setInsertCart(OrderVO vo, String member_Idx);

	public List<CartVO> getCartList(int sIdx);

	public void setDeleteCart(int[] cartArray);

	public OrderVO getCart(int cart_Idx);

	public void setMinusPoint(int sIdx, int usedPoint);

	public void setPlusPoint(int sIdx, int savePoint);

	public void setUsedCoupon(int coupon_Idx);

	public OrderHistory_DetailVO getIdxOrderHistory_Detail(int idx);

	public void setRefundGoods(RefundVO refundVO, int order_Stock);

	public void setExchangeGoods(ExchangeVO exchangeVO);

	public void setExchange_DetailGoods(Exchange_DetailVO exchange_DetailVO, List<Exchange_DetailVO> vos);

	public void setUpdateOrderHistory_Detail(int orderHistory_Detail_Idx, int totalStock);

	public void setUpdateOrderHistory_Detail2(int orderHistory_Detail_Idx, int i);

	public int getCartDupliCheck(OrderVO vo, String member_Idx);

	public void setUpdateCart(OrderVO vo, String member_Idx);

	public void setUpdateGoodsStock(List<OrderVO> vos);

	public void setUpdateCartStock(int cart_Idx, String str);

	public List<Goods_ImageVO> getGoodsImages(int goods_Idx);

	public void setInsertExchangeOrderHistory(ExchangeVO exchangeVO);

	public void setInsertExchangeOrderHistory_Detail(List<OrderVO> vos);

	public int getOrderHistory_DetailCnt(int sOhIdx);

	public void setDeleteOrderHistory_Detail(int orderHistory_Detail_Idx);

	public void setDeleteOrderHistory(int sOhIdx);

	public void setUpdateOrderHistory(int sOhIdx, int sOhdIdx, int totalStock, int updatePrice);

	public void setInsertRefundOrderHistory(RefundVO refundVO);

	public void setInsertRefundOrderHistory_Detail(OrderVO vo);

	public List<ReviewVO> getReviewList(PageVO pageVO, int goods_Idx);

	public BrandVO getBrandVO(int brand_Idx);

	public int getSelectSameMemberAddress(OrderHistoryVO vo);

	public void setInsertMemberAddress(OrderHistoryVO vo);




}