package com.spring.groovy.common;

import java.util.HashMap;
import java.util.Map;

public class Pagination {

	private int pageSize = 10; // 한 페이지당 보여줄 게시물 건수 (초기값 10)
	private int currentPage = 1; // 현재 페이지번호 (초기값 1)
	private String searchType = ""; // 검색기준
	private String searchWord = ""; // 검색어

	private int blockSize = 5; // 한 페이지 당 보여줄 페이지 개수
	private int totalPage; // 총 페이지수
	private int startRno; // 시작 행번호
	private int endRno; // 끝 행번호

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = (pageSize != 10 && pageSize != 30 && pageSize != 50)? 10 : pageSize;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getSearchWord() {
		return searchWord;
	}

	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}

	public int getBlockSize() {
		return blockSize;
	}

	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getStartRno() {
		return startRno;
	}

	public void setStartRno(int startRno) {
		this.startRno = startRno;
	}

	public int getEndRno() {
		return endRno;
	}

	public void setEndRno(int endRno) {
		this.endRno = endRno;
	}

	// 특정 페이지 조회 시 필요한 정보들을 Map에 담아서 리턴해줌
	public Map<String, Object> getPageRange(int listCnt) {

		// 총 페이지 수 계산
		totalPage = (int) Math.ceil((double) listCnt / pageSize);
		
		currentPage = (currentPage > totalPage)? 1 : currentPage;

		// startRno, endRno 설정
		startRno = ((currentPage - 1) * pageSize) + 1;
		endRno = startRno + pageSize - 1;

		Map<String, Object> resultMap = new HashMap<>();
		
		resultMap.put("startRno", startRno);
		resultMap.put("endRno", endRno);
		
		resultMap.put("searchType", searchType);
		resultMap.put("searchWord", searchWord);

		resultMap.put("pageSize", pageSize);

		return resultMap;
	}
	
	// 인스턴스에 페이지 정보 설정하기
	public void setPageInfo(int listCnt) {
		
		// 총 페이지 수 계산
		totalPage = (int) Math.ceil((double) listCnt / pageSize);
		
		currentPage = (currentPage > totalPage)? 1 : currentPage;
		
		// startRno, endRno 설정
		startRno = ((currentPage - 1) * pageSize) + 1;
		endRno = startRno + pageSize - 1;
	}
	
	// 페이지바 만들기
	public String getPagebar(String url) { 

		int loop = 1;

		int pageNo = ((currentPage - 1) / blockSize) * blockSize + 1;

		String pageBar = "<ul class='pagination justify-content-center'>";

		// === [맨처음][이전] 만들기 === //
		if (pageNo != 1) {
			pageBar += "<li class='page-item'><a class='page-link' href='" + url + "?searchType="
					+ searchType + "&searchWord=" + searchWord + "&currentPage=1" + "&pageSize=" + pageSize +"'><i class='fas fa-angle-double-left'></i></a></li>";
			pageBar += "<li class='page-item'><a class='page-link' href='" + url + "?searchType="
					+ searchType + "&searchWord=" + searchWord + "&currentPage=" + (pageNo - 1) + "&pageSize=" + pageSize
					+ "'><i class='fas fa-angle-left'></i></i></a></li>";
		}

		while (!(loop > blockSize || pageNo > totalPage)) {

			if (pageNo == currentPage) {
				pageBar += "<li class='page-item active'><a class='page-link' href=#>" + pageNo + "</a></li>";
			} else {
				pageBar += "<li class='page-item'><a class='page-link' href='" + url
						+ "?searchType=" + searchType + "&searchWord=" + searchWord + "&currentPage=" + pageNo + "&pageSize=" + pageSize
						+ "'>" + pageNo + "</a></li>";
			}

			loop++;
			pageNo++;
		}

		// === [다음][마지막] 만들기 === //
		if (pageNo <= totalPage) {
			pageBar += "<li class='page-item'><a class='page-link' href='" + url + "?searchType="
					+ searchType + "&searchWord=" + searchWord + "&currentPage=" + pageNo + "&pageSize=" + pageSize + "'><i class='fas fa-angle-right'></i></a></li>";
			pageBar += "<li class='page-item'><a class='page-link' href='" + url + "?searchType="
					+ searchType + "&searchWord=" + searchWord + "&currentPage=" + totalPage + "&pageSize=" + pageSize + "'><i class='fas fa-angle-double-right'></i></a></li>";
		}

		pageBar += "</ul>";


		return pageBar;
	}
	 
}
