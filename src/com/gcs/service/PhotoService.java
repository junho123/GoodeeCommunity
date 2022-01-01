package com.gcs.service;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import com.gcs.DTO.MemberDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class PhotoService {

	HttpServletRequest req=null;
	
	public PhotoService(HttpServletRequest req) {
		this.req = req;	
	}
	
	// 파일 업로드 수행
	public MemberDTO upload() {
		// 저장경로 설정 
		String savePath = "C:/Users/GDJ26/Desktop/GCS/GoodeecommunityService/WebContent/image/member";
		//String savePath = "C:/upload/gcsmember";
		
		// 용량제한 
		int maxSize = 10*1024*1024;
		String oriName = "";
		String newName = "";
		MemberDTO dto = new MemberDTO();
		
		try {
			MultipartRequest multi = new MultipartRequest(req, savePath, maxSize,"UTF-8"); // 파일 저장
			// 파일명 변경
			
			dto.setId(multi.getParameter("id"));
			/*
			 * String photo_no = multi.getParameter("photo_no"); if(photo_no!=null) {
			 * dto.setPhoto_no(Integer.parseInt(photo_no)); }
			 */
						
			oriName = multi.getFilesystemName("photo");// 원본파일명 추출
			if(oriName!=null) { // 업로드한 파일이 있다면
				String ext = oriName.substring(oriName.lastIndexOf("."));
				newName = System.currentTimeMillis()+ext; // 새 파일명 생성
				File oldFile = new File(savePath+oriName); // java의 File 객체는 파일, 경로, 디렉토리 모두 포함 => 여기서는 파일 경로를 의미해서 사용됨
				File newFile = new File(savePath+newName);
				oldFile.renameTo(newFile); // 파일명 변경
				dto.setOriName(oriName);
				dto.setNewName(newName);				
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		} 
		return dto;	
	}
		
//파일삭제
	public void delete(String fileName) {
		File file = new File("C:/upload/gcsmember"+fileName);
		boolean success = false;
		if(file.exists()) {
			success = file.delete();
			System.out.println("실제파일삭제");
		}
		
	}
	
}
