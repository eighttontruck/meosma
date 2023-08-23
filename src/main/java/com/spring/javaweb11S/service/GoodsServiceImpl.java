package com.spring.javaweb11S.service;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb11S.dao.GoodsDAO;
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
import com.spring.javaweb11S.vo.InquiryVO;
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

@Service
public class GoodsServiceImpl implements GoodsService {
	@Autowired
	GoodsDAO goodsDAO;
	
	@Override
	public List<GoodsVO> getGoodsList(PageVO pageVO) {
		return goodsDAO.getGoodsList(pageVO);
	}

	@Override
	public GoodsVO getGoodsDetail(int goods_Idx) {
		return goodsDAO.getGoodsDetail(goods_Idx);
	}

	@Override
	public List<Goods_StockVO> getGoodsStock(int goods_Idx) {
		return goodsDAO.getGoodsStock(goods_Idx);
	}
	
	@Override
	public ArrayList<MainCategoryVO> getMainCateArrayList() {
		return goodsDAO.getMainCateArrayList();
	}
	
	@Override
	public ArrayList<SubCategoryVO> getSubCateArrayList(int mainCategory) {
		return goodsDAO.getSubCateArrayList(mainCategory);
	}

	@Override
	public ArrayList<SecondCategoryVO> getSecondCateArrayList(int subCategory) {
		return goodsDAO.getSecondCateArrayList(subCategory);
	}

	@Override
	public void setGoodsStockRegister(Map<String, Integer> vos) {
		goodsDAO.setGoodsStockRegister(vos);
	}

	@Override
	public ArrayList<BrandVO> getBrandList() {
		return goodsDAO.getBrandList();
	}

	@Override
	public void setGoodsRegister(GoodsVO vo) {
		goodsDAO.setGoodsRegister(vo);
		
	}

	@Override
	public String fileUpload(MultipartFile fName, GoodsVO vo) {
		String fileName="";
		
		UUID uid = UUID.randomUUID();
		String oFileName = fName.getOriginalFilename();
		String saveFileName = vo.getBrand_Idx()+"_"+vo.getName()+"_"+uid+"_"+oFileName;
		System.out.println("파일명:"+oFileName);
		
		try {
			writeFile(fName,saveFileName);
			fileName = saveFileName;
		} catch(IOException e) {
			e.printStackTrace();
		}
		
		return fileName;
	}
	
