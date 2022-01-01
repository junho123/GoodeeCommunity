package com.gcs.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gcs.DAO.BoardDAO;
import com.gcs.DAO.ReplyDAO;


public class ReplyService {

	HttpServletRequest req = null;
	HttpServletResponse resp = null;

	public ReplyService(HttpServletRequest req, HttpServletResponse resp) {
		this.req = req;
		this.resp = resp;
	}

	public  void reply() throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String board_no = req.getParameter("board_no"); //???? 이걸 어떻게 갖고오지?
		String id = (String) req.getSession().getAttribute("id");
		String co_content = req.getParameter("co_content");
		String msg = "댓글 내용을 입력해주세요.";
		System.out.println(board_no+id+co_content);
		
		ReplyDAO dao = new ReplyDAO();
		RequestDispatcher dis;
		if(dao.reply(board_no, id, co_content)) {
			if(id.equals("admin")) {
				dis = req.getRequestDispatcher("mngboardDetail?board_no="+board_no);
			}	else {
				dis = req.getRequestDispatcher("boardDetail?board_no="+board_no);}			
		}else {
			req.setAttribute("msg", msg);
			if(id.equals("admin")) {
				dis = req.getRequestDispatcher("mngboardDetail?board_no="+board_no);
			}	else {
				dis = req.getRequestDispatcher("boardDetail?board_no="+board_no);}			
		}
		dis.forward(req, resp);
		System.out.println("reply service 끝");
	}

	public void recommentDel() throws ServletException, IOException {
		String recomment_no = req.getParameter("recomment_no");
		String board_no = req.getParameter("board_no");
		ReplyDAO dao = new ReplyDAO();
		String msg = "댓글 삭제에 실패했습니다.";
		
		if(dao.recommentDel(recomment_no)) {
			msg = "삭제에 성공했습니다.";
		}
		
		req.setAttribute("msg", msg);
		RequestDispatcher dis = req.getRequestDispatcher("boardDetail?board_no="+board_no);
		dis.forward(req, resp);
		
		
	}
	
	public void recomment() throws SQLException, IOException {
		req.setCharacterEncoding("UTF-8");
		String comment_no = req.getParameter("comment_no");
		String reco_content = req.getParameter("recomment");
		String board_no = req.getParameter("board_no");
		String id =(String) req.getSession().getAttribute("id");
		System.out.println(comment_no+ reco_content+ id);
		ReplyDAO dao = new ReplyDAO();
		dao.recomment(comment_no, id, reco_content);
		resp.sendRedirect("boardDetail?board_no="+board_no);
	}
	

	}
	
	
