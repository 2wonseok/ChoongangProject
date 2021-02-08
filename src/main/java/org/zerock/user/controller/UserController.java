package org.zerock.user.controller;

import java.util.ArrayList;

import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
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
	
	private BCryptPasswordEncoder pwdEncoder;
	
	private UserService service;
	
	@GetMapping("/userRegister") //회원 가입 페이지 로딩
	public void register() {
	
	}
	
	@PostMapping("/userRegister") // 회원 가입 처리
	public String register(UserVO user, Model model, RedirectAttributes rttr) {
		String inputPass = user.getUser_password();
		String pwd = pwdEncoder.encode(inputPass);
		user.setUser_password(pwd);
		
		service.register(user);

		return "redirect:/main/index";
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
	public String modify(UserVO user, @RequestParam String changePw, Criteria cri, RedirectAttributes rttr) {
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
			rttr.addFlashAttribute("result", "modifySuccess");
			rttr.addFlashAttribute("message", user.getUser_seq()+"번 회원 정보가 수정되었습니다.");
		}

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/main/index";
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
	public void address() {
		
	}
	
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
	public void login() {
		
	}
	
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
			return "redirect:/main/index";
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
		
		return "redirect:/main/index";
	}
	
	@GetMapping("/userRemove") // 회원 탈퇴
	public void RemoveUser() {
		
	}
	
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
		
		return "redirect:/main/index";
	}
	
	@GetMapping("/sendSMS") // 휴대폰 인증 
	public @ResponseBody void sendSMS(String user_phone, HttpSession session) {
		
		Random rand  = new Random();
    String numStr = "";
    for(int i=0; i<4; i++) {
        String ran = Integer.toString(rand.nextInt(10));
        numStr+=ran;
    }

    System.out.println("수신자 번호 : " + user_phone);
    System.out.println("인증번호 : " + numStr);
    service.smsService(user_phone,numStr);
//    rttr.addFlashAttribute("AuthenticationNum", numStr);
    session.setAttribute("phoneConfirm", numStr);
	}
	
	@GetMapping("/authentication") // 인증번호 확인
	public @ResponseBody int authentication(String phoneConfirm, HttpSession session) {
		int result = 1;
		
		if (session.getAttribute("phoneConfirm").equals(phoneConfirm)) {
			result = 0;
		} else {
			result = 1;
		}
		
		return result;
	}
	
	@GetMapping("/findId")
	public void findId() {
		
	}
	
	@GetMapping("/findPw")
	public void findPw() {
		
	}
	
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
}
