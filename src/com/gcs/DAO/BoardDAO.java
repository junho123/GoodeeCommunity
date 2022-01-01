package com.gcs.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.commons.dbcp2.BasicDataSource;

import com.gcs.DTO.BoardDTO;

public class BoardDAO {
	
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	public BoardDAO() {
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

	public ArrayList<BoardDTO> commentlist() {
		String sql = 				
				"SELECT ta.comment_no, ta.board_no, ta.id, ta.co_content, ta.co_reg_date, tc.boardname "
				+ "FROM commentary ta INNER JOIN board tb ON tb.board_no=ta.board_no "
				+ "INNER JOIN mboard tc ON tb.mBoard_no = tc.mBoard_no "
				+ "ORDER BY co_reg_date DESC";
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
		try {		
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			
			while(rs.next()){
				BoardDTO dto = new BoardDTO();
				dto.setComment_no(rs.getInt("comment_no"));
				dto.setBoard_no(rs.getInt("board_no"));
				dto.setId(rs.getString("id"));
				dto.setCo_content(rs.getString("co_content"));
				dto.setCo_reg_date(rs.getDate("co_reg_date"));
				dto.setBoardname(rs.getString("boardname"));//게시판을 가져와야함! 게시판을 가져오는 건... 조인...
				list.add(dto);  
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return list;
	}

	public boolean write(String mboard_no, String id, String subject, String content) {
		String sql = "INSERT INTO board (board_no, mBoard_no, id, bo_subject, bo_content, bo_bHit) VALUES (seq_board.NEXTVAL,?,?,?,?,0)";
		boolean result = false;
		try {
			conn.setAutoCommit(false);
			
			ps = conn.prepareStatement(sql);
			ps.setString(1, mboard_no);
			ps.setString(2, id);
			ps.setString(3, subject);
			ps.setString(4, content);
			
			int success = ps.executeUpdate();
			System.out.println(success);
			if(success>0) {
				result = true;
				conn.commit();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return result;	
	}

	public boolean delmngcomment(String comment_no) {
		String sql = "UPDATE commentary SET co_content = '관리자에 의해 삭제된 댓글입니다.' WHERE  comment_no=?";
		boolean result = false;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, comment_no);
			
			int success = ps.executeUpdate();
			if(success > 0) {
				result = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return result;
	}


	public ArrayList<BoardDTO> boardlist(String mBoard_no) throws SQLException {
	      ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
	      String sql ="SELECT * FROM board WHERE mBoard_no=? ORDER BY board_no DESC";
	      ps = conn.prepareStatement(sql);
	      ps.setString(1, mBoard_no);
	      rs = ps.executeQuery();
	      
	      while(rs.next()) {
	         BoardDTO dto = new BoardDTO();
	         dto.setBoard_no(rs.getInt("board_no"));
	         dto.setId(rs.getString("Id"));
	         dto.setBo_subject(rs.getString("bo_subject"));
	         dto.setBo_content(rs.getNString("bo_content"));
	         dto.setBo_reg_date(rs.getDate("bo_reg_date"));
	         dto.setBo_bHit(rs.getInt("bo_bHit"));
	         list.add(dto);	         
	      }
	      return list;
	}

	public ArrayList<BoardDTO> boardList(String mboard_no, int startPage, int endPage) throws SQLException {
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
		
		String sql = "SELECT r.rnum, r.board_no, r.mboard_no, r.id, r.bo_subject, r.bo_content, r.bo_reg_date, r.bo_bhit, m.boardname, r.nickname " + 
				"FROM (SELECT ROW_NUMBER() OVER(ORDER BY board_no DESC) AS rnum, board_no, mboard_no, id, bo_subject, bo_content, bo_reg_date, bo_bhit, nickname " + 
				"FROM (SELECT b.board_no, b.mboard_no, b.id, b.bo_subject, b.bo_content, b.bo_reg_date, b.bo_bhit, m.nickname " + 
				"FROM board b, member m WHERE m.id = b.id) WHERE mboard_no=?) r, mboard m WHERE r.mboard_no = m.mboard_no AND rnum BETWEEN ? AND ?";
		
		ps = conn.prepareStatement(sql);
		ps.setString(1, mboard_no);
		ps.setInt(2, startPage);
		ps.setInt(3, endPage);
		
		rs = ps.executeQuery();		
		
		while(rs.next()) {
			BoardDTO dto = new BoardDTO();
			dto.setBoard_no(rs.getInt("board_no"));
			dto.setMboard_no(rs.getInt("mboard_no"));
			dto.setId(rs.getString("id"));
			dto.setBo_subject(rs.getString("bo_subject"));
			dto.setBo_content(rs.getString("bo_content"));
			dto.setBo_reg_date(rs.getDate("bo_reg_date"));
			dto.setBo_bHit(rs.getInt("bo_bHit"));
			dto.setBoardname(rs.getString("boardName"));
			dto.setNickName(rs.getString("nickName"));	
			
			list.add(dto);
		}
		
		return list;	
	}

	public int listCnt(String mboard_no) throws SQLException {		
		String sql = "SELECT COUNT(*) AS num FROM board WHERE mboard_no=?";
		int cnt = 0;
		ps = conn.prepareStatement(sql);
		ps.setString(1, mboard_no);
		
		rs = ps.executeQuery();
		if(rs.next()) {
			cnt = rs.getInt("num");
		}
		
		return cnt;
	}


	public BoardDTO boardDetail(String board_no) throws SQLException {
		BoardDTO dto = new BoardDTO();
		
		String sql = "SELECT * FROM (SELECT b.board_no, b.mboard_no, b.id, b.bo_subject, b.bo_content, b.bo_reg_date, b.bo_bhit, b.boardname, m.nickname " + 
				"FROM (SELECT b.board_no, b.mboard_no, b.id, b.bo_subject, b.bo_content, b.bo_reg_date, b.bo_bhit, m.boardname " + 
				"FROM board b, mboard m WHERE b.mboard_no = m.mboard_no) b, member m " + 
				"WHERE b.id= m.id) WHERE board_no=?";
		
		ps = conn.prepareStatement(sql);
		ps.setString(1, board_no);
		rs = ps.executeQuery();
		
		if(rs.next()) {
			dto.setBoard_no(rs.getInt("board_no"));
			dto.setMboard_no(rs.getInt("mboard_no"));
			dto.setId(rs.getString("id"));
			dto.setBo_subject(rs.getString("bo_subject"));
			dto.setBo_content(rs.getString("bo_content"));
			dto.setBo_reg_date(rs.getDate("bo_reg_date"));			
			dto.setNickName(rs.getString("nickname"));
			dto.setBoardname(rs.getString("boardname"));
			upHit(rs.getInt("board_no"));
			dto.setBo_bHit(rs.getInt("bo_bHit"));
		}
		
		ps.close();
		rs.close();
	
		return dto;
	}

	private void upHit(int board_no) {
		String sql = "UPDATE board SET bo_bHit = bo_bHit+1 WHERE board_no = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, board_no);
			int success = ps.executeUpdate();
			System.out.println("조회수 올리기 성공 : "+success);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
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
						ps.close();
						rs.close();
					}
				} catch (SQLException e) {
					e.printStackTrace();
				} 
			}		
		return blikeCnt;
	}

	public ArrayList<Integer> commentCnt(ArrayList<BoardDTO> list) {		
		ArrayList<Integer> commentCnt = new ArrayList<Integer>();		
		for (int i = 0; i < list.size(); i++) {
			String sql = "SELECT COUNT(*) FROM commentary WHERE board_no=?";
			try {
				ps = conn.prepareStatement(sql);
				ps.setInt(1, list.get(i).getBoard_no());
				rs = ps.executeQuery();
				
				if(rs.next()) {
					commentCnt.add(i, rs.getInt("COUNT(*)"));
					ps.close();
					rs.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return commentCnt;		
	}


	public ArrayList<BoardDTO> allBoard(int startPage, int endPage) throws SQLException {
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
		
		String sql = "SELECT r.rnum, r.board_no, r.mboard_no, r.id, r.bo_subject, r.bo_content, r.bo_reg_date, r.bo_bhit, m.boardname, r.nickname " + 
				"FROM (SELECT ROW_NUMBER() OVER(ORDER BY board_no DESC) AS rnum, board_no, mboard_no, id, bo_subject, bo_content, bo_reg_date, bo_bhit, nickname " + 
				"FROM (SELECT b.board_no, b.mboard_no, b.id, b.bo_subject, b.bo_content, b.bo_reg_date, b.bo_bhit, m.nickname " + 
				"FROM board b, member m WHERE m.id = b.id)) r, mboard m WHERE r.mboard_no = m.mboard_no AND rnum BETWEEN ? AND ? ORDER BY BOARD_NO DESC";
		
		ps = conn.prepareStatement(sql);
		ps.setInt(1, startPage);
		ps.setInt(2, endPage);
		
		rs = ps.executeQuery();		
		
		while(rs.next()) {
			BoardDTO dto = new BoardDTO();
			dto.setBoard_no(rs.getInt("board_no"));
			dto.setMboard_no(rs.getInt("mboard_no"));
			dto.setId(rs.getString("id"));
			dto.setBo_subject(rs.getString("bo_subject"));
			dto.setBo_content(rs.getString("bo_content"));
			dto.setBo_reg_date(rs.getDate("bo_reg_date"));
			dto.setBo_bHit(rs.getInt("bo_bHit"));
			dto.setBoardname(rs.getString("boardName"));
			dto.setNickName(rs.getString("nickName"));				
			list.add(dto);
		}		
		return list;			
	}

	public int AllListCnt() throws SQLException {
		String sql = "SELECT COUNT(*) AS num FROM board";
		int cnt = 0;
		ps = conn.prepareStatement(sql);		
		rs = ps.executeQuery();
		if(rs.next()) {
			cnt = rs.getInt("num");
		}		
		return cnt;
	}

	public boolean update(String mboard_no, String board_no, String bo_subject, String bo_content) {
		boolean result = false;
		String sql = "UPDATE board SET mboard_no=?, bo_subject=?, bo_content=? WHERE board_no=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, mboard_no);
			ps.setString(2, bo_subject);
			ps.setString(3, bo_content);
			ps.setString(4, board_no);
			
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

	public boolean del(String board_no) {
		String sql ="DELETE FROM board WHERE board_no=?";
		boolean result = false;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, board_no);
			
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

	//검색
	public ArrayList<BoardDTO> search(String search, int startPage, int endPage) throws SQLException {
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
		
		String sql = "SELECT distinct rnum, board_no, mboard_no, id, bo_subject, bo_content, bo_reg_date, bo_bhit, boardname, nickname " + 
				"FROM (SELECT ROW_NUMBER() OVER(ORDER BY board_no DESC) AS rnum, r.board_no, r.mboard_no, r.id, r.bo_subject, r.bo_content, r.bo_reg_date, r.bo_bhit, m.boardname, r.nickname " + 
				"FROM (SELECT board_no, mboard_no, id, bo_subject, bo_content, bo_reg_date, bo_bhit, nickname  " + 
				"FROM (SELECT b.board_no, b.mboard_no, b.id, b.bo_subject, b.bo_content, b.bo_reg_date, b.bo_bhit, m.nickname " + 
				"FROM board b, member m WHERE m.id = b.id)) r, mboard m WHERE r.mboard_no = m.mboard_no AND bo_subject like ?) WHERE rnum BETWEEN ? AND ?";
		
		ps = conn.prepareStatement(sql);
		ps.setString(1, "%"+search+"%");
		ps.setInt(2, startPage);
		ps.setInt(3, endPage);
		rs = ps.executeQuery();		
		
		while(rs.next()) {
			BoardDTO dto = new BoardDTO();
			dto.setBoard_no(rs.getInt("board_no"));
			dto.setMboard_no(rs.getInt("mboard_no"));
			dto.setId(rs.getString("id"));
			dto.setBo_subject(rs.getString("bo_subject"));
			dto.setBo_content(rs.getString("bo_content"));
			dto.setBo_reg_date(rs.getDate("bo_reg_date"));
			dto.setBo_bHit(rs.getInt("bo_bHit"));
			dto.setBoardname(rs.getString("boardName"));
			dto.setNickName(rs.getString("nickName"));	
			
			list.add(dto);
		}
		
		ps.close();
		rs.close();
		
		return list;	
	}

	public int searchListCnt(String search) throws SQLException {
		
		String sql = "SELECT COUNT(*)"+
				"FROM (SELECT ROW_NUMBER() OVER(ORDER BY board_no DESC) AS rnum, r.board_no, r.mboard_no, r.id, r.bo_subject, r.bo_content, r.bo_reg_date, r.bo_bhit, m.boardname, r.nickname "+
				"FROM (SELECT board_no, mboard_no, id, bo_subject, bo_content, bo_reg_date, bo_bhit, nickname "+
				"FROM (SELECT b.board_no, b.mboard_no, b.id, b.bo_subject, b.bo_content, b.bo_reg_date, b.bo_bhit, m.nickname "+
				"FROM board b, member m WHERE m.id = b.id)) r, mboard m WHERE r.mboard_no = m.mboard_no AND bo_subject like ? ORDER BY BOARD_NO DESC)";
		int cnt = 0;
		ps = conn.prepareStatement(sql);
		ps.setString(1, "%"+search+"%");
		
		rs = ps.executeQuery();
		
		if(rs.next()) {
			cnt = rs.getInt("COUNT(*)");
		}
		
		ps.close();
		rs.close();
		
		return cnt;			
	}

	public ArrayList<Integer> recommentCnt(ArrayList<BoardDTO> list, ArrayList<Integer> commentCnt) {
		ArrayList<Integer> allCnt = new ArrayList<Integer>();
		
		for (int i = 0; i < list.size(); i++) {
			String sql = "SELECT COUNT(*) FROM commentary c, recomment r WHERE c.comment_no=r.comment_no AND board_no=?";

			try {
				ps = conn.prepareStatement(sql);
				ps.setInt(1, list.get(i).getBoard_no());
				rs = ps.executeQuery();
				
				if(rs.next()) {
					allCnt.add(i,commentCnt.get(i)+rs.getInt("COUNT(*)"));
					ps.close();
					rs.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return allCnt;
	}

	public ArrayList<BoardDTO> commentList(String board_no) throws SQLException {
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
		
		String sql = "SELECT c.comment_no, c.board_no, c.id, c.co_reg_date, c.co_content, m.nickname FROM commentary c, member m "
				+ "WHERE c.id = m.id AND board_no = ? ORDER BY comment_no ASC";
		
		ps = conn.prepareStatement(sql);
		ps.setString(1, board_no);
		rs = ps.executeQuery();
		
		while(rs.next()) {
			BoardDTO dto = new BoardDTO();
			dto.setComment_no(rs.getInt("comment_no"));
			dto.setBoard_no(rs.getInt("board_no"));
			dto.setId(rs.getString("id"));
			dto.setCo_reg_date(rs.getDate("co_reg_date"));
			dto.setCo_content(rs.getString("co_content"));
			dto.setNickName(rs.getString("nickname"));
			list.add(dto);
		}
		
		ps.close();
		rs.close();
		
		return list;
	}
		
	public BoardDTO mboardDetail(String board_no) throws SQLException {
		BoardDTO dto = new BoardDTO();
		
		String sql = "SELECT * FROM (SELECT b.board_no, b.mboard_no, b.id, b.bo_subject, b.bo_content, b.bo_reg_date, b.bo_bhit, b.boardname, m.nickname " + 
				"FROM (SELECT b.board_no, b.mboard_no, b.id, b.bo_subject, b.bo_content, b.bo_reg_date, b.bo_bhit, m.boardname " + 
				"FROM board b, mboard m WHERE b.mboard_no = m.mboard_no) b, member m " + 
				"WHERE b.id= m.id) WHERE board_no=?";
		
		ps = conn.prepareStatement(sql);
		ps.setString(1, board_no);
		rs = ps.executeQuery();
		
		if(rs.next()) {
			dto.setBoard_no(rs.getInt("board_no"));
			dto.setMboard_no(rs.getInt("mboard_no"));
			dto.setId(rs.getString("id"));
			dto.setBo_subject(rs.getString("bo_subject"));
			dto.setBo_content(rs.getString("bo_content"));
			dto.setBo_reg_date(rs.getDate("bo_reg_date"));			
			dto.setNickName(rs.getString("nickname"));
			dto.setBoardname(rs.getString("boardname"));
			upHit(rs.getInt("board_no"));
			dto.setBo_bHit(rs.getInt("bo_bHit"));
		}	
		return dto;
	}

	public int detailCommentCnt(String board_no) throws SQLException {
		int cnt = 0;
		
		String sql = "SELECT COUNT(*) FROM commentary WHERE board_no=?";
		ps = conn.prepareStatement(sql);
		ps.setString(1, board_no);
		rs = ps.executeQuery();
		
		if(rs.next()) {
			cnt = rs.getInt("COUNT(*)");
		}
		
		ps.close();
		rs.close();
		
		return cnt;
	}	

	public boolean delcom(String idx, String id) {
		String sql = "DELETE FROM commentary WHERE id=? and board_no=?";
		boolean result = false;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, idx);			
			int success = ps.executeUpdate();
			if(success > 0) {
				result = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return result;
	}

	public ArrayList<BoardDTO> recommentList(ArrayList<BoardDTO> commentList) throws SQLException {
		String sql = "SELECT comment_no, recomment_no, id, reco_reg_date, reco_content FROM recomment WHERE comment_no=?";
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
		
		for (int i = 0; i < commentList.size(); i++) {
			try {
				ps = conn.prepareStatement(sql);
				ps.setInt(1, commentList.get(i).getComment_no());
				
				rs = ps.executeQuery();
				while(rs.next()) {
					BoardDTO dto = new BoardDTO();
					dto.setComment_no(rs.getInt("comment_no"));
					dto.setRecomment_no(rs.getInt("recomment_no"));
					dto.setId(rs.getString("id"));
					dto.setReco_reg_date(rs.getDate("reco_reg_date"));
					dto.setReco_content(rs.getString("reco_content"));
					list.add(dto);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				ps.close();
				rs.close();
			}
			
		}

		return list;
	}

	public int detailRecommentCnt(int commentCnt, String board_no) throws SQLException {
		String sql = "SELECT COUNT(*) FROM commentary c, recomment r WHERE c.comment_no=r.comment_no AND board_no=?";
		int allCnt = 0;
		
		ps = conn.prepareStatement(sql);
		ps.setString(1, board_no);
		rs = ps.executeQuery();
		
		if(rs.next()) {
			allCnt = rs.getInt("COUNT(*)")+commentCnt;
		}
		
		ps.close();
		rs.close();

		return allCnt;
	}

	public boolean write2(String id, String subject, String content) {
		String sql = "INSERT INTO board (board_no, mBoard_no, id, bo_subject, bo_content, bo_bHit) VALUES (seq_board.NEXTVAL,2,?,?,?,0)";
		boolean result = false;
		try {
			conn.setAutoCommit(false);
			
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, subject);
			ps.setString(3, content);
			
			int success = ps.executeUpdate();
			System.out.println(success);
			if(success>0) {
				result = true;
				conn.commit();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return result;	
	}

	public  List<BoardDTO> prev(String board_no, String mBoard_no) {
		String sql = "SELECT MAX(BOARD_NO) AS board_no, mBoard_no FROM board WHERE BOARD_NO < ? AND MBOARD_NO = ? GROUP BY mboard_no";
		List<BoardDTO> list = new ArrayList<BoardDTO>();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, board_no);
			ps.setString(2, mBoard_no);
			rs = ps.executeQuery();
			BoardDTO dto = new BoardDTO();			
			while(rs.next()) {
				System.out.println("받은 보드넘버 : "+rs.getInt("board_no"));					
					dto.setBoard_no(rs.getInt("board_no"));					
					dto.setMboard_no(rs.getInt("mboard_no"));
					list.add(dto);			
			}
		} catch (SQLException e) {		
			e.printStackTrace();
		}	finally{resClose();}
		return list;
	}
	

	public List<BoardDTO> next(String board_no, String mBoard_no) {
		String sql = "SELECT MIN(BOARD_NO) AS board_no, mBoard_no FROM board WHERE BOARD_NO > ? AND MBOARD_NO = ? GROUP BY mboard_no";
		List<BoardDTO> list = new ArrayList<BoardDTO>();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, board_no);
			ps.setString(2, mBoard_no);
			rs = ps.executeQuery();
			BoardDTO dto = new BoardDTO();	
			
			while(rs.next()) {
				System.out.println("받은 보드넘버 : "+rs.getInt("board_no"));				
					dto.setBoard_no(rs.getInt("board_no"));					
					dto.setMboard_no(rs.getInt("mboard_no"));
					list.add(dto);				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}	finally{resClose();}
		return list;	
	}

	public int detailLikeCnt(String board_no) throws SQLException {
		String sql = "SELECT COUNT(board_no) FROM blike WHERE board_no=?";
		int detailLikeCnt = 0;
		ps = conn.prepareStatement(sql);
		ps.setString(1, board_no);
		rs = ps.executeQuery();					
		if(rs.next()) {				
			detailLikeCnt = rs.getInt("COUNT(board_no)");			
		}
		return detailLikeCnt;
	}

	public boolean detailLikeStatus(String board_no, String id) throws SQLException {
		boolean detailLikeStatus = false;
		
		String sql = "SELECT * FROM blike WHERE board_no=? AND id=?";
		
		ps = conn.prepareStatement(sql);
		ps.setString(1, board_no);
		ps.setString(2, id);
		rs = ps.executeQuery();					
		if(rs.next()) {				
			detailLikeStatus = true;
		}

		return detailLikeStatus;
	}

	public boolean like(boolean likeStatus, String board_no, String id) throws SQLException {
		String sql = "";
		boolean result = false;
		if(likeStatus) {
			sql = "DELETE FROM blike WHERE id=? AND board_no=?";
		} else {
			sql = "INSERT INTO blike(blike_no, id, board_no) VALUES(seq_bLike.NEXTVAL, ?, ?)";
		}
		
		ps = conn.prepareStatement(sql);
		ps.setString(1, id);
		ps.setString(2, board_no);
		if(ps.executeUpdate()>0) {
			result = true;
		}
		
		return result;
	}


}

