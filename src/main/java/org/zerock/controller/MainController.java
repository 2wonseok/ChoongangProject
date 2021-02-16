package org.zerock.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zerock.product.domain.Criteria;
import org.zerock.product.domain.PageDTO;
import org.zerock.product.domain.ProductVO;
import org.zerock.product.service.ProductService;

import edu.emory.mathcs.backport.java.util.Arrays;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/main/*") // 예전 list.do -> List.handler가 일하라고 했던 역할
@AllArgsConstructor
@Log4j
public class MainController {
	
	private ProductService service;
	
	@GetMapping("/mainPage")
	public void list(@ModelAttribute("cri") Criteria cri, Model model) {
		cri.setArray("readcnt");
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
	}
}
