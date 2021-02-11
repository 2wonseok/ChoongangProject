package org.zerock.RevBoard.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.RevBoard.domain.Criteria;
import org.zerock.RevBoard.domain.GoodCheck;
import org.zerock.RevBoard.domain.HateCheck;
import org.zerock.RevBoard.domain.PageDTO;
import org.zerock.RevBoard.domain.RevVO;
import org.zerock.RevBoard.service.RevBoardService;
import org.zerock.user.domain.UserVO;

import edu.emory.mathcs.backport.java.util.Arrays;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/rev/*")
@AllArgsConstructor
@Log4j
public class RevBoardController {

	private RevBoardService service;

	@GetMapping("/register")
	public void register() {

	}

	@PostMapping("/register")
	public String register(RevVO revVo, Model model, RedirectAttributes rttr, MultipartFile[] upload,
			HttpServletRequest request) {
		Map<String, Boolean> errors = new HashMap<String, Boolean>();

		if (revVo.getRev_title().isEmpty() || revVo.getRev_title() == null) {
			errors.put("noTitle", Boolean.TRUE);
		}
		if (revVo.getRev_category().isEmpty() || revVo.getRev_category() == null) {
			errors.put("noCategory", Boolean.TRUE);
		}
		if (revVo.getRev_content().isEmpty() || revVo.getRev_content() == null) {
			errors.put("noContent", Boolean.TRUE);
		}
		if (revVo.getRev_writer().isEmpty() || revVo.getRev_writer() == null) {
			errors.put("noWriter", Boolean.TRUE);
		}

		// 파일이 업로드 될 경로 설정
		String saveDir = request.getSession().getServletContext().getRealPath("/resources/upload");
		// 위에서 설정한 경로의 폴더가 없을 경우 생성
		System.out.println(saveDir);
		File dir = new File(saveDir);

		if (!dir.exists()) {
			dir.mkdirs();
		} // 파일 업로드

		List<String> reNames = new ArrayList<String>();

		for (MultipartFile f : upload) {
			if (!f.isEmpty()) {
				// 기존 파일 이름을 받고 확장자 저장
				String orifileName = f.getOriginalFilename();
				String ext = orifileName.substring(orifileName.lastIndexOf("."));
				// 이름 값 변경을 위한 설정
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd-HHmmssSSS");
				int rand = (int) (Math.random() * 1000);
				// 파일 이름 변경
				String reName = sdf.format(System.currentTimeMillis()) + "_" + rand + ext;
				// 파일 저장
				try {
					f.transferTo(new File(saveDir + "/" + reName));
				} catch (IOException e) {
					e.printStackTrace();
				}

				reNames.add(reName);
			}
		}
		if (!reNames.isEmpty()) { // 파일이 비어있지않을때
			revVo.setRev_filename(reNames.get(0));
		} else { // 파일이 비어있을때
			revVo.setRev_filename("");
		}
		// list를 string 쉼표구분으로 만들기
		String filenames = String.join(",", reNames);
		revVo.setRev_filename(filenames);
		System.out.println(filenames);

		if (!errors.isEmpty()) {
			rttr.addFlashAttribute("errors", errors);
			rttr.addFlashAttribute("category", revVo.getRev_category());
			rttr.addFlashAttribute("title", revVo.getRev_title());
			rttr.addFlashAttribute("content", revVo.getRev_content());
			rttr.addFlashAttribute("writer", revVo.getRev_writer());

			return "redirect:/rev/register";
		}

		UserVO user = (UserVO) request.getSession(false).getAttribute("authUser");

		revVo.setRev_writer(user.getUser_id());

		service.register(revVo);
		rttr.addFlashAttribute("result", "success");
		rttr.addFlashAttribute("message", revVo.getRev_writer() + " 님" + revVo.getRev_seq() + " 번 글이 등록되었습니다.");

		int cnt = service.boardSelect(revVo.getRev_writer());
		if (cnt == 5) {
			service.pointUpdate(user.getUser_id());
			rttr.addFlashAttribute("result", revVo.getRev_writer()); // 객체로 붙게됨.
			rttr.addFlashAttribute("message", revVo.getRev_writer() + "님 포인트 500000원이 증정됐습니다.");

		}

		return "redirect:/rev/list";
	}

	@GetMapping("/list")
	public void list(@ModelAttribute("cri") Criteria cri, Model model, HttpServletRequest request) {
		List<RevVO> list = service.getListWithPaging(cri);

		int total = service.getTotal(cri);

		PageDTO dto = new PageDTO(cri, total);

		UserVO user = (UserVO) request.getSession().getAttribute("authUser");

		model.addAttribute("authUser", user);
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", dto);
	}

	@GetMapping({ "/get" })
	public ModelAndView get(@RequestParam int rev_seq, @ModelAttribute("cri") Criteria cri, Model model,
			HttpServletRequest req, HttpServletResponse res) {
		UserVO user = (UserVO) req.getSession().getAttribute("authUser");

		// 해당 게시판 번호를 받아 리뷰 상세페이지로 넘겨줌
		RevVO rev = service.get(rev_seq);

		// 여러 상품파일이름을 list로 변환하고 넘겨줌
		if (rev.getRev_filename() != null && !rev.getRev_filename().isEmpty()) {
			List<String> fileNamesList = Arrays.asList(rev.getRev_filename().split(","));
			model.addAttribute("RevfileNameList", fileNamesList);
		}
		ModelAndView view = new ModelAndView();

		Cookie[] cookies = req.getCookies();

		// 비교하기 위해 새로운 쿠키
		Cookie viewCookie = null;

		// 쿠키가 있을 경우
		if (cookies != null && cookies.length > 0) {
			for (int i = 0; i < cookies.length; i++) {
				// Cookie의 name이 cookie + rev_seq와 일치하는 쿠키를 viewCookie에 넘겨줌
				if (user != null) {
					if (cookies[i].getName().equals("cookie" + user.getUser_id())) {
						System.out.println("처음 쿠키가 생성한 뒤 들어옴.");
						viewCookie = cookies[i];
					}
				} else {
					if (cookies[i].getName().equals("cookie" + rev_seq)) {
						System.out.println("처음 쿠키가 생성한 뒤 들어옴.");
						viewCookie = cookies[i];
					}
				}
			}
		}
		if (rev != null) {
			System.out.println("System - 해당 상세 리뷰페이지로 넘어감");

			view.addObject("review", rev);

			// 만일 viewCookie가 null일 경우 쿠키를 생성해서 조회수 증가 로직을 처리함
			if (viewCookie == null) {
				System.out.println("cookie 없음");

				// 쿠키 생성(이름, 값)
				if (user != null) {
					Cookie newCookie = new Cookie("cookie" + user.getUser_id(), "|" + user.getUser_id() + "|");
					res.addCookie(newCookie);
				} else {
					Cookie newCookie = new Cookie("cookie" + rev_seq, "|" + rev_seq + "|");
					res.addCookie(newCookie);
				}

				// 쿠키 추가

				// 쿠키를 추가 시키고 조회수 증가시킴
				int result = service.addReadCnt(rev_seq);

				if (result > 0) {
					System.out.println("조회수 증가");
				} else {
					System.out.println("조회수 증가 에러");
				}
			} // viewCokkie가 null이 아닌경우 쿠키가 있으므로 조회수 증가 로직을 처리하지 않음.
			else {
				System.out.println("cookie 있음");

				// 쿠키 값 받아옴

				String value = viewCookie.getValue();

				System.out.println("cookie 값 : " + value);
			}
			model.addAttribute("RevBoard", rev);
			view.setViewName("/rev/get");
			return view;
		} else {
			// 에러페이지 설정
			view.setViewName("error/reviewError");
			return view;
		}

		/*
		 * RevVO vo = service.get(rev.getRev_seq());
		 * 
		 * if (rev.getRev_title() != null && !rev.getRev_title().isEmpty()) {
		 * service.addReadCnt(rev.getRev_seq()); }
		 * 
		 * 
		 * ;
		 */

	}

	@GetMapping("/modify")
	public void modify(@RequestParam int rev_seq, @ModelAttribute("cri") Criteria cri, Model model) {

		RevVO rev = service.get(rev_seq);

		model.addAttribute("RevBoard", rev);

		String preFileNames = rev.getRev_filename();
		if (rev.getRev_filename() != null && !rev.getRev_filename().isEmpty()) {
			List<String> fileNamesList = Arrays.asList(rev.getRev_filename().split(","));
			model.addAttribute("preFileNames", preFileNames);
			model.addAttribute("fileNamesList", fileNamesList);
		}
	}

	@PostMapping("/modify")
	public String modify(RevVO revVo, Criteria cri, RedirectAttributes rttr, MultipartFile[] upload,
			HttpServletRequest request) {
		Map<String, Boolean> errors = new HashMap<String, Boolean>();

		if (revVo.getRev_title().isEmpty() || revVo.getRev_title() == null) {
			errors.put("noTitle", Boolean.TRUE);
		}
		if (revVo.getRev_category().isEmpty() || revVo.getRev_category() == null) {
			errors.put("noCategory", Boolean.TRUE);
		}
		if (revVo.getRev_content().isEmpty() || revVo.getRev_content() == null) {
			errors.put("noContent", Boolean.TRUE);
		}

		// 파일이 업로드 될 경로 설정
		String saveDir = request.getSession().getServletContext().getRealPath("/resources/upload");
		// 위에서 설정한 경로의 폴더가 없을 경우 생성
		System.out.println(saveDir);
		File dir = new File(saveDir);

		if (!dir.exists()) {
			dir.mkdirs();
		} // 파일 업로드

		List<String> reNames = new ArrayList<String>();
		for (MultipartFile f : upload) {
			if (!f.isEmpty()) {
				// 기존 파일 이름을 받고 확장자 저장
				String orifileName = f.getOriginalFilename();
				String ext = orifileName.substring(orifileName.lastIndexOf("."));
				// 이름 값 변경을 위한 설정
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd-HHmmssSSS");
				int rand = (int) (Math.random() * 1000);
				// 파일 이름 변경
				String reName = sdf.format(System.currentTimeMillis()) + "_" + rand + ext;
				// 파일 저장
				try {
					f.transferTo(new File(saveDir + "/" + reName));
				} catch (IOException e) {
					e.printStackTrace();
				}

				reNames.add(reName);
			}
		}
		if (!reNames.isEmpty()) {
			revVo.setRev_filename(reNames.get(0));
		} else {
			revVo.setRev_filename("");
		}

		if (!errors.isEmpty()) {
			rttr.addFlashAttribute("errors", errors);
			rttr.addFlashAttribute("RevBoard", revVo);

			return "redirect:/rev/modify?rev_seq=" + revVo.getRev_seq();
		}

		// list를 string 쉼표구분으로 만들기
		String filenames = String.join(",", reNames);
		revVo.setRev_filename(filenames);
		System.out.println(filenames);

		if (reNames.size() == 0) { //
			revVo.setRev_filename(request.getParameter("preFileNames"));
		} else {
			/* 변동있다면 이전그림지우기 */
			String oldFileNames = request.getParameter("preFileNames");
			List<String> fileNamesList = Arrays.asList(oldFileNames.split(","));
			System.out.println(fileNamesList);

			String saveDir2 = request.getSession().getServletContext().getRealPath("/resources/upload");

			/* 그림파일삭제 */
			for (String f : fileNamesList) {
				if (!f.isEmpty()) {
					File file = new File(saveDir2 + "/" + f);
					file.delete();
				}
			}

		}

		if (service.moidfy(revVo)) {
			rttr.addFlashAttribute("result", "success");
			rttr.addFlashAttribute("message", revVo.getRev_seq() + "번 글이 수정 됐습니다.");
		}

		return "redirect:/rev/list";

	}

	@PostMapping("/remove")
	public String remove(@RequestParam("rev_seq") int rev_seq, Criteria cri, RedirectAttributes rttr) {

		if (service.remove(rev_seq)) {
			rttr.addFlashAttribute("result", "success");
			rttr.addFlashAttribute("message", rev_seq + "번 글이 삭제되었습니다.");
		}

		return "redirect:/rev/list";
	}
