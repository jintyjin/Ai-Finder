package com.refa.ai.sql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.refa.ai.dto.*;

public class PolFinder {

	public int insertRoomInfo(RoomInfoDto roomInfoDto, Connection conn) {
	    String url = "jdbc:postgresql://localhost:5432/postgres";
	    String user = "postgres";
	    String password = "1234";
	    Connection conn2 = null;
		PreparedStatement pstmt = null;
		String sql = "with rows as ("
				+ "INSERT INTO police.roominfo ("
				+ "room_name, room_user_name, room_pwd, room_close_date) "
				+ " select '" + roomInfoDto.getRoom_name() + "', '" + roomInfoDto.getRoom_user_name() + "', '" + roomInfoDto.getRoom_pwd() + "', '" + roomInfoDto.getRoom_close_date()
				+ "' where not exists (select * from police.roominfo where room_name = '" + roomInfoDto.getRoom_name() + "' and room_isclose = 'N')"
				+ " returning room_idx)"
				+ " select * from rows;"; 

		ResultSet rs = null;
		int room_idx = -1;
		
        try {
			conn2 = DriverManager.getConnection(url, user, password);
			pstmt = conn2.prepareStatement(sql);
			//pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				room_idx = rs.getInt("room_idx");
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
        
        return room_idx;
	}

	public int insertRoomUserInfo(RoomUserInfoDto roomUserInfoDto, Connection conn) {
		//Connection conn = null;
		PreparedStatement pstmt = null;
		int count = 0;
	    String url = "jdbc:postgresql://localhost:5432/postgres";
	    String user = "postgres";
	    String password = "1234";
	    Connection conn2 = null;
		
		String sql = "with upsert as (update police.roomuserinfo set room_isexit = 'N', room_recent_time = now(), "
				+ " room_recent_gps = case when room_recent_gps != ? then ? else room_recent_gps end, room_gps = case when room_recent_gps != ? then ? else room_gps end where room_user_name = ? and room_name = ? and room_idx = (select room_idx from police.roominfo where room_name = ? and room_isclose = 'N' order by room_idx desc limit 1) " + 
				" returning *) " + 
				" INSERT INTO police.roomuserinfo (room_user_name, room_name, room_idx, room_recent_gps, room_gps, room_isadmin) " + 
				" select ?, ?, (select room_idx from police.roominfo where room_name = ? and room_isclose = 'N' order by room_idx desc limit 1), ?, ?, ?" + 
				" where not exists (select * from upsert);";
		
        try {
			conn2 = DriverManager.getConnection(url, user, password);
			//pstmt = conn.prepareStatement(sql);
			pstmt = conn2.prepareStatement(sql);
		    conn2.setAutoCommit(false);

			pstmt.setString(1, roomUserInfoDto.getRoom_recent_gps());
			pstmt.setString(2, roomUserInfoDto.getRoom_recent_gps());
			pstmt.setString(3, roomUserInfoDto.getRoom_recent_gps());
			pstmt.setString(4, roomUserInfoDto.getRoom_recent_gps());
			pstmt.setString(5, roomUserInfoDto.getRoom_user_name());
			pstmt.setString(6, roomUserInfoDto.getRoom_name());
			pstmt.setString(7, roomUserInfoDto.getRoom_name());
			pstmt.setString(8, roomUserInfoDto.getRoom_user_name());
			pstmt.setString(9, roomUserInfoDto.getRoom_name());
			pstmt.setString(10, roomUserInfoDto.getRoom_name());
			pstmt.setString(11, roomUserInfoDto.getRoom_recent_gps());
			pstmt.setString(12, roomUserInfoDto.getRoom_gps());
			pstmt.setString(13, roomUserInfoDto.getRoom_isadmin());
			
			count = pstmt.executeUpdate();
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
        return count;
	}

	public ArrayList<RoomUserInfoDto> pol_getRoomUser(RoomInfoDto roomInfoDto, Connection conn) {
		//Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<RoomUserInfoDto> list = new ArrayList<RoomUserInfoDto>();
	    String url = "jdbc:postgresql://localhost:5432/postgres";
	    String user = "postgres";
	    String password = "1234";
	    Connection conn2 = null;
		
		String sql = "select room_user_name, room_name, room_idx, room_recent_gps, room_gps, room_isadmin, room_isexit "
				+ " from police.roomuserinfo "
				+ " where room_idx = " + roomInfoDto.getRoom_idx()	// + " and room_isexit = '" + roomInfoDto.getRoom_isexit() + "' "
				+ " order by case when room_user_name = '" + roomInfoDto.getRoom_user_name() + "' then 1 else 0 end, room_user_idx desc;";
		
        try {
			conn2 = DriverManager.getConnection(url, user, password);
			//pstmt = conn.prepareStatement(sql);
        	pstmt = conn2.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				RoomUserInfoDto roomUserInfoDto = new RoomUserInfoDto();
				String room_name = rs.getString("room_name");
				String room_user_name = rs.getString("room_user_name");
				String room_isadmin = rs.getString("room_isadmin");
				String room_recent_gps = rs.getString("room_recent_gps");
				String room_gps = rs.getString("room_gps");
				int room_idx = rs.getInt("room_idx");
				String room_isexit = rs.getString("room_isexit");
				
				roomUserInfoDto.setRoom_name(room_name);
				roomUserInfoDto.setRoom_user_name(room_user_name);
				roomUserInfoDto.setRoom_isadmin(room_isadmin);
				roomUserInfoDto.setRoom_recent_gps(room_recent_gps);
				roomUserInfoDto.setRoom_gps(room_gps);
				roomUserInfoDto.setRoom_idx(room_idx);
				roomUserInfoDto.setRoom_isexit(room_isexit);
				
				list.add(roomUserInfoDto);
			}
		} catch (Exception e) {
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
        
        return list;
	}

	public ArrayList<RoomInfoDto> getAllRoomInfo(AppUserInfoDto appUserInfoDto, Connection conn) {
		//Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<RoomInfoDto> list = new ArrayList<RoomInfoDto>();

	    String url = "jdbc:postgresql://localhost:5432/postgres";
	    String user = "postgres";
	    String password = "1234";
	    Connection conn2 = null;
	    
		String sql = "select room_idx, room_name, room_user_name, room_count, room_create_date, room_close_date, room_isclose "
				+ " from police.roominfo "
				+ " where room_isclose = 'N' and app_user_group = '" + appUserInfoDto.getApp_user_group() + "' "
				+ " order by room_idx desc";
	
        try {
			conn2 = DriverManager.getConnection(url, user, password);
			//pstmt = conn.prepareStatement(sql);
			pstmt = conn2.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				RoomInfoDto roomInfoDto = new RoomInfoDto();
				roomInfoDto.setRoom_idx(rs.getInt("room_idx"));
				roomInfoDto.setRoom_name(rs.getString("room_name"));
				roomInfoDto.setRoom_user_name(rs.getString("room_user_name"));
				roomInfoDto.setRoom_count(rs.getInt("room_count"));
				roomInfoDto.setRoom_create_date(rs.getString("room_create_date"));
				roomInfoDto.setRoom_close_date(rs.getString("room_close_date"));
				roomInfoDto.setRoom_isclose(rs.getString("room_isclose"));
				
				list.add(roomInfoDto);
			}
		} catch (Exception e) {
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
        
        return list;
	}

	public ArrayList<RoomInfoDto> getRoomInfo(RoomUserInfoDto roomUserDto, Connection conn) {
		//Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<RoomInfoDto> list = new ArrayList<RoomInfoDto>();
	    String url = "jdbc:postgresql://localhost:5432/postgres";
	    String user = "postgres";
	    String password = "1234";
	    Connection conn2 = null;
		
		String sql = "select room_pwd "
				+ " from police.roominfo "
				+ " where room_isclose = 'N' and room_idx = " + roomUserDto.getRoom_user_idx()
				+ " order by room_idx desc";
	
        try {
			conn2 = DriverManager.getConnection(url, user, password);
			pstmt = conn2.prepareStatement(sql);
			//pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				RoomInfoDto roomInfoDto = new RoomInfoDto();
				roomInfoDto.setRoom_pwd(rs.getString("room_pwd"));
				
				list.add(roomInfoDto);
			}
		} catch (Exception e) {
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
        
        return list;
	}

	public ArrayList<RoomInfoDto> getSearchRoom(String keyword, Connection conn) {
		//Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<RoomInfoDto> list = new ArrayList<RoomInfoDto>();
	    String url = "jdbc:postgresql://localhost:5432/postgres";
	    String user = "postgres";
	    String password = "1234";
	    Connection conn2 = null;

		String sql = "select room_idx, room_name, room_user_name, room_count, room_create_date, room_close_date, room_isclose "
				+ " from police.roominfo "
				+ " where room_isclose = 'N' and room_name like '%' || '" + keyword + "' || '%'"
				+ " order by room_idx desc;";
	
        try {
			conn2 = DriverManager.getConnection(url, user, password);
			pstmt = conn2.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				RoomInfoDto roomInfoDto = new RoomInfoDto();
				roomInfoDto.setRoom_idx(rs.getInt("room_idx"));
				roomInfoDto.setRoom_name(rs.getString("room_name"));
				roomInfoDto.setRoom_user_name(rs.getString("room_user_name"));
				roomInfoDto.setRoom_count(rs.getInt("room_count"));
				roomInfoDto.setRoom_create_date(rs.getString("room_create_date"));
				roomInfoDto.setRoom_close_date(rs.getString("room_close_date"));
				roomInfoDto.setRoom_isclose(rs.getString("room_isclose"));
				
				list.add(roomInfoDto);
			}
		} catch (Exception e) {
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
        
        return list;
	}
	
	public void exitRoom(RoomUserInfoDto roomUserInfoDto, Connection conn) {
	    String url = "jdbc:postgresql://localhost:5432/postgres";
	    String user = "postgres";
	    String password = "1234";
	    Connection conn2 = null;
		PreparedStatement pstmt = null;
		String sql = "update police.roomuserinfo "
				+ " set room_isexit = 'Y', room_exit_time = now() "
				+ " where room_user_name = ? and room_name = ? and room_idx = ? and room_isexit = 'N';";
		
        try {
			conn2 = DriverManager.getConnection(url, user, password);
		    conn2.setAutoCommit(false);
			pstmt = conn2.prepareStatement(sql);

			pstmt.setString(1, roomUserInfoDto.getRoom_user_name());
			pstmt.setString(2, roomUserInfoDto.getRoom_name());
			pstmt.setInt(3, roomUserInfoDto.getRoom_idx());

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

	public void closeRoom(RoomUserInfoDto roomUserInfoDto, Connection conn) {
	    String url = "jdbc:postgresql://localhost:5432/postgres";
	    String user = "postgres";
	    String password = "1234";
	    Connection conn2 = null;
		PreparedStatement pstmt = null;
		
		String sql = "update police.roominfo "
				+ " set room_isclose = 'Y', room_close_date = now()::timestamp(0) "
				+ " where room_idx = ?;";

		ResultSet rs = null;

        try {
			conn2 = DriverManager.getConnection(url, user, password);
		    conn2.setAutoCommit(false);
			pstmt = conn2.prepareStatement(sql);

			pstmt.setInt(1, roomUserInfoDto.getRoom_idx());
			
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

	public void exitAllUser(RoomUserInfoDto roomUserInfoDto, Connection conn) {
	    String url = "jdbc:postgresql://localhost:5432/postgres";
	    String user = "postgres";
	    String password = "1234";
	    Connection conn2 = null;
		PreparedStatement pstmt = null;
		String sql = "update police.roomuserinfo "
				+ " set room_isexit = 'Y', room_exit_time = now() "
				+ " where room_idx = ?;";
		
        try {
			conn2 = DriverManager.getConnection(url, user, password);
		    conn2.setAutoCommit(false);
			pstmt = conn2.prepareStatement(sql);

			pstmt.setInt(1, roomUserInfoDto.getRoom_idx());
			
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

	public void updateUserCount(RoomUserInfoDto roomUserInfoDto, Connection conn) {
		//Connection conn = null;
	    String url = "jdbc:postgresql://localhost:5432/postgres";
	    String user = "postgres";
	    String password = "1234";
	    Connection conn2 = null;
		PreparedStatement pstmt = null;
		String sql = "update police.roominfo "
				+ " set room_count = room_count + 1 "
				+ " where room_idx = ?;";
		
        try {
			conn2 = DriverManager.getConnection(url, user, password);
		    conn2.setAutoCommit(false);
			pstmt = conn2.prepareStatement(sql);

			System.out.println("roomUserInfoDto.getRoom_user_idx() = " + roomUserInfoDto.getRoom_user_idx());
			
			pstmt.setInt(1, roomUserInfoDto.getRoom_user_idx());
			
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

	public void updateUserCountMinus(RoomUserInfoDto roomUserInfoDto, Connection conn) {
	    String url = "jdbc:postgresql://localhost:5432/postgres";
	    String user = "postgres";
	    String password = "1234";
	    Connection conn2 = null;
		PreparedStatement pstmt = null;
		String sql = "update police.roominfo "
				+ " set room_count = room_count - 1 "
				+ " where room_idx = ?;";
		
        try {
			conn2 = DriverManager.getConnection(url, user, password);
		    conn2.setAutoCommit(false);
			pstmt = conn2.prepareStatement(sql);

			pstmt.setInt(1, roomUserInfoDto.getRoom_idx());
			
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

	public RoomGpsInfoDto getUserInfoOne(RoomUserInfoDto roomUserInfoDto, Connection conn) {
	    String url = "jdbc:postgresql://localhost:5432/postgres";
	    String user = "postgres";
	    String password = "1234";
	    Connection conn2 = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		RoomGpsInfoDto roomGpsInfoDto = new RoomGpsInfoDto();

		String sql = "select * "
				+ " from police.roomgpsinfo "
				+ " where room_user_name = '" + roomUserInfoDto.getRoom_user_name() + "' and room_idx = (select room_idx from police.roominfo where room_name = '" + roomUserInfoDto.getRoom_name() + "' and room_isclose = 'N' order by room_idx desc limit 1) and room_isexit = 'N' "
				+ " order by room_gps_idx desc limit 1;";
	
        try {
			conn2 = DriverManager.getConnection(url, user, password);
			pstmt = conn2.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				roomGpsInfoDto.setRoom_user_name(rs.getString("room_user_name"));
				roomGpsInfoDto.setRoom_name(rs.getString("room_name"));
				roomGpsInfoDto.setRoom_idx(rs.getInt("room_idx"));
				roomGpsInfoDto.setRoom_gps_la(rs.getString("room_gps_la"));
				roomGpsInfoDto.setRoom_gps_ma(rs.getString("room_gps_ma"));
				roomGpsInfoDto.setRoom_isadmin(rs.getString("room_isadmin"));
			}
		} catch (Exception e) {
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
        
        return roomGpsInfoDto;
	}
	
	public RoomUserInfoDto getRoomInfoOne(RoomInfoDto roomInfoDto, Connection conn) {
	    String url = "jdbc:postgresql://localhost:5432/postgres";
	    String user = "postgres";
	    String password = "1234";
	    Connection conn2 = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		RoomUserInfoDto roomUserInfoDto = new RoomUserInfoDto();

		String sql = "select * "
				+ " from police.roominfo "
				+ " where room_name = '" + roomInfoDto.getRoom_name() + "' and room_user_name = '" + roomInfoDto.getRoom_user_name() + "' and room_isclose = 'N' "
				+ " order by room_idx desc limit 1;";
	
        try {
			conn2 = DriverManager.getConnection(url, user, password);
			pstmt = conn2.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				roomUserInfoDto.setRoom_idx(rs.getInt("room_idx"));
				roomUserInfoDto.setRoom_name(rs.getString("room_name"));
				roomUserInfoDto.setRoom_user_name(rs.getString("room_user_name"));
			}
		} catch (Exception e) {
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
        
        return roomUserInfoDto;
	}

	public void exitAllGps(RoomUserInfoDto roomUserInfoDto, Connection conn) {
	    String url = "jdbc:postgresql://localhost:5432/postgres";
	    String user = "postgres";
	    String password = "1234";
	    Connection conn2 = null;
		PreparedStatement pstmt = null;
		String sql = "update police.roomgpsinfo "
				+ " set room_isexit = 'Y', room_isclose = 'Y'"
				+ " where room_idx = ?;";
		
        try {
			conn2 = DriverManager.getConnection(url, user, password);
		    conn2.setAutoCommit(false);
			pstmt = conn2.prepareStatement(sql);

			pstmt.setInt(1, roomUserInfoDto.getRoom_idx());
			
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
	public void exitGps(RoomUserInfoDto roomUserInfoDto, Connection conn) {
	    String url = "jdbc:postgresql://localhost:5432/postgres";
	    String user = "postgres";
	    String password = "1234";
	    Connection conn2 = null;
		PreparedStatement pstmt = null;
		String sql = "update police.roomgpsinfo "
				+ " set room_isexit = 'Y' "
				+ " where room_user_name = ? and room_name = ? and room_idx = ? and room_isexit = 'N';";
		
        try {
			conn2 = DriverManager.getConnection(url, user, password);
		    conn2.setAutoCommit(false);
			pstmt = conn2.prepareStatement(sql);

			pstmt.setString(1, roomUserInfoDto.getRoom_user_name());
			pstmt.setString(2, roomUserInfoDto.getRoom_name());
			pstmt.setInt(3, roomUserInfoDto.getRoom_idx());

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

	public ArrayList<RoomGpsInfoDto> pol_getRoomGps(RoomInfoDto roomInfoDto, Connection conn) {
		//Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<RoomGpsInfoDto> list = new ArrayList<RoomGpsInfoDto>();
	    String url = "jdbc:postgresql://localhost:5432/postgres";
	    String user = "postgres";
	    String password = "1234";
	    Connection conn2 = null;
		
		String sql = "select * "
				+ " from police.roomgpsinfo "
				+ " where room_idx = " + roomInfoDto.getRoom_idx()	// + " and room_isexit = '" + roomInfoDto.getRoom_isexit() + "' "
				+ " order by case when room_user_name = '" + roomInfoDto.getRoom_user_name() + "' then 1 else 0 end, room_user_name asc, room_gps_idx asc;";
		
        try {
			conn2 = DriverManager.getConnection(url, user, password);
			//pstmt = conn.prepareStatement(sql);
			pstmt = conn2.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				RoomGpsInfoDto roomGpsInfoDto = new RoomGpsInfoDto();
				String room_user_name = rs.getString("room_user_name");
				String room_name = rs.getString("room_name");
				int room_idx = rs.getInt("room_idx");
				String room_gps_la = rs.getString("room_gps_la");
				String room_gps_ma = rs.getString("room_gps_ma");
				String room_gps_time = rs.getString("room_gps_time");
				String room_isadmin = rs.getString("room_isadmin");
				String room_isexit = rs.getString("room_isexit");
				String room_isclose = rs.getString("room_isclose");

				roomGpsInfoDto.setRoom_user_name(room_user_name);
				roomGpsInfoDto.setRoom_name(room_name);
				roomGpsInfoDto.setRoom_idx(room_idx);
				roomGpsInfoDto.setRoom_gps_la(room_gps_la);
				roomGpsInfoDto.setRoom_gps_ma(room_gps_ma);
				roomGpsInfoDto.setRoom_gps_time(room_gps_time);
				roomGpsInfoDto.setRoom_isadmin(room_isadmin);
				roomGpsInfoDto.setRoom_isexit(room_isexit);
				roomGpsInfoDto.setRoom_isclose(room_isclose);
				
				list.add(roomGpsInfoDto);
			}
		} catch (Exception e) {
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
        
        return list;
	}

	public RoomGpsInfoDto insertRoomGpsInfo(RoomUserInfoDto roomUserInfoDto, Connection conn) {
	    String url = "jdbc:postgresql://localhost:5432/postgres";
	    String user = "postgres";
	    String password = "1234";
	    Connection conn2 = null;
		//Connection conn = null;
		PreparedStatement pstmt = null;
		RoomGpsInfoDto roomGpsInfoDto = new RoomGpsInfoDto();
		String sql = "with rows as (" +  
				" INSERT INTO police.roomgpsinfo (room_user_name, room_name, room_idx, room_gps_la, room_gps_ma, room_isadmin, room_address, room_gps_time, app_user_group) " + 
				" select '" + roomUserInfoDto.getRoom_user_name() + "', '" + roomUserInfoDto.getRoom_name() + "', (select room_idx from police.roominfo where room_name = '" + roomUserInfoDto.getRoom_name() + "' and room_isclose = 'N' order by room_idx desc limit 1), '" + roomUserInfoDto.getRoom_recent_gps().split(",")[0] + "', '" + roomUserInfoDto.getRoom_recent_gps().split(",")[1] + "', '" + roomUserInfoDto.getRoom_isadmin() + "', '" + roomUserInfoDto.getRoom_address() + "', "
				 + roomUserInfoDto.getRoom_gps_time() + ", '" + roomUserInfoDto.getApp_user_group() + "'"
				//+ ", '" + roomGpsInfoDto.getRoom_gps_time() + "'::timestamp(0)"
				+ " returning * )"
				 + " select * from rows;";

		System.out.println("sql = " + sql);
		
		ResultSet rs = null;
		
        try {
			conn2 = DriverManager.getConnection(url, user, password);
			pstmt = conn2.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				roomGpsInfoDto.setRoom_user_name(rs.getString("room_user_name"));
				roomGpsInfoDto.setRoom_name(rs.getString("room_name"));
				roomGpsInfoDto.setRoom_idx(rs.getInt("room_idx"));
				roomGpsInfoDto.setRoom_gps_la(rs.getString("room_gps_la"));
				roomGpsInfoDto.setRoom_gps_ma(rs.getString("room_gps_ma"));
				roomGpsInfoDto.setRoom_isadmin(rs.getString("room_isadmin"));
				roomGpsInfoDto.setRoom_gps_time(rs.getString("room_gps_time"));
				roomGpsInfoDto.setApp_user_group(rs.getString("app_user_group"));
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
        
        return roomGpsInfoDto;
	}

	public void insertRoomGpsInfo2() {
	    String url = "jdbc:postgresql://localhost:5432/postgres";
	    String user = "postgres";
	    String password = "1234";
	    Connection conn = null;
		
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO police.roomgpsinfo (room_user_name, room_name, room_idx, room_gps_la, room_gps_ma, room_isadmin) values ('테스트GPS', '테스트GPS', 77, 37.47889152820166, 126.8788276, 'N')" ;

        try {
			conn = DriverManager.getConnection(url, user, password);
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement(sql);
			pstmt.executeUpdate();
			conn.commit();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
        	try {
				pstmt.close();
	            conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public void updateRoomGpsInfo(RoomUserInfoDto roomUserInfoDto, Connection conn) {
		//Connection conn = null;
	    String url = "jdbc:postgresql://localhost:5432/postgres";
	    String user = "postgres";
	    String password = "1234";
	    Connection conn2 = null;
		PreparedStatement pstmt = null;
		String sql = " update police.roomgpsinfo set room_isexit = 'N' "
				+ " where room_idx = (select room_idx from police.roominfo where room_name = ? and room_isclose = 'N' order by room_idx desc limit 1) and room_user_name = ? and "
				+ " room_isexit = 'Y' ;";

        try {
			conn2 = DriverManager.getConnection(url, user, password);
		    conn2.setAutoCommit(false);
			pstmt = conn2.prepareStatement(sql);
			//pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, roomUserInfoDto.getRoom_name());
			pstmt.setString(2, roomUserInfoDto.getRoom_user_name());
			
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

	public ArrayList<RoomGpsInfoDto> pol_getRoomGpsDistinct(RoomInfoDto roomInfoDto, Connection conn) {
		//Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<RoomGpsInfoDto> list = new ArrayList<RoomGpsInfoDto>();
	    String url = "jdbc:postgresql://localhost:5432/postgres";
	    String user = "postgres";
	    String password = "1234";
	    Connection conn2 = null;
		
		String sql = "select distinct on (room_user_name, room_name) * "
				+ " from ( "
				+ " select distinct on (room_user_name, room_name) * "
				+ " from police.roomgpsinfo where room_idx = " + roomInfoDto.getRoom_idx()
				+ " order by room_user_name, room_name, room_gps_idx desc "
				+ " ) sub "
				+ " order by room_user_name, room_name, room_gps_idx;";
		
		/*
		String sql = "select * "
				+ " from police.roomgpsinfo "
				+ " where room_idx = " + roomInfoDto.getRoom_idx() + " and room_gps_time > '" + roomInfoDto.getRoom_create_date() + "' "
				+ " order by room_gps_idx asc";
		*/
		
        try {
			conn2 = DriverManager.getConnection(url, user, password);
			pstmt = conn2.prepareStatement(sql);
			//pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				RoomGpsInfoDto roomGpsInfoDto = new RoomGpsInfoDto();
				String room_user_name = rs.getString("room_user_name");
				String room_name = rs.getString("room_name");
				int room_idx = rs.getInt("room_idx");
				String room_gps_la = rs.getString("room_gps_la");
				String room_gps_ma = rs.getString("room_gps_ma");
				String room_gps_time = rs.getString("room_gps_time");
				String room_isadmin = rs.getString("room_isadmin");
				String room_isexit = rs.getString("room_isexit");
				String room_isclose = rs.getString("room_isclose");

				roomGpsInfoDto.setRoom_user_name(room_user_name);
				roomGpsInfoDto.setRoom_name(room_name);
				roomGpsInfoDto.setRoom_idx(room_idx);
				roomGpsInfoDto.setRoom_gps_la(room_gps_la);
				roomGpsInfoDto.setRoom_gps_ma(room_gps_ma);
				roomGpsInfoDto.setRoom_gps_time(room_gps_time);
				roomGpsInfoDto.setRoom_isadmin(room_isadmin);
				roomGpsInfoDto.setRoom_isexit(room_isexit);
				roomGpsInfoDto.setRoom_isclose(room_isclose);
				
				list.add(roomGpsInfoDto);
			}
		} catch (Exception e) {
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
        
        return list;
	}

	public ArrayList<RoomGpsInfoDto> pol_getRoomUserAll(RoomInfoDto roomInfoDto, Connection conn) {
		//Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<RoomGpsInfoDto> list = new ArrayList<RoomGpsInfoDto>();
	    String url = "jdbc:postgresql://localhost:5432/postgres";
	    String user = "postgres";
	    String password = "1234";
	    Connection conn2 = null;
		
		String sql = "select * "
				+ " from police.roomgpsinfo "
				+ " where room_idx = " + roomInfoDto.getRoom_idx() +" and room_isclose = 'N' "
				+ " order by room_gps_idx asc";
		
        try {
			conn2 = DriverManager.getConnection(url, user, password);
			//pstmt = conn.prepareStatement(sql);
			pstmt = conn2.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				RoomGpsInfoDto roomGpsInfoDto = new RoomGpsInfoDto();
				String room_user_name = rs.getString("room_user_name");
				String room_name = rs.getString("room_name");
				int room_idx = rs.getInt("room_idx");
				String room_gps_la = rs.getString("room_gps_la");
				String room_gps_ma = rs.getString("room_gps_ma");
				String room_gps_time = rs.getString("room_gps_time");
				String room_isadmin = rs.getString("room_isadmin");
				String room_isexit = rs.getString("room_isexit");
				String room_isclose = rs.getString("room_isclose");

				roomGpsInfoDto.setRoom_user_name(room_user_name);
				roomGpsInfoDto.setRoom_name(room_name);
				roomGpsInfoDto.setRoom_idx(room_idx);
				roomGpsInfoDto.setRoom_gps_la(room_gps_la);
				roomGpsInfoDto.setRoom_gps_ma(room_gps_ma);
				roomGpsInfoDto.setRoom_gps_time(room_gps_time);
				roomGpsInfoDto.setRoom_isadmin(room_isadmin);
				roomGpsInfoDto.setRoom_isexit(room_isexit);
				roomGpsInfoDto.setRoom_isclose(room_isclose);
				
				list.add(roomGpsInfoDto);
			}
		} catch (Exception e) {
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
        
        return list;
	}
}
