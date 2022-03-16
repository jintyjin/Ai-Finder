package com.refa.ai.dto;

public class GpsDto {
	private int gps_idx;
	private String status;
	private String caseNum;
	private String tmpNum;
	private String color;
	
	public int getGps_idx() {
		return gps_idx;
	}
	public void setGps_idx(int gps_idx) {
		this.gps_idx = gps_idx;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getCaseNum() {
		return caseNum;
	}
	public void setCaseNum(String caseNum) {
		this.caseNum = caseNum;
	}
	public String getTmpNum() {
		return tmpNum;
	}
	public void setTmpNum(String tmpNum) {
		this.tmpNum = tmpNum;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
}
