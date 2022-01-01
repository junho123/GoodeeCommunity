package com.gcs.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gcs.DAO.BoardDAO;
import com.gcs.DAO.MypageDAO;
import com.gcs.DTO.BoardDTO;
import com.gcs.DTO.MemberDTO;
import com.google.gson.Gson;

public class MypageService {
	HttpServletRequest req = null;
	HttpServletResponse resp = null;
	
	public MypageService(HttpServletRequest req, HttpServletResponse resp) {
		this.req = req;
		this.resp = resp;
	}

	public void boardList() throws ServletException, IOException {
		String id = (String) req.getSession().getAttribute("id");
		String pageParam = req.getParameter("curPage");
		
		System.out.println("전달받은 curPage의 값 = "+pageParam);
		int curPage = 1; // 첫 페이지 1 설정
		int listCnt = 0;
		if(pageParam != null) {
			curPage = Integer.parseInt(pageParam);			
		}
	
		int startPage =  (curPage)*5-4;
		int endPage = (curPage)*5;
		
		System.out.println(id+"/"+curPage);
	
		ArrayList<BoardDTO> list = null;		
		ArrayList<BoardDTO> blikeCnt = null;	
		ArrayList<Integer> commentCnt = null;	
		ArrayList<Integer> allCommentCnt = null;	
		System.out.println(id+" 아이디 /  curPage"+curPage);
		
		MypageDAO dao = new MypageDAO();
		String location = "upmy2.jsp"; // 리로드할 곳 up
			
		try {		
				list = dao.boardList(id, startPage, endPage);
				listCnt = dao.listCnt(id); // 총 게시물의 개수			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		// 얘내는 자체적으로 prepareStatement 종료시켜줌
		blikeCnt = dao.blikeCnt(list);
		BoardDAO boardDAO = new BoardDAO();
		commentCnt = boardDAO.commentCnt(list);
		allCommentCnt = boardDAO.recommentCnt(list, commentCnt);
						
		
		dao.resClose();
		
		Pagination page = new Pagination(listCnt, curPage);
		System.out.println(list);
		req.setAttribute("list", list);
		req.setAttribute("blikeCnt", blikeCnt);
		req.setAttribute("commentCnt", allCommentCnt);
		req.setAttribute("page", page);
		
		RequestDispatcher dis = req.getRequestDispatcher(location);
		dis.forward(req, resp);		
	}

	//사진 업로드	
		public void upload(String id) throws IOException, ServletException {		
			MypageDAO dao = new MypageDAO();
			PhotoService pservice = new PhotoService(req);
			MemberDTO dto = pservice.upload();		
			String msg = "사진 업로드가 실패하였습니다.";
			if(dao.pupload(dto)) {
				msg = "사진 업로드에 성공했습니다.";
			}
			req.setAttribute("msg", msg);
			RequestDispatcher dis = req.getRequestDispatcher("photo_test.jsp");
			dis.forward(req, resp);			
		}
		
		// 프로필 사진 불러오기
		public void userphoto() throws IOException {
			req.setCharacterEncoding("UTF-8");
			MypageDAO dao = new MypageDAO();
			String id = (String) req.getSession().getAttribute("id");
			ArrayList<MemberDTO> list = null;		
			list = dao.userphoto(id);	
			String oriname ="";
			if(list!=null) {
				oriname = list.get(0).getOriName();
			}
			req.getSession().setAttribute("userphoto",oriname);
			System.out.println(req.getAttribute("userphoto"));
			
			HashMap<String,Object> map =  new HashMap<String, Object>();
			map.put("userphoto",oriname);
			Gson json = new Gson();
			String obj = json.toJson(map);
			System.out.println("result :"+obj);
			resp.getWriter().println(obj);				
		}

		
		//사진 삭제하기
		public void delphoto(String id) throws ServletException, IOException {
			MypageDAO dao = new MypageDAO();
			PhotoService upload = new PhotoService(req);
			String fileName = dao.getFileName(id);//파일명 추출(photo)	
			System.out.println("파일명" + fileName);
			
			dao = new MypageDAO();//이미 getFileName 에서 커넥션을 쓰고 반납 했으므로 다시 생성
			if(fileName != null) {
				upload.delete(fileName); //삭제할 파일이 있어으면 파일을 지우는 작업
				}		
			String msg = "사진 삭제가 실패했습니다.";
			if(dao.delphoto(id)) {// 테이블에서 지우는 작업
				msg = "사진을 삭제했습니다.";
				}
			req.getSession().removeAttribute("userphoto");
			req.setAttribute("msg", msg);
			RequestDispatcher dis = req.getRequestDispatcher("myPageList");
			dis.forward(req, resp);
		}

		public void commentList() throws ServletException, IOException {
			String id = (String) req.getSession().getAttribute("id");
			
			String pageParam = req.getParameter("curPage");
			
			System.out.println("전달받은 curPage의 값 = "+pageParam);
			
			int curPage = 1; // 첫 페이지 1 설정
			int listCnt = 0;
			if(pageParam != null) {
				curPage = Integer.parseInt(pageParam);			
			}
		
			int startPage =  (curPage)*5-4;
			int endPage = (curPage)*5;
			
			System.out.println(id+"/"+curPage);
			
			ArrayList<BoardDTO> list = null;	
			
			MypageDAO dao = new MypageDAO();
			//String location = "upmy2.jsp"; // 리로드할 곳 up
				
			try {		
					list = dao.commentList(id, startPage, endPage);
					listCnt = dao.listComCnt(id); // 총 게시물의 개수			
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
			dao.resClose();
			HashMap<String, Object> map = new HashMap<String, Object>();
			Gson gson = new Gson();	     	
			Pagination page = new Pagination(listCnt, curPage);
			System.out.println(list);			
			map.put("list",list);
		      String obj = gson.toJson(map);
		      System.out.println(obj);
		      resp.setContentType("text/html; charset=UTF-8");
		      resp.getWriter().println(obj);
			
		}
			
		
	
}
