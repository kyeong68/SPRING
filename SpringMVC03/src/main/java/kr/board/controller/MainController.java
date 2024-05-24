package kr.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
	
	@RequestMapping("/")
	public String index() {
		return "index";
	}
	
	// return하는게 없으니까 얘가 비동기인지 동기인지 헷갈리므로 추천X
//	method이름이 뷰네임이랑 똑같으면 아래와 같이 가능
//	@RequestMapping("/")
//	public void index() {
//	}
	
}




