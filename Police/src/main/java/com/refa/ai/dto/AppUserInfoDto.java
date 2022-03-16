package com.refa.ai.dto;

import org.json.simple.JSONObject;

public class AppUserInfoDto {
	private int app_user_idx;
	private String app_user_id;
	private String app_user_pwd;
	private String app_user_group;
	private String app_create_time;
	private String app_delete_time;
	private String app_ismain;
	private JSONObject json;
	private String local_ip;
	private String local_port;
	private String app_first_gps;
	
	public int getApp_user_idx() {
		return app_user_idx;
	}
	public void setApp_user_idx(int app_user_idx) {
		this.app_user_idx = app_user_idx;
	}
	public String getApp_user_id() {
		return app_user_id;
	}
	public void setApp_user_id(String app_user_id) {
		this.app_user_id = app_user_id;
	}
	public String getApp_user_pwd() {
		return app_user_pwd;
	}
	public void setApp_user_pwd(String app_user_pwd) {
		this.app_user_pwd = app_user_pwd;
	}
	public String getApp_user_group() {
		return app_user_group;
	}
	public void setApp_user_group(String app_user_group) {
		this.app_user_group = app_user_group;
	}
	public String getApp_create_time() {
		return app_create_time;
	}
	public void setApp_create_time(String app_create_time) {
		this.app_create_time = app_create_time;
	}
	public String getApp_delete_time() {
		return app_delete_time;
	}
	public void setApp_delete_time(String app_delete_time) {
		this.app_delete_time = app_delete_time;
	}
	public String getApp_ismain() {
		return app_ismain;
	}
	public void setApp_ismain(String app_ismain) {
		this.app_ismain = app_ismain;
	}
	public JSONObject getJson() {
		return json;
	}
	public void setJson(JSONObject json) {
		this.json = json;
	}
	public String getLocal_ip() {
		return local_ip;
	}
	public void setLocal_ip(String local_ip) {
		this.local_ip = local_ip;
	}
	public String getLocal_port() {
		return local_port;
	}
	public void setLocal_port(String local_port) {
		this.local_port = local_port;
	}
	public String getApp_first_gps() {
		return app_first_gps;
	}
	public void setApp_first_gps(String app_first_gps) {
		this.app_first_gps = app_first_gps;
	}
}
