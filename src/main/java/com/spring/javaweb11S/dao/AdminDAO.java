package com.spring.javaweb11S.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

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

public interface AdminDAO {
	public void setBrandRegister(@Param("vo") BrandVO vo);

	public List<BrandVO> getBrandList();

	public void setGoodsStockRegister(@Param("vos") Map<String, Integer> vos);

	public void setGoodsRegister(@Param("vo") GoodsVO vo);

	public List<GoodsVO> getGoodsTableList(@Param("pageVO") PageVO pageVO);

	public List<MainCategoryVO> getMainCateArrayList();

	public List<SubCategoryVO> getSubCateArrayList(@Param("mainCategory") int mainCategory);

	public List<SecondCategoryVO> getSecondCateArrayList(@Param("subCategory") int subCategory);

	public List<Goods_StockVO> getGoodsStock(@Param("goods_Idx") int goods_Idx);

	public GoodsVO getGoodsDetail(@Param("goods_Idx") int goods_Idx);

	public CategoryVO getGoodsCategory(@Param("secondCategory_Idx") int secondCategory_Idx);

	public List<OrderHistoryVO> getgoodsOrderHistoryList(@Param("delivery_Status") String delivery_Status, @Param("searchKeyword") String searchKeyword, @Param("searchString") String searchString, @Param("startDate") String startDate, @Param("endDate") String endDate);

	public List<OrderHistory_DetailVO> getOrderHistory_DetailListAJAX(@Param("idx") int idx);

	public void setorderShippingNumRegister(@Param("orderHistoryIdx") int orderHistoryIdx, @Param("shippingNum") int shippingNum);

	public List<MemberVO> getMemberList(@Param("pageVO") PageVO pageVO);
	
	public List<OrderHistoryVO> getgoodsOrderHistoryList2(@Param("delivery_Status") String delivery_Status, @Param("pageVO") PageVO pageVO);

	public int orderHistoryTotRecCnt(@Param("filter") String filter, @Param("searchKeyword") String searchKeyword, @Param("searchString") String searchString, @Param("startDate") String startDate, @Param("endDate") String endDate);

	public int goodsTotRecCnt(@Param("mainCategory") String mainCategory, @Param("subCategory") String subCategory, @Param("secondCategory") String secondCategory, @Param("searchKeyword") String searchKeyword, @Param("searchString") String searchString, @Param("startFilter") String startFilter, @Param("endFilter") String endFilter);

	public List<BrandVO> getBrandFilterList(@Param("pageVO") PageVO pageVO);

	public int brandTotRecCnt(@Param("filter") String filter, @Param("searchKeyword") String searchKeyword, @Param("searchString") String searchString);

	public BrandVO getBrandVO(@Param("brand_Idx") int brand_Idx);

	public void setBrandUpdate(@Param("brandVO") BrandVO brandVO);

	public void setBrandDelete(@Param("brand_Idx") int brand_Idx);

	public List<ExchangeVO> getExchangeList(@Param("pageVO") PageVO pageVO);

	public int exchangeTotRecCnt(@Param("filter") String filter, @Param("searchKeyword") String searchKeyword, @Param("searchString") String searchString);

	public void setUpdateExchangeDelivery(@Param("idx") int idx);

	public void setExchangeShippingNumRegister(@Param("idx") int idx, @Param("shippingNum") int shippingNum);

	public List<Exchange_DetailVO> getExchange_DetailList(@Param("idx") int idx);

	public void insertMainCategory(@Param("mainCategoryInput") String mainCategoryInput);

	public void insertSubCategory(@Param("mainCategorySelect") int mainCategorySelect, @Param("subCategoryInput") String subCategoryInput);

	public void insertSecondCategory(@Param("subCategorySelect") int subCategorySelect, @Param("secondCategoryInput") String secondCategoryInput);

	public void setInsertGoodsImage(@Param("imgFile") String imgFile, @Param("goods_Idx") int goods_Idx);

	public void setDeleteGoodsImage(@Param("goods_Idx") int goods_Idx);

	public void setUpdateGoods(@Param("vo") GoodsVO vo);

	public void setUpdateGoods_Stock(@Param("vos") Map<String, Integer> vos, @Param("goods_Idx") int goods_Idx);

	public void setDeleteGoods(@Param("goods_Idx") int goods_Idx);


}