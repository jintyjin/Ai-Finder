package com.refa.ai.dto;

public class Case_info {
	private int case_idx;
	private int case_image_count;
	private int case_roi_count;
	private int case_chk_confidence;
	private int case_progress;
	private String login_id;
	private String analyze_content;
	private String case_time;
	private String case_taken;
	private String case_chk_yellow;
	private String case_chk_gray;
	private String case_chk_trash;
	public int getCase_idx() {
		return case_idx;
	}
	public void setCase_idx(int case_idx) {
		this.case_idx = case_idx;
	}
	public int getCase_image_count() {
		return case_image_count;
	}
	public void setCase_image_count(int case_image_count) {
		this.case_image_count = case_image_count;
	}
	public int getCase_roi_count() {
		return case_roi_count;
	}
	public void setCase_roi_count(int case_roi_count) {
		this.case_roi_count = case_roi_count;
	}
	public int getCase_chk_confidence() {
		return case_chk_confidence;
	}
	public void setCase_chk_confidence(int case_chk_confidence) {
		this.case_chk_confidence = case_chk_confidence;
	}
	public int getCase_progress() {
		return case_progress;
	}
	public void setCase_progress(int case_progress) {
		this.case_progress = case_progress;
	}
	public String getLogin_id() {
		return login_id;
	}
	public void setLogin_id(String login_id) {
		this.login_id = login_id;
	}
	public String getCase_time() {
		return case_time;
	}
	public void setCase_time(String case_time) {
		this.case_time = case_time;
	}
	public String getCase_taken() {
		return case_taken;
	}
	public void setCase_taken(String case_taken) {
		this.case_taken = case_taken;
	}
	public String getCase_chk_yellow() {
		return case_chk_yellow;
	}
	public void setCase_chk_yellow(String case_chk_yellow) {
		this.case_chk_yellow = case_chk_yellow;
	}
	public String getCase_chk_gray() {
		return case_chk_gray;
	}
	public void setCase_chk_gray(String case_chk_gray) {
		this.case_chk_gray = case_chk_gray;
	}
	public String getCase_chk_trash() {
		return case_chk_trash;
	}
	public void setCase_chk_trash(String case_chk_trash) {
		this.case_chk_trash = case_chk_trash;
	}
	public String getAnalyze_content() {
		return analyze_content;
	}
	public void setAnalyze_content(String analyze_content) {
		this.analyze_content = analyze_content;
	}
}
