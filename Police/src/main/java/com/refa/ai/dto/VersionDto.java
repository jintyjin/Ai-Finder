package com.refa.ai.dto;

public class VersionDto {
	private int version_idx;
	private String version_name;
	private String client_code;
	private String request_url;
	private String analyze_url;
	public int getVersion_idx() {
		return version_idx;
	}
	public void setVersion_idx(int version_idx) {
		this.version_idx = version_idx;
	}
	public String getVersion_name() {
		return version_name;
	}
	public void setVersion_name(String version_name) {
		this.version_name = version_name;
	}
	public String getClient_code() {
		return client_code;
	}
	public void setClient_code(String client_code) {
		this.client_code = client_code;
	}
	public String getRequest_url() {
		return request_url;
	}
	public void setRequest_url(String request_url) {
		this.request_url = request_url;
	}
	public String getAnalyze_url() {
		return analyze_url;
	}
	public void setAnalyze_url(String analyze_url) {
		this.analyze_url = analyze_url;
	}
	
	
}
