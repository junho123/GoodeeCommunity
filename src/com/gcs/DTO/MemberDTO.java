package com.gcs.DTO;

public class MemberDTO {
	private String id;
	private String pw;
	private String name;
	private String nickName;
	private String u_email;
	private boolean u_email_checked;
	/*사진에 관련된 내용*/	
	private int photo_no;
	private String oriName;
	private String newName;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getU_email() {
		return u_email;
	}
	public void setU_email(String u_email) {
		this.u_email = u_email;
	}
	public boolean isU_email_checked() {
		return u_email_checked;
	}
	public void setU_email_checked(boolean u_email_checked) {
		this.u_email_checked = u_email_checked;
	}
	public int getPhoto_no() {
		return photo_no;
	}
	public void setPhoto_no(int photo_no) {
		this.photo_no = photo_no;
	}
	public String getOriName() {
		return oriName;
	}
	public void setOriName(String oriName) {
		this.oriName = oriName;
	}
	public String getNewName() {
		return newName;
	}
	public void setNewName(String newName) {
		this.newName = newName;
	}

}
