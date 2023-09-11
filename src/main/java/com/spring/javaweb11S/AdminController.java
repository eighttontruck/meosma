package com.spring.javaweb11S;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb11S.pagination.PageProcess;
import com.spring.javaweb11S.pagination.PageVO;
import com.spring.javaweb11S.service.AdminService;
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

@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	AdminService adminService;
	
	@Autowired
	PageProcess pageProcess;
	
	@RequestMapping(value="/adminMain", method=RequestMethod.GET)
	public String adminMainGet() {
		return "admin/adminMain";
	}
	
	
	//=======================================관리자페이지(브랜드)===================================================
	
	@RequestMapping(value="/brandList", method=RequestMethod.GET)
	public String brandListGet(Model model,
			@RequestParam(name = "sortFilter", defaultValue="",required=false) String sortFilter,
			@RequestParam(name = "searchString", defaultValue="",required=false) String searchString,
			@RequestParam(name = "searchKeyword", defaultValue="",required=false) String searchKeyword,
			@RequestParam(name = "pag", defaultValue="1",required=false) int pag,
			@RequestParam(name = "pagSize", defaultValue="15",required=false) int pagSize
			) {
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pagSize, "brand", sortFilter, searchKeyword, searchString, "","");
		System.out.println(pageVO.getPageSize()+"dddd");
		List<BrandVO> brandVos = adminService.getBrandFilterList(pageVO);
		
		model.addAttribute("brandVos",brandVos);
		model.addAttribute("pageVO",pageVO);
		return "admin/adminBrandList";
	}
	
	@RequestMapping(value="/brandRegister", method=RequestMethod.GET)
	public String brandRegisterGet() {
		return "admin/adminBrandRegister";
	}
	
	@RequestMapping(value="/brandRegister", method=RequestMethod.POST)
	public String brandRegisterPost(BrandVO vo) {
		adminService.setBrandRegister(vo);
		
		return "admin/adminBrandRegister";
	}
	
	@RequestMapping(value="/brandUpdate", method=RequestMethod.GET)
	public String adminBrandrUpdateGet(Model model,
			@RequestParam(name = "brand_Idx", defaultValue="",required=false) int brand_Idx
			) {
		BrandVO vo = adminService.getBrandVO(brand_Idx);
		
		model.addAttribute("vo",vo);
		return "admin/adminBrandUpdate";
	}
	
	@RequestMapping(value="/brandUpdate", method=RequestMethod.POST)
	public String adminBrandrUpdatePost(Model model,BrandVO brandVO) {
		System.out.println(brandVO.getName());
		System.out.println(brandVO.getContent());
		adminService.setBrandUpdate(brandVO);
		
		return "redirect:/admin/brandList";
	}
	
	@ResponseBody
	@RequestMapping(value="/brandDeleteAJAX", method=RequestMethod.POST)
	public String adminBrandrDeletePost(int brand_Idx) {
		
		adminService.setBrandDelete(brand_Idx);
		
		return "굿";
	}
	
	//===================================상품====================================================
	
	@RequestMapping(value="/goodsList", method=RequestMethod.GET)
	public String goodsTableListGet(Model model,
			@RequestParam(name = "mainCategory", defaultValue="",required=false) String mainCategory,
			@RequestParam(name = "subCategory", defaultValue="",required=false) String subCategory,
			@RequestParam(name = "secondCategory", defaultValue="",required=false) String secondCategory,
			@RequestParam(name = "searchString", defaultValue="",required=false) String searchString,
			@RequestParam(name = "searchKeyword", defaultValue="",required=false) String searchKeyword,
			@RequestParam(name = "startPrice", defaultValue="",required=false) String startPrice,
			@RequestParam(name = "endPrice", defaultValue="",required=false) String endPrice,
			@RequestParam(name = "pag", defaultValue="1",required=false) int pag,
			@RequestParam(name = "pagSize", defaultValue="5",required=false) int pagSize
			) {
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pagSize, "goods", mainCategory, subCategory, secondCategory, searchKeyword, searchString, startPrice, endPrice);
		
		List<GoodsVO> goodsVos= adminService.getGoodsTableList(pageVO);
		List<MainCategoryVO> mainCategory_vos= adminService.getMainCateArrayList(); //필터에서 메인카테고리 가져오기
		
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("goodsVos",goodsVos);
		model.addAttribute("mainCategory_vos",mainCategory_vos);
		
		return "admin/adminGoodsList";
	}
	
	@RequestMapping(value="/goodsRegister", method=RequestMethod.GET)
	public String goodsRegisterGet(Model model) {
		List<MainCategoryVO> mainCategory_vos= adminService.getMainCateArrayList();
		List<BrandVO> brand_vos= adminService.getBrandList();
		model.addAttribute("mainCategory_vos",mainCategory_vos);
		model.addAttribute("brand_vos",brand_vos);
		return "admin/adminGoodsRegister";
	}
	
	@Transactional
	@RequestMapping(value="/goodsRegister", method=RequestMethod.POST)
	public String goodsRegisterPost(GoodsVO vo, MultipartFile file,
			@RequestParam(name = "goodsSize", defaultValue="",required=false) String[] goodsSize,
			@RequestParam(name = "goodsStock", defaultValue="",required=false) int[] goodsStock
			) {
		String fileName = adminService.fileUpload(file,vo);
		vo.setThumbNail(fileName);
		
		Map<String, Integer> vos=new HashMap<>();
		for(int i=0; i<goodsSize.length; i++) {
			vos.put(goodsSize[i], goodsStock[i]);
			System.out.println(goodsSize[i]+" "+goodsStock[i]);
		}

		adminService.setGoodsRegister(vo);
		adminService.setGoodsStockRegister(vos);
		
		adminService.imgCheck(vo.getImages(), 0);
		vo.setImages(vo.getImages().replace("/data/ckeditor/", "/data/goods/"));
		
		return "redirect:/admin/goodsList";
		
	}
	
	@RequestMapping(value="/goodsUpdate", method=RequestMethod.GET)
	public String goodsUpdateGet(Model model,
			@RequestParam(name = "goods_Idx", defaultValue="",required=false) int goods_Idx) {
		List<MainCategoryVO> mainCategory_vos= adminService.getMainCateArrayList();
		List<Goods_StockVO> stockVos = adminService.getGoodsStock(goods_Idx);
		GoodsVO goodsVo = adminService.getGoodsDetail(goods_Idx);
		CategoryVO categoryVo = adminService.getGoodsCategory(goodsVo.getSecondCategory_Idx());
		List<BrandVO> brandVos= adminService.getBrandList();
		
		if(goodsVo.getImages().indexOf("src=\"/") != -1) {
			adminService.imgCheckUpdate(goodsVo.getImages());
		}
		
		model.addAttribute("brandVos",brandVos);
		model.addAttribute("mainCategory_vos",mainCategory_vos);
		model.addAttribute("stockVos",stockVos);
		model.addAttribute("goodsVo",goodsVo);
		model.addAttribute("categoryVo",categoryVo);
		return "admin/adminGoodsUpdate";
	}
	
	@Transactional
	@RequestMapping(value="/goodsUpdate", method=RequestMethod.POST)
	public String goodsUpdatePost(GoodsVO vo, MultipartFile file,
			@RequestParam(name = "goodsSize", defaultValue="",required=false) String[] goodsSize,
			@RequestParam(name = "goodsStock", defaultValue="",required=false) int[] goodsStock
			) {
		String fileName = adminService.fileUpload(file,vo);
		System.out.println("Dd");
//		썸네임 사진도 수정하면 삭제처리해야되는
		System.out.println("바뀐 썸네일"+fileName);
		if(fileName!="") {
			System.out.println("왜 안바뀜?");
			vo.setThumbNail(fileName);
		}
		
		System.out.println("가져오냐?"+vo.getIdx());
		GoodsVO origVO = adminService.getGoodsDetail(vo.getIdx());
		System.out.println("걍vo"+vo.getImages());
		System.out.println("오리지널vo"+origVO.getIdx());
		
		Map<String, Integer> vos=new HashMap<>();
		for(int i=0; i<goodsSize.length; i++) {
			vos.put(goodsSize[i], goodsStock[i]);
			System.out.println(goodsSize[i]+" "+goodsStock[i]);
		}

		
		if(!origVO.getImages().equals(vo.getImages())) {
			// 실제로 수정하기 버튼을 클릭하게되면, 기존의 board폴더에 저장된, 현재 content의 그림파일 모두를 삭제 시킨다.
			if(origVO.getImages().indexOf("src=\"/") != -1) adminService.imgDelete(origVO.getImages());
			
			// board폴더에는 이미 그림파일이 삭제되어 있으므로(ckeditor폴더로 복사해놓았음), vo.getContent()에 있는 그림파일경로 'board'를 'ckeditor'경로로 변경해줘야한다.
			vo.setImages(vo.getImages().replace("/data/goods/", "/data/ckeditor/"));
			
			// 앞의 작업이 끝나면 파일을 처음 업로드한것과 같은 작업을 처리시켜준다.
			// content에 이미지가 저장되어 있다면, 저장된 이미지만 골라서 /resources/data/board/폴더에 저장시켜준다.
			adminService.imgCheck(vo.getImages(), origVO.getIdx());
			
			// 이미지들의 모든 복사작업을 마치면, ckeditor폴더경로를 board폴더 경로로 변경한다.(/resources/data/ckeditor/ ===>> /resources/data/board/)
			vo.setImages(vo.getImages().replace("/data/ckeditor/", "/data/goods/"));
		}
		
		System.out.println("카테고리값:"+vo.getSecondCategory_Idx());
		adminService.setUpdateGoods(vo);
		adminService.setUpdateGoods_Stock(vos,vo.getIdx());
		return "redirect:/admin/goodsList";
	}
	
	@Transactional
	@ResponseBody
	@RequestMapping(value="/goodsDeleteAJAX", method=RequestMethod.POST)
	public String adminGoodsDeleteAJAXPost(int goods_Idx) {
		
		GoodsVO vo = adminService.getGoodsDetail(goods_Idx);
		
		adminService.imgDelete(vo.getImages());
		
		adminService.setDeleteGoods(goods_Idx);
		
		return "굿";
	}
	
	//============================================주문내역==================================================
	
	@RequestMapping(value="/orderHistoryList", method=RequestMethod.GET)
	public String goodsOrderHistoryListGet(Model model,
			@RequestParam(name = "delivery_Status", defaultValue="",required=false) String delivery_Status,
			@RequestParam(name = "searchString", defaultValue="",required=false) String searchString,
			@RequestParam(name = "searchKeyword", defaultValue="",required=false) String searchKeyword,
			@RequestParam(name = "startDate", defaultValue="",required=false) String startDate,
			@RequestParam(name = "endDate", defaultValue="",required=false) String endDate,
			@RequestParam(name = "pag", defaultValue="1",required=false) int pag,
			@RequestParam(name = "pagSize", defaultValue="15",required=false) int pagSize
			) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pagSize, "orderHistory", delivery_Status, searchKeyword, searchString, startDate, endDate);
		
		List<OrderHistoryVO> vos= adminService.getgoodsOrderHistoryList2(delivery_Status,pageVO);

		
		model.addAttribute("vos",vos);
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("delivery_Status",delivery_Status);
		model.addAttribute("searchString",searchString);
		model.addAttribute("searchKeyword",searchKeyword);
		model.addAttribute("startDate",startDate);
		model.addAttribute("endDate",endDate);
		
		return "admin/adminOrderHistoryList";
	}
	
	
	@RequestMapping(value="/memberList", method=RequestMethod.GET)
	public String adminMemberListGet(Model model
//			@RequestParam(name = "searchString", defaultValue="",required=false) String searchString,
//			@RequestParam(name = "searchKeyword", defaultValue="",required=false) String searchKeyword,
//			@RequestParam(name = "startDate", defaultValue="",required=false) String startDate,
//			@RequestParam(name = "endDate", defaultValue="",required=false) String endDate,
//			@RequestParam(name = "pag", defaultValue="1",required=false) int pag,
//			@RequestParam(name = "pagSize", defaultValue="15",required=false) int pagSize
			) {
		//PageVO pageVO = pageProcess.totRecCnt(pag, pagSize, "member", "", searchKeyword, searchString, startDate, endDate);
		PageVO pageVO=new PageVO();
		List<MemberVO> member_Vos = adminService.getMemberList(pageVO);
		
		
		model.addAttribute("member_Vos",member_Vos);
		//model.addAttribute("pageVO",pageVO);
		return "admin/adminMemberList";
	}
	
	@RequestMapping(value="/categoryList", method=RequestMethod.GET)
	public String adminCategoryListGet(Model model,
			@RequestParam(name = "mainCategory", defaultValue="-99",required=false) int mainCategory,
			@RequestParam(name = "subCategory", defaultValue="-99",required=false) int subCategory,
			@RequestParam(name = "secondCategory", defaultValue="-99",required=false) int secondCategory,
			@RequestParam(name = "searchString", defaultValue="",required=false) String searchString,
			@RequestParam(name = "searchKeyword", defaultValue="",required=false) String searchKeyword,
			@RequestParam(name = "pag", defaultValue="1",required=false) int pag,
			@RequestParam(name = "pagSize", defaultValue="15",required=false) int pagSize
			) {
		System.out.println(subCategory);
		if(mainCategory!=-99&&subCategory==-99) {
			List<SubCategoryVO> subCategory_vos= adminService.getSubCateArrayList(mainCategory);
			model.addAttribute("subCategory_vos",subCategory_vos);
			model.addAttribute("mainCategory",mainCategory);
		}
		if(subCategory!=-99) {
			List<SecondCategoryVO> secondCategory_vos= adminService.getSecondCateArrayList(subCategory);
			model.addAttribute("secondCategory_vos",secondCategory_vos);
			model.addAttribute("mainCategory",mainCategory);
			model.addAttribute("subCategory",subCategory);
		}
		List<MainCategoryVO> mainCategory_vos= adminService.getMainCateArrayList();
		model.addAttribute("mainCategory_vos",mainCategory_vos);
		return "admin/adminCategoryList";
	}
	
	@RequestMapping(value="/categoryRegister", method=RequestMethod.GET)
	public String adminCategoryRegisterGet(Model model) {
		List<MainCategoryVO> mainCategory_vos= adminService.getMainCateArrayList();
		model.addAttribute("mainCategory_vos",mainCategory_vos);
		return "admin/adminCategoryRegister";
	}
	
	@RequestMapping(value="/exchangeList", method=RequestMethod.GET)
	public String adminExchangeListGet(Model model,
			@RequestParam(name = "sortFilter", defaultValue="",required=false) String sortFilter,
			@RequestParam(name = "searchString", defaultValue="",required=false) String searchString,
			@RequestParam(name = "searchKeyword", defaultValue="",required=false) String searchKeyword,
			@RequestParam(name = "pag", defaultValue="1",required=false) int pag,
			@RequestParam(name = "pagSize", defaultValue="15",required=false) int pagSize
			) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pagSize, "exchange", sortFilter, searchKeyword, searchString, "","");
		System.out.println(pageVO.getTotRecCnt());
		List<ExchangeVO> vos = adminService.getExchangeList(pageVO);
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("vos",vos);
		return "admin/adminExchangeList";
	}
	
	@RequestMapping(value="/refundList", method=RequestMethod.GET)
	public String adminRefundListGet(Model model,
			@RequestParam(name = "sortFilter", defaultValue="",required=false) String sortFilter,
			@RequestParam(name = "searchString", defaultValue="",required=false) String searchString,
			@RequestParam(name = "searchKeyword", defaultValue="",required=false) String searchKeyword,
			@RequestParam(name = "pag", defaultValue="1",required=false) int pag,
			@RequestParam(name = "pagSize", defaultValue="15",required=false) int pagSize
			) {
		
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pagSize, "refund", sortFilter, searchKeyword, searchString, "","");
		return "admin/adminRefundList";
	}
	
	@ResponseBody
	@RequestMapping(value="/insertMainCategory", method=RequestMethod.POST)
	public String adminInsertMainCategoryAJAXPost(String mainCategoryInput) {
		adminService.insertMainCategory(mainCategoryInput);
		return "굿";
	}
	
	@ResponseBody
	@RequestMapping(value="/insertSubCategory", method=RequestMethod.POST)
	public String adminInsertSubCategoryAJAXPost(int mainCategorySelect, String subCategoryInput) {
		adminService.insertSubCategory(mainCategorySelect, subCategoryInput);
		return "굿";
	}
	
	@ResponseBody
	@RequestMapping(value="/insertSecondCategory", method=RequestMethod.POST)
	public String adminInsertSecondCategoryAJAXPost(int subCategorySelect, String secondCategoryInput) {
		adminService.insertSecondCategory(subCategorySelect, secondCategoryInput);
		return "굿";
	}
	
	@ResponseBody
	@RequestMapping(value="/updateExchangeDeliveryAJAX", method=RequestMethod.POST)
	public String adminUpdateExchangeDeliveryAJAXPost(int idx) {
		
		adminService.setUpdateExchangeDelivery(idx);
		
		return "굿";
	}
	
	
	
	@RequestMapping(value="/memberUpdate", method=RequestMethod.GET)
	public String adminMemberUpdateGet(Model model,
			@RequestParam(name = "goodsSize", defaultValue="",required=false) int member_Idx
			) {
		//MemberVO vo = adminService.getMemberList(member_Idx);
		
		//model.addAttribute("vo",vo);
		return "admin/adminMemberUpdate";
	}
	
	
	@ResponseBody
	@RequestMapping(value="/exchangeShippingNumRegisterAJAX", method=RequestMethod.POST)
	public String adminExchangeShippingNumRegisterAJAXPost(int idx, int shippingNum) {
		adminService.setExchangeShippingNumRegister(idx,shippingNum);
		
		return "굿";
	}
	
	@ResponseBody
	@RequestMapping(value="/orderShippingNumRegister", method=RequestMethod.POST)
	public String orderShippingNumRegisterPost(int orderHistoryIdx, int shippingNum) {
		adminService.setorderShippingNumRegister(orderHistoryIdx,shippingNum);
		
		return "굿";
	}
	
	@ResponseBody
	@RequestMapping(value="/exchange_DetailListAJAX", method=RequestMethod.POST)
	public List<Exchange_DetailVO> adminExchange_DetailListAJAXPost(int idx) {
		List<Exchange_DetailVO> vos = adminService.getExchange_DetailList(idx);
		return vos;
	}
	
	@ResponseBody
	@RequestMapping(value="/orderHistory_DetailListAJAX", method=RequestMethod.POST)
	public List<OrderHistory_DetailVO> orderHistory_DetailListAJAXPost(int idx) {
		List<OrderHistory_DetailVO> vos = adminService.getOrderHistory_DetailListAJAX(idx);
		return vos;
	}
	
	@ResponseBody
	@RequestMapping(value="/subCategoryList", method=RequestMethod.POST)
	public List<SubCategoryVO> subCategoryListPost(int mainCategory) {
		System.out.println(mainCategory);
		List<SubCategoryVO> vos= adminService.getSubCateArrayList(mainCategory);
		return vos;
	}
	
	@ResponseBody
	@RequestMapping(value="/secondCategoryList", method=RequestMethod.POST)
	public List<SecondCategoryVO> secondCategoryListPost(int subCategory) {
		System.out.println(subCategory);
		List<SecondCategoryVO> vos= adminService.getSecondCateArrayList(subCategory);
		System.out.println(vos.toString());
		return vos;
	}
}
