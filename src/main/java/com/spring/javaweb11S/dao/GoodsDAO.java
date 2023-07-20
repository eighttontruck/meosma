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
import com.spring.javaweb11S.vo.BrandVO;
import com.spring.javaweb11S.vo.CategoryVO;
import com.spring.javaweb11S.vo.CouponVO;
import com.spring.javaweb11S.vo.GoodsVO;
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

	public CategoryVO getGoodsCategory(@Param("secondCatagory_Idx") int secondCatagory_Idx);

	public MemberVO getOrderMemberInfo(@Param("sIdx") int sIdx);

	public List<CouponVO> getMemberCouponList(@Param("sIdx") int sIdx);

	public void setBrandRegister(@Param("vo") BrandVO vo);

	public BrandVO getBrandContent(@Param("goods_Idx") int goods_Idx);

	public List<GoodsVO> getGoodsTableList();

	public List<Goods_StockVO> getGoodsStockAJAX(@Param("goods_Idx") int goods_Idx);

	public List<Member_ShippingAddressVO> getMemberShipAddList(@Param("sIdx") int sIdx);

	public void setOrderHistory(@Param("vo") OrderHistoryVO vo);

	public void setOrderHistory_Detail(@Param("vos") List<OrderHistory_DetailVO> vos);

	public int totRecCnt();

	public void setInsertCart(@Param("vos") List<OrderVO> vos, @Param("member_Idx") String member_Idx);

	public List<OrderVO> getCartList(@Param("sIdx") int sIdx);

	public void setDeleteCart(@Param("cartArray") int[] cartArray);

	public OrderVO getCart(@Param("cart_Idx") int cart_Idx);

	public void setMinusPoint(@Param("sIdx") int sIdx, @Param("usedPoint") int usedPoint);

	public void setPlusPoint(@Param("sIdx") int sIdx, @Param("savePoint") int savePoint);

	public void setUsedCoupon(@Param("coupon_Idx") int coupon_Idx);

	public OrderHistory_DetailVO getIdxOrderHistory_Detail(@Param("idx") int idx);


}