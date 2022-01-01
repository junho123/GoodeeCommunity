package com.gcs.DTO;

import java.util.Date;

public class BoardDTO {
	@Override
	public String toString() {
		return "BoardDTO [board_no=" + board_no + ", mboard_no=" + mboard_no + ", id=" + id + ", bo_subject="
				+ bo_subject + ", bo_content=" + bo_content + ", bo_reg_date=" + bo_reg_date + ", bo_bHit=" + bo_bHit
				+ ", boardName=" + boardName + ", nickName=" + nickName + ", comment_no=" + comment_no + ", co_content="
				+ co_content + ", co_reg_date=" + co_reg_date + ", blike_cnt=" + blike_cnt + ", commentCnt="
				+ commentCnt + ", recomment_no=" + recomment_no + ", reco_content=" + reco_content + ", reco_reg_date="
				+ reco_reg_date + "]";
	}
	private int board_no;
	private int mboard_no;
	private String id;
	private String bo_subject;
	private String bo_content;
	private Date bo_reg_date;
	private int bo_bHit;
	private String boardName;
	private String nickName;
	
	private int comment_no;
	private String co_content;
	private Date co_reg_date;
	private String blike_cnt;
	private int commentCnt;
	
	private int recomment_no;
	private String reco_content;
	private Date reco_reg_date;
		
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	public int getMboard_no() {
		return mboard_no;
	}
	public void setMboard_no(int mboard_no) {
		this.mboard_no = mboard_no;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getBo_subject() {
		return bo_subject;
	}
	public void setBo_subject(String bo_subject) {
		this.bo_subject = bo_subject;
	}
	public String getBo_content() {
		return bo_content;
	}
	public void setBo_content(String bo_content) {
		this.bo_content = bo_content;
	}
	public Date getBo_reg_date() {
		return bo_reg_date;
	}
	public void setBo_reg_date(Date bo_reg_date) {
		this.bo_reg_date = bo_reg_date;
	}
	public int getBo_bHit() {
		return bo_bHit;
	}
	public void setBo_bHit(int bo_bHit) {
		this.bo_bHit = bo_bHit;
	}
	public String getBoardname() {
		return boardName;
	}
	public void setBoardname(String boardName) {
		this.boardName = boardName;
	}
	public int getComment_no() {
		return comment_no;
	}
	public void setComment_no(int comment_no) {
		this.comment_no = comment_no;
	}
	public String getCo_content() {
		return co_content;
	}
	public void setCo_content(String co_content) {
		this.co_content = co_content;
	}
	public Date getCo_reg_date() {
		return co_reg_date;
	}
	public void setCo_reg_date(Date co_reg_date) {
		this.co_reg_date = co_reg_date;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getBlike_cnt() {
		return blike_cnt;
	}
	public void setBlike_cnt(String blike_cnt) {
		this.blike_cnt = blike_cnt;
	}
	public int getCommentCnt() {
		return commentCnt;
	}
	public void setCommentCnt(int commentCnt) {
		this.commentCnt = commentCnt;
	}
	public String getBoardName() {
		return boardName;
	}
	public void setBoardName(String boardName) {
		this.boardName = boardName;
	}
	public int getRecomment_no() {
		return recomment_no;
	}
	public void setRecomment_no(int recomment_no) {
		this.recomment_no = recomment_no;
	}
	public String getReco_content() {
		return reco_content;
	}
	public void setReco_content(String reco_content) {
		this.reco_content = reco_content;
	}
	public Date getReco_reg_date() {
		return reco_reg_date;
	}
	public void setReco_reg_date(Date reco_reg_date) {
		this.reco_reg_date = reco_reg_date;
	}
}
