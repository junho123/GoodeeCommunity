package com.gcs.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gcs.DAO.ContactDAO;
import com.gcs.DTO.ContactDTO;
import com.google.gson.Gson;

public class ContactService {
	
	HttpServletRequest req = null;
	HttpServletResponse resp = null;

	public ContactService(HttpServletRequest req, HttpServletResponse resp) {
		this.req = req;
		this.resp = resp;
	}

	public void contact() throws ServletException, IOException {
		ContactDAO dao = new ContactDAO();
		ArrayList<ContactDTO> contact = dao.contact();
		req.setAttribute("contact", contact);
		RequestDispatcher dis = req.getRequestDispatcher("contact.jsp");
		dis.forward(req, resp);	
		
	}

	public void ctwrite() throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		ContactDAO dao = new ContactDAO();
		String writer = req.getParameter("writer");
		System.out.println(writer);
		String subject = req.getParameter("subject");
		System.out.println(subject);
		String c_email = req.getParameter("c_email");
		System.out.println(c_email);
		String content = req.getParameter("content");
		System.out.println(content);
		String msg = "문의사항 보내기가 실패했습니다.";
		System.out.println(content);
		
		boolean result = dao.ctwrite(writer, subject, c_email, content);
		if(result){
			msg = "문의사항을 성공적으로 보냈습니다.";		
		}
		
		HashMap<String,Object> map =  new HashMap<String, Object>();
		map.put("contactmsg",msg);
		Gson json = new Gson();
		String obj = json.toJson(map);
		System.out.println("result :"+obj);
		resp.setContentType("text/html; charset=UTF-8");
		resp.getWriter().println(obj);		
		
		
	}

	public void statusSet() throws ServletException, IOException {
		String c_status = req.getParameter("c_status");
		String contact_no = req.getParameter("contact_no");
		String msg = "처리에 실패했습니다.";
		
		ContactDAO dao = new ContactDAO();
		if(dao.statusSet(c_status, contact_no)) {
			msg = "처리되었습니다.";
		}
		
		req.setAttribute("msg", msg);
		RequestDispatcher dis = req.getRequestDispatcher("contact");
		dis.forward(req, resp);
	}

	public void contactMain() throws ServletException, IOException {
		ContactDAO dao = new ContactDAO();
		ArrayList<ContactDTO> contact = dao.contactMain();
		req.setAttribute("contact", contact);
		RequestDispatcher dis = req.getRequestDispatcher("admin_main.jsp");
		dis.forward(req, resp);	
		
	}
}
