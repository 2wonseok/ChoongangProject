package org.zerock.product.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.product.domain.Criteria;
import org.zerock.product.domain.PageDTO;
import org.zerock.product.domain.ProductVO;
import org.zerock.product.service.ProductService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@AllArgsConstructor
@Log4j
@RequestMapping("/product/*")
public class ProductController {

	private ProductService service;

	@GetMapping("/register")
	public void register(@ModelAttribute("cri") Criteria cri) {

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
		//철수추가 파일 올린 후에 그 이름을 product에 복사
		product.setProduct_filename(reNames.get(0));
		
		System.out.println(product.getProduct_filename());
		
		
		
		
		
		service.register(product);
		
		rttr.addFlashAttribute("result", product.getProduct_seq());
		rttr.addFlashAttribute("message",product.getProduct_seq() + "번 상품이 등록되었습니다.");
		
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

		int total = service.getTotal(cri);
		//페이징을 위한 total개수를 가져옴
		//cri가 들어가서 검색시에도 적용

		PageDTO dto = new PageDTO(cri, total);
		//JSP에 한꺼번에 넘겨서 사용할 페이징과 검색
		//statrPage, endPage, (prev, next = boolean), total, cri
		//생성자로 cri와 totla을 받아서 endPage와 startPage prev, next를 계산함

		model.addAttribute("list", list);
		model.addAttribute("pageDTO", dto);
	}

	@GetMapping({ "/get", "/modify" })
	public void get(@RequestParam("product_seq") int product_seq, @ModelAttribute("cri") Criteria cri, Model model) {
		ProductVO vo = service.get(product_seq);
		model.addAttribute("product", vo);
		model.addAttribute("cri", cri);
	}

	@PostMapping("/modify")
	public String modify(ProductVO product, Criteria cri, RedirectAttributes rttr, MultipartFile[] upload, HttpServletRequest request) {

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
		//철수추가 파일 올린 후에 그 이름을 product에 복사
		product.setProduct_filename(reNames.get(0));
		
		System.out.println(product.getProduct_filename());
		
		
		if (service.modify(product)) {
			rttr.addFlashAttribute("result", "success");
			rttr.addFlashAttribute("message", product.getProduct_seq() + "번 상품정보가 수정되었습니다.");

		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
 
		return "redirect:/product/list";
	}

	@PostMapping("/remove")
	public String remove(@RequestParam("product_seq") int product_seq, Criteria cri, RedirectAttributes rttr) {

		if (service.remove(product_seq)) {
			rttr.addFlashAttribute("result", "success");
			rttr.addFlashAttribute("message", product_seq + "번 글이 삭제되었습니다.");
		}

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());

		return "redirect:/product/list";
	}

}
