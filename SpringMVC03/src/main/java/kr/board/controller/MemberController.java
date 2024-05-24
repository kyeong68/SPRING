package kr.board.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.board.entity.Member;
import kr.board.mapper.MemberMapper;

@Controller
public class MemberController {

	@Autowired
	private MemberMapper memberMapper;

	// 회원프로필사진 등록 /imageUpdate.do
	@PostMapping("/imageUpdate.do")
	public String imageUpdate(HttpServletRequest request, HttpSession session, RedirectAttributes rttr) {
		// 파일업로드 API (cos.jar) -> MultipartRequest객체
		MultipartRequest multi = null;

		// MultipartRequest객체 생성하기위해서는 매개변수가 필요
		// 1.요청객체 (request)
		// 2.이미지를 저장할 폴더의 경로
		// 3.허용가능한 크기
		// 4.파일이름에 대한 인코딩
		// 5.파일명 중복 제거

		// upload폴더 우클릭 -> properties 경로보기
		// request.getRealPath() -> 하위호완성을 위해 삭제하지는 않았지만 사용하지 않는 걸 권장
		String savePath = request.getRealPath("resources/upload"); // 현재위치, context위치
//		String savePath = request.getSession().getServletContext().getRealPath("resources/upload"); // 현재위치, context위치
		System.out.println("savePath1 : " + savePath);
		int maxSize = 1024 * 1024 * 100; // 100MB 10MB로도 해보기
		String encoding = "UTF-8";
		DefaultFileRenamePolicy rename = new DefaultFileRenamePolicy();

		// 2
		// 기존 가지고 있는 해당 프로필 이미지 삭제
		// multi객체 생성 전에 삭제 -> 객체 생성하자마자 저장하기 때문
		// 그러기 위해선 사용자의 memID를 가져온 후 DB에서 그 memID에 해당하는 memProfile 이름을 가져와야함
		// but, request.getParameter를 사용해서 가져올 수 없음
		String memID = ((Member) session.getAttribute("mvo")).getMemID();
		String oldImg = memberMapper.getMember(memID).getMemProfile();
		File oldFile = new File(savePath + "/" + oldImg); // 기존에 내가 저장해놓은 사진을 파일객체로 가져오기
		// 존재할 때만 파일 삭제
		if (oldFile.exists()) {
			oldFile.delete();
		}

		// 1
		try {
			multi = new MultipartRequest(request, savePath, maxSize, encoding, rename);

		} catch (IOException e) {
			// 에러날 경우는 파일크기
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "경로를 찾을 수 없습니다.");
			return "redirect:/imageForm.do";
		};

		// 3
		// img 파일인지 아닌지 판별하기
		// 내가 보낸 파일을 가져옴
		File file = multi.getFile("memProfile");

		System.out.println(file.getName());
		
		if (file != null) { 
			// 여기 안에 왔다는 것은 파일을 올린경우
			//확장자 가져오기
			// System.out.println(file.getName());               마지막에 존재하는 문자
			String ext = file.getName().substring(file.getName().lastIndexOf(".") + 1);
			// 대문자로 통일
			ext = ext.toUpperCase(); // toLowerCase() -> 소문자로 변환
			
			boolean extResult = ext.equals("JPG") || ext.equals("PNG") || ext.equals("GIF");
			if(!extResult) {
				// 이미지파일이 아닐때
				if(file.exists()) {
					// MultipartRequest객체가 생성되는 순간 무조건 저장
					file.delete();
					rttr.addFlashAttribute("msgType","실패 메세지");
					rttr.addFlashAttribute("msg","이미지 파일만 가능합니다(PNG, JPG, GIF)");
					return "redirect:/imageForm.do";
				}
			}
		}
		// 여기까지는 서버에 사진을 등록까지만 한것 지금부터 DB에 저장
		
		// 새로운 이미지를 테이블에 저장
		String newProfile = multi.getFilesystemName("memProfile");
		// Mapper에 넣기 위한 객체 생성 -> memID, newProfile
		Member vo = new Member();
		// memID, 와 memProfile 두개를 받는 생성자를 만들지 않았기 때문에 기본생성자를 사용해서 설정해주기
		vo.setMemProfile(newProfile);
		vo.setMemID(memID);
		memberMapper.profileUpdate(vo); // 이미지 새롭게 업데이트
		
		// DB에서 수정된 회원의 정보를 다시 불러와서 session에 저장
		Member mvo = memberMapper.getMember(memID);
		
		session.setAttribute("mvo", mvo);
		
