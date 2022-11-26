package com.spring.groovy.common;

import java.awt.image.BufferedImage;
import java.awt.image.renderable.ParameterBlock;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.Calendar;

import javax.media.jai.JAI;
import javax.media.jai.RenderedOp;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;

@Component
public class FileManager {

	/** 
	 * 파일 업로드하기
	 * @param bytes: 파일의 내용물
	 * @param originalFileName: 첨부된 파일의 원래이름
	 * @param path: 업로드할 파일의 저장경로
	 * @return 서버에 저장된 새로운 파일명
	*/
	public String doFileUpload(byte[] bytes, String originalFileName, String path) throws Exception {

		String newFileName = null;

		// 파일이 비어있다면
		if (bytes == null) {
			return null; // 끝내기
		}

		// 클라이언트가 업로드한 파일의 이름이 없다면
		if ("".equals(originalFileName) || originalFileName == null) {
			return null; // 끝내기
		}

		// 파일확장자
		String fileExt = originalFileName.substring(originalFileName.lastIndexOf(".")); // => .png

		// 파일확장자가 없다면
		if (fileExt == null || "".equals(fileExt) || ".".equals(fileExt)) {
			return null; // 끝내기
		}

		// 서버에 저장할 새로운 파일명을 만든다.
		// 현재의 연월일시분초+나노세컨즈(nanoseconds)+확장자
		newFileName = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", Calendar.getInstance());
		newFileName += System.nanoTime();
		newFileName += fileExt;

		// File: 파일을 관리하는 클래스
		File dir = new File(path);
		// 파라미터로 입력받은 경로명으로 File 객체를 생성한다.(실제 파일을 만드는것이 아님)

		// 만약 해당 경로의 디렉토리가 존재하지 않으면
		if (!dir.exists()) {
			dir.mkdirs(); // 디렉토리를 생성한다. (mkdir: 폴더 한개만 만드는것 mkdirs: 하위폴더까지 만드는것)
		}

		// 서버에 올라갈 파일명
		String pathname = path + File.separator + newFileName;

		FileOutputStream fos = new FileOutputStream(pathname);
		// FileOutputStream은 해당 경로명에 실제로 데이터 내용을 기록해주는 클래스이다.

		fos.write(bytes); // 해당 경로 파일명에 실제 데이터 내용을 기록해준다.
		fos.close();

		return newFileName; // 서버에 저장된 새로운 파일명을 리턴한다.
	}

