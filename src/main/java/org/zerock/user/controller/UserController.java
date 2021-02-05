package org.zerock.user.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
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
	
	private RevBoardService revService;
	
	private UserService service;
	
	@GetMapping("/userRegister")
	public void register() {
	
	}
	
	@PostMapping("/userRegister")
	public String register(UserVO user, Model model, RedirectAttributes rttr) {
		service.register(user);
//		rttr.addFlashAttribute("result", board.getBno());
//		rttr.addFlashAttribute("message", board.getBno()+"번 글이 등록되었습니다.");
		return "redirect:/main/index";
	}
	
	@GetMapping("/userList")
	public void getList(@ModelAttribute("cri") Criteria cri, Model model) {
		log.info(cri.getType() + "=" + cri.getKeyword());
		List<UserVO> list = service.getList(cri);
		
		int total = service.getTotal(cri);
		
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
	}
	
	@GetMapping({"/userRead", "/userModify"})
	public void read(@RequestParam String user_id, @ModelAttribute("cri") Criteria cri, Model model) {
		model.addAttribute("read", service.getUser(user_id));
	}
	
	@PostMapping("/gradeUpdate")
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
	
	@PostMapping("/userModify")
	public String modify(UserVO user, @RequestParam String changePw, Criteria cri, RedirectAttributes rttr) {
		UserVO vo = service.getUser(user.getUser_id());
		
		if (!vo.getUser_password().equals(user.getUser_password())) {
			rttr.addFlashAttribute("notMatch", "현재 비밀번호가 맞지 않습니다.");
			rttr.addAttribute("user_id", vo.getUser_id());	
			rttr.addAttribute("pageNum", cri.getPageNum());
			rttr.addAttribute("amount", cri.getAmount());
			
			return "redirect:/user/userModify";
		}
		
		user.setUser_password(changePw);
		
		if (service.update(user)) {
			rttr.addFlashAttribute("result", "modifySuccess");
			rttr.addFlashAttribute("message", user.getUser_seq()+"번 회원 정보가 수정되었습니다.");
		}

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/user/userList";
	}
	
	@PostMapping("/userDelete")
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
	
	@PostMapping("/userCheckDel")
	public String checkDel(@RequestParam("seq") ArrayList<Integer> seq, RedirectAttributes rttr) {
		for (int no : seq) {
			if (service.delete(no)) {
				rttr.addFlashAttribute("result", "deleteSuccess");
				rttr.addFlashAttribute("message", seq+"번 회원이 삭제되었습니다.");
			}
		}
		return "redirect:/user/userList";
	}
	
	@RequestMapping("/jusoPopup")
	public void address() {
		
	}
	
	@GetMapping("/idCheck")
	public void idCheck() {
		
	}
	
	@GetMapping("/nickCheck")
	public void nickCheck() {
		
	}
	
	@RequestMapping("/searchIdCheck")
	public String searchIdCheck(UserVO vo, RedirectAttributes rttr) {
		if (vo.getUser_id() != null) {
			int checkId = service.idCheck(vo.getUser_id());
			
			if (checkId == 1) {
				rttr.addFlashAttribute("user_id", vo.getUser_id());
				rttr.addFlashAttribute("checkResultN", "이미 사용중인 아이디 입니다.");
			} else {
				rttr.addFlashAttribute("user_id", vo.getUser_id());
				rttr.addFlashAttribute("checkResultY", "사용 가능합니다.");
			}
			
			return "redirect:/user/idCheck";
		}
		
		if (vo.getUser_nickname() != null) {
			int checkNick = service.nickCheck(vo.getUser_nickname());
			
			if (checkNick == 1) {
				rttr.addFlashAttribute("user_nickname", vo.getUser_nickname());
				rttr.addFlashAttribute("checkResultNcikN", "이미 사용중인 닉네임 입니다.");
			} else {
				rttr.addFlashAttribute("user_nickname", vo.getUser_nickname());
				rttr.addFlashAttribute("checkResultNcikY", "사용 가능합니다.");
			}
			return "redirect:/user/nickCheck";
		}
		
		return "";
	}
	
	@GetMapping("/login")
	public void login() {
		
	}
	
	@PostMapping("/login")
	public String login(UserVO user, RedirectAttributes rttr, HttpSession session) {
		UserVO vo = service.getUser(user.getUser_id());
		
		if (vo == null || !user.getUser_id().equals(vo.getUser_id()) || 
				!user.getUser_password().equals(vo.getUser_password())) {
			rttr.addFlashAttribute("noUser", "일치하는 정보가 없습니다.");
			return "redirect:/user/login";
		} else {
			session.setAttribute("authUser", vo);
			return "redirect:/main/index";
		}
		
	}
	
	@GetMapping("/logout")
	public String logout(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		
		if (session != null) {
			session.invalidate();
		}
		
		return "redirect:/main/index";
	}
	
	@RequestMapping("/sendSMS")
	public @ResponseBody String sendSMS(String user_phone) {
		Random rand  = new Random();
    String numStr = "";
    for(int i=0; i<4; i++) {
        String ran = Integer.toString(rand.nextInt(10));
        numStr+=ran;
    }

    System.out.println("수신자 번호 : " + user_phone);
    System.out.println("인증번호 : " + numStr);
    create(user_phone,numStr);
    return numStr;
	}
	
	public void create(String user_phone, String cerNum) {
		
		String api_key = "NCSKI3A4IVCQ0M1E";
    String api_secret = "9FBKZ8X5QO6MLPBYMA21D0HZIR1Q4XCF";
    Message coolsms = new Message(api_key, api_secret);

    // 4 params(to, from, type, text) are mandatory. must be filled
    HashMap<String, String> params = new HashMap<String, String>();
    params.put("to", user_phone);    // 수신전화번호
    params.put("from", "010-2369-3793");    // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
    params.put("type", "SMS");
    params.put("text", "인증번호는" + "["+cerNum+"]" + "입니다.");
    params.put("app_version", "test app 1.2"); // application name and version

    try {
      JSONObject obj = (JSONObject) coolsms.send(params);
      System.out.println(obj.toString());
    } catch (CoolsmsException e) {
      System.out.println(e.getMessage());
      System.out.println(e.getCode());
    }
	}
}
