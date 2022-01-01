package com.gcs.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gcs.service.BoardService;


@WebServlet({"/main","/boardList","/mngboard","/mngcomment","/write","/delmngcomment","/writeView",
	"/updateForm","/boardDetail","/update","/del","/mngboardDetail","/deletecom",
	"/myBoardList","/search","/memoWrite","/prev","/next","/detailLikeCnt","/like"})

public class BoardController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		proc(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		proc(req, resp);
	}
	
	private void proc(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException{
		
		String uri = req.getRequestURI();
		String ctx = req.getContextPath();
		String reqAddr = uri.substring(ctx.length());
		
		BoardService boardService = new BoardService(req, resp);
		
		switch(reqAddr) {
		case "/main":
			System.out.println("메인 페이지");
			boardService.boardList();
			break;
		
		case "/boardList":
			System.out.println("게시판 리스트 띄우기");
			boardService.boardList();
			break;		
		
		case "/mngboard": // 관리자 게시판별 게시글 목록
			String mBoard_no = req.getParameter("mBoard_no");
			System.out.println(mBoard_no);
			boardService.boardlist(mBoard_no);
			break;

		case "/mngcomment": // 관리자 댓글 전체 목록
			System.out.println("댓글 목록 호출");
			boardService.comread();			
			break;
			
		case "/writeView" :
			System.out.println("writeView");
			System.out.println(req.getSession().getAttribute("id"));
			if(req.getSession().getAttribute("id") == null) {
				String writeMsg = "로그인 후 이용가능합니다.";
				req.setAttribute("writeMsg", writeMsg);
				RequestDispatcher dis = req.getRequestDispatcher("index.jsp");
				dis.forward(req, resp);
			} else if(req.getSession().getAttribute("id").equals("admin")) {
				resp.sendRedirect("mngwrite.jsp");
			}
			else {
				resp.sendRedirect("write.jsp");
			}
			break;

		case "/deletecom":
			System.out.println("회원 본인 댓글 삭제");
			boardService.delcom();
			break;
			
		case "/delmngcomment"://관리자 댓글 삭제
			System.out.println("관리자 댓글 삭제 ");
			boardService.delmngcomment();
			break;
			
		case "/boardDetail":
			System.out.println("게시글 상세보기 게시글 번호 ? "+req.getParameter("board_no"));
			boardService.boardDetail();
			break;

		case "/updateForm":
			System.out.println("수정 폼 이동 요청");
			boardService.updateForm();
			break;
			
		case "/update":
			System.out.println("수정");
			boardService.update();
			break;
			
		case "/del":
			System.out.println("글 삭제");
			boardService.del();
			break;
			
		case "/mngboardDetail":
			System.out.println("관리자글 상세보기 게시글 번호"+req.getParameter("board_no"));
			boardService.mboardDetail();
			break;
/*
		case "/myBoardList":
			System.out.println("내 글보기");
			boardService.myBoardList();
			break;
*/			
		case "/search":
			System.out.println("검색");
			boardService.search();
			break;
			
		case "/write":
			boardService.write();
			System.out.println("글쓰기 요청");
			break;
			
		//메모장 글쓰기
		case "/memoWrite":
			System.out.println("메모글쓰기");
			boardService.memoWrite();
			break;
			
		case "/prev":
			System.out.println("이전글 불러오기");
			boardService.prev();
			break;
		
		
		case "/next":
			System.out.println("다음글 불러오기");
			boardService.next();
			break;
			
		case "/detailLikeCnt":
			System.out.println("글 상세보기 좋아요 수");
			boardService.detailLikeCnt();
			break;
			
		case "/like":
			System.out.println("좋아요하기");
			boardService.like();
			break;
		}
	}
}