		rttr.addFlashAttribute("msgType","성공 메세지");
		rttr.addFlashAttribute("msg","이미지 변경이 성공했습니다.");
		return "redirect:/";
		
		}


	// 회원프로필등록페이지 이동 /imageForm.do
	@GetMapping("/imageForm.do")
	public String imageForm() {
		return "member/imageForm";
	}

	// 회원정보수정기능 /update.do
	
	// 회원수정할 정보를 입력받아 아이디가 일치하는 회원의
	// 비밀번호, 이름, 나이, 성별, 이메일 수정하기
	
	// 조건
	// 1. 하나라도 누락된 데이터가 있다면 회원정보수정 페이지로 이동 후 
	//	 "모든 내용을 입력해주세요." 모달창 띄우기
	// 2. 회원정보수정이 실패했다면 회원정보수정 페이지로 이동 후
	// 	 "회원정보수정이 실패했습니다." 모달창 띄우기
	// 3. 회원정보수정 성공 시 수정된 회원의 정보를 세션에 다시 저장 후 메인페이지로 이동
	// 	 "회원정보수정을 성공했습니다." 모달창 띄우기
	@PostMapping("/update.do")
	public String update(Member m, RedirectAttributes rttr, HttpSession session) {

		if (m.getMemID() == null || m.getMemID().equals("") || m.getMemPassword() == null
				|| m.getMemPassword().equals("") || m.getMemName() == null || m.getMemName().equals("")
				|| m.getMemAge() == 0 || m.getMemEmail() == null || m.getMemEmail().equals("")) {
			// 누락된 데이터가 존재하는 부분

			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "모든 내용을 입력하세요.");
			return "redirect:/updateForm.do";
		} else {
			// 프로필 파일 이름 빈문자열로 바꿔주기 -> session에 들어갈 때 null로 들어가기 싫어!
			m.setMemProfile("");

			int cnt = memberMapper.update(m);

			if (cnt == 1) {
				rttr.addFlashAttribute("msgType", "성공 메세지");
				rttr.addFlashAttribute("msg", "회원정보 수정에 성공했습니다.");
				session.setAttribute("mvo", m);
				return "redirect:/";
			} else {
				rttr.addFlashAttribute("msgType", "실패 메세지");
				rttr.addFlashAttribute("msg", "회원정보 수정에 실패했습니다.");
				return "redirect:/updateForm.do";
			}
		}
	}

	// 회원정보수정 페이지 이동 /updateForm.do
	@GetMapping("/updateForm.do")
	public String updateForm() {
		return "member/updateForm";
	}

	// 로그인 기능 /login.do
	@PostMapping("/login.do")
	public String login(Member m, RedirectAttributes rttr, HttpSession session) {
		// 문제
		// 로그인 기능 구현
		// 입력한 아이디와 비밀번호 일치하는 회원을 검색하여
		// 로그인 성공 시
		// - session에 mvo이름으로 회원의 정보를 저장 index.jsp에서 "로그인에 성공했습니다." 모달창
		// 로그인 실패 시
		// - loginForm.jsp로 이동 후 "아이디와 비밀번호를 다시 입력해주세요." 모달창
		
		Member mvo = memberMapper.login(m);
		if (mvo == null) {
			// 로그인 실패
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "아이디와 비밀번호를 입력해주세요.");
			return "redirect:/loginForm.do";
		} else {
			// 로그인 성공
			rttr.addFlashAttribute("msgType", "성공 메세지");
			rttr.addFlashAttribute("msg", "로그인에 성공했습니다.");
			session.setAttribute("mvo", mvo);
			return "redirect:/";
		}

	}

	// 로그인 페이지 이동 /loginForm.do
	@GetMapping("/loginForm.do")
	public String loginForm() {
		return "member/loginForm";
	}

	// 로그아웃 기능 /logout.do
	@GetMapping("/logout.do")
	public String logout(HttpSession session, RedirectAttributes rttr) {
		session.invalidate();
		rttr.addFlashAttribute("msgType", "로그아웃 메세지");
		rttr.addFlashAttribute("msg", "정상적으로 로그아웃 되었습니다.");
		return "redirect:/";
	}

	// 회원아이디 중복체크 기능 /registerCheck.do
	@GetMapping("/registerCheck.do")
	public @ResponseBody int registerCheck(@RequestParam("memID") String memID) {

		Member m = memberMapper.registerCheck(memID);

		if (memID.equals("") || m != null) {
			return 0; // 이미 존재하거나 아이디를 아에 입력 X
		} else {
			return 1; // 사용할 수 있음
		}
	}

	// 회원가입 페이지 이동 /joinForm.do
	@GetMapping("/joinForm.do")
	public String joinForm() {
		return "member/joinForm";
	}

	// 회원가입기능 /join.do
	@PostMapping("/join.do")
	public String join(Member m, HttpSession session, RedirectAttributes rttr) {
		
		// System.out.println(m.toString());
		
		// RedirectAttributes
		// - Redirect 방식으로 페이지를 이동할때 전달할 데이터가 있는데
		// Request에 담자니 데이터가 사라지고 Session에 담자니 뭔가 너무 아깝고 할때
		// 딱 한번만 데이터를 저장해서 뿌려주는 저장소(객체)
		//    name값이 틀림(못받아온 것)   input값은 있지만 아무것도 안쓴 경우       
		if (m.getMemID() == null || m.getMemID().equals("") || m.getMemPassword() == null
				|| m.getMemPassword().equals("") || m.getMemName() == null || m.getMemName().equals("")
				|| m.getMemAge() == 0 || m.getMemEmail() == null || m.getMemEmail().equals("")) {

			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "모든 내용을 입력하세요.");

			// 회원가입이 불가능한 상황 (미입력 데이터 존재)
			return "redirect:/joinForm.do";
		} else {
			// 회원가입이 가능한 상황
			// 프로필 파일 이름 빈문자열로 바꿔주기
			m.setMemProfile("");
			int cnt = memberMapper.join(m);

			if (cnt == 1) {
				// 회원가입 성공
				rttr.addFlashAttribute("msgType", "성공 메세지");
				rttr.addFlashAttribute("msg", "회원가입에 성공했습니다.");
				// 회원가입 성공하면 로그인이 된 채로 main 페이지로 갈 거임
				session.setAttribute("mvo", m); // 게시판 정보는 model에 담았는데 왜? -> request영역 게시판 전체보기했을 때만 필요 다른 페이지에서 게시글 필요 없음
				return "redirect:/";
			} else {
				// 회원가입 실패
				rttr.addFlashAttribute("msgType", "실패 메세지");
				rttr.addFlashAttribute("msg", "회원가입에 실패했습니다.");

				return "redirect:/joinForm.do";
			}

		}

	}

}
