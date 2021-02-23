package org.zerock.product.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.catalina.mapper.Mapper;
import org.apache.commons.collections.map.HashedMap;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.product.domain.CategoryVO;
import org.zerock.product.domain.Criteria;
import org.zerock.product.domain.OrderVO;
import org.zerock.product.domain.PageDTO;
import org.zerock.product.domain.ProductLikeVO;
import org.zerock.product.domain.ProductOptionVO;
import org.zerock.product.domain.ProductVO;
import org.zerock.product.service.ProductService;
import org.zerock.user.domain.UserVO;
import org.zerock.user.service.UserService;

import edu.emory.mathcs.backport.java.util.Arrays;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@AllArgsConstructor
@Log4j
@RequestMapping("/product/*")
public class ProductController {

	private ProductService service;
	private UserService userService;
	
	/* 좋아요 */
	@ResponseBody
	@PostMapping(value="/like", consumes = MediaType.APPLICATION_JSON_VALUE)
	public  ResponseEntity<Integer> productLikeUp (@RequestBody ProductLikeVO productLikeVO) {
		Integer total = service.changeProductLike(productLikeVO);
		return new ResponseEntity<Integer>(total,HttpStatus.OK) ;
	}
	
	/* 카테고리관련 */
	@ResponseBody
	@PostMapping("/getCategorySub")
	public  ResponseEntity<List<String>> categorySub (@RequestBody String categoryMain) {
		List<String> list = service.getCategorySubList(categoryMain);
		return new ResponseEntity<List<String>>(list,HttpStatus.OK) ;
	}
	@ResponseBody
	@PostMapping("/getCategorySeq")
	public  ResponseEntity<Integer> categorySub (@RequestBody CategoryVO categoryVO) {
		Integer categorySeq = service.getCategorySeq(categoryVO);
		return new ResponseEntity<Integer>(categorySeq,HttpStatus.OK) ;
	}
	
	
	@GetMapping("/register")
	public String register(@ModelAttribute("cri") Criteria cri, HttpServletRequest request, Model model, RedirectAttributes rttr) {
		
		/* 로그인 해야지만 register를 할 수 있게끔 */
		if (request.getSession().getAttribute("authUser") == null) {
			rttr.addFlashAttribute("message","로그인 되어있지 않습니다.");
			return "redirect:/product/list";
		}
		/* 카테고리 대분류를 보내줌 */
		List<String> categoryMainList = service.getCategoryMainList();
		model.addAttribute("categoryMainList", categoryMainList);
		
		return "/product/register";
	}

	
	
	/* 배열로 받았을때 함수 */
	public void productAndOption(String[] po_name, String[] po_quantity, String[] po_price, ProductVO product) {
		
	}
	
	
	@PostMapping("/register")
	public String register(String[] po_name, String[] po_quantity, String[] po_price, ProductVO product, RedirectAttributes rttr, MultipartFile[] upload, HttpServletRequest request) {

		/* 카테고리가 비어 있을 때 돌려보냄 */
		if (product.getCategory_seq() == 0) {
			rttr.addFlashAttribute("product", product);
			rttr.addFlashAttribute("message", "카테고리 선택이 올바르지 않습니다");
			return "redirect:/product/register";
		}
		
		/*상품옵션이 비었을때 돌려보냄*/
			String emp = "";
			int cnt = 0;
			/* 숫자배열2개 내 최소값이 0보다 커야함을표시 */
				for(int i = 0; i < po_quantity.length; i++) {
					if(!po_quantity[i].equals(emp) && Integer.parseInt(po_quantity[i]) <= 0 ) {
						cnt++;
					}
				}
				for(int i = 0; i < po_price.length; i++) {
					if(!po_price[i].equals(emp) && Integer.parseInt(po_price[i]) <= 0 ) {
						cnt++;
					}
				}
			if(/* 옵션하나도안넣으면안됨 */
				Arrays.asList(po_name).size() == 0 || Arrays.asList(po_quantity).size() == 0 || Arrays.asList(po_price).size() == 0 ||
				/* 빈값이 있으면 안됨 */
				Arrays.asList(po_name).contains(emp) || Arrays.asList(po_quantity).contains(emp) || Arrays.asList(po_price).contains(emp) ||
				/* 숫자들은 무조건 0보다 커야함 */
				cnt !=0
				) {
				rttr.addFlashAttribute("product", product);
				rttr.addFlashAttribute("message", "상품옵션항목이 올바르지 않습니다");
				return "redirect:/product/register";
			}
			
		//옵션입력확인했으니 맨 처음 옵션의 가격과 옵션 총 수량을 넣어줌
		product.setProduct_price(Integer.parseInt(po_price[0]));
		int total = 0;
		for(String po_q : po_quantity) {
			total += Integer.parseInt(po_q);
		}
		product.setProduct_quantity(total);
		
		//파일 올리는 방법 복사
				//파일이 업로드 될 경로 설정 
				String saveDir = request.getSession().getServletContext().getRealPath("/resources/upload"); 
				
				//위에서 설정한 경로의 폴더가 없을 경우 생성 
				System.out.println(saveDir);
				File dir = new File(saveDir); 
				if(!dir.exists()) { 
					dir.mkdirs(); 
				}
				// 파일 업로드
					//철수추가 파일 이름 list추가
					List<String> reNames = new ArrayList<String>();
				for(MultipartFile f : upload) { 
					if(!f.isEmpty()) { 
						// 기존 파일 이름을 받고 확장자 저장 
						String orifileName = f.getOriginalFilename(); 
						String ext = orifileName.substring(orifileName.lastIndexOf("."));
						// 이름 값 변경을 위한 설정 
						SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd-HHmmssSSS"); 
						int rand = (int)(Math.random()*1000); 
						// 파일 이름 변경 
						String reName = sdf.format(System.currentTimeMillis()) + "_" + rand + ext; 
						// 파일 저장 
						try { 
							f.transferTo(new File(saveDir + "/" + reName)); 
						} catch (IOException e) { 
							e.printStackTrace(); 
						}
						
					//철수추가
					reNames.add(reName);
					} 
				}
			
			/* 파일이 하나도 첨부되어있지 않을때 다시돌려보냄 */
			if (reNames.size() == 0) {
				rttr.addFlashAttribute("product", product);
				rttr.addFlashAttribute("message", "상품이미지를 한 개이상 등록해야합니다.");
				return "redirect:/product/register";
			}
				
				
		//철수추가 파일 올린 후에 그 이름을 product에 복사
			//list를 string 쉼표구분으로 만들기 
			String filenames = String.join(",", reNames);
		product.setProduct_filename(filenames);
		System.out.println(filenames);
		/* System.out.println(product.getProduct_filename()); */
		
			/* 다시 list로 얻는 방법 
			List<String> fileNamesList = Arrays.asList(filenames.split(","));
			System.out.println(fileNamesList);
			*/
		
		service.registerReturn(product,po_name,po_quantity,po_price);
		
		rttr.addFlashAttribute("message", "상품이 등록되었습니다.");
		
		/* 상품옵션등록-서비스로 옮김 트랜잭션 
		List<ProductOptionVO> optionList= new ArrayList<ProductOptionVO>(); 
		for (int i = 0; i<po_name.length ;i++ ) {
			ProductOptionVO poVO = new ProductOptionVO();
			poVO.setProduct_seq(product.getProduct_seq());
			poVO.setPo_name(po_name[i]);
			poVO.setPo_quantity(Integer.parseInt(po_quantity[i]));
			poVO.setPo_price(Integer.parseInt(po_price[i]));
			optionList.add(poVO);
		}*/
		
		return "redirect:/product/list";
	}

	@GetMapping("/list")
	public void list(@ModelAttribute("cri") Criteria cri, Model model) {
		
		//cri => 페이징과 검색
		//cri의 필드 = pageNum, amount, type, keyword  (페이징2 검색2)
		//			초기값 1,10
		//cri의 type이 N-제품이름 I-제품소개 S-판매자로 저장됨(안에서 .split)
		//cri의 getTypeArr() 메소드 = String[]을 리턴
		//			type이 없으면 빈{} / 있으면 type.split("")
		
		List<ProductVO> list = service.getList(cri);
		//cri에따른 list를 가져옴
		
		//List의 상품파일이름 여러개 일 시 앞에 한개로 수정
		for (ProductVO productVO : list) {
			List<String> fileNamesList = Arrays.asList(productVO.getProduct_filename().split(","));
			String fileNameFirst = fileNamesList.get(0);
			productVO.setProduct_filename(fileNameFirst);
		}
		
		int total = service.getTotal(cri);
		//페이징을 위한 total개수를 가져옴
		//cri가 들어가서 검색시에도 적용

		PageDTO dto = new PageDTO(cri, total);
		//JSP에 한꺼번에 넘겨서 사용할 페이징과 검색
		//statrPage, endPage, (prev, next = boolean), total, cri
		//생성자로 cri와 totla을 받아서 endPage와 startPage prev, next를 계산함
		
		model.addAttribute("list", list);
		model.addAttribute("pageDTO", dto);
		
		/* 카테고리 대분류를 보내줌 */
		List<String> categoryMainList = service.getCategoryMainList();
		model.addAttribute("categoryMainList", categoryMainList);
		
		//카테고리를 구해서 넣어줌(검색연동
		if (cri.getCategoryNum() != null && !cri.getCategoryNum().isEmpty()) {
			CategoryVO  categoryVO = service.getCategoryMainAndSub(Integer.parseInt(cri.getCategoryNum()));
			model.addAttribute("category", categoryVO);
		}
		
	}

	@GetMapping("/get")
	public void get(@RequestParam("product_seq") int product_seq, @ModelAttribute("cri") Criteria cri, Model model, HttpServletRequest request) {
		ProductVO vo = service.getCountUp(product_seq);
		model.addAttribute("product", vo);

		//옵션리스트넣어줌
		List<ProductOptionVO> poVOList = service.getProductOption(product_seq);
		model.addAttribute("poList", poVOList);
		model.addAttribute("cri", cri);
		
		//카테고리를 구해서 넣어줌
		CategoryVO  categoryVO = service.getCategoryMainAndSub(vo.getCategory_seq());
		model.addAttribute("category", categoryVO);
		
		//여러 상품파일이름을 list로 변환하고 넘겨줌
		List<String> fileNamesList = Arrays.asList(vo.getProduct_filename().split(","));
		model.addAttribute("productImgList", fileNamesList);
		
		/* 하트 처음 상태를 위해 좋아요를 눌렀는지 확인=리턴이 1이상이면 이미 눌른놈임 */
		int check = 0;
		if (request.getSession().getAttribute("authUser") != null) {
			UserVO userVO = (UserVO) request.getSession().getAttribute("authUser");
			ProductLikeVO productLikeVO = new ProductLikeVO();
			productLikeVO.setProduct_seq(product_seq);
			productLikeVO.setUser_seq(userVO.getUser_seq());     
			check = service.checkProductLike(productLikeVO);
		}
		model.addAttribute("produckLikeCheck", check);
	}
	
	@GetMapping("/modify")
	public String modify(@RequestParam("product_seq") int product_seq, @ModelAttribute("cri") Criteria cri, Model model, HttpServletRequest request, RedirectAttributes rttr) {
		
		ProductVO vo = service.get(product_seq);
		
		/* 로그인 본인인지 비교 */
		UserVO userVO = (UserVO) request.getSession().getAttribute("authUser");
		if (userVO.getUser_seq() != vo.getProduct_seller()) {
			rttr.addFlashAttribute("message","본인이 아닙니다");
			return "redirect:/product/list";
		}
		
		model.addAttribute("product", vo);
		model.addAttribute("cri", cri);
		
		String preFileNames = vo.getProduct_filename();
		//상품파일이름을 list로 변환해서 보내줌
		List<String> fileNamesList = Arrays.asList(preFileNames.split(","));
		System.out.println(fileNamesList);
		model.addAttribute("fileNamesList", fileNamesList);
		model.addAttribute("preFileNames", preFileNames);
		
		//옵션리스트넣어줌
		List<ProductOptionVO> poVOList = service.getProductOption(product_seq);
		model.addAttribute("poList", poVOList);
		
		/* 카테고리 대분류를 보내줌 */
		List<String> categoryMainList = service.getCategoryMainList();
		model.addAttribute("categoryMainList", categoryMainList);
		
		//카테고리를 구해서 넣어줌(검색연동
		CategoryVO  categoryVO = service.getCategoryMainAndSub(vo.getCategory_seq());
		model.addAttribute("category", categoryVO);
		
		return "/product/modify";
	}

