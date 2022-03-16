package com.refa.ai.dto;

public class GalleryImageInfoDto {
	private int gallery_idx;
	private String gallery_favorites;
	private String gallery_login_id;
	private String gallery_img_name;
	private String gallery_crop_name;
	private int[] gallery_bbox;
	private double gallery_confidence;
	private int gallery_x;
	private int gallery_y;
	private String gallery_class_name;
	private int gallery_width;
	private int gallery_height;
	private String[] gallery_tags;
	private int gallery_hWidth;
	private int gallery_hHeight;
	private String gallery_case_num;
	private int gallery_roiNum;
	
	public int getGallery_idx() {
		return gallery_idx;
	}
	public void setGallery_idx(int gallery_idx) {
		this.gallery_idx = gallery_idx;
	}
	public String getGallery_favorites() {
		return gallery_favorites;
	}
	public void setGallery_favorites(String gallery_favorites) {
		this.gallery_favorites = gallery_favorites;
	}
	public String getGallery_login_id() {
		return gallery_login_id;
	}
	public void setGallery_login_id(String gallery_login_id) {
		this.gallery_login_id = gallery_login_id;
	}
	public String getGallery_img_name() {
		return gallery_img_name;
	}
	public void setGallery_img_name(String gallery_img_name) {
		this.gallery_img_name = gallery_img_name;
	}
	public String getGallery_crop_name() {
		return gallery_crop_name;
	}
	public void setGallery_crop_name(String gallery_crop_name) {
		this.gallery_crop_name = gallery_crop_name;
	}
	public int[] getGallery_bbox() {
		return gallery_bbox;
	}
	public void setGallery_bbox(int[] gallery_bbox) {
		this.gallery_bbox = gallery_bbox;
	}
	public double getGallery_confidence() {
		return gallery_confidence;
	}
	public void setGallery_confidence(double gallery_confidence) {
		this.gallery_confidence = gallery_confidence;
	}
	public int getGallery_x() {
		return gallery_x;
	}
	public void setGallery_x(int gallery_x) {
		this.gallery_x = gallery_x;
	}
	public int getGallery_y() {
		return gallery_y;
	}
	public void setGallery_y(int gallery_y) {
		this.gallery_y = gallery_y;
	}
	public String getGallery_class_name() {
		return gallery_class_name;
	}
	public void setGallery_class_name(String gallery_class_name) {
		this.gallery_class_name = gallery_class_name;
	}
	public int getGallery_width() {
		return gallery_width;
	}
	public void setGallery_width(int gallery_width) {
		this.gallery_width = gallery_width;
	}
	public int getGallery_height() {
		return gallery_height;
	}
	public void setGallery_height(int gallery_height) {
		this.gallery_height = gallery_height;
	}
	public String[] getGallery_tags() {
		return gallery_tags;
	}
	public void setGallery_tags(String[] gallery_tags) {
		this.gallery_tags = gallery_tags;
	}
	public int getGallery_hWidth() {
		return gallery_hWidth;
	}
	public void setGallery_hWidth(int gallery_hWidth) {
		this.gallery_hWidth = gallery_hWidth;
	}
	public int getGallery_hHeight() {
		return gallery_hHeight;
	}
	public void setGallery_hHeight(int gallery_hHeight) {
		this.gallery_hHeight = gallery_hHeight;
	}
	public String getGallery_case_num() {
		return gallery_case_num;
	}
	public void setGallery_case_num(String gallery_case_num) {
		this.gallery_case_num = gallery_case_num;
	}
	public int getGallery_roiNum() {
		return gallery_roiNum;
	}
	public void setGallery_roiNum(int gallery_roiNum) {
		this.gallery_roiNum = gallery_roiNum;
	}	
}
