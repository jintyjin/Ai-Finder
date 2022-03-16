package com.refa.ai.dto;

import org.json.simple.JSONObject;

public class UserDto {
	private int login_idx;
	private String login_id;
	private String login_pw;
	private String login_gallery;
	private String login_confidence;
	private JSONObject json;
	private String caseNum;
	
	public int getLogin_idx() {
		return login_idx;
	}
	public void setLogin_idx(int login_idx) {
		this.login_idx = login_idx;
	}
	public String getLogin_id() {
		return login_id;
	}
	public void setLogin_id(String login_id) {
		this.login_id = login_id;
	}
	public String getLogin_pw() {
		return login_pw;
	}
	public void setLogin_pw(String login_pw) {
		this.login_pw = login_pw;
	}
	public String getLogin_gallery() {
		return login_gallery;
	}
	public void setLogin_gallery(String login_gallery) {
		this.login_gallery = login_gallery;
	}
	public String getLogin_confidence() {
		return login_confidence;
	}
	public void setLogin_confidence(String login_confidence) {
		this.login_confidence = login_confidence;
	}
	public JSONObject getJson() {
		return json;
	}
	public void setJson(JSONObject json) {
		this.json = json;
	}
	public String getCaseNum() {
		return caseNum;
	}
	public void setCaseNum(String caseNum) {
		this.caseNum = caseNum;
	}
	
	
}
