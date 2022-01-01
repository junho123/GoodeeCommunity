package com.gcs.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class ReplyDAO {	
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	public ReplyDAO() {
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

	public boolean reply(String board_no, String id, String content) {
		String sql = "";
		boolean result = false;		
			sql= "INSERT INTO commentary (comment_no, board_no, id, co_content) VALUES (seq_comment.NEXTVAL, ?, ?, ?)";
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1, board_no);
				ps.setString(2, id);
				ps.setString(3, content);
				int success = ps.executeUpdate();
				if(success > 0) {
					result = true;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}finally {resClose();}			
		return result;
	}

	public boolean recommentDel(String recomment_no) {		
		String sql ="DELETE FROM recomment WHERE recomment_no=?";
		boolean result = false;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, recomment_no);			
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
	
	
	public void recomment(String comment_no, String id, String reco_content){
		String sql ="INSERT INTO recomment (recomment_no, comment_no, id, reco_content) VALUES (SEQ_RECOMMENT.nextval, ?, ?, ?)";
		boolean success = false;		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, comment_no);
			ps.setString(2, id);
			ps.setString(3, reco_content);
			if(ps.executeUpdate()>0) {
				success = true;
			}
			System.out.println(success);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			resClose();
		}
		
	}

	
}
