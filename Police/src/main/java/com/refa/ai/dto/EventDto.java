package com.refa.ai.dto;

import org.springframework.web.multipart.MultipartFile;

public class EventDto {
	private int data_idx;
	private String item_type;
	private String item_name;
	private String item_mac;
	private String item_ip;
	private String item_id;
	private String item_pwd;
	private String item_port;
	private String dev_ip;
	private String dev_mac;
	private String dev_id;
	private String dev_pwd;
	private String dev_port;
	private String dev_channel;
	private String user_id;
	private String event_name;
	private String event_info;
	private String event_time;
	private String event_isCheck;
	/* private String file; */
	private String image_name;
	private String img_data;
	private String img_type;
	private String image_before;
	
	public int getData_idx() {
		return data_idx;
	}
	public void setData_idx(int data_idx) {
		this.data_idx = data_idx;
	}
	public String getItem_type() {
		return item_type;
	}
	public void setItem_type(String item_type) {
		this.item_type = item_type;
	}
	public String getItem_name() {
		return item_name;
	}
	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}
	public String getItem_mac() {
		return item_mac;
	}
	public void setItem_mac(String item_mac) {
		this.item_mac = item_mac;
	}
	public String getItem_ip() {
		return item_ip;
	}
	public void setItem_ip(String item_ip) {
		this.item_ip = item_ip;
	}
	public String getItem_id() {
		return item_id;
	}
	public void setItem_id(String item_id) {
		this.item_id = item_id;
	}
	public String getItem_pwd() {
		return item_pwd;
	}
	public void setItem_pwd(String item_pwd) {
		this.item_pwd = item_pwd;
	}
	public String getItem_port() {
		return item_port;
	}
	public void setItem_port(String item_port) {
		this.item_port = item_port;
	}
	public String getDev_ip() {
		return dev_ip;
	}
	public void setDev_ip(String dev_ip) {
		this.dev_ip = dev_ip;
	}
	public String getDev_mac() {
		return dev_mac;
	}
	public void setDev_mac(String dev_mac) {
		this.dev_mac = dev_mac;
	}
	public String getDev_id() {
		return dev_id;
	}
	public void setDev_id(String dev_id) {
		this.dev_id = dev_id;
	}
	public String getDev_pwd() {
		return dev_pwd;
	}
	public void setDev_pwd(String dev_pwd) {
		this.dev_pwd = dev_pwd;
	}
	public String getDev_port() {
		return dev_port;
	}
	public void setDev_port(String dev_port) {
		this.dev_port = dev_port;
	}
	public String getDev_channel() {
		return dev_channel;
	}
	public void setDev_channel(String dev_channel) {
		this.dev_channel = dev_channel;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getEvent_name() {
		return event_name;
	}
	public void setEvent_name(String event_name) {
		this.event_name = event_name;
	}
	public String getEvent_info() {
		return event_info;
	}
	public void setEvent_info(String event_info) {
		this.event_info = event_info;
	}
	public String getEvent_time() {
		return event_time;
	}
	public void setEvent_time(String event_time) {
		this.event_time = event_time;
	}
	public String getEvent_isCheck() {
		return event_isCheck;
	}
	public void setEvent_isCheck(String event_isCheck) {
		this.event_isCheck = event_isCheck;
	}

	/*
	 * public String getFile() { return file; } public void setFile(String file) {
	 * this.file = file; }
	 */
	public String getImage_name() {
		return image_name;
	}
	public void setImage_name(String image_name) {
		this.image_name = image_name;
	}
	public String getImg_data() {
		return img_data;
	}
	public void setImg_data(String img_data) {
		this.img_data = img_data;
	}
	public String getImg_type() {
		return img_type;
	}
	public void setImg_type(String img_type) {
		this.img_type = img_type;
	}
	public String getImage_before() {
		return image_before;
	}
	public void setImage_before(String image_before) {
		this.image_before = image_before;
	}
}
