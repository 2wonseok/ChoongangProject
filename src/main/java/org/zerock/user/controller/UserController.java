package org.zerock.user.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.RevBoard.service.RevBoardService;
import org.zerock.product.domain.OrderVO;
import org.zerock.product.domain.ProductVO;
import org.zerock.product.service.ProductService;
import org.zerock.user.domain.Criteria;
import org.zerock.user.domain.PageDTO;
import org.zerock.user.domain.UserVO;
import org.zerock.user.service.UserService;


import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Controller
@AllArgsConstructor
@Log4j
@RequestMapping("/user/*")
public class UserController {
	
	private ProductService pdService;
	
	private BCryptPasswordEncoder pwdEncoder;
	
	private UserService service;
	
	@GetMapping("/userRegister") //회원 가입 페이지 로딩
	public void register() {}
	
	@PostMapping("/userRegister") // 회원 가입 처리
	public String register(UserVO user, Model model, RedirectAttributes rttr) {
		String inputPass = user.getUser_password();
		String pwd = pwdEncoder.encode(inputPass);
		user.setUser_password(pwd);
		
		service.register(user);

		return "redirect:/main/mainPage";
	}
	
	@GetMapping("/userList") // 회원 목록 로딩
	public void getList(@ModelAttribute("cri") Criteria cri, Model model) {
		log.info(cri.getType() + "=" + cri.getKeyword());
		List<UserVO> list = service.getList(cri);
		
		int total = service.getTotal(cri);
		
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
	}
	
	@GetMapping({"/userRead", "/userModify"}) // 회원 정보 및 수정 로딩
	public void read(@RequestParam String user_id, @ModelAttribute("cri") Criteria cri, Model model) {
		model.addAttribute("read", service.getUser(user_id));
	}
	
	@PostMapping("/gradeUpdate") // 회원 등급 업데이트
	public String gradeUpdate(UserVO vo, @ModelAttribute("cri") Criteria cri, 
													Model model, RedirectAttributes rttr) {
		
		service.gradeUpdate(vo);
		
		rttr.addAttribute("user_id", vo.getUser_id());	
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
//		rttr.addAttribute("type", cri.getType());
//		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/user/userRead";
	}
	
	@PostMapping("/userModify") // 회원 정보 수정
	public String modify(UserVO user, @RequestParam String changePw, Criteria cri, RedirectAttributes rttr, HttpSession session) {
		UserVO vo = service.getUser(user.getUser_id());
		
		boolean pwdMatch = pwdEncoder.matches(user.getUser_password(), vo.getUser_password());
		
		if (pwdMatch == false) {
			rttr.addFlashAttribute("notMatch", "현재 비밀번호가 맞지 않습니다.");
			rttr.addAttribute("user_id", vo.getUser_id());	
			rttr.addAttribute("pageNum", cri.getPageNum());
			rttr.addAttribute("amount", cri.getAmount());
			
			return "redirect:/user/userModify";
		}
		
		String inputPass = changePw;
		String pwd = pwdEncoder.encode(inputPass);
		user.setUser_password(pwd);
		
		if (service.update(user)) {
			session.setAttribute("authUser", user);
			rttr.addFlashAttribute("result", "modifySuccess");
			rttr.addFlashAttribute("message", user.getUser_seq()+"번 회원 정보가 수정되었습니다.");
		}

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/main/mainPage";
	}
	
