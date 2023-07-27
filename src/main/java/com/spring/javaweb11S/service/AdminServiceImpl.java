package com.spring.javaweb11S.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb11S.dao.AdminDAO;
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
		
		System.out.println("파일저장 들어옴");
		UUID uid = UUID.randomUUID();
		String oFileName = fName.getOriginalFilename();
		String saveFileName = vo.getBrand_Idx()+"_"+vo.getName()+"_"+uid+"_"+oFileName;
		System.out.println("파일명:"+oFileName);
		
		if(oFileName!="") {
			try {
				writeFile(fName,saveFileName);
				fileName = saveFileName;
			} catch(IOException e) {
				e.printStackTrace();
			}
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
	public CategoryVO getGoodsCategory(int secondCategory_Idx) {
		return adminDAO.getGoodsCategory(secondCategory_Idx);
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

	@Override
	public List<ExchangeVO> getExchangeList(PageVO pageVO) {
		return adminDAO.getExchangeList(pageVO);
	}

	@Override
	public void setUpdateExchangeDelivery(int idx) {
		adminDAO.setUpdateExchangeDelivery(idx);
		
	}

	@Override
	public void setExchangeShippingNumRegister(int idx, int shippingNum) {
		adminDAO.setExchangeShippingNumRegister(idx, shippingNum);
		
	}

	@Override
	public List<Exchange_DetailVO> getExchange_DetailList(int idx) {
		return adminDAO.getExchange_DetailList(idx);
	}

	@Override
	public void insertMainCategory(String mainCategoryInput) {
		adminDAO.insertMainCategory(mainCategoryInput);
		
	}

	@Override
	public void insertSubCategory(int mainCategorySelect, String subCategoryInput) {
		adminDAO.insertSubCategory(mainCategorySelect, subCategoryInput);
		
	}

	@Override
	public void insertSecondCategory(int subCategorySelect, String secondCategoryInput) {
		adminDAO.insertSecondCategory(subCategorySelect, secondCategoryInput);
		
	}

	@Override
	public void imgCheck(String content, int goods_Idx) {
		//             0         1         2         3         4
		//             01234567890123456789012345678901234567890
		// <img alt="" src="/javawebS/data/ckeditor/230616141341_sanfran.jpg" style="height:300px; width:400px" /></p><p><img alt="" src="/javawebS/data/ckeditor/230616141353_paris.jpg" style="height:300px; width:400px" /></p>
		// <img alt="" src="/javawebS/data/board/230616141341_sanfran.jpg" style="height:300px; width:400px" /></p><p><img alt="" src="/javawebS/data/ckeditor/230616141353_paris.jpg" style="height:300px; width:400px" /></p>
		
		// content안에 그림파일이 존재한다면 그림을 /data/board/폴더로 복사처리한다. 없으면 돌려보낸다.
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 31; //프로젝트명때문에 2를 더해야된다.

		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		int cnt=0;
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			if(goods_Idx == 0) {
				adminDAO.setInsertGoodsImage(imgFile, goods_Idx);
			} else {
				if(cnt==0) {
					adminDAO.setDeleteGoodsImage(goods_Idx);
					cnt++;
				}
				adminDAO.setInsertGoodsImage(imgFile, goods_Idx);
			}
			
			String origFilePath = realPath + "ckeditor/" + imgFile;
			String copyFilePath = realPath + "goods/" + imgFile;
			
			fileCopyCheck(origFilePath, copyFilePath);	// ckeditor폴더의 그림파일을 board폴더위치로 복사처리한다.
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
	}
	
	// 파일을 복사처리...
	private void fileCopyCheck(String origFilePath, String copyFilePath) {
		try {
			FileInputStream  fis = new FileInputStream(new File(origFilePath));
			FileOutputStream fos = new FileOutputStream(new File(copyFilePath));
			
			byte[] bytes = new byte[2048];
			int cnt = 0;
			while((cnt = fis.read(bytes)) != -1) {
				fos.write(bytes, 0, cnt);
			}
			fos.flush();
			fos.close();
			fis.close();		
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void imgCheckUpdate(String images) {
		//             0         1         2         3         4
		//             01234567890123456789012345678901234567890
		// <img alt="" src="/javawebS/data/board/230616141341_sanfran.jpg" style="height:300px; width:400px" /></p><p><img alt="" src="/javawebS/data/ckeditor/230616141353_paris.jpg" style="height:300px; width:400px" /></p>
		// <img alt="" src="/javawebS/data/ckeditor/230616141341_sanfran.jpg" style="height:300px; width:400px" /></p><p><img alt="" src="/javawebS/data/ckeditor/230616141353_paris.jpg" style="height:300px; width:400px" /></p>
		
		// content안에 그림파일이 존재한다면 그림을 /data/board/폴더로 복사처리한다. 없으면 돌려보낸다.
		if(images.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 28;
		String nextImg = images.substring(images.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "goods/" + imgFile;
			String copyFilePath = realPath + "ckeditor/" + imgFile;
			
			fileCopyCheck(origFilePath, copyFilePath);	// ckeditor폴더의 그림파일을 board폴더위치로 복사처리한다.
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
		
	}
	
	@Override
	public void imgDelete(String content) {
		//             0         1         2         3         4
		//             01234567890123456789012345678901234567890
		// <img alt="" src="/javawebS/data/board/230616141341_sanfran.jpg" style="height:300px; width:400px" /></p><p><img alt="" src="/javawebS/data/ckeditor/230616141353_paris.jpg" style="height:300px; width:400px" /></p>
		
		// content안에 그림파일이 존재한다면 그림을 /data/board/폴더로 복사처리한다. 없으면 돌려보낸다.
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 28;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));	// 그림파일명만 꺼내오기
			
			String origFilePath = realPath + "goods/" + imgFile;
			
			fileDelete(origFilePath);	// 'board'폴더의 그림을 삭제처리한다.
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
	}
	
	// 실제로 서버의 파일을 삭제처리한다.
	private void fileDelete(String origFilePath) {
		File delFile = new File(origFilePath);
		if(delFile.exists()) delFile.delete();
	}

	@Override
	public void setUpdateGoods(GoodsVO vo) {
		adminDAO.setUpdateGoods(vo);
		
	}

	@Override
	public void setUpdateGoods_Stock(Map<String, Integer> vos, int goods_Idx) {
		adminDAO.setUpdateGoods_Stock(vos, goods_Idx);
	}

	@Override
	public void setDeleteGoods(int goods_Idx) {
		adminDAO.setDeleteGoods(goods_Idx);
		
	}
}