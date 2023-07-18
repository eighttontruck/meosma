package com.spring.javaweb11S.service;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb11S.dao.AdminDAO;
import com.spring.javaweb11S.pagination.PageVO;
import com.spring.javaweb11S.vo.BrandVO;
import com.spring.javaweb11S.vo.CategoryVO;
import com.spring.javaweb11S.vo.GoodsVO;
import com.spring.javaweb11S.vo.Goods_StockVO;
import com.spring.javaweb11S.vo.MainCategoryVO;
import com.spring.javaweb11S.vo.MemberVO;
import com.spring.javaweb11S.vo.OrderHistoryVO;
import com.spring.javaweb11S.vo.OrderHistory_DetailVO;
import com.spring.javaweb11S.vo.SecondCategoryVO;
import com.spring.javaweb11S.vo.SubCategoryVO;

@Service
public class AdminServiceImpl implements AdminService {
	@Autowired
	AdminDAO adminDAO;

	@Override
	public void setBrandRegister(BrandVO vo) {
		adminDAO.setBrandRegister(vo);
		
	}

	@Override
	public List<BrandVO> getBrandList() {
		return adminDAO.getBrandList();
	}

	@Override
	public void setGoodsStockRegister(Map<String, Integer> vos) {
		adminDAO.setGoodsStockRegister(vos);
	}

	@Override
	public void setGoodsRegister(GoodsVO vo) {
		adminDAO.setGoodsRegister(vo);
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

	public void writeFile(MultipartFile fName, String saveFileName) throws IOException{
		byte[] data = fName.getBytes();
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/images/");
		
		FileOutputStream fos = new FileOutputStream(realPath + saveFileName);
		fos.write(data);
		fos.close();
	}
	
	@Override
	public List<GoodsVO> getGoodsTableList(PageVO pageVO) {
		return adminDAO.getGoodsTableList(pageVO);
	}

	@Override
	public List<MainCategoryVO> getMainCateArrayList() {
		return adminDAO.getMainCateArrayList();
	}

	@Override
	public List<SubCategoryVO> getSubCateArrayList(int mainCategory) {
		return adminDAO.getSubCateArrayList(mainCategory);
	}

	@Override
	public List<SecondCategoryVO> getSecondCateArrayList(int subCategory) {
		return adminDAO.getSecondCateArrayList(subCategory);
	}

	@Override
	public List<Goods_StockVO> getGoodsStock(int goods_Idx) {
		return adminDAO.getGoodsStock(goods_Idx);
	}

	@Override
	public GoodsVO getGoodsDetail(int goods_Idx) {
		return adminDAO.getGoodsDetail(goods_Idx);
	}

	@Override
	public CategoryVO getGoodsCategory(int secondCatagory_Idx) {
		return adminDAO.getGoodsCategory(secondCatagory_Idx);
	}

	@Override
	public List<OrderHistoryVO> getgoodsOrderHistoryList(String delivery_Status ,String searchKeyword, String searchString, String startDate, String endDate) {
		return adminDAO.getgoodsOrderHistoryList(delivery_Status, searchKeyword, searchString, startDate, endDate);
	}

	@Override
	public List<OrderHistory_DetailVO> getOrderHistory_DetailListAJAX(int idx) {
		return adminDAO.getOrderHistory_DetailListAJAX(idx);
	}

	@Override
	public void setorderShippingNumRegister(int orderHistoryIdx, int shippingNum) {
		adminDAO.setorderShippingNumRegister(orderHistoryIdx,shippingNum);
		
	}

	@Override
	public List<MemberVO> getMemberList(PageVO pageVO) {
		return adminDAO.getMemberList(pageVO);
	}

	@Override
	public List<OrderHistoryVO> getgoodsOrderHistoryList2(String delivery_Status, PageVO pageVO) {
		return adminDAO.getgoodsOrderHistoryList2(delivery_Status, pageVO);
	}

	@Override
	public List<BrandVO> getBrandFilterList(PageVO pageVO) {
		return adminDAO.getBrandFilterList(pageVO);
	}

	@Override
	public BrandVO getBrandVO(int brand_Idx) {
		return adminDAO.getBrandVO(brand_Idx);
	}

	@Override
	public void setBrandUpdate(BrandVO brandVO) {
		adminDAO.setBrandUpdate(brandVO);
		
	}

	@Override
	public void setBrandDelete(int brand_Idx) {
		adminDAO.setBrandDelete(brand_Idx);
	}


}