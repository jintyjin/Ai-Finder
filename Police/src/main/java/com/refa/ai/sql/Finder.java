package com.refa.ai.sql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;

import com.refa.ai.dto.AppUserInfoDto;
import com.refa.ai.dto.GalleryImageInfoDto;
import com.refa.ai.dto.ReceiveGpsInfoDto;
import com.refa.ai.dto.RoomGpsInfoDto;
import com.refa.ai.dto.RoomInfoDto;
import com.refa.ai.dto.RoomUserInfoDto;

public class Finder {
	public void insertDashInfo(GalleryImageInfoDto galleryImageInfoDto) {
	    String url = "jdbc:postgresql://localhost:5432/postgres";
	    String user = "postgres";
	    String password = "1234";
	    Connection conn2 = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO police.galleryimageinfo(" + 
				" gallery_favorites, gallery_login_id, gallery_img_name, gallery_crop_name, gallery_bbox, gallery_confidence, gallery_x, gallery_y, gallery_class_name, gallery_width, gallery_height, gallery_tags, gallery_hwidth, gallery_hheight, gallery_case_num, gallery_roinum) " + 
				" VALUES ('" + galleryImageInfoDto.getGallery_favorites() + "', '" + galleryImageInfoDto.getGallery_login_id() + "', '" + galleryImageInfoDto.getGallery_img_name() + "', '" + galleryImageInfoDto.getGallery_crop_name() + "', "
						+ " '" + "{" + Arrays.toString(galleryImageInfoDto.getGallery_bbox()).substring(1, Arrays.toString(galleryImageInfoDto.getGallery_bbox()).lastIndexOf("]")) + "}" + "'::int[], '" + galleryImageInfoDto.getGallery_confidence() + "', '" + galleryImageInfoDto.getGallery_x() + "', '" + galleryImageInfoDto.getGallery_y() + "', '" + galleryImageInfoDto.getGallery_class_name() + "', '" + galleryImageInfoDto.getGallery_width()
						+ "', '" + galleryImageInfoDto.getGallery_height() + "', '" + "{"+ Arrays.toString(galleryImageInfoDto.getGallery_tags()).substring(1, Arrays.toString(galleryImageInfoDto.getGallery_tags()).lastIndexOf("]")) + "}" + "'::text[], '" + galleryImageInfoDto.getGallery_hWidth() + "', '" + galleryImageInfoDto.getGallery_hHeight() + "', '" + galleryImageInfoDto.getGallery_case_num() + "', '" + galleryImageInfoDto.getGallery_roiNum() + "');" ;

        try {
			conn2 = DriverManager.getConnection(url, user, password);
			conn2.setAutoCommit(false);
			pstmt = conn2.prepareStatement(sql);
			pstmt.executeUpdate();
			conn2.commit();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
        	try {
				pstmt.close();
	            conn2.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public ArrayList<ReceiveGpsInfoDto> selectReceiveGpsInfoList(ReceiveGpsInfoDto receiveGpsInfoDto, Connection conn) {
		//Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ReceiveGpsInfoDto> list = new ArrayList<ReceiveGpsInfoDto>();
		
		String sql = "select * "
				+ " from police.receivegpsinfo "
				+ " where to_char(receive_gps_time, 'YYYY-MM-DD') = to_char('" + receiveGpsInfoDto.getReceive_gps_time() + "'::timestamp(0), 'YYYY-MM-DD') ";
		
        try {
			//conn = DriverManager.getConnection(url, user, password);
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				ReceiveGpsInfoDto receiveGpsInfoDto2 = new ReceiveGpsInfoDto();
				int receive_gps_idx = rs.getInt("receive_gps_idx");
				String receive_user_name = rs.getString("receive_user_name");
				String receive_room_name = rs.getString("receive_room_name");
				int receive_room_idx = rs.getInt("receive_room_idx");
				String receive_gps_la = rs.getString("receive_gps_la");
				String receive_gps_ma = rs.getString("receive_gps_ma");
				String receive_gps_time = rs.getString("receive_gps_time");

				receiveGpsInfoDto2.setReceive_gps_la(receive_gps_la);
				receiveGpsInfoDto2.setReceive_gps_ma(receive_gps_ma);
				receiveGpsInfoDto2.setReceive_gps_time(receive_gps_time);
				receiveGpsInfoDto2.setReceive_room_name(receive_room_name);
				receiveGpsInfoDto2.setReceive_user_name(receive_user_name);
				receiveGpsInfoDto2.setReceive_gps_time(receive_gps_time);
				receiveGpsInfoDto2.setReceive_room_idx(receive_room_idx);
				
				list.add(receiveGpsInfoDto2);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
        	try {
				pstmt.close();
	            //conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        
        return list;
	}

	public ArrayList<ReceiveGpsInfoDto> selectReceiveGpsInfoList3(ReceiveGpsInfoDto receiveGpsInfoDto, Connection conn) {
		//Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ReceiveGpsInfoDto> list = new ArrayList<ReceiveGpsInfoDto>();
		
		String sql = "select * from police.receivegpsinfo "
				+ " where to_char(receive_gps_time, 'YYYY-MM-DD') >= to_char('" + receiveGpsInfoDto.getReceive_gps_la() + "'::timestamp(0), 'YYYY-MM-DD') and "
				+ " to_char(receive_gps_time, 'YYYY-MM-DD') <= to_char('" + receiveGpsInfoDto.getReceive_gps_ma() + "'::timestamp(0), 'YYYY-MM-DD') "
				+ " order by receive_gps_idx asc;";
		
        try {
			//conn = DriverManager.getConnection(url, user, password);
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				ReceiveGpsInfoDto receiveGpsInfoDto2 = new ReceiveGpsInfoDto();
				int receive_gps_idx = rs.getInt("receive_gps_idx");
				String receive_user_name = rs.getString("receive_user_name");
				String receive_room_name = rs.getString("receive_room_name");
				int receive_room_idx = rs.getInt("receive_room_idx");
				String receive_gps_la = rs.getString("receive_gps_la");
				String receive_gps_ma = rs.getString("receive_gps_ma");
				String receive_gps_time = rs.getString("receive_gps_time");

				receiveGpsInfoDto2.setReceive_gps_la(receive_gps_la);
				receiveGpsInfoDto2.setReceive_gps_ma(receive_gps_ma);
				receiveGpsInfoDto2.setReceive_gps_time(receive_gps_time);
				receiveGpsInfoDto2.setReceive_room_name(receive_room_name);
				receiveGpsInfoDto2.setReceive_user_name(receive_user_name);
				receiveGpsInfoDto2.setReceive_gps_time(receive_gps_time);
				
				list.add(receiveGpsInfoDto2);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
        	try {
				pstmt.close();
	            //conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        
        return list;
	}
	
	public ReceiveGpsInfoDto insertReceiveGpsInfo(RoomGpsInfoDto roomGpsInfoDto, Connection conn) {
	    String url = "jdbc:postgresql://localhost:5432/postgres";
	    String user = "postgres";
	    String password = "1234";
	    Connection conn2 = null;
		PreparedStatement pstmt = null;
		ReceiveGpsInfoDto receiveGpsInfoDto2 = new ReceiveGpsInfoDto();
		ResultSet rs = null;
		String sql ="with rows as (" +  
				"INSERT INTO police.receivegpsinfo "
				+ " (receive_user_name, receive_room_name, receive_room_idx, receive_gps_la, receive_gps_ma, receive_gps_time, app_user_group) "
				+ " values ('" + roomGpsInfoDto.getRoom_user_name() + "', '" + roomGpsInfoDto.getRoom_name() + "', " + roomGpsInfoDto.getRoom_idx() + " , '" + roomGpsInfoDto.getRoom_gps_la() + "', "
				+ " '" + roomGpsInfoDto.getRoom_gps_ma() + "', '" + roomGpsInfoDto.getRoom_gps_time() + "', '" + roomGpsInfoDto.getApp_user_group() + "')"
				+ " returning * )"
				+ " select * from rows;";

        try {
			conn2 = DriverManager.getConnection(url, user, password);
			pstmt = conn2.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				receiveGpsInfoDto2.setReceive_user_name(rs.getString("receive_user_name"));
				receiveGpsInfoDto2.setReceive_room_name(rs.getString("receive_room_name"));
				receiveGpsInfoDto2.setReceive_room_idx(rs.getInt("receive_room_idx"));
				receiveGpsInfoDto2.setReceive_gps_la(rs.getString("receive_gps_la"));
				receiveGpsInfoDto2.setReceive_gps_ma(rs.getString("receive_gps_ma"));
				receiveGpsInfoDto2.setReceive_gps_time(rs.getString("receive_gps_time"));
				receiveGpsInfoDto2.setApp_user_group(rs.getString("app_user_group"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
        	try {
				pstmt.close();
	            conn2.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        return receiveGpsInfoDto2;
	}

	public ArrayList<String> selectSituationData(ReceiveGpsInfoDto receiveGpsInfoDto, Connection conn) {
		//Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<String> list = new ArrayList<String>();
		
		String sql = "select gallery_json from police.galleryinfo "
				+ " where \"gallery_json\" ->> 'wtmX' != 'null' and \"gallery_json\" ->> 'wtmY' != 'null' and to_char((\"gallery_json\" ->> 'imgTime')::timestamp(0), 'YYYY-MM-DD') =  "
				+ " to_char('" + receiveGpsInfoDto.getReceive_gps_time() + "'::timestamp(0), 'YYYY-MM-DD') "
				+ " order by gallery_idx asc";
		
        try {
			//conn = DriverManager.getConnection(url, user, password);
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				list.add(rs.getString("gallery_json"));
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
        	try {
				pstmt.close();
	            //conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        
        return list;
	}

	public ArrayList<String> selectReceiveGpsInfoList2(ReceiveGpsInfoDto receiveGpsInfoDto, Connection conn) {
		//Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<String> list = new ArrayList<String>();
		
		String sql = "select gallery_json from police.galleryinfo "
				+ " where \"gallery_json\" ->> 'wtmX' != 'null' and \"gallery_json\" ->> 'wtmY' != 'null' and "
				+ " to_char((\"gallery_json\" ->> 'imgTime')::timestamp(0), 'YYYY-MM-DD') >= " + " to_char('" + receiveGpsInfoDto.getReceive_gps_la() + "'::timestamp(0), 'YYYY-MM-DD') "
				+ " and to_char((\"gallery_json\" ->> 'imgTime')::timestamp(0), 'YYYY-MM-DD') <= " + " to_char('" + receiveGpsInfoDto.getReceive_gps_ma() + "'::timestamp(0), 'YYYY-MM-DD') "
				+ " order by gallery_idx asc";
		
        try {
			//conn = DriverManager.getConnection(url, user, password);
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				list.add(rs.getString("gallery_json"));
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
        	try {
				pstmt.close();
	            //conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        
        return list;
	}

	public String selectAnalyzeContent(String case_num, Connection conn) {
		//Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String analyze_content = "";
		
		String sql = "select \"case_json\" ->> 'analyze_content' analyze_content from police.caseinfo "
				+ " where \"case_json\" ->> 'case_num' = '" + case_num + "'";
		
        try {
			//conn = DriverManager.getConnection(url, user, password);
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				analyze_content = rs.getString("analyze_content");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
        	try {
				pstmt.close();
	            //conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        
        return analyze_content;
	}

	public AppUserInfoDto pol_login(AppUserInfoDto appUserInfoDto, Connection conn) {
		//Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		AppUserInfoDto appUserInfoDto2 = null;
		
		String sql = "select * from police.appuserinfo " + 
				"where app_user_id = '" + appUserInfoDto.getApp_user_id() + "'";
		
        try {
			//conn = DriverManager.getConnection(url, user, password);
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				int app_user_idx = rs.getInt("app_user_idx");
				String app_user_id = rs.getString("app_user_id");
				String app_user_pwd = rs.getString("app_user_pwd");
				String app_user_group = rs.getString("app_user_group");
				String app_create_time = rs.getString("app_create_time");
				String app_delete_time = rs.getString("app_delete_time");
				String app_ismain = rs.getString("app_ismain");
				String app_first_gps = rs.getString("app_first_gps");
				
				appUserInfoDto2 = new AppUserInfoDto();
				appUserInfoDto2.setApp_user_idx(app_user_idx);
				appUserInfoDto2.setApp_create_time(app_create_time);
				appUserInfoDto2.setApp_delete_time(app_delete_time);
				appUserInfoDto2.setApp_ismain(app_ismain);
				appUserInfoDto2.setApp_user_group(app_user_group);
				appUserInfoDto2.setApp_user_id(app_user_id);
				appUserInfoDto2.setApp_user_pwd(app_user_pwd);
				appUserInfoDto2.setApp_first_gps(app_first_gps);
				
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
        	try {
				pstmt.close();
	            //conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        
        return appUserInfoDto2;
	}
}
