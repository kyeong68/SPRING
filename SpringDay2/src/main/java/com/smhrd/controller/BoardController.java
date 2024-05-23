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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.smhrd.entity.Board;
import com.smhrd.mapper.BoardMapper;

@Controller // 해당 클래스가 Controller의 역할을 수행한다
public class BoardController {
	// 게시판 관련 기능 수행

	@Autowired
	private BoardMapper mapper;

	// "/"로 요청이 들어왔을 때 main.jsp 로 이동
	@GetMapping("/")
	public String main() {
		return "main";
	}
	
	
	
}














