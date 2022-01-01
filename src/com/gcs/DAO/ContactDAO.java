package com.gcs.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.gcs.DTO.ContactDTO;

public class ContactDAO {
	
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	public ContactDAO() {
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");
			conn = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}	
	}
	
	public void resClose() {
		try {
			if(rs!=null) {rs.close();}
			if(ps!=null) {ps.close();}
			if(conn!=null) {conn.close();}
		}catch(Exception e) {
			e.printStackTrace();
		}		
	}
	
	public ArrayList<ContactDTO> contact() {
		String sql = "SELECT contact_no, writer, subject, c_email, content, c_status FROM contact ORDER BY contact_no DESC";
		ArrayList<ContactDTO> contact = new ArrayList<ContactDTO>();
		try {		
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			
			while(rs.next()){
				ContactDTO dto = new ContactDTO();
				dto.setContact_no(rs.getInt("contact_no"));
				dto.setWriter(rs.getString("writer"));
				dto.setSubject((rs.getString("subject")));
				dto.setC_email((rs.getString("c_email")));
				dto.setContent((rs.getString("content")));;
				dto.setC_status((rs.getString("c_status")));				
				contact.add(dto);  
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return contact;
	}
	
	public boolean ctwrite(String writer, String subject, String c_email, String content) {
		String sql = "INSERT INTO contact (contact_no,writer,subject,content,c_email,c_status) VALUES (seq_contact.NEXTVAL,?,?,?,?,0)";
		boolean result = false;
		try {
			conn.setAutoCommit(false);
			
			ps = conn.prepareStatement(sql);

			ps.setString(1, writer);
			ps.setString(2, subject);
			ps.setString(3, content);
			ps.setString(4, c_email);

			
			int success = ps.executeUpdate();
			System.out.println(success);
			if(success>0) {
				result = true;
				conn.commit();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return result;	
	}

	public boolean statusSet(String c_status, String contact_no) {
		
		String sql = "";
		boolean result = false;
		
		if(c_status.equals("0")) { // 접수를 처리함
			sql = "UPDATE contact SET c_status=1 WHERE contact_no=?";
		} else {
			sql = "UPDATE contact SET c_status=0 WHERE contact_no=?";
		}
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, contact_no);
			
			if(ps.executeUpdate()>0) {
				result = true;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		
		return result;
	}

	public ArrayList<ContactDTO> contactMain() {
		String sql = "SELECT CONTACT_NO, WRITER, SUBJECT, CONTENT, C_EMAIL, C_STATUS FROM (SELECT CONTACT_NO, WRITER, SUBJECT, CONTENT, C_EMAIL, C_STATUS FROM CONTACT ORDER BY CONTACT_NO DESC) WHERE ROWNUM <= 5";
		ArrayList<ContactDTO> contact = new ArrayList<ContactDTO>();
		try {		
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			
			while(rs.next()){
				ContactDTO dto = new ContactDTO();
				dto.setContact_no(rs.getInt("contact_no"));
				dto.setWriter(rs.getString("writer"));
				dto.setSubject((rs.getString("subject")));
				dto.setC_email((rs.getString("c_email")));
				dto.setContent((rs.getString("content")));;
				dto.setC_status((rs.getString("c_status")));
				
				contact.add(dto);  
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return contact;
	}
}
