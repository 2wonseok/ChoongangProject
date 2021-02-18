package org.zerock.user.domain;

import java.util.Date;

import lombok.Data;

@Data
public class UserVO {
	private int user_seq;
	private String user_id;
	private String user_name;
	private String user_nickname;
	private String user_password;
	private String user_address;
	private String user_addresscode;
	private String user_email;
	private String user_phone;
	private String user_gender;
	private String user_birth;
	private int user_grade;
	private int user_point;
	private Date user_regdate;
	private int eventCheck;
}
