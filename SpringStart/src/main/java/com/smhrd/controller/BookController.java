package com.smhrd.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.smhrd.entity.BookVO;
import com.smhrd.mapper.BookMapper;

@Controller
public class BookController {

	@Autowired
	private BookMapper mapper;
	
	@RequestMapping("/")
	public String home() {
		return "redirect:/bookList.do";
	}
	
	
	@RequestMapping("/bookList.do")
	public String bookList(Model model) {
		List<BookVO> list = mapper.bookList();
		model.addAttribute("list", list);
		return "bookList";
	}
	
	@RequestMapping("/bookInsert.do")
	public String bookInsert(BookVO vo) {
		mapper.bookInsert(vo);
		return "redirect:/bookList.do";
	}
}