	@Override
	public String fileUpload(MultipartFile fName, InquiryVO vo) {
		String fileName="";
		
		UUID uid = UUID.randomUUID();
		String oFileName = fName.getOriginalFilename();
		String saveFileName = vo.getMember_Idx()+"_"+vo.getTitle()+"_"+uid+"_"+oFileName;
		System.out.println("파일명:"+oFileName);
		
		try {
			writeFile(fName,saveFileName);
			fileName = saveFileName;
		} catch(IOException e) {
			e.printStackTrace();
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
	public CategoryVO getGoodsCategory(int secondCategory_Idx) {
		return goodsDAO.getGoodsCategory(secondCategory_Idx);
	}

	@Override
	public MemberVO getOrderMemberInfo(int sIdx) {
		return goodsDAO.getOrderMemberInfo(sIdx);
	}

	@Override
	public List<CouponVO> getMemberCouponList(int sIdx) {
		return goodsDAO.getMemberCouponList(sIdx);
	}

	@Override
	public BrandVO getBrandContent(int goods_Idx) {
		return goodsDAO.getBrandContent(goods_Idx);
	}

	@Override
	public List<GoodsVO> getGoodsTableList() {
		return goodsDAO.getGoodsTableList();
	}

	@Override
	public List<Goods_StockVO> getGoodsStockAJAX(int goods_Idx) {
		return goodsDAO.getGoodsStockAJAX(goods_Idx);
	}

	@Override
	public List<Member_ShippingAddressVO> getMemberShipAddList(int sIdx) {
		return goodsDAO.getMemberShipAddList(sIdx);
	}

	@Override
	public void setOrderHistory(OrderHistoryVO vo) {
		goodsDAO.setOrderHistory(vo);
		
	}

	@Override
	public void setOrderHistory_Detail(List<OrderVO> vos) {
		goodsDAO.setOrderHistory_Detail(vos);
		
	}

	@Override
	public void setInsertCart(OrderVO vo, String member_Idx) {
		goodsDAO.setInsertCart(vo, member_Idx);
		
	}

	@Override
	public List<CartVO> getCartList(int sIdx) {
		return goodsDAO.getCartList(sIdx);
	}

	@Override
	public void setDeleteCart(int[] cartArray) {
		goodsDAO.setDeleteCart(cartArray);
		
	}

	@Override
	public OrderVO getCart(int cart_Idx) {
		return goodsDAO.getCart(cart_Idx);
	}

	@Override
	public void setMinusPoint(int sIdx, int usedPoint) {
		goodsDAO.setMinusPoint(sIdx, usedPoint);
		
	}

	@Override
	public void setPlusPoint(int sIdx, int savePoint) {
		goodsDAO.setPlusPoint(sIdx, savePoint);
	}

	@Override
	public void setUsedCoupon(int coupon_Idx) {
		goodsDAO.setUsedCoupon(coupon_Idx);
	}

	@Override
	public OrderHistory_DetailVO getIdxOrderHistory_Detail(int idx) {
		return goodsDAO.getIdxOrderHistory_Detail(idx);
	}

	@Override
	public void setRefundGoods(RefundVO refundVO, int order_Stock) {
		goodsDAO.setRefundGoods(refundVO, order_Stock);
		
	}

	@Override
	public void setExchangeGoods(ExchangeVO exchangeVO) {
		goodsDAO.setExchangeGoods(exchangeVO);
		
	}

	@Override
	public void setExchange_DetailGoods(Exchange_DetailVO exchange_DetailVO, List<Exchange_DetailVO> vos) {
		goodsDAO.setExchange_DetailGoods(exchange_DetailVO, vos);
		
	}

	@Override
	public void setUpdateOrderHistory_Detail(int orderHistory_Detail_Idx, int totalStock) {
		goodsDAO.setUpdateOrderHistory_Detail(orderHistory_Detail_Idx, totalStock);
		
	}

	@Override
	public void setUpdateOrderHistory_Detail2(int orderHistory_Detail_Idx, int i) {
		goodsDAO.setUpdateOrderHistory_Detail2(orderHistory_Detail_Idx, i);
		
	}

	@Override
	public int getCartDupliCheck(OrderVO vo, String member_Idx) {
		return goodsDAO.getCartDupliCheck(vo, member_Idx);
	}

	@Override
	public void setUpdateCart(OrderVO vo, String member_Idx) {
		goodsDAO.setUpdateCart(vo, member_Idx);
	}

	@Override
	public void setUpdateGoodsStock(List<OrderVO> vos) {
		goodsDAO.setUpdateGoodsStock(vos);
	}

	@Override
	public void setUpdateCartStock(int cart_Idx, String str) {
		goodsDAO.setUpdateCartStock(cart_Idx, str);
		
	}

	@Override
	public List<Goods_ImageVO> getGoodsImages(int goods_Idx) {
		return goodsDAO.getGoodsImages(goods_Idx);
	}

	@Override
	public void setInsertExchangeOrderHistory(ExchangeVO exchangeVO) {
		goodsDAO.setInsertExchangeOrderHistory(exchangeVO);
		
	}

	@Override
	public void setInsertExchangeOrderHistory_Detail(List<OrderVO> vos) {
		goodsDAO.setInsertExchangeOrderHistory_Detail(vos);
		
	}

	@Override
	public int getOrderHistory_DetailCnt(int sOhIdx) {
		return goodsDAO.getOrderHistory_DetailCnt(sOhIdx);
	}

	@Override
	public void setDeleteOrderHistory_Detail(int orderHistory_Detail_Idx) {
		goodsDAO.setDeleteOrderHistory_Detail(orderHistory_Detail_Idx);
		
	}

	@Override
	public void setDeleteOrderHistory(int sOhIdx) {
		goodsDAO.setDeleteOrderHistory(sOhIdx);
		
	}

	@Override
	public void setUpdateOrderHistory(int sOhIdx, int sOhdIdx, int totalStock, int updatePrice) {
		goodsDAO.setUpdateOrderHistory(sOhIdx,sOhdIdx,totalStock,updatePrice);
		
	}

	@Override
	public void setInsertRefundOrderHistory(RefundVO refundVO) {
		goodsDAO.setInsertRefundOrderHistory(refundVO);
		
	}

	@Override
	public void setInsertRefundOrderHistory_Detail(OrderVO vo) {
		goodsDAO.setInsertRefundOrderHistory_Detail(vo);
	}

	@Override
	public List<ReviewVO> getReviewList(PageVO pageVO, int goods_Idx) {
		return goodsDAO.getReviewList(pageVO, goods_Idx);
	}

	@Override
	public BrandVO getBrandVO(int brand_Idx) {
		return goodsDAO.getBrandVO(brand_Idx);
	}

	@Override
	public int getSelectSameMemberAddress(OrderHistoryVO vo) {
		return goodsDAO.getSelectSameMemberAddress(vo);
	}

	@Override
	public void setInsertMemberAddress(OrderHistoryVO vo) {
		goodsDAO.setInsertMemberAddress(vo);
		
	}

	@Override
	public void setInsertInquiry(InquiryVO vo) {
		goodsDAO.setInsertInquiry(vo);
		
	}

	@Override
	public List<InquiryVO> getSelectInquiry(int goods_Idx) {
		return goodsDAO.getSelectInquiry(goods_Idx);
	}


}