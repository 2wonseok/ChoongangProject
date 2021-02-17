package org.zerock.qaboard.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import org.zerock.product.domain.ProductVO;
import org.zerock.qaboard.domain.Criteria;
import org.zerock.qaboard.domain.PageDTO;
import org.zerock.qaboard.domain.QaVO;
import org.zerock.qaboard.domain.QaReplyVO;
import org.zerock.qaboard.service.QaService;
import org.zerock.user.domain.UserVO;
import org.zerock.user.service.UserService;

import edu.emory.mathcs.backport.java.util.Arrays;

import org.zerock.qaboard.service.QaReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/qa/*")
@Log4j
@AllArgsConstructor
public class QaController {
	
	private QaService service;	


	
	HttpSession session;
	
//	@RequestMapping(value="/list", method = RequestMethod.GET)
//	@GetMapping("/list") 
	// 메소드가 void 타입의 경우 return 경로가 view(jsp)가 됨
	// 이 메소드는 (/board/list) -> /board/list.jsp
//	public void list(Model model) {
//		log.info("***** list, 누군가 접속 or 새로고침 *****");
//		List<BoardVO> list = service.getlist();
//		model.addAttribute("list", list);		
//	}
	
	@GetMapping("/list")
	public void list(@ModelAttribute("criteria") Criteria cri, Model model, QaVO vo) {
		
		// 게시물 리스트 가져오기
		List<QaVO> list = service.getList(cri);	
		
		for (QaVO qaVO : list) {
			// filename에 값이 있을 경우 0 번째의 파일명을 가져옴
			if(qaVO.getQa_filename() != null && !qaVO.getQa_filename().isEmpty()) {			
				@SuppressWarnings("unchecked")
				List<String> fileNamesList = Arrays.asList(qaVO.getQa_filename().split(","));
				String fileNameFirst = fileNamesList.get(0);
				qaVO.setQa_filename(fileNameFirst);
				}
		}

		// 페이징 처리
		int total = service.getTotal(cri);

		PageDTO dto = new PageDTO(cri, total);	
		
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", dto);
		
	}
	
	
//	@RequestMapping(value="/register", method = RequestMethod.POST)
	
	@GetMapping("/register")
	public void register(@ModelAttribute("criteria") Criteria cri) {
		
	}
	
	@PostMapping("/register")
	public String register(QaVO board, RedirectAttributes rttr, 
			MultipartFile[] upload, HttpServletRequest request) {
		
		Map<String, Boolean> errors = new HashMap<String, Boolean>();
		
		if (board.getQa_title().isEmpty() || board.getQa_title() == null) {
			errors.put("noTitle" , Boolean.TRUE);
		} 
		if (board.getQa_secret() == null) {
			errors.put("noSecret", Boolean.TRUE);
		} 
		if (board.getQa_category().isEmpty() || board.getQa_category() == null) {
			errors.put("noCategory", Boolean.TRUE);
		} 
		if (board.getQa_content().isEmpty() || board.getQa_content() == null) {
			errors.put("noContent", Boolean.TRUE);
		}
		
		if(!errors.isEmpty()) {
			rttr.addFlashAttribute("errors", errors);
			rttr.addFlashAttribute("category", board.getQa_category());
			rttr.addFlashAttribute("secret", board.getQa_secret());
			rttr.addFlashAttribute("title",board.getQa_title());
			rttr.addFlashAttribute("content", board.getQa_content());
			rttr.addFlashAttribute("filename", board.getQa_filename());
			
			return "redirect:/qa/register";
		}
		
		// 파일이 업로드 될 경로 설정
				String saveDir = request.getSession().getServletContext().getRealPath("/resources/qaboard/upload");
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
					board.setQa_filename(reNames.get(0));
				} else { // 파일이 비어있을때
					board.setQa_filename("");
				}
				// list를 string 쉼표구분으로 만들기
				String filenames = String.join(",", reNames);
				board.setQa_filename(filenames);
				System.out.println(filenames);
			
		
		service.register(board);		
		
		rttr.addFlashAttribute("result", board.getQa_seq());

		return "redirect:/qa/list";
	}
	
	//
	@GetMapping({"/get"})
	public String get(@RequestParam("qa_seq") int qa_seq, UserVO user,
			@ModelAttribute("criteria") Criteria cri, Model model,
			HttpSession session, RedirectAttributes rttr) {
		// 게시물 가져오기
		// 쿼리문으로 붙어서 감
		//UserVO user_vo = user_service.getUser(user.getUser_id());
		//System.out.println(user_vo.getUser_address());
		
		QaVO vo = service.get(qa_seq);
		
		if("공개".equals(vo.getQa_secret())) {
			service.addCnt(qa_seq);
			model.addAttribute("board", vo);
			if (vo.getQa_filename() != null && !vo.getQa_filename().isEmpty()) {
				@SuppressWarnings("unchecked")
				List<String> fileNamesList = Arrays.asList(vo.getQa_filename().split(","));
				model.addAttribute("getQafileNameList", fileNamesList);
				
				return "/qa/get";
			}
		} else {
			if(session.getAttribute("authUser") == null) {
				System.out.println("세션이 없음");
				
				return "redirect:/qa/read_error";
			} else {
				UserVO userVO = (UserVO) session.getAttribute("authUser");
				System.out.println(userVO.toString());				
				String userNickname = userVO.getUser_nickname();				
				int userGrade = userVO.getUser_grade();				
				System.out.println(vo.toString());

				if(userNickname.equals(vo.getQa_writer()) || userGrade == 0) {										
					//	작성자와 세션에서 가져온 userNickname이 같은 경우
					//	get 페이지로 이동
					service.addCnt(qa_seq);
					model.addAttribute("board", vo);
					if (vo.getQa_filename() != null && !vo.getQa_filename().isEmpty()) {
						@SuppressWarnings("unchecked")
						List<String> fileNamesList = Arrays.asList(vo.getQa_filename().split(","));
						model.addAttribute("getQafileNameList", fileNamesList);
					}
					return "/qa/get";

				} else {
					return "redirect:/qa/list";
				}
			}
		}
			return null;
		}
	
	@GetMapping({"/read_error"})
	public void read_error() {
		
	}
		
	

	@RequestMapping("/remove")
	public String remove(@RequestParam("qa_seq") int qa_seq) {
		service.remove(qa_seq);
		
		return "redirect:/qa/list";
	}
	
	@GetMapping({"/modify"})
	public void get(@RequestParam("qa_seq") int qa_seq,
			@ModelAttribute("criteria") Criteria cri, Model model) {
				
		QaVO vo = service.get(qa_seq);		
		model.addAttribute("board", vo);
		
		String preFileNames = vo.getQa_filename();
		if (vo.getQa_filename() != null && !vo.getQa_filename().isEmpty()) {
			@SuppressWarnings("unchecked")
			List<String> fileNamesList = Arrays.asList(vo.getQa_filename().split(","));
			model.addAttribute("preFileNames", preFileNames);
			model.addAttribute("qafileNameList", fileNamesList);
		}
	}
	
	@PostMapping("/modify")
	public String modify(QaVO board, Criteria cri, RedirectAttributes rttr, 
			MultipartFile[] upload, HttpServletRequest request) {
		
		Map<String, Boolean> errors = new HashMap<String, Boolean>();
		
		if (board.getQa_title().isEmpty() || board.getQa_title() == null) {
			errors.put("noTitle" , Boolean.TRUE);
		} 
		if (board.getQa_secret() == null) {
			errors.put("noSecret", Boolean.TRUE);
		} 
		if (board.getQa_category().isEmpty() || board.getQa_category() == null) {
			errors.put("noCategory", Boolean.TRUE);
		} 
		if (board.getQa_content().isEmpty() || board.getQa_content() == null) {
			errors.put("noContent", Boolean.TRUE);
		}
		
		// 파일이 업로드 될 경로 설정
		String saveDir = request.getSession().getServletContext().getRealPath("/resources/qaboard/upload");
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
			board.setQa_filename(reNames.get(0));
		} else {
			board.setQa_filename("");
		}

		if (!errors.isEmpty()) {
			rttr.addFlashAttribute("errors", errors);
			rttr.addFlashAttribute("board", board);
			rttr.addFlashAttribute("secret", board.getQa_secret());
			rttr.addFlashAttribute("title",board.getQa_title());
			rttr.addFlashAttribute("content", board.getQa_content());
			rttr.addFlashAttribute("filename", board.getQa_filename());

			return "redirect:/qa/modify?qa_seq=" + board.getQa_seq();
		}

		// list를 string 쉼표구분으로 만들기
		String filenames = String.join(",", reNames);
		board.setQa_filename(filenames);
		System.out.println(filenames);

		if (reNames.size() == 0) { //
			board.setQa_filename(request.getParameter("preFileNames"));
		} else {
			/* 변동있다면 이전그림지우기 */
			String oldFileNames = request.getParameter("preFileNames");
			@SuppressWarnings("unchecked")
			List<String> fileNamesList = Arrays.asList(oldFileNames.split(","));
			System.out.println(fileNamesList);

			String saveDir2 = request.getSession().getServletContext().getRealPath("/resources/qaboard/upload");

			/* 그림파일삭제 */
			for (String f : fileNamesList) {
				if (!f.isEmpty()) {
					File file = new File(saveDir2 + "/" + f);
					file.delete();
				}
			}

		}
		rttr.addAttribute("pageNum", cri.getPageNum()); // request가 아니라 redirect해줬기때문에
		rttr.addAttribute("amount", cri.getAmount());	// RedirectAttributes에 넣어줘야함
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
				
		if (service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
			rttr.addFlashAttribute("message", board.getQa_seq() + "번 글이 수정 됐습니다.");
		}

		return "redirect:/qa/list";
	}
}
