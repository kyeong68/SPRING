package kr.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.board.entity.Board;
import kr.board.mapper.BoardMapper;
// 어떤 방식으로 요청들어올지 모르기 때문에 모든 요청을 받을 수 있게 @RequestMapping("/board")
@RequestMapping("/board") // url을 통일시켜주기 위해 매핑?? 굳이 없어도 되지않나?? 이러면 요청url 앞에 다시 다 /board를 붙여줘야하는디?
@RestController // 비동기 통신만을 처리하는 Controller, 상태를 전송받을 수 있음
public class BoardRestController {
	
	@Autowired
	private BoardMapper boardMapper;

//	// 게시글 전체보기 /boardList.do
//	@RequestMapping("/boardList.do")
//	public @ResponseBody List<Board> boardList(){
//		List<Board> list = boardMapper.boardList();
//		return list;
//	}
	
	// 게시글 전체보기 /boardList.do
	@GetMapping("/all") // 요청 url -> /board/all
	public List<Board> boardList() {
		List<Board> list = boardMapper.boardList();
		return list;
	}

	// 게시글 등록 /boardInsert.do
	@PostMapping("/new")
	public void boardInsert(Board board) {
		boardMapper.boardInsert(board);
	}

	// 게시글 삭제 /boardDelte.do
	@DeleteMapping("/{idx}")
	public void boardDelte(@PathVariable("idx") int idx) {
		boardMapper.boardDelete(idx);
	}

	// 게시글 수정 /boardUpdate.do
	@PutMapping("/update")
	public void boardUpdate(@RequestBody Board board) {
		boardMapper.boardUpdate(board);
	}

	// 게시글 상세보기 /boardContent.do
	@GetMapping("/{idx}")
	public Board boardContent(@PathVariable("idx") int idx) {
		Board vo = boardMapper.boardContent(idx);
		return vo;
	}

	// 게시글 조회수 올리기 /boardCount.do
	@PutMapping("/count/{idx}")
	public void boardCount(@PathVariable("idx") int idx) {
		boardMapper.boardCount(idx);
	}

}






