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
import com.spring.javaweb11S.vo.BrandVO;
import com.spring.javaweb11S.vo.CategoryVO;
import com.spring.javaweb11S.vo.CouponVO;
import com.spring.javaweb11S.vo.GoodsVO;
import com.spring.javaweb11S.vo.Goods_StockVO;
import com.spring.javaweb11S.vo.SecondCategoryVO;
import com.spring.javaweb11S.vo.SubCategoryVO;

public interface GoodsService {

	public List<GoodsVO> getGoodsList();

	public GoodsVO getGoodsDetail(int goods_Idx);
	
	public List<Goods_StockVO> getGoodsStock(int goods_Idx);

	public ArrayList<MainCategoryVO> getMainCateArrayList();
	
	public ArrayList<SubCategoryVO> getSubCateArrayList(int mainCategory);

	public ArrayList<SecondCategoryVO> getSecondCateArrayList(int subCategory);
	
	public void setGoodsStockRegister(Map<String, Integer> vos);

	public ArrayList<BrandVO> getBrandList();

	public void setGoodsRegister(GoodsVO vo);

	public String fileUpload(MultipartFile fName, GoodsVO vo);

	public CategoryVO getGoodsCategory(int secondCatagory_Idx);

	public MemberVO getOrderMemberInfo(int sIdx);

	public List<CouponVO> getMemberCouponList(int sIdx);

	public BrandVO getBrandContent(int goods_Idx);

	public List<GoodsVO> getGoodsTableList();

	public List<Goods_StockVO> getGoodsStockAJAX(int goods_Idx);

	public List<Member_ShippingAddressVO> getMemberShipAddList(int sIdx);

	public void setOrderHistory(OrderHistoryVO vo);

	public void setOrderHistory_Detail(List<OrderHistory_DetailVO> vos);

	public void setInsertCart(List<OrderVO> vos, String member_Idx);

	public List<OrderVO> getCartList(int sIdx);

	public void setDeleteCart(int[] cartArray);

	public OrderVO getCart(int cart_Idx);

	public void setMinusPoint(int sIdx, int usedPoint);

	public void setPlusPoint(int sIdx, int savePoint);

	public void setUsedCoupon(int coupon_Idx);

	public OrderHistory_DetailVO getIdxOrderHistory_Detail(int idx);



}