package kr.board.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@NoArgsConstructor // form에서 name값으로 요청데이터 넘길 때 알아서 객체로 묶어주는데 기본생성자가 꼭 있어야함
@AllArgsConstructor
@Data
//@ToString
public class Member {
	
	private int memIdx;
	private String memID;
	private String memPassword;
	private String memName;
	private int memAge;
	private String memGender;
	private String memEmail;
	private String memProfile;
	
}









