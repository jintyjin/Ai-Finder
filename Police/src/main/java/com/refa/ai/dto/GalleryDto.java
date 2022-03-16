package com.refa.ai.dto;

import java.util.ArrayList;

public class GalleryDto {
	private String gallery_idx;
	private String gallery_path;
	private String login_id;
	private String tags; 
	private String object_list; 
	
	public String getTags() {
		return tags;
	}
	public void setTags(String tags) {
		this.tags = tags;
	}
	public String getGallery_idx() {
		return gallery_idx;
	}
	public void setGallery_idx(String gallery_idx) {
		this.gallery_idx = gallery_idx;
	}
	public String getGallery_path() {
		return gallery_path;
	}
	public void setGallery_path(String gallery_path) {
		this.gallery_path = gallery_path;
	}
	public String getLogin_id() {
		return login_id;
	}
	public void setLogin_id(String login_id) {
		this.login_id = login_id;
	}
	public String getObject_list() {
		return object_list;
	}
	public void setObject_list(String object_list) {
		this.object_list = object_list;
	}
}
