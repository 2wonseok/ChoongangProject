package org.zerock.product.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
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

	
	//원래 @PostMapping인데
	@GetMapping("/register")
	public String register(ProductVO product, RedirectAttributes rttr) {
			 
		
			log.info("상품등록");
			ProductVO productVO = new ProductVO();
			productVO.setProduct_filename("1");
			productVO.setProduct_info("1");
			productVO.setProduct_name("1");
			productVO.setProduct_price(123);
			productVO.setProduct_quantity(34);
			productVO.setProduct_seller("sd");
			productVO.setProduct_seq(5);
		
			 service.register(product);
				/*
				 * rttr.addFlashAttribute("result", product.getBno());
				 * rttr.addFlashAttribute("message",product.getBno() + "번 상품이 등록되었습니다.");
				 */
			return "redirect:/product/list";
	}
	
	
	/*
	 * @GetMapping("/list") public void list(@ModelAttribute("cri") Criteria cri,
	 * Model model) { List<BoardVO> list = service.getList(cri);
	 * 
	 * int total = service.getTotal(cri);
	 * 
	 * PageDTO dto = new PageDTO(cri, total);
	 * 
	 * model.addAttribute("list",list); model.addAttribute("pageMaker",dto); }
	 * 
	 * @GetMapping("/register") public void register(@ModelAttribute("cri") Criteria
	 * cri) { }
	 * 
	 * 
	 * 
	 * @GetMapping({"/get", "/modify"}) public void get(@RequestParam("bno") Long
	 * bno, @ModelAttribute("cri") Criteria cri, Model model) {
	 * 
	 * 예전코드 (스프링 없이) String boardNum = request.getParameter("num"); int num =
	 * Integer.parseInt(boardNum); BoardVO vo = service.get((long) num);
	 * request.setAttribute("board", vo);
	 * request.getRequestDispatcher(".jsp").forward();
	 * 
	 * 
	 * log.info("get method - bno:"+bno); BoardVO vo = service.get(bno);
	 * model.addAttribute("board", vo); //model.addAttribute("cri", cri); }
	 * 
	 * @PostMapping("/modify") public String modify(BoardVO board, Criteria cri,
	 * RedirectAttributes rttr, HttpServletRequest req) {
	 * 
	 * 예전코드 (스프링 없이) BoardVO board = new BoardVO();
	 * board.setBno(request.getParameter("bno"));//일단long변환등은생략
	 * board.setTitle(request.getParameter("title"));
	 * board.setContent(request.getParameter("content"));
	 * 
	 * if (service.modify(board)) { rttr.addFlashAttribute("result","success");
	 * rttr.addFlashAttribute("message",board.getBno() + "번 글이 수정되었습니다.");
	 * 
	 * //rttr.addAttribute("a","b"); //이렇게하면 쿼리스트링에 붙어서 redirect되게됨 }
	 * log.info("#######################@$@#$@$@#$@$###################");
	 * log.info(req.getParameter("keyword"));
	 * log.info(req.getParameterValues("keyword").length);
	 * log.info(req.getParameter("type"));
	 * log.info(req.getParameterValues("type").length); log.info(cri);
	 * rttr.addAttribute("pageNum", cri.getPageNum()); rttr.addAttribute("amount",
	 * cri.getAmount()); rttr.addAttribute("type", cri.getType());
	 * rttr.addAttribute("keyword", cri.getKeyword());
	 * 
	 * return "redirect:/board/list"; }
	 * 
	 * 
	 * @PostMapping("/remove") public String remove(@RequestParam("bno") Long bno,
	 * Criteria cri, RedirectAttributes rttr) {
	 * 
	 * if (service.remove(bno)) { rttr.addFlashAttribute("result","success");
	 * rttr.addFlashAttribute("message",bno + "번 글이 삭제되었습니다."); }
	 * 
	 * rttr.addAttribute("pageNum", cri.getPageNum()); rttr.addAttribute("amount",
	 * cri.getAmount()); rttr.addAttribute("type", cri.getType());
	 * rttr.addAttribute("keyword", cri.getKeyword());
	 * 
	 * return "redirect:/board/list"; }
	 * 
	 * 
	 * @GetMapping("/modify") public void modify(Long bno, Model model) { BoardVO vo
	 * = service.get(bno); model.addAttribute("board",vo); }
	 * 
	 * 
	 * }
	 */

}
