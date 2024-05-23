package com.smhrd.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class BookVO {
	
	private int num;
	private String title;
	private String author;
	private String company;
	private String isbn;
	private int cnt;

}
