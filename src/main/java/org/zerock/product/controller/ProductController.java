package org.zerock.product.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	public String register(ProductVO product, RedirectAttributes rttr) {

		service.register(product);
		
		rttr.addFlashAttribute("result", product.getProduct_seq());
		rttr.addFlashAttribute("message",product.getProduct_seq() + "번 상품이 등록되었습니다.");
		
		return "redirect:/product/list";
	}
	/////////////////////////////////////

	@GetMapping("/list")
	public void list(@ModelAttribute("cri") Criteria cri, Model model) {
		List<ProductVO> list = service.getList(cri);

		int total = service.getTotal(cri);

		PageDTO dto = new PageDTO(cri, total);

		model.addAttribute("list", list);
		model.addAttribute("pageMaker", dto);
	}

	@GetMapping({ "/get", "/modify" })
	public void get(@RequestParam("") int product_seq, @ModelAttribute("cri") Criteria cri, Model model) {
		ProductVO vo = service.get(product_seq);
		model.addAttribute("ProductVO", vo);
	}

	@PostMapping("/modify")
	public String modify(ProductVO product, Criteria cri, RedirectAttributes rttr, HttpServletRequest req) {

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