	@PostMapping("/userDelete") // 회원 삭제
	public String remove(@RequestParam int user_seq, Criteria cri, RedirectAttributes rttr) {
		if (service.delete(user_seq)) {
			rttr.addFlashAttribute("result", "deleteSuccess");
			rttr.addFlashAttribute("message", user_seq+"번 회원이 삭제되었습니다.");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/user/userList";
	}
	
	@PostMapping("/userCheckDel") // 회원 선택 삭제
	public String checkDel(@RequestParam("seq") ArrayList<Integer> seq, RedirectAttributes rttr) {
		for (int no : seq) {
			if (service.delete(no)) {
				rttr.addFlashAttribute("result", "deleteSuccess");
				rttr.addFlashAttribute("message", seq+"번 회원이 삭제되었습니다.");
			}
		}
		return "redirect:/user/userList";
	}
	
	@RequestMapping("/jusoPopup") // 주소 api 팝업 로딩
	public void address() {}
	
	@GetMapping("/duplicateCheck") // 아이디 및 닉네임 중복 확인
	public @ResponseBody int idCheck(UserVO vo, RedirectAttributes rttr) {
		if (vo.getUser_id() != null && !vo.getUser_id().isEmpty()) {
			int checkId = service.idCheck(vo.getUser_id());
			return checkId;
		}
		
		if (vo.getUser_nickname() != null && !vo.getUser_nickname().isEmpty()) {
			int checkNick = service.nickCheck(vo.getUser_nickname());
			return checkNick;
		}
		
		return 1;
	}
	
	@GetMapping("/login") // 로그인 페이지 로딩
	public void login() {}
	
	@PostMapping("/login") // 로그인 처리
	public String login(UserVO user, RedirectAttributes rttr, HttpSession session) {
		UserVO vo = service.getUser(user.getUser_id());
		
		if (vo == null || !user.getUser_id().equals(vo.getUser_id())) {
			rttr.addFlashAttribute("noUser", "일치하는 정보가 없습니다.");
			return "redirect:/user/login";
		}
				
		boolean pwdMatch = pwdEncoder.matches(user.getUser_password(), vo.getUser_password());
		
		if (vo != null && pwdMatch == true) {
			session.setAttribute("authUser", vo);
			return "redirect:/main/mainPage";
		} else {
			rttr.addFlashAttribute("noUser", "일치하는 정보가 없습니다.");
			return "redirect:/user/login";
		}
		
	}
	
	@GetMapping("/logout") // 로그아웃 처리
	public String logout(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		
		if (session != null) {
			session.invalidate();
		}
		
		return "redirect:/main/mainPage";
	}
	
	@GetMapping("/userRemove") // 회원 탈퇴
	public void RemoveUser() {}
	
	@PostMapping("/userRemove") // 회원 탈퇴 처리
	public String UserRemove(UserVO user, HttpServletRequest req, RedirectAttributes rttr) {
		UserVO vo = service.getUser(user.getUser_id());
		
		boolean pwdMatch = pwdEncoder.matches(user.getUser_password(), vo.getUser_password());
		
		if (pwdMatch == false) {
			rttr.addFlashAttribute("errorPw", "비밀번호가 맞지 않습니다.");
			return "redirect:/user/userRemove";
		}
		
		service.userRemove(user.getUser_id());
		
		HttpSession session = req.getSession(false);
		
		if (session != null) {
			session.invalidate();
		}
		
		return "redirect:/main/mainPage";
	}
	
	@GetMapping("/sendSMS") // 휴대폰 인증 
	public @ResponseBody int sendSMS(String user_phone, HttpSession session) {
		UserVO phoneCheck = service.findUser(user_phone);
		System.out.println(phoneCheck);
		
		if (user_phone == null || user_phone.isEmpty()) {
			session.setAttribute("null", "번호를 입력해주세요.");
			return 2;
		} 
		
		if (phoneCheck == null && user_phone != null) {
			Random rand  = new Random();
	    String numStr = "";
	    for(int i=0; i<4; i++) {
	        String ran = Integer.toString(rand.nextInt(10));
	        numStr+=ran;
	    }

	    System.out.println("수신자 번호 : " + user_phone);
	    System.out.println("인증번호 : " + numStr);
	    service.smsService(user_phone,numStr);
//	    rttr.addFlashAttribute("AuthenticationNum", numStr);
	    session.setAttribute("phoneConfirm", numStr);
	    
	    return 0;
		}
		
		if (phoneCheck.getUser_phone() != null || !phoneCheck.getUser_phone().isEmpty()) {
			session.setAttribute("inUse", "이미 등록된 번호입니다.");
			return 1;
		} 
		
		return 0;
	}
	
	@GetMapping("/authentication") // 인증번호 확인
	public @ResponseBody int authentication(String phoneConfirm, HttpSession session) {
		int result = 1;
		
		if (phoneConfirm == null || phoneConfirm.isEmpty()) {
			return result;
		}
		
		if (session.getAttribute("phoneConfirm").equals(phoneConfirm)) {
			result = 0;
		} else {
			result = 1;
		}
		
		return result;
	}
	
	@GetMapping("/findId")
	public void findId() {}
	
	@GetMapping("/findPw")
	public void findPw() {}
	
	@GetMapping("/findUserId")
	public @ResponseBody String findInfo(UserVO user) {
		UserVO vo = service.findUser(user.getUser_phone());
		
			if (user.getUser_name() == null || user.getUser_phone() == null ||
					user.getUser_name().isEmpty() || user.getUser_phone().isEmpty() || 
					vo == null) {
				return null;
			}
		
		return vo.getUser_id();
	}
	
	@GetMapping("/findUserPw")
	public @ResponseBody UserVO findPw(UserVO user) {
		UserVO vo = service.findUser(user.getUser_phone());
		
		if (user.getUser_id() == null || user.getUser_phone() == null ||
				user.getUser_id().isEmpty() || user.getUser_phone().isEmpty() ||
				vo == null) {
			return vo;
		}
    
		return vo;
	}
	
	@GetMapping("/modifyPw")
	public void modPw(String user_id) {}
	
	@PostMapping("/modifyPw")
	public @ResponseBody int modifyPw(UserVO user) {
		String inputPass = user.getUser_password();
		String pwd = pwdEncoder.encode(inputPass);
		user.setUser_password(pwd);
		
		int result = service.modifyPw(user);
		
		return result;
	}
	
	@GetMapping("/userOrderList") // 주문목록
	public void orderList(HttpSession session, Criteria cri, Model model) {
		UserVO vo = (UserVO) session.getAttribute("authUser");
		int order_userseq = 0;
		
		if (vo != null) {
			order_userseq = vo.getUser_seq();
		}
		
		List<OrderVO> order = service.orderList(order_userseq, cri);
		model.addAttribute("pageMaker", new PageDTO(cri, service.getTotalOrderList(vo.getUser_seq(), cri)));
		model.addAttribute("order", order);
	}
	
	@GetMapping("/cart") // 장바구니
	public void cart(HttpSession session, Criteria cri, Model model) {
		UserVO vo = (UserVO) session.getAttribute("authUser");
		int order_userseq = 0;
		
		if (vo != null) {
			order_userseq = vo.getUser_seq();
			
			List<OrderVO> cart = service.cartList(order_userseq, cri);
			
			model.addAttribute("pageMaker", new PageDTO(cri, service.getTotalCartList(vo.getUser_seq(), cri)));
			model.addAttribute("cartList", cart);
		}
		
	}
	
	@GetMapping("/shippingCheck") //배송조회
	public void ShippingCheckBtn(int order_seq) {
		
	}
	
	@GetMapping("/smsSubmit") // 회원 문자 전송
	public void smsSubmit(@RequestParam("seq") ArrayList<Integer> seq, Model model) {
		List<UserVO> list = new ArrayList<UserVO>();
			for (int no : seq) {
				UserVO vo = service.getUserSeq(no);
				
				//List<UserVO> list = new ArrayList<UserVO>();
				list.add(vo);
	
			}
		model.addAttribute("user", list);
		
	}
	
	@PostMapping("/smsSubmit") // 유저 문자 전송
	public String smsSubmitPost(@RequestParam("user_phone") ArrayList<String> user_phone, 
			@RequestParam String smsContent,RedirectAttributes rttr) {
		for (String phoneNum : user_phone) {
			service.smsSubmit(phoneNum, smsContent);
		}
		
		return "redirect:/user/userList";
	}
	
	@GetMapping("/productList") // 판매 목록 
	public void proList(HttpSession session, Criteria cri, Model model) {
		UserVO vo = (UserVO) session.getAttribute("authUser");
		
		if (vo != null) {
			model.addAttribute("pageMaker", new PageDTO(cri, service.getTotalProductList(vo.getUser_nickname(), cri)));
		}
	}
	
	@GetMapping(value = "/productList2", produces = MediaType.APPLICATION_JSON_UTF8_VALUE) // 판매 목록 AJAX
	public @ResponseBody List<ProductVO> pdList(HttpSession session, Criteria cri, Model model) {
		List<ProductVO> list = new ArrayList<ProductVO>();
		UserVO vo = (UserVO) session.getAttribute("authUser");
		
		if (vo != null) {
			list = service.productList(vo.getUser_nickname(), cri);
		}
		
		model.addAttribute("pageMaker", new PageDTO(cri, service.getTotalProductList(vo.getUser_nickname(), cri)));
		
		return list;
	}
	
	@GetMapping("/orderList") // 결제완료 목록
	public @ResponseBody List<OrderVO> odInfo(OrderVO order, Criteria cri, Model model) {
		List<OrderVO> vo = service.orderInfo(order.getOrder_productseq(), cri);
		model.addAttribute("orderPageMaker", new PageDTO(cri, service.getTotalOrderInfoList(order.getOrder_productseq(), cri)));
		return vo;
		
	}
	
	@GetMapping("/productSend") // 배송 처리
	public String productSend(@RequestParam("order_seq") ArrayList<Integer> order_seq, Criteria cri) {
		for (int no : order_seq) {
			service.productSend(no, cri);
		}
		
		return "redirect:/user/productList";
	}
	
	@GetMapping("/sendList") // 배송중인 상품 목록
	public @ResponseBody List<OrderVO> sendList(HttpSession session, Criteria cri) {
		List<OrderVO> list = new ArrayList<OrderVO>();
		UserVO vo = (UserVO) session.getAttribute("authUser");
		
		if (vo != null) {
			List<ProductVO> pvo = service.productList(vo.getUser_nickname(), cri);
			for (ProductVO pvoList : pvo) {
				System.out.println("product seq 번호: " +pvoList.getProduct_seq());
				List<OrderVO> sendList = service.sendList(pvoList.getProduct_seq(), cri);
				list.addAll(sendList);
				
			}
			return list;
					
		}
		
		
		return list;
		
	}
}
