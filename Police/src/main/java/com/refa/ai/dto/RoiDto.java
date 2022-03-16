package com.refa.ai.dto;

import org.json.simple.JSONObject;

public class RoiDto {
	private String favorites;
	private String img_name;
	private String hHeight;
	private String hWidth;
	private String isShow;
	private String login_id;
	private String roiNum;
	private String crop_name;
	private String roi;
	
	public String getFavorites() {
		return favorites;
	}
	public void setFavorites(String favorites) {
		this.favorites = favorites;
	}
	public String getImg_name() {
		return img_name;
	}
	public void setImg_name(String img_name) {
		this.img_name = img_name;
	}
	public String gethHeight() {
		return hHeight;
	}
	public void sethHeight(String hHeight) {
		this.hHeight = hHeight;
	}
	public String gethWidth() {
		return hWidth;
	}
	public void sethWidth(String hWidth) {
		this.hWidth = hWidth;
	}
	public String getIsShow() {
		return isShow;
	}
	public void setIsShow(String isShow) {
		this.isShow = isShow;
	}
	public String getLogin_id() {
		return login_id;
	}
	public void setLogin_id(String login_id) {
		this.login_id = login_id;
	}
	public String getRoiNum() {
		return roiNum;
	}
	public void setRoiNum(String roiNum) {
		this.roiNum = roiNum;
	}
	public String getRoi() {
		return roi;
	}
	public void setRoi(String roi) {
		this.roi = roi;
	}
	public String getCrop_name() {
		return crop_name;
	}
	public void setCrop_name(String crop_name) {
		this.crop_name = crop_name;
	}
	
}
