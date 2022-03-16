package com.refa.ai.dto;

public class DashDto {
	private String dash_idx;
	private String image_name;
	private int roi_count;
	private String login_id;
	
	public String getDash_idx() {
		return dash_idx;
	}
	public void setDash_idx(String dash_idx) {
		this.dash_idx = dash_idx;
	}
	public String getImage_name() {
		return image_name;
	}
	public void setImage_name(String image_name) {
		this.image_name = image_name;
	}
	public int getRoi_count() {
		return roi_count;
	}
	public void setRoi_count(int roi_count) {
		this.roi_count = roi_count;
	}
	public String getLogin_id() {
		return login_id;
	}
	public void setLogin_id(String login_id) {
		this.login_id = login_id;
	}
}
