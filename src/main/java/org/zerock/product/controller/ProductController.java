package org.zerock.product.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.product.domain.Criteria;
import org.zerock.product.domain.PageDTO;
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
	
	@GetMapping("/register")
	public String register(@ModelAttribute("cri") Criteria cri, HttpServletRequest request, RedirectAttributes rttr) {
		
		/* 로그인 해야지만 register를 할 수 있게끔 */
		if (request.getSession().getAttribute("authUser") == null) {
			rttr.addFlashAttribute("message","로그인 되어있지 않습니다.");
			return "redirect:/product/list";
		}
		return "/product/register";
	}

	@PostMapping("/register")
	public String register(ProductVO product, RedirectAttributes rttr, MultipartFile[] upload, HttpServletRequest request) {
		
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
		
		service.register(product);
		
		rttr.addFlashAttribute("message", "상품이 등록되었습니다.");
		
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
		
		
		/* seller(user_seq)에 따른 닉네임 얻고 넘겨주기 */
		/* seller(user_seq)에 따른 닉네임 얻고 넘겨주기 */
		Map<Integer, String> userIdNick = new HashMap<Integer, String>();
		for(ProductVO productVO :list) {
			int user_seq = productVO.getProduct_seller();
			UserVO userVO = userService.getUserSeq(user_seq);
			
			String user_nick ="";
			if(userVO == null) {
				user_nick ="탈퇴한 유저";
			}
			user_nick = userVO.getUser_nickname();				
			
			userIdNick.put(user_seq, user_nick);
		}		
		model.addAttribute("userIdNick", userIdNick);
		
		model.addAttribute("list", list);
		model.addAttribute("pageDTO", dto);
	}

	@GetMapping("/get")
	public void get(@RequestParam("product_seq") int product_seq, @ModelAttribute("cri") Criteria cri, Model model) {
		ProductVO vo = service.getCountUp(product_seq);
		model.addAttribute("product", vo);
		model.addAttribute("cri", cri);
		
		//여러 상품파일이름을 list로 변환하고 넘겨줌
		List<String> fileNamesList = Arrays.asList(vo.getProduct_filename().split(","));
		model.addAttribute("productImgList", fileNamesList);
		
		/* seller(user_id)에 따른 닉네임 얻고 넘겨주기 */
		
		String user_id = vo.getProduct_seller();
		UserVO userVO = userService.getUser(user_id);
		String user_nick = userVO.getUser_nickname();
				
		model.addAttribute("user_nick", user_nick);
		
	}
	
	@GetMapping("/modify")
	public void modify(@RequestParam("product_seq") int product_seq, @ModelAttribute("cri") Criteria cri, Model model) {
		
		ProductVO vo = service.get(product_seq);
		model.addAttribute("product", vo);
		model.addAttribute("cri", cri);
		
		String preFileNames = vo.getProduct_filename();
		//상품파일이름을 list로 보내줌
		List<String> fileNamesList = Arrays.asList(preFileNames.split(","));
		System.out.println(fileNamesList);
		model.addAttribute("fileNamesList", fileNamesList);
		model.addAttribute("preFileNames", preFileNames);
	}

	@PostMapping("/modify")
	public String modify(ProductVO product, Criteria cri, RedirectAttributes rttr, MultipartFile[] upload, HttpServletRequest request, Model model) {
		
		
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		/* 수정하는 사람이 로그인 본인인지 비교 */
		if (request.getSession().getAttribute("authUser").equals(product.getProduct_seller())) {
			return "redirect:/product/list";
		}
		
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
		
		if (service.modify(product)) {
			rttr.addFlashAttribute("message", "해당 상품정보가 수정되었습니다.");
		}
		 
		return "redirect:/product/list";
	}

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
