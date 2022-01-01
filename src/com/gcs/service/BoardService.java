package com.gcs.service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.dbcp2.BasicDataSource;

import com.gcs.DAO.BoardDAO;
import com.gcs.DTO.BoardDTO;
import com.google.gson.Gson;


public class BoardService  {
	
	HttpServletRequest req = null;
	HttpServletResponse resp = null;

	public BoardService(HttpServletRequest req, HttpServletResponse resp) {
		this.req = req;
		this.resp = resp;
	}

	public void write() throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String id =(String) req.getSession().getAttribute("id");
		String mboard_no = req.getParameter("mboard_no");
		String subject = req.getParameter("subject");
		String content = req.getParameter("content");
		String msg = "글 작성에 실패했습니다.";
		
		BoardDAO dao = new BoardDAO();
		if(dao.write(mboard_no, id, subject, content)) {
			msg = "글이 작성되었습니다.";
		}
			req.setAttribute("msg", msg);
			RequestDispatcher dis = req.getRequestDispatcher("write.jsp");
			dis.forward(req, resp);
				
	}

	public void comread() throws ServletException, IOException {
		BoardDAO dao = new BoardDAO();
		ArrayList<BoardDTO> list = dao.commentlist();
		req.setAttribute("list", list);
		RequestDispatcher dis = req.getRequestDispatcher("mngcomment.jsp");
		dis.forward(req, resp);	
	}

	public void delmngcomment() throws ServletException, IOException{
		String idx = req.getParameter("comment_no");
		System.out.println("comment_no : "+idx);
		BoardDAO dao = new BoardDAO();
		String page = "/mngcomment";
		String msg = "수정에 실패했습니다.";
		
		if(dao.delmngcomment(idx)) {
			page = "/mngcomment";
			msg = "수정에 성공 했습니다.";
		}
		req.setAttribute("msg", msg);
		RequestDispatcher dis = req.getRequestDispatcher(page);
		dis.forward(req, resp);
	  	}
		
	public void boardlist(String mBoard_no) throws IOException {
		HashMap<String, Object> map = new HashMap<String, Object>();
	     	 Gson gson = new Gson();	  
       		  BoardDAO dao = new BoardDAO();
        		 ArrayList<BoardDTO> list = null;
        		  try {
			list= dao.boardlist(mBoard_no);
		} catch (SQLException e) {
			e.printStackTrace();
		}
          dao.resClose();
	      map.put("list",list);
	      String obj = gson.toJson(map);
	      System.out.println(obj);
	      resp.setContentType("text/html; charset=UTF-8");
	      resp.getWriter().println(obj);      
		/*
		req.setAttribute("msg", msg);
		RequestDispatcher dis = req.getRequestDispatcher("write.jsp");
		dis.forward(req, resp);
		 */		
	}

	public void boardList() throws IOException, ServletException {
		
		String mboard_no = req.getParameter("mboard_no");
		String pageParam = req.getParameter("curPage");
		
		System.out.println("전달받은 curPage의 값 = "+pageParam);
		int curPage = 1; // 첫 페이지 1 설정
		int listCnt = 0;
		if(pageParam != null) {
			curPage = Integer.parseInt(pageParam);			
		}
	
		int startPage =  (curPage)*5-4;
		int endPage = (curPage)*5;
		
		System.out.println(mboard_no+"/"+curPage);
	
		ArrayList<BoardDTO> list = null;		
		ArrayList<BoardDTO> blikeCnt = null;	
		ArrayList<Integer> commentCnt = null;	
		ArrayList<Integer> allCommentCnt = null;	
		BoardDTO dto = new BoardDTO();
		System.out.println(mboard_no+"게시판번호 /  curPage"+curPage);
		
		BoardDAO dao = new BoardDAO();
		String location = "boardList.jsp";
			
		try {
			if(mboard_no == null) {
				location= "index.jsp";
				list = dao.allBoard(startPage, endPage);
				listCnt = dao.AllListCnt();
			} else {
				list = dao.boardList(mboard_no, startPage, endPage);
				listCnt = dao.listCnt(mboard_no); // 총 게시물의 개수
				
				
				if(Integer.parseInt(mboard_no) == 4) {
					location = "index.jsp";
				}
			}				
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		// 얘내는 자체적으로 prepareStatement 종료시켜줌
		blikeCnt = dao.blikeCnt(list);
		commentCnt = dao.commentCnt(list);
		System.out.println(commentCnt);
		allCommentCnt = dao.recommentCnt(list, commentCnt);
		System.out.println(allCommentCnt);
		
		dao.resClose();
		
		Pagination page = new Pagination(listCnt, curPage);
		
		req.setAttribute("list", list);
		req.setAttribute("blikeCnt", blikeCnt);
		req.setAttribute("commentCnt", allCommentCnt);
		req.setAttribute("page", page);
		
		RequestDispatcher dis = req.getRequestDispatcher(location);
		dis.forward(req, resp);

	}
	
	//updateForm
	public void updateForm() throws ServletException, IOException {
		BoardDAO dao = new BoardDAO();
		String board_no = req.getParameter("board_no");
		System.out.println("수정board_no : "+board_no);
		BoardDTO dto = null;
		try {
			dto = dao.boardDetail(board_no);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			dao.resClose();
			req.setAttribute("boardDetail", dto);
			RequestDispatcher dis = req.getRequestDispatcher("boardUpdate.jsp");
			dis.forward(req, resp);
		}
	}

	public void boardDetail() throws ServletException, IOException {
		BoardDTO dto = null;
		String board_no = req.getParameter("board_no");
		BoardDAO dao = new BoardDAO();
		ArrayList<BoardDTO> commentList = null;
		ArrayList<BoardDTO> recommentList = null;
		int commentCnt = 0;
		int AllCommentCnt = 0;
		
		try {
			dto = dao.boardDetail(board_no);
			commentList = dao.commentList(board_no); // 댓글리스트
			commentCnt = dao.detailCommentCnt(board_no); // 댓글개수
			AllCommentCnt = dao.detailRecommentCnt(commentCnt, board_no);
			recommentList =  dao.recommentList(commentList); // 댓글리스트를 받아서... 대댓글리스트를 가져옴
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.resClose();
			req.setAttribute("boardDetail", dto);
			req.setAttribute("commentList", commentList);
			req.setAttribute("commentCnt", AllCommentCnt);
			req.setAttribute("recommentList", recommentList);
			RequestDispatcher dis = req.getRequestDispatcher("boardDetail.jsp");
			dis.forward(req, resp);
		}				
	}

	//수정
	public void update() throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String mboard_no = req.getParameter("mboard_no");
		String board_no = req.getParameter("board_no");
		String bo_subject = req.getParameter("subject");
		String bo_content = req.getParameter("content");
		System.out.println(mboard_no+"/"+board_no+" / "+bo_subject+" / "+bo_content);
		BoardDAO dao = new BoardDAO();
		String page = "boardDetail?board_no="+board_no;
		String msg = "수정에 실패 했습니다.";
		if(dao.update(mboard_no,board_no,bo_subject,bo_content)) {
			msg ="수정에 성공 했습니다.";
		}
		req.setAttribute("msg", msg);
		RequestDispatcher dis = req.getRequestDispatcher(page);
		dis.forward(req, resp);
	}

	//삭제
	public void del() throws ServletException, IOException {
		String board_no = req.getParameter("board_no");
		String mboard_no = req.getParameter("mboard_no");
		System.out.println("board_no :"+board_no);
		BoardDAO dao = new BoardDAO();
		String page = "boardDetail";
		String msg = "삭제에 실패 했습니다";
		if(dao.del(board_no)) {
			page = "/boardList?mboard_no"+mboard_no;
			msg = "삭제에 성공 했습니다.";
			if(req.getSession().getAttribute("id").equals("admin")) {
				page = "mngboard.jsp";
			}
		}
		req.setAttribute("msg", msg);
		RequestDispatcher dis = req.getRequestDispatcher(page);
		dis.forward(req, resp);
	}

	//관리자 게시글 상세보기
	public void mboardDetail() throws ServletException, IOException {
		BoardDTO dto = null;
		String board_no = req.getParameter("board_no");
		BoardDAO dao = new BoardDAO();
		
		try {
			dto = dao.mboardDetail(board_no);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.resClose();
			req.setAttribute("boardDetail", dto);
			
			RequestDispatcher dis = req.getRequestDispatcher("mboardDetail.jsp");
			dis.forward(req, resp);
		}		
	}
	
	//회원 본인 댓글 삭제
	public void delcom() throws ServletException, IOException {
		String idx = req.getParameter("board_no");
		String id = (String) req.getSession().getAttribute("id");
		System.out.println("board_no : "+idx+" id: "+id);
		BoardDAO dao = new BoardDAO();			
		dao.delcom(idx,id); //근데 끝나고 어디로 가?
		resp.sendRedirect("myPageList");
	}	
	

	//검색
	public void search() throws IOException, ServletException{
		
		String search = req.getParameter("search");
		if(search == "") {
			search = " #★$★&★&★*★$★%★&★@★$★%★^★@★^★$★";//검색값이 이러면 결과에 일부러 아무것도 안뜨게 함
		}
		
		System.out.println("search확인 : "+search);
		String pageParam = req.getParameter("curPage");		
		System.out.println("전달받은 curPage의 값 = "+pageParam);
		
		int curPage = 1;// 첫 페이지 1 설정
		int listCnt = 0;
		if(pageParam != null) {
			curPage = Integer.parseInt(pageParam);
		}
		
		int startPage = (curPage)*5-4;
		int endPage = (curPage)*5;
		
		System.out.println(search+"/"+curPage);
		
		ArrayList<BoardDTO> list = null;		
		ArrayList<BoardDTO> blikeCnt = null;	
		ArrayList<Integer> commentCnt = null;	
		BoardDTO dto = new BoardDTO();
		
		BoardDAO dao = new BoardDAO();
		
		try {
			list = dao.search(search, startPage, endPage);
			listCnt = dao.searchListCnt(search); // 총 게시물의 개수
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		// 얘내는 자체적으로 prepareStatement 종료시켜줌
		blikeCnt = dao.blikeCnt(list);
		commentCnt = dao.commentCnt(list);
		commentCnt = dao.recommentCnt(list, commentCnt);
		Pagination page = new Pagination(listCnt, curPage);
		
		System.out.println("검색 리스트 : "+list);
		System.out.println("게시글 좋아요 : "+ blikeCnt);
		System.out.println("댓글 수 : "+commentCnt);
		dao.resClose();
		
		req.setAttribute("list", list);
		req.setAttribute("blikeCnt", blikeCnt);
		req.setAttribute("commentCnt", commentCnt);
		req.setAttribute("page", page);
		req.setAttribute("search", search);
		
		RequestDispatcher dis = req.getRequestDispatcher("searchresult.jsp");
		dis.forward(req, resp);
	}

	//메모장 글쓰기
	public void memoWrite() throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String id =(String) req.getSession().getAttribute("id");
		String subject = req.getParameter("subject");
		String content = req.getParameter("content");
		String msg = "글 작성에 실패했습니다.";
		
		BoardDAO dao = new BoardDAO();
		if(dao.write2(id, subject, content)) {
			msg = "글이 작성되었습니다.";
			req.setAttribute("msg", msg);
			RequestDispatcher dis = req.getRequestDispatcher("main");
			dis.forward(req, resp);		
		}else if(id == null){
			msg = "로그인 후 작성 가능합니다.";
			req.setAttribute("msg", msg);
			RequestDispatcher dis = req.getRequestDispatcher("main");
			dis.forward(req, resp);		
		}
		
	}
	
	public void prev() throws ServletException, IOException {
		String board_no = req.getParameter("board_no");
		String mBoard_no = req.getParameter("mBoard_no");
		BoardDAO dao = new BoardDAO();
		List<BoardDTO> list = dao.prev(board_no, mBoard_no);
		String msg = "이전 글이 존재하지 않습니다.";
		System.out.println(list.size());		
		RequestDispatcher dis = null;
		if(list.isEmpty()) {
			req.setAttribute("msg", msg);
			dis = req.getRequestDispatcher("boardList?mBoard_no="+mBoard_no);
			
		}else {
			req.setAttribute("boardDetail", list.get(0));
			dis = req.getRequestDispatcher("boardDetail?board_no="+list.get(0).getBoard_no());
		}
		dis.forward(req, resp);
		
	}


	public void next() throws ServletException, IOException {
		String board_no = req.getParameter("board_no");
		String mBoard_no = req.getParameter("mBoard_no");
		BoardDAO dao = new BoardDAO();
		List<BoardDTO> list = dao.next(board_no, mBoard_no);
		String msg = "다음 글이 존재하지 않습니다.";
		System.out.println(list.size());		
		RequestDispatcher dis = null;
		if(list.isEmpty()) {
			req.setAttribute("msg", msg);
			dis = req.getRequestDispatcher("boardList?mBoard_no="+mBoard_no);		
		}else {
			req.setAttribute("boardDetail", list.get(0));
			dis = req.getRequestDispatcher("boardDetail?board_no="+list.get(0).getBoard_no());			
		}
		dis.forward(req, resp);
		
	}

	public void detailLikeCnt() throws IOException {
		String board_no = req.getParameter("board_no");
		String id = (String) req.getSession().getAttribute("id");
		BoardDAO dao = new BoardDAO();		
		int detailLikeCnt = 0;
		boolean likeStatus = false;
		try {
			detailLikeCnt = dao.detailLikeCnt(board_no); // 게시글의 좋아요 수
			likeStatus = dao.detailLikeStatus(board_no, id); // 내가 좋아요를 했는가 상태
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.resClose();
		}
		
		
		HashMap<String, Object> map = new HashMap<String, Object>();
    	Gson gson = new Gson();	  
  	
	    map.put("detailLikeCnt", detailLikeCnt);
	    map.put("likeStatus", likeStatus);
	    String obj = gson.toJson(map);
	    System.out.println(obj);
	    resp.setContentType("text/html; charset=UTF-8");
	    resp.getWriter().println(obj);  
		
		
	}

	public void like() throws IOException {
		String board_no = req.getParameter("board_no");
		String id = (String) req.getSession().getAttribute("id");
		BoardDAO dao = new BoardDAO();
		boolean likeStatus = false;
		boolean result = false;
		
		try {
			likeStatus = dao.detailLikeStatus(board_no, id);
			result = dao.like(likeStatus, board_no, id);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.resClose();
			HashMap<String, Object> map = new HashMap<String, Object>();
	    	Gson gson = new Gson();	  
	  	
		    map.put("result", result);
		    String obj = gson.toJson(map);
		    System.out.println(obj);
		    resp.setContentType("text/html; charset=UTF-8");
		    resp.getWriter().println(obj); 
		}
	}
}