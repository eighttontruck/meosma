package com.spring.javaweb11S;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
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
	
	@RequestMapping(value="/brandRegister", method=RequestMethod.GET)
	public String brandRegisterGet() {
		return "admin/adminBrandRegister";
	}
	
	@RequestMapping(value="/brandRegister", method=RequestMethod.POST)
	public String brandRegisterPost(BrandVO vo) {
		adminService.setBrandRegister(vo);
		
		return "admin/adminBrandRegister";
	}
	
	
	@RequestMapping(value="/goodsUpdate", method=RequestMethod.GET)
	public String goodsUpdateGet(Model model,
			@RequestParam(name = "goods_Idx", defaultValue="",required=false) int goods_Idx) {
		List<MainCategoryVO> mainCategory_vos= adminService.getMainCateArrayList();
		List<Goods_StockVO> stockVos = adminService.getGoodsStock(goods_Idx);
		GoodsVO goodsVo = adminService.getGoodsDetail(goods_Idx);
		CategoryVO categoryVo = adminService.getGoodsCategory(goodsVo.getSecondCatagory_Idx());
		List<BrandVO> brandVos= adminService.getBrandList();
		
		model.addAttribute("brandVos",brandVos);
		model.addAttribute("mainCategory_vos",mainCategory_vos);
		model.addAttribute("stockVos",stockVos);
		model.addAttribute("goodsVo",goodsVo);
		model.addAttribute("categoryVo",categoryVo);
		return "admin/adminGoodsUpdate";
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
		System.out.println(file);
		String fileName = adminService.fileUpload(file,vo);
		
		if(fileName==null) {
			System.out.println("파일업로드 오류");
		}
		vo.setThumbNail(fileName);
		Map<String, Integer> vos=new HashMap<>();
		for(int i=0; i<goodsSize.length; i++) {
			vos.put(goodsSize[i], goodsStock[i]);
			System.out.println(goodsSize[i]+" "+goodsStock[i]);
		}
		System.out.println(vo.toString());
		vo.toString();
		adminService.setGoodsRegister(vo);
		adminService.setGoodsStockRegister(vos);
		return "redirect:/admin/goodsRegister";
		
	}
	
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
		System.out.println(startDate);
		System.out.println(endDate);
		PageVO pageVO = pageProcess.totRecCnt(pag, pagSize, "orderHistory", delivery_Status, searchKeyword, searchString, startDate, endDate);
		
		//List<OrderHistoryVO> vos= adminService.getgoodsOrderHistoryList(delivery_Status,searchKeyword,searchString,startDate,endDate);
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
	
	@RequestMapping(value="/memberUpdate", method=RequestMethod.GET)
	public String adminMemberUpdateGet(Model model,
			@RequestParam(name = "goodsSize", defaultValue="",required=false) int member_Idx
			) {
		//MemberVO vo = adminService.getMemberList(member_Idx);
		
		//model.addAttribute("vo",vo);
		return "admin/adminMemberUpdate";
	}
	
	
	@ResponseBody
	@RequestMapping(value="/orderShippingNumRegister", method=RequestMethod.POST)
	public String orderShippingNumRegisterPost(int orderHistoryIdx, int shippingNum) {
		adminService.setorderShippingNumRegister(orderHistoryIdx,shippingNum);
		
		return "굿";
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
