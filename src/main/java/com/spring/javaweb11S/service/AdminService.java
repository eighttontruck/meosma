package com.spring.javaweb11S.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb11S.pagination.PageVO;
import com.spring.javaweb11S.vo.BrandVO;
import com.spring.javaweb11S.vo.CategoryVO;
import com.spring.javaweb11S.vo.ExchangeVO;
import com.spring.javaweb11S.vo.Exchange_DetailVO;
import com.spring.javaweb11S.vo.GoodsVO;
import com.spring.javaweb11S.vo.Goods_StockVO;
import com.spring.javaweb11S.vo.MainCategoryVO;
import com.spring.javaweb11S.vo.MemberVO;
import com.spring.javaweb11S.vo.OrderHistoryVO;
import com.spring.javaweb11S.vo.OrderHistory_DetailVO;
import com.spring.javaweb11S.vo.SecondCategoryVO;
import com.spring.javaweb11S.vo.SubCategoryVO;

public interface AdminService {
	public void setBrandRegister(BrandVO vo);

	public List<BrandVO> getBrandList();
	
	public void setGoodsStockRegister(Map<String, Integer> vos);
	
	public void setGoodsRegister(GoodsVO vo);
	
	public String fileUpload(MultipartFile fName, GoodsVO vo);
	
	public List<GoodsVO> getGoodsTableList(PageVO pageVO);
	
	public List<MainCategoryVO> getMainCateArrayList();
	
	public List<SubCategoryVO> getSubCateArrayList(int mainCategory);

	public List<SecondCategoryVO> getSecondCateArrayList(int subCategory);
	
	public List<Goods_StockVO> getGoodsStock(int goods_Idx);
	
	public GoodsVO getGoodsDetail(int goods_Idx);
	
	public CategoryVO getGoodsCategory(int secondCatagory_Idx);

	public List<OrderHistoryVO> getgoodsOrderHistoryList(String delivery_Status, String searchKeyword, String searchString, String startDate, String endDate);

	public List<OrderHistory_DetailVO> getOrderHistory_DetailListAJAX(int idx);

	public void setorderShippingNumRegister(int orderHistoryIdx, int shippingNum);

	public List<MemberVO> getMemberList(PageVO pageVO);

	public List<OrderHistoryVO> getgoodsOrderHistoryList2(String delivery_Status, PageVO pageVO);

	public List<BrandVO> getBrandFilterList(PageVO pageVO);

	public BrandVO getBrandVO(int brand_Idx);

	public void setBrandUpdate(BrandVO brandVO);

	public void setBrandDelete(int brand_Idx);

	public List<ExchangeVO> getExchangeList(PageVO pageVO);

	public void setUpdateExchangeDelivery(int idx);

	public void setExchangeShippingNumRegister(int idx, int shippingNum);

	public List<Exchange_DetailVO> getExchange_DetailList(int idx);

}
