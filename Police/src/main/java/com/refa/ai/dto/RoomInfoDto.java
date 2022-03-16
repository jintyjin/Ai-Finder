package com.refa.ai.dto;

public class RoomInfoDto {
	private int room_idx;
	private String room_name;
	private String room_user_name;
	private String room_pwd;
	private int room_count;
	private String room_create_date;
	private String room_close_date;
	private String room_isclose;
	private String room_isexit;
	private String app_user_group;
	
	public int getRoom_idx() {
		return room_idx;
	}
	public void setRoom_idx(int room_idx) {
		this.room_idx = room_idx;
	}
	public int getRoom_count() {
		return room_count;
	}
	public void setRoom_count(int room_count) {
		this.room_count = room_count;
	}
	public String getRoom_name() {
		return room_name;
	}
	public void setRoom_name(String room_name) {
		this.room_name = room_name;
	}
	public String getRoom_user_name() {
		return room_user_name;
	}
	public void setRoom_user_name(String room_user_name) {
		this.room_user_name = room_user_name;
	}
	public String getRoom_pwd() {
		return room_pwd;
	}
	public void setRoom_pwd(String room_pwd) {
		this.room_pwd = room_pwd;
	}
	public String getRoom_create_date() {
		return room_create_date;
	}
	public void setRoom_create_date(String room_create_date) {
		this.room_create_date = room_create_date;
	}
	public String getRoom_close_date() {
		return room_close_date;
	}
	public void setRoom_close_date(String room_close_date) {
		this.room_close_date = room_close_date;
	}
	public String getRoom_isclose() {
		return room_isclose;
	}
	public void setRoom_isclose(String room_isclose) {
		this.room_isclose = room_isclose;
	}
	public String getRoom_isexit() {
		return room_isexit;
	}
	public void setRoom_isexit(String room_isexit) {
		this.room_isexit = room_isexit;
	}
	public String getApp_user_group() {
		return app_user_group;
	}
	public void setApp_user_group(String app_user_group) {
		this.app_user_group = app_user_group;
	}
}
