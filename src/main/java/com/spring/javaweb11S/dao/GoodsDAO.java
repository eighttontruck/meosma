package com.spring.javaweb11S.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb11S.vo.MainCategoryVO;
import com.spring.javaweb11S.vo.MemberVO;
import com.spring.javaweb11S.vo.Member_ShippingAddressVO;
import com.spring.javaweb11S.vo.OrderHistoryVO;
import com.spring.javaweb11S.vo.OrderHistory_DetailVO;
import com.spring.javaweb11S.vo.OrderVO;
import com.spring.javaweb11S.vo.RefundVO;
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

public interface GoodsDAO {

	public List<GoodsVO> getGoodsList();

	public GoodsVO getGoodsDetail(@Param("goods_Idx") int goods_Idx);

	public List<Goods_StockVO> getGoodsStock(@Param("goods_Idx") int goods_Idx);
	
	public void setGoodsStockRegister(@Param("vos") Map<String, Integer> vos);

	public ArrayList<MainCategoryVO> getMainCateArrayList();
	
	public ArrayList<SubCategoryVO> getSubCateArrayList(@Param("mainCategory") int mainCategory);

	public ArrayList<SecondCategoryVO> getSecondCateArrayList(@Param("subCategory") int subCategory);

	public ArrayList<BrandVO> getBrandList();

	public void setGoodsRegister(@Param("vo") GoodsVO vo);

	public CategoryVO getGoodsCategory(@Param("secondCategory_Idx") int secondCategory_Idx);

	public MemberVO getOrderMemberInfo(@Param("sIdx") int sIdx);

	public List<CouponVO> getMemberCouponList(@Param("sIdx") int sIdx);

	public void setBrandRegister(@Param("vo") BrandVO vo);

	public BrandVO getBrandContent(@Param("goods_Idx") int goods_Idx);

	public List<GoodsVO> getGoodsTableList();

	public List<Goods_StockVO> getGoodsStockAJAX(@Param("goods_Idx") int goods_Idx);

	public List<Member_ShippingAddressVO> getMemberShipAddList(@Param("sIdx") int sIdx);

	public void setOrderHistory(@Param("vo") OrderHistoryVO vo);

	public void setOrderHistory_Detail(@Param("vos") List<OrderVO> vos);

	public int totRecCnt();

	public void setInsertCart(@Param("vo") OrderVO vo, @Param("member_Idx") String member_Idx);

	public List<CartVO> getCartList(@Param("sIdx") int sIdx);

	public void setDeleteCart(@Param("cartArray") int[] cartArray);

	public OrderVO getCart(@Param("cart_Idx") int cart_Idx);

	public void setMinusPoint(@Param("sIdx") int sIdx, @Param("usedPoint") int usedPoint);

	public void setPlusPoint(@Param("sIdx") int sIdx, @Param("savePoint") int savePoint);

	public void setUsedCoupon(@Param("coupon_Idx") int coupon_Idx);

	public OrderHistory_DetailVO getIdxOrderHistory_Detail(@Param("idx") int idx);

	public void setRefundGoods(@Param("refundVO") RefundVO refundVO, @Param("order_Stock") int order_Stock);

	public void setExchangeGoods(@Param("exchangeVO") ExchangeVO exchangeVO, @Param("vos") List<Exchange_DetailVO> vos);

	public void setExchange_DetailGoods(@Param("exchange_DetailVO") Exchange_DetailVO exchange_DetailVO, @Param("vos") List<Exchange_DetailVO> vos);

	public void setUpdateOrderHistory_Detail(@Param("orderHistory_Detail_Idx") int orderHistory_Detail_Idx, @Param("totalStock") int totalStock);

	public void setUpdateOrderHistory_Detail2(@Param("orderHistory_Detail_Idx") int orderHistory_Detail_Idx, @Param("i") int i);

	public int getCartDupliCheck(@Param("vo") OrderVO vo, @Param("member_Idx") String member_Idx);

	public void setUpdateCart(@Param("vo") OrderVO vo, @Param("member_Idx") String member_Idx);

	public void setUpdateGoodsStock(@Param("vos") List<OrderVO> vos);

	public void setUpdateCartStock(@Param("cart_Idx") int cart_Idx, @Param("str") String str);

	public List<Goods_ImageVO> getGoodsImages(@Param("goods_Idx") int goods_Idx);

	public void setInsertExchangeOrderHistory(@Param("exchangeVO") ExchangeVO exchangeVO);

	public void setInsertExchangeOrderHistory_Detail(@Param("vos") List<OrderVO> vos);

	public int getOrderHistory_DetailCnt(@Param("sOhIdx") int sOhIdx);

	public void setDeleteOrderHistory(@Param("sOhIdx") int sOhIdx);

	public void setDeleteOrderHistory_Detail(@Param("orderHistory_Detail_Idx") int orderHistory_Detail_Idx);

	public void setUpdateOrderHistory(@Param("sOhIdx") int sOhIdx, @Param("totalStock") int totalStock, @Param("sOhdIdx") int sOhdIdx, @Param("updatePrice") int updatePrice);

	public void setInsertRefundOrderHistory(@Param("refundVO") RefundVO refundVO);

	public void setInsertRefundOrderHistory_Detail(@Param("vo") OrderVO vo);


}