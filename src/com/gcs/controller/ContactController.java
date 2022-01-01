package com.gcs.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gcs.service.ContactService;

@WebServlet({"/contact","/contactWrite","/contactState","/contactmain"})
public class ContactController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		proc(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		proc(req, resp);
	}

	private void proc(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI();
		String ctx = req.getContextPath();
		String reqAddr = uri.substring(ctx.length());
		
		ContactService contactService = new ContactService(req, resp);
		
		switch(reqAddr) {
		
			case "/contact":
				System.out.println("목록 불러오기");
				contactService.contact();
				break;
				
			case "/contactWrite":
				System.out.println("문의사항 작성");
				contactService.ctwrite();
				break;
				
			case "/contactState":
				contactService.statusSet();
				
				break;
				
			case "/contactmain":
				contactService.contactMain();
				
				break;
				
		}
	}
}