	/**
	 * 파일 다운로드하기
	 * @param fileName: 서버에 저장된 파일 이름
	 * @param orgFilename: 원본 파일명
	 * @param path: 파일 저장 경로
	 * @param response: 응답 객체
	 * @return 파일 다운로드 성공 여부
	 */
	public boolean doFileDownload(String fileName, String orgFilename, String path, HttpServletResponse response) {

		String pathname = path + File.separator + fileName;
		// C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\files\서버에저장된파일명

		try {
			orgFilename = new String(orgFilename.getBytes("UTF-8"), "8859_1");
			// UTF-8 형태의 문자열을 byte 형태로 변경한 후 byte 형태의 문자열을 표준인 ISO-Latin1(8859_1)형태로 인코딩하는 것

			File file = new File(pathname);
			// 다운로드할 파일의 경로명으로 File 객체를 생성한다.
			
			// exists(): OS에게 이 경로에 파일이 진짜 존재하는지 물어보는 메소드
			if (file.exists()) { // 해당 파일이 존재한다면
				response.setContentType("application/octet-stream");
				// 다운로드할 파일의 종류에 따라 Content-Type 을 지정해주어야 한다.
				// 이미지는 "image/jpeg" 같은 형식으로, 비디오는 "video/mpeg" 형식으로
				// 기타 인코딩된 모든 파일들은 "application/octet-stream" 으로 지정한다.
				// 여기서는 모든 파일을 다운로드할 것이므로 기본값인 "application/octet-stream" 으로 지정해준다.

				// response header의 이름과 값을 설정한다.
				response.setHeader("Content-disposition", "attachment; filename=" + orgFilename);
				// Name = Content-Disposition: 해당 패킷의 데이터형식
				// Value = attachment: 데이터형식을 첨부파일로 지정함
				// Name = filename: 첨부파일명
				// Value = orgFilename: 원본파일명

				byte[] readByte = new byte[4096];
				// 다운로드할 파일의 내용을 읽어오는 byte 배열

				BufferedInputStream bfin = new BufferedInputStream(new FileInputStream(file));
				// File 객체가 가리키는 파일을 바이트로 읽어오는 객체

				ServletOutputStream souts = response.getOutputStream();
				// 읽어온 파일을 브라우저에 출력하는 객체

				int length = 0;

				// bfin을 사용해 파일을 4096바이트까지 읽어온 후 readByte 배열에 저장한다.
				// 만약 더 이상 읽어올 내용이 없으면 -1을 리턴한다.
				while ((length = bfin.read(readByte, 0, 4096)) != -1) {
					// bfin이 읽어온 길이만큼 ServletOutputStream에 저장한다.
					souts.write(readByte, 0, length);
				}
				souts.flush(); // ServletOutputStream에 기록해둔 내용을 출력하며 버퍼를 비운다.
				souts.close(); // ServletOutputStream을 닫는다.
				bfin.close(); // BufferedInputStream을 닫는다.

				return true; // 파일이 존재하고 Exception이 발생하지 않으면 true를 리턴
			}
		} catch (Exception e) {
				return false; // 예외 발생시 false 리턴
		}
		return false; // 파일이 존재하지 않으면 false 리턴
	}

	// 파일 삭제하기
	public void doFileDelete(String fileName, String path) {
		String pathname = path + File.separator + fileName;

		File file = new File(pathname);
		if (file.exists()) { // 파일이 존재한다면

			file.delete(); // 파일 삭제
		}
	}

	// 이미지 폭 구하기
	public int getImageWidth(String pathname) {
		int width = -1;

		File file = new File(pathname);
		if (!file.exists())
			return width;

		ParameterBlock pb = new ParameterBlock();
		pb.add(pathname);
		RenderedOp rOp = JAI.create("fileload", pb);

		BufferedImage bi = rOp.getAsBufferedImage();

		width = bi.getWidth();

		return width;
	}

	// 이미지 높이 구하기
	public int getImageHeight(String pathname) {
		int height = -1;

		File file = new File(pathname);
		if (!file.exists())
			return height;

		ParameterBlock pb = new ParameterBlock();
		pb.add(pathname);
		RenderedOp rOp = JAI.create("fileload", pb);

		BufferedImage bi = rOp.getAsBufferedImage();

		height = bi.getHeight();

		return height;
	}
	
	// 네이버 스마트 에디터를 사용한 사진첨부
	public String doFileUpload(InputStream is, String originalFileName, String path) throws Exception {

		String newFilename = null;

		// 클라이언트가 업로드한 파일의 이름
		if (originalFileName == null || originalFileName.equals(""))
			return null;

		// 확장자
		String fileExt = originalFileName.substring(originalFileName.lastIndexOf("."));
		if (fileExt == null || fileExt.equals(""))
			return null;

		// 서버에 저장할 새로운 파일명 생성
		newFilename = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", Calendar.getInstance());
		newFilename += System.nanoTime();
		newFilename += fileExt;

		// 업로드할 경로가 존재하지 않는 경우 폴더를 생성
		File dir = new File(path);
		if (!dir.exists())
			dir.mkdirs();

		String pathname = path + File.separator + newFilename;

		byte[] byteArr = new byte[1024];
		int size = 0;
		FileOutputStream fos = new FileOutputStream(pathname);

		while ((size = is.read(byteArr)) != -1) {
			fos.write(byteArr, 0, size);
		}
		fos.flush();

		fos.close();
		is.close();

		return newFilename;
	}

}