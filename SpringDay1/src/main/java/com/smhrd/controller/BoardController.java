package com.smhrd.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.smhrd.entity.Board;
import com.smhrd.mapper.BoardMapper;

@Controller // 해당 클래스가 Controller의 역할을 수행한다
public class BoardController {
	// 게시판 관련 기능 수행
	
	@Autowired
	private BoardMapper mapper;
	
	// 메인실행
	@RequestMapping("/")
	public String home() {
		return "redirect:/boardList.do";
	}
	
	
	
	// 게시판 목록
	@RequestMapping("boardList.do")
	public String boardList(Model model) {
		
		List<Board> list = mapper.boardList();
		
		model.addAttribute("list", list);
		
		return "boardList"; // WEB-INF/views/boardList.jsp
	}
	
	
	
	// 게시판 상세보기
	@GetMapping("boardContent.do")
	public String boardContent(@RequestParam("idx") int idx, Model model) {
		
		// 조회수
		mapper.boardCount(idx);
		Board vo = mapper.boardCotent(idx);
		model.addAttribute("vo",vo);
		System.out.print(vo.toString());
		return "boardContent";
		
		
	}
	//게시글 작성 페이지 이동
	@GetMapping("boardForm.do")
	public String boardForm() {
		return "boardForm";
	}
	
	// 게시글 작성 ,( Board에는 기본생성자가 있어야한다 ) 
	@PostMapping("boardInsert.do")
	public String boardInsert(Board vo, RedirectAttributes rttr) {
		
		mapper.boardInsert(vo);
		rttr.addFlashAttribute("result", "ok");
		return "redirect:/boardList.do";
	}
	
	
	// 게시글 삭제
	@GetMapping("boardDelete.do")
	public String boardDelete(@RequestParam("idx") int idx, Model model) {
		
		mapper.boardDelete(idx);
		return "redirect:/boardList.do";
	}
	
	
	// 게시글 수정화면 이동
	@GetMapping("boardUpdateForm.do")
	public String boardUpdateForm(@RequestParam("idx") int idx, Model model ) {
		Board vo = mapper.boardCotent(idx);
		model.addAttribute("vo", vo);
		return "boardUpdateForm";
	}
	
	// 게시글 수정
	@PostMapping("boardUpdate.do")
	public String boardUpdate(Board vo) {
		mapper.boardUpdate(vo);
		return "redirect:/boardContent.do?idx="+vo.getIdx();
	}
		

	
	
	

}