//	@GetMapping(value = "/get/like",
//				produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
//	public String addGood(int rev_seq) {
//		log.info("rev_seq");
//		service.addGood(rev_seq);
//		
//		/* return new ResponseEntity<RevVO>(HttpStatus.OK); */
//		return "redirect:/rev/get?rev_seq=" + rev_seq;
//		
//	}

	@GetMapping(value = "/like", produces = MediaType.TEXT_PLAIN_VALUE)
	public @ResponseBody int goodAdd(GoodCheck check, HttpServletRequest req, HttpServletResponse res,
			RedirectAttributes rttr) {
		System.out.println(check.getRev_seq());
		System.out.println(check.getUser_seq());
		int cnt = service.checkread(check.getUser_seq(), check.getRev_seq());
		System.out.println(cnt);
		if (cnt == 0) {
			service.insertCheck(check); // 인서트로 행을만듬.
			service.addGood(check.getRev_seq()); // 좋아요를 1눌러줌
			service.goodCheck(check.getUser_seq(), check.getRev_seq()); // 좋아요를 눌러서 체크 + 1 ( 하기전엔 체크 0 )
			return 0;
		} 
		return 1;
	}

	

	@GetMapping(value = "/hate", produces = MediaType.TEXT_PLAIN_VALUE)
	public @ResponseBody int addHate(HateCheck hateCheck) {
		int cnt = service.hatecheckread(hateCheck.getUser_seq(), hateCheck.getRev_seq());
		
		if (cnt == 0) {
			service.hateinsertCheck(hateCheck);
			service.addHate(hateCheck.getRev_seq());
			service.hateCheck(hateCheck.getUser_seq(), hateCheck.getRev_seq());
			return 0;
		}
		return 1;
	}

}