	@PostMapping("/modify")
	public String modify(ProductVO product, Criteria cri, RedirectAttributes rttr,
			MultipartFile[] upload, HttpServletRequest request, Model model,
			String[] deletePo_seqArray, String[] productOption_seq, String[] po_name, String[] po_quantity, String[] po_price) {
		
		/* 아래에 cri로 대체해서 잘되면 지울거
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		*/
		rttr.addFlashAttribute("cri", cri);
		
		/* 카테고리가 비어 있을 때 돌려보냄-대분류소분류지정안했으면0임 */ 
		if (product.getCategory_seq() == 0) {
			rttr.addAttribute("product_seq", product.getProduct_seq());
			rttr.addFlashAttribute("message", "카테고리 선택이 올바르지 않습니다");
			return "redirect:/product/modify";
		}	
		/*상품옵션이 비었을때 돌려보냄*/
		String emp = "";
		int cnt = 0;
		/* 숫자배열2개 내 최소값이 0보다 커야함을표시 */
			for(int i = 0; i < po_quantity.length; i++) {
				if(!po_quantity[i].equals(emp) && Integer.parseInt(po_quantity[i]) <= 0 ) {
					cnt++;
				}
			}
			for(int i = 0; i < po_price.length; i++) {
				if(!po_price[i].equals(emp) && Integer.parseInt(po_price[i]) <= 0 ) {
					cnt++;
				}
			}
		if(/* 옵션하나도안넣으면안됨 */
			Arrays.asList(po_name).size() == 0 || Arrays.asList(po_quantity).size() == 0 || Arrays.asList(po_price).size() == 0 ||
			/* 빈값이 있으면 안됨 */
			Arrays.asList(po_name).contains(emp) || Arrays.asList(po_quantity).contains(emp) || Arrays.asList(po_price).contains(emp) ||
			/* 숫자들은 무조건 0보다 커야함 */
			cnt !=0
			) {
			rttr.addAttribute("product_seq", product.getProduct_seq());
			rttr.addFlashAttribute("message", "상품옵션항목이 올바르지 않습니다");
			return "redirect:/product/modify";
		}
		//옵션입력확인했으니 맨 처음 옵션의 가격과 옵션 총 수량을 넣어줌
		product.setProduct_price(Integer.parseInt(po_price[0]));
		int total = 0;
		for(String po_q : po_quantity) {
			total += Integer.parseInt(po_q);
		}
		product.setProduct_quantity(total);
		
		//파일 올리는 방법 복사
				//파일이 업로드 될 경로 설정 
				String saveDir = request.getSession().getServletContext().getRealPath("/resources/upload"); 
				
				//위에서 설정한 경로의 폴더가 없을 경우 생성 
				System.out.println(saveDir);
				File dir = new File(saveDir); 
				if(!dir.exists()) { 
					dir.mkdirs(); 
				}
				// 파일 업로드
					//철수추가 파일 이름 list추가
					List<String> reNames = new ArrayList<String>();
				
				for(MultipartFile f : upload) { 
					if(!f.isEmpty()) { 
						// 기존 파일 이름을 받고 확장자 저장 
						String orifileName = f.getOriginalFilename(); 
						String ext = orifileName.substring(orifileName.lastIndexOf("."));
						// 이름 값 변경을 위한 설정 
						SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd-HHmmssSSS"); 
						int rand = (int)(Math.random()*1000); 
						// 파일 이름 변경 
						String reName = sdf.format(System.currentTimeMillis()) + "_" + rand + ext; 
						// 파일 저장 
						try { 
							f.transferTo(new File(saveDir + "/" + reName)); 
						} catch (IOException e) { 
							e.printStackTrace(); 
						}
						
					//철수추가
					reNames.add(reName);
					} 
				}
				
				
				/* 파일이 하나도 첨부되어있지 않을때 다시돌려보냄=>수정시는 하나이상 반드시있음 
				if (reNames.size() == 0) {
					model.addAttribute("message", "상품이미지를 한 개이상 등록해야합니다.");
					model.addAttribute("product", product);
					model.addAttribute("cri", cri);
					return "/product/modify";
				}
				*/
				
		//철수추가 파일 올린 후에 그 이름을 product에 복사
			//list를 string 쉼표구분으로 만들기 
			String filenames = String.join(",", reNames);
		product.setProduct_filename(filenames);
		/* System.out.println(product.getProduct_filename()); */
		
			/* 다시 list로 얻는 방법 
			List<String> fileNamesList = Arrays.asList(filenames.split(","));
			System.out.println(fileNamesList);
			*/		
		
		/* 만약 첨부파일이 변동없다면 upload는 널이었을 것 */
		if(reNames.size() == 0) {
			product.setProduct_filename(request.getParameter("preFileNames"));
		} else {
			/* 변동있다면 이전그림지우기 */
			String oldFileNames = request.getParameter("preFileNames");
			List<String> fileNamesList = Arrays.asList(oldFileNames.split(","));
			System.out.println(fileNamesList);
			
			String saveDir2 = request.getSession().getServletContext().getRealPath("/resources/upload"); 
			
			/* 그림파일삭제 */
			for(String f : fileNamesList) { 
				if(!f.isEmpty()) { 
					File file = new File(saveDir2+"/"+f);			
					file.delete();
					} 
			}
			
		}
		
		/* 옵션 수정하는 것 추가  */
		int product_seq = product.getProduct_seq();
		rttr.addAttribute("product_seq", product_seq);
		if (service.modify(product, deletePo_seqArray, productOption_seq, po_name, po_quantity, po_price)) {
			rttr.addFlashAttribute("message", "수정하지 못했습니다");
		} else {
			rttr.addFlashAttribute("message", "해당 상품정보가 수정되었습니다.");
		}
		
		
		return "redirect:/product/get";
	}

