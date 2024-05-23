package com.smhrd.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.smhrd.entity.BookVO;

@Mapper
public interface BookMapper {

	public List<BookVO> bookList();

	public void bookInsert(BookVO vo);

	

}
