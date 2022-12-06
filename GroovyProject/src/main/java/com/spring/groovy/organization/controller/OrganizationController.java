package com.spring.groovy.organization.controller;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.StringUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groovy.common.Pagination;
import com.spring.groovy.mail.model.MailVO;
import com.spring.groovy.mail.model.TagVO;
import com.spring.groovy.mail.service.InterMailService;
import com.spring.groovy.management.model.MemberVO;
import com.spring.groovy.organization.model.InterOrganizationService;

@Controller
public class OrganizationController {
	@Autowired // Type 에 따라 알아서 Bean 을 주입해준다.
	private InterOrganizationService service;

	@RequestMapping(value = "/organization.on")
	public ModelAndView organization(ModelAndView mav, Pagination pagination, HttpServletRequest request) {
		Map<String, Object> paraMap = new HashMap<>();

		HttpSession session = request.getSession();

		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

		String mail_address = loginuser.getCpemail();

		paraMap.put("mail_address", mail_address);

		// 내 중요표시 가져오기
		/*
		 * List<TagVO> tagList = null; Map<String, String> paraMap2 = new HashMap<>();
		 * paraMap2.put("FK_MAIL_ADDRESS", mail_address);
		 * 
		 * tagList=service.getTagListByMailNo(paraMap2);
		 * 
		 * for(TagVO tag :tagList ) { System.out.println("getTag_no:"+tag.getTag_no());
		 * System.out.println("getTag_color:"+tag.getTag_color());
		 * System.out.println("getFk_mail_no:"+tag.getFk_mail_no()); }
		 */

		/*
		 * List<MailVO> empList = null;
		 * 
		 * String searchType = pagination.getSearchType(); String searchWord =
		 * pagination.getSearchWord(); System.out.println(searchType);
		 * System.out.println(searchWord); // 둘다 없다면 "" 처리 if(searchType == null ||
		 * (!"subject".equals(searchType) && !"FK_Sender_address".equals(searchType)) )
		 * { searchType = ""; }
		 * 
		 * if(searchWord == null || "".equals(searchWord) || searchWord.trim().isEmpty()
		 * ) { searchWord = ""; } paraMap.put("searchType",searchType);
		 * paraMap.put("searchWord",searchWord);
		 * 
		 * // 총 게시물 건수(totalCount) int listCnt = service.getEmpTotalCount(paraMap);
		 * 
		 * Map<String, Object> resultMap = pagination.getPageRange(listCnt );
		 * 
		 * paraMap.put("startRno",resultMap.get("startRno"));
		 * paraMap.put("endRno",(resultMap.get("endRno")));
		 * 
		 * mailList = service.mailListSearchWithPaging(paraMap); // 페이징 처리한 글목록 가져오기(검색이
		 * 있든지, 검색이 없든지 모두 다 포함한 것)
		 * 
		 * // 아래의 것은 검색대상 컬럼과 검색어를 뷰단 페이지에서 유지시키기 위한 것임. if( !"".equals(searchType) &&
		 * !"".equals(searchWord) ) {
		 * 
		 * mav.addObject("paraMap", paraMap); }
		 * 
		 * System.out.println(mailList);
		 * 
		 * List<TagVO>tagListSide = service.getTagListSide(mail_address);
		 * 
		 * 
		 * mav.addObject("mailList", mailList); mav.addObject("tagList", tagList);
		 * mav.addObject("tagListSide", tagListSide);
		 * 
		 * for(MailVO mail :mailList ) {
		 * System.out.println("sendTime:"+mail.getSend_time());
		 * 
		 * System.out.println("send_time_date"+mail.getSend_time_date()); }
		 * 
		 * 
		 * 
		 * 
		 * mav.addObject("pagebar",
		 * pagination.getPagebar("/groovy/mail/receiveMailBox.on"));
		 */

		mav.setViewName("organization/organizationMain.tiles");
		// ==> views/tiles/organization/content/organizationMain.jsp

		return mav;
	}

	@ResponseBody
	@RequestMapping(value = "/organizationSideAjax.on", method = {
			RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
	public String sendMailBoxAjax(HttpServletRequest request) {

		List<Map<String, String>> departmentList = service.getDepartmentList();
		// html 맵에 mailList tagList 넣어줌

		List<String> bumunList = new ArrayList<String>();

		JSONArray departmentArray = new JSONArray();
		StringBuilder bumunListstr = new StringBuilder();
		for (Map<String, String> map : departmentList) { // 중복없는 리스트 만들기
			if (bumunList.size() > 0) {
				if (!bumunList.contains(map.get("BUMUN_NO"))) {
					bumunList.add(map.get("BUMUN_NO"));
					bumunListstr.append(map.get("BUMUN_NO"));
					bumunListstr.append(",");

				}
			} else {
				bumunList.add(map.get("BUMUN_NO"));
				bumunListstr.append(map.get("BUMUN_NO"));
				bumunListstr.append(",");
			}

			JSONObject json = new JSONObject(map);
			departmentArray.put(json);
		}

		if (bumunListstr.length() > 0) {
			bumunListstr.deleteCharAt(bumunListstr.length() - 1);
		}
		String bumunListString = bumunListstr.toString();

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("bumunList", bumunListString);
		departmentArray.put(jsonObj);

		System.out.println(departmentArray);

		return departmentArray.toString();

	}

}