	@PostMapping("/finish")
	public String finish(@RequestParam("product_seq") int product_seq, Criteria cri, HttpServletRequest request, RedirectAttributes rttr) {
		
		ProductVO vo = service.get(product_seq);
		
		/* 로그인 본인인지 비교 */
		UserVO userVO = (UserVO) request.getSession().getAttribute("authUser");
		if (userVO.getUser_seq() != vo.getProduct_seller()) {
			rttr.addFlashAttribute("message","본인이 아닙니다");
			return "redirect:/product/list";
		}
		
		if (service.finish(product_seq)) {
			rttr.addFlashAttribute("message","해당 상품 판매가 종료되었습니다.");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/product/list";
	}
	
	@GetMapping("/cart")
	public String cart (int product_seq, String[] order_poseq, String[] order_poname, 
			String[] order_poprice, String[] order_quantity, OrderVO orderVO, Criteria cri, 
			HttpServletRequest request, RedirectAttributes rttr, Model model, String checkCartOrder) {
		
		/*상품옵션이 비었을때 돌려보냄*/
			String emp = "";
			/* 숫자배열 내 최소값이 0보다 커야함을표시 */
			int cnt = 0;
			if(order_quantity !=null) {				
				for(int i = 0; i < order_quantity.length; i++) {
					if(!order_quantity[i].equals(emp) && Integer.parseInt(order_quantity[i]) <= 0 ) {
						cnt++;
					}
				}
			}
			if(/* 옵션하나도안넣으면안됨 */
				order_quantity == null ||
				Arrays.asList(order_quantity).size() == 0 ||
				/* 빈값이 있으면 안됨 */
				Arrays.asList(order_quantity).contains(emp) ||
				/* 숫자들은 무조건 0보다 커야함 */
				cnt !=0
				) {
				rttr.addFlashAttribute("message", "상품옵션항목이 올바르지 않습니다");
				rttr.addAttribute("product_seq", product_seq);
				return "redirect:/product/get";
			}
		/* 올바르면 리스트 만들기*/
		List<OrderVO> list = new ArrayList<OrderVO>();
		for (int i=0; i<order_quantity.length; i++) {
			OrderVO orderVOn = new OrderVO();
			orderVOn.setOrder_productseq(orderVO.getOrder_productseq());
			orderVOn.setOrder_poseq(Integer.parseInt(order_poseq[i]));
			orderVOn.setOrder_quantity(Integer.parseInt(order_quantity[i]));
			orderVOn.setOrder_poname(order_poname[i]);
			orderVOn.setOrder_poprice(Integer.parseInt(order_poprice[i]));
			orderVOn.setOrder_userseq(orderVO.getOrder_userseq());
			orderVOn.setOrder_username(orderVO.getOrder_username());
			orderVOn.setOrder_useraddress(orderVO.getOrder_useraddress());
			orderVOn.setOrder_userphone(orderVO.getOrder_userphone());
			orderVOn.setOrder_filename(orderVO.getOrder_filename());
			orderVOn.setOrder_filename(orderVO.getOrder_filename());
			
			list.add(orderVOn);
		}
		
		/*get에서 카트버튼으로 넘어왔으면 등록*/
		if (checkCartOrder.equals("cart")) {
			int rowNum = service.makeCart(list);
			
			rttr.addAttribute("product_seq", product_seq);
			rttr.addAttribute("pageNum", cri.getPageNum());
			rttr.addAttribute("amount", cri.getAmount());
			rttr.addAttribute("type", cri.getType());
			rttr.addAttribute("keyword", cri.getKeyword());
			rttr.addAttribute("array", cri.getArray());
			rttr.addAttribute("type", cri.getType());
			
			if(rowNum != list.size()) {
				rttr.addFlashAttribute("message", "장바구니 담기 실패");
			} else {
				rttr.addFlashAttribute("message", "장바구니 담기 성공");			
			}
			return "redirect:/product/get";
		/* get에서 구매버튼 눌렀으면 order로 넘겨주기 */
		} else {
			rttr.addFlashAttribute("direct", list);
			return "redirect:/product/orderFromDirect";
		}
		
	}
	@GetMapping("/order")
	public void order(@ModelAttribute("orderList")List<OrderVO> orderList, Model model) {
		
		model.addAttribute("orderList", orderList);
	}
	
	@GetMapping("/orderFromDirect")
	public String order(@ModelAttribute("direct")List<OrderVO> direct,
		RedirectAttributes rttr	) {
		
		rttr.addFlashAttribute("orderList", direct);
		return "redirect:/product/order";
		
	}
	@GetMapping("/orderFromCart")
	public String order(@RequestParam("order_seq") String[] order_seq, RedirectAttributes rttr) {
		
		List<OrderVO> list = new ArrayList<>();
		
		if(order_seq == null || order_seq.length == 0) {
			rttr.addFlashAttribute("message","카트에 물품을 하나라도 선택해야합니다.");
			return "redirect:/product/list";
		}	
		list = service.getOrderList(order_seq);
		rttr.addFlashAttribute("orderList", list);
		return "redirect:/product/order";
		
	}
	@PostMapping("/order")
	public String order (@RequestParam ("usePoint") String usePoint, 
			@RequestParam ("requireTotalPrice") String requireTotalPrice,
			OrderVO orderVO, RedirectAttributes rttr, HttpSession session) {
		
		/* 일단 가격이 맞는지 확인 */
		if(!usePoint.equals(requireTotalPrice)) {
			rttr.addFlashAttribute("message", "가격이 부족합니다.");
			return "redirect:/product/list";
		}
		
		/* null체크 */
		if(orderVO == null || orderVO.getOrderVOList() == null || orderVO.getOrderVOList().get(0) == null) {
			rttr.addFlashAttribute("message", "선택항목이 없습니다.");
			return "redirect:/product/list";
		}
		
		List<OrderVO> orderVOList = orderVO.getOrderVOList();
		
		int result = 0;
		boolean check = false;
		
		/* get에서 구매버튼으로 눌렀을 때 넘어온거면 들어온첫번째order_seq는 반드시0임*/
		if (orderVOList.get(0).getOrder_seq() == 0) {
			result = service.directOrder(orderVOList);
			if(result != orderVOList.size()) {
				check = true;
			}
		/* 장바구니에서 order_seq 배열로 넘어온것을 처리(seq만빼서사용됨) */
		} else {
			result= service.makeOrder(orderVOList);
			if(result != orderVOList.size()) {
				check = true;
			}
		}
		/* 위 두개의 열 적용수가 다르면 돌려보냄 */
		if (check) {
			rttr.addFlashAttribute("message", "오더실패");
			return "redirect:/product/list";	
		}
		/* 오더가 성공하면 구매자의 포인트를 낮춤*/
		int user_seq = orderVO.getOrderVOList().get(0).getOrder_userseq();
		int updatePointResult = service.updateUserPoint(user_seq, usePoint);
		if (updatePointResult == 0) {
			rttr.addFlashAttribute("message", "포인트반영실패");
			return "redirect:/product/list";
		}
		/* 포인트반영세션업데이트 */
		UserVO userVO = userService.getUserSeq(user_seq);
		session.setAttribute("authUser", userVO);
		
		return "redirect:/user/userOrderList";
	}
	
	
	/* 삭제참고용-구현만해둠 */
	@PostMapping("/remove")
	public String remove(@RequestParam("product_seq") int product_seq, Criteria cri, HttpServletRequest request, RedirectAttributes rttr) {
		
		ProductVO vo = service.get(product_seq);

		/* 지우는 사람이 로그인 본인인지 비교 */
		if (request.getSession().getAttribute("authUser").equals(vo.getProduct_seller())) {
			return "redirect:/product/list";
		}
		
		
		/* 상품db지우기 전에 그림지우기 */
		List<String> fileNamesList = Arrays.asList(vo.getProduct_filename().split(","));
		System.out.println(fileNamesList);
		
		String saveDir = request.getSession().getServletContext().getRealPath("/resources/upload"); 
		
		if (service.remove(product_seq)) {
			
			/* 그림파일삭제 */
			for(String f : fileNamesList) { 
				if(!f.isEmpty()) { 
					File file = new File(saveDir+"/"+f);			
					file.delete();
					} 
			}
			
			rttr.addFlashAttribute("message","해당 상품이 삭제되었습니다.");
		}

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());

		return "redirect:/product/list";
	}

}
