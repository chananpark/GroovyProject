package com.spring.groovy.survey.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groovy.survey.model.InterSurveyDAO;

@Service
public class SurveyService implements InterSurveyService {

	@Autowired
	private InterSurveyDAO dao;

	
	
	
	
}
