package com.gcs.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.gcs.DTO.BoardDTO;
import com.gcs.DTO.MemberDTO;

public class MypageDAO {

	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	public MypageDAO() {
		try {
			Context ctxt = new InitialContext();
			DataSource ds = (DataSource) ctxt.lookup("java:comp/env/jdbc/Oracle");
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

	
	public ArrayList<BoardDTO> boardList(String id, int startPage, int endPage) throws SQLException {
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
		String sql = "SELECT r.rnum, r.board_no, r.mboard_no, r.id, r.bo_subject, r.bo_content, r.bo_reg_date, r.bo_bhit, "
				+ "m.boardname, r.nickname FROM (SELECT ROW_NUMBER() OVER(ORDER BY board_no DESC) AS rnum, "
				+ "b.board_no, b.mboard_no, b.id, b.bo_subject, b.bo_content, b.bo_reg_date, b.bo_bhit, m.nickname "
				+ "FROM board b, member m WHERE m.id = b.id and b.id=?) r, mboard m "
				+ "WHERE r.mBoard_no = m.mBoard_no AND rnum BETWEEN ? AND ?";

		ps = conn.prepareStatement(sql);
		ps.setString(1, id);
		ps.setInt(2, startPage);
		ps.setInt(3, endPage);		
		rs = ps.executeQuery();				
		while(rs.next()) {
			BoardDTO dto = new BoardDTO();
			dto.setBoard_no(rs.getInt("board_no"));
			dto.setMboard_no(rs.getInt("mboard_no"));
			dto.setId(rs.getString("id"));
			dto.setBo_subject(rs.getString("bo_subject"));
			dto.setBo_reg_date(rs.getDate("bo_reg_date"));
			dto.setBo_bHit(rs.getInt("bo_bHit"));
			dto.setBoardname(rs.getString("boardName"));			
			list.add(dto);
		}		
		ps.close();
		rs.close();			
		return list;
	}

	public int listCnt(String id) throws SQLException {
		String sql = "SELECT COUNT(*) AS num FROM board WHERE id=?";
		int cnt = 0;
		ps = conn.prepareStatement(sql);
		ps.setString(1, id);
		
		rs = ps.executeQuery();
		if(rs.next()) {
			cnt = rs.getInt("num");
		}		
		return cnt;
	}
	
	public int listComCnt(String id) throws SQLException {
		String sql = "SELECT COUNT(*) AS num FROM commentary WHERE id=?";
		int cnt = 0;
		ps = conn.prepareStatement(sql);
		ps.setString(1, id);
		
		rs = ps.executeQuery();
		if(rs.next()) {
			cnt = rs.getInt("num");
		}		
		return cnt;
	}

	public ArrayList<BoardDTO> blikeCnt(ArrayList<BoardDTO> list) {
		ArrayList<BoardDTO> blikeCnt = new ArrayList<BoardDTO>();		
		for (int i = 0; i < list.size(); i++) {			
			String sql = "SELECT COUNT(board_no) FROM blike WHERE board_no=?";
				try {
					ps = conn.prepareStatement(sql);
					ps.setInt(1, list.get(i).getBoard_no());
					rs = ps.executeQuery();
					
					if(rs.next()) {
						BoardDTO dto = new BoardDTO();
						dto.setBlike_cnt(rs.getString("COUNT(board_no)"));
						blikeCnt.add(dto);						
					}					
					ps.close();
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				} 
		}
		
		return blikeCnt;
	}

	// 사진 업로드 
		public boolean pupload(MemberDTO dto) {
			boolean result = false;
			String sql ="";
			String id = dto.getId();
			System.out.println("ID: "+id);
			if(dto.getOriName()!=null) { // photo 테이블에 데이터 추가
				sql="INSERT INTO photo (photo_no, id, oriName, newName) VALUES (seq_photo.NEXTVAL, ?,?,?)";
				try {
					ps = conn.prepareStatement(sql);
					ps.setString(1, id);
					ps.setString(2, dto.getOriName());
					ps.setString(3, dto.getNewName());
						if(ps.executeUpdate()>0) {
							result = true;
						}
				} catch (SQLException e) {
					e.printStackTrace();
				} finally {resClose();}
			}			
			return result;
		}
		
		// 파일명 업데이트
		public void updateFileName(String prevFileName, String newFileName, String id) {
			// photo Table에 newFileName 을 새로운 파일명으로 변경		
			String sql = "";
			try {
				if(prevFileName!=null) { // 기존 파일이 있는 경우는 UPDATE
					sql="UPDATE photo SET newName =? WHERE id=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1, newFileName);
					ps.setString(2, id);
				}else { // 기존 파일이 없는 경우는 INSERT
					sql="INSERT INTO photo (photo_no, id, oriName, newName) VALUES (seq_photo.nextVAL, ?,?,?)";
					ps = conn.prepareStatement(sql);
					ps.setString(1, id);			
					ps.setString(2, prevFileName);
					ps.setString(3, newFileName);		
				}
				ps.executeUpdate();			
				
			} catch (SQLException e) {
				e.printStackTrace();
			}finally {
				resClose();
			}
		}
		
		// 파일명 추출하기
		public String getFileName(String id) {
			String oriName = null;
			String sql = "SELECT oriName FROM photo WHERE ID=?";			
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1, id);
				rs = ps.executeQuery();				
				
				if(rs.next()) {
					oriName = rs.getString(1);
				}				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				resClose();
			}
			System.out.println(oriName);
			return oriName;
		}

		// 사용자 사진 가져오기
		public ArrayList<MemberDTO> userphoto(String id) {
			String sql = "SELECT * FROM PHOTO WHERE ID=? ";
			ArrayList<MemberDTO> list = new ArrayList<MemberDTO>();
			MemberDTO dto = new MemberDTO();
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1, id);
				rs = ps.executeQuery();
				while(rs.next()) {
						dto.setOriName(rs.getString("oriName"));
						dto.setNewName(rs.getString("newName"));
						list.add(dto);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}	finally {
				resClose();
			}
			return list;
		}

		// 사용자 코멘트 리스트
		public ArrayList<BoardDTO> commentList(String id, int startPage, int endPage) throws SQLException {
			ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
			String sql = "SELECT rnum, board_no, id, co_content, co_reg_date "
					+ "FROM (SELECT ROW_NUMBER() OVER(ORDER BY comment_no DESC) AS rnum, "
					+ "board_no, id, co_content, co_reg_date FROM commentary WHERE id = ?) WHERE id = ? and "
					+ "rnum BETWEEN ? AND ?";
			
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, id);
			ps.setInt(3, startPage);
			ps.setInt(4, endPage);
			
			rs = ps.executeQuery();				
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();				
				dto.setBoard_no(rs.getInt("board_no"));
				dto.setId(rs.getString("id"));
				dto.setCo_content(rs.getString("co_content"));
				dto.setCo_reg_date(rs.getDate("co_reg_date"));				
				list.add(dto);
			}
			ps.close();
			rs.close();			
			return list;
		}

		public boolean delphoto(String id){
			boolean result = false;
			String sql = "DELETE FROM photo WHERE ID = ?";
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1, id);			
				if(ps.executeUpdate()>0) {
					result = true;
				}
			} catch (SQLException e) {				
				e.printStackTrace();
			} finally {resClose();}			
			return result;
		}
		
	
}
