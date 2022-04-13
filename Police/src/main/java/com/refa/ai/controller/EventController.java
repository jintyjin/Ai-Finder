package com.refa.ai.controller;

import static java.lang.Math.toIntExact;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.Rectangle;
import java.awt.Stroke;
import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.UnknownHostException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.attribute.BasicFileAttributes;
import java.nio.file.attribute.FileTime;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.TimeZone;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JFileChooser;
import javax.xml.bind.DatatypeConverter;

import org.apache.commons.io.FileUtils;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.HttpClientBuilder;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.converter.MessageConverter;
import org.springframework.messaging.converter.StringMessageConverter;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.zeroturnaround.zip.ZipUtil;

import com.drew.imaging.ImageMetadataReader;
import com.drew.imaging.ImageProcessingException;
import com.drew.lang.GeoLocation;
import com.drew.metadata.Metadata;
import com.drew.metadata.exif.ExifSubIFDDirectory;
import com.drew.metadata.exif.GpsDirectory;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.refa.ai.dao.EventDao;
import com.refa.ai.dao.LoginDao;
import com.refa.ai.dto.AppUserInfoDto;
import com.refa.ai.dto.CaseDto;
import com.refa.ai.dto.CaseJsonDto;
import com.refa.ai.dto.GalleryDto;
import com.refa.ai.dto.GalleryImageInfoDto;
import com.refa.ai.dto.GpsDto;
import com.refa.ai.dto.InsertImageDto;
import com.refa.ai.dto.ReceiveGpsInfoDto;
import com.refa.ai.dto.RoiDto;
import com.refa.ai.dto.RoomGpsInfoDto;
import com.refa.ai.dto.RoomInfoDto;
import com.refa.ai.dto.RoomUserInfoDto;
import com.refa.ai.dto.UserDto;
import com.refa.ai.dto.VersionDto;
import com.refa.ai.infra.Download;
import com.refa.ai.infra.EasyImage;
import com.refa.ai.infra.ZipUtils;
import com.refa.ai.session.SessionListener;
import com.refa.ai.sql.Finder;
import com.refa.ai.sql.PolFinder;

import sun.misc.BASE64Encoder;

@Controller
public class EventController {

	private SimpMessagingTemplate template;

	@Autowired
	private EventDao eventDao;
	private LoginDao loginDao;
	RestTemplate rest;
    private String url;
    private String user;
    private String password;
	private Connection conn;
	private ExecutorService executorService;
	private String sendFinderUrl;
	private String sendPolUrl;
	private JSONObject localAddress;
	private HttpClient client; // HttpClient 생성
	private HttpPost postRequest; // POST 메소드 URL 새성
	private String requestURL;
	private VersionDto versionDto;
	
	@PostConstruct
	public void init() throws SQLException {
	    url = "jdbc:postgresql://localhost:5432/postgres";
	    user = "postgres";
	    password = "1234";
	    conn = DriverManager.getConnection(url, user, password);
	    conn.setAutoCommit(false);
	    executorService = Executors.newCachedThreadPool();
		VersionDto sendVersionInfo = eventDao.selectVersionInfo("send_server");
	    sendFinderUrl = sendVersionInfo.getRequest_url();
	    sendPolUrl = sendVersionInfo.getAnalyze_url();
	    localAddress = new JSONObject();
	    client = HttpClientBuilder.create().build(); // HttpClient 생성
		versionDto = eventDao.selectVersionInfo("finder");
	    requestURL = versionDto.getAnalyze_url();
	    postRequest = new HttpPost(requestURL); // POST 메소드 URL 새성
	}
	
	@Autowired
	public void setMessagingTemplate(SimpMessagingTemplate template) {
		this.template = template;
	}

	@RequestMapping(value = "/pol_map", method = RequestMethod.GET)
	public String pol_map(Model model) {
		System.out.println("pol_map()");

		return "./pol_finder/pol_map";
	}

	@RequestMapping(value = "/pol_test", method = RequestMethod.GET)
	public String pol_test(Model model) {
		System.out.println("pol_test()");

		return "./pol_finder/pol_test";
	}
	
	@RequestMapping(value = "/setting", method = RequestMethod.GET)
	public String setting(Model model) {
		System.out.println("setting()");

		return "./police/setting";
	}

	@RequestMapping(value = "/updateCode")
	@ResponseBody
	public void updateCode(@RequestBody VersionDto versionDto) {
		System.out.println("police_updateCode()");

		eventDao.updateCode(versionDto);
	}

	// 가입되어있는 지 확인하고 로그인 시켜줌
	@RequestMapping(value = "/settingInfo")
	@ResponseBody
	public VersionDto settingInfo(@RequestBody VersionDto versionDto) {
		System.out.println("police_settingInfo()");

		String version_name = versionDto.getVersion_name();
		
		VersionDto dto = eventDao.selectVersionInfo(version_name);
		
		return dto;
	}
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public ModelAndView police_main(ModelAndView mv, String case_idx, String case_content) {
		System.out.println("police_main()");

		if (case_idx != null) {
			mv.addObject("case_idx", case_idx);
		}
		if (case_content != null) {
			mv.addObject("case_content", eventDao.findCaseContentByCaseIdx(Integer.parseInt(case_idx)));
		}
		
		mv.setViewName("./police/main");
		
		return mv;
	}

	@RequestMapping(value = "/pol_main", method = RequestMethod.GET)
	public ModelAndView pol_main(ModelAndView mv, String caseNum, String analyze_content) {
		System.out.println("pol_main()");
		
		mv.setViewName("./pol_finder/pol_main");
		
		return mv;
	}

	@RequestMapping(value = "/pol_createRoom")
	@ResponseBody
	public String pol_createRoom(@RequestBody RoomInfoDto roomInfoDto, HttpServletRequest request) throws SQLException, java.text.ParseException {
		System.out.println("pol_createRoom()");
		
		String hour = roomInfoDto.getRoom_close_date().split(":")[0];
		String minute = roomInfoDto.getRoom_close_date().split(":")[1];
		
		Date today = new Date();
		
	    Calendar calendar = new GregorianCalendar(Locale.KOREA);
	    calendar.set(Calendar.HOUR_OF_DAY, Integer.parseInt(hour));
	    calendar.set(Calendar.MINUTE, Integer.parseInt(minute));
	    calendar.set(Calendar.SECOND, 0);
	    
	    Date nowDate = new Date();

	    //System.out.println(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(nowDate) + " / " + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(calendar.getTimeInMillis()));
	    
	    roomInfoDto.setRoom_close_date(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(calendar.getTimeInMillis()));
		
		PolFinder polFinder = new PolFinder();
		int count = polFinder.insertRoomInfo(roomInfoDto, conn);

		JSONObject json = new JSONObject();
		json.put("count", count);
		json.put("room_close_date", roomInfoDto.getRoom_close_date());

		RoomUserInfoDto roomUserInfoDto = polFinder.getRoomInfoOne(roomInfoDto, conn);
		
		HttpSession session = request.getSession(true);
        session.setAttribute((roomUserInfoDto.getRoom_name() + "_" + roomUserInfoDto.getRoom_user_name()), roomUserInfoDto);
        SessionListener.getInstance().setSession(session, (roomUserInfoDto.getRoom_name() + "_" + roomUserInfoDto.getRoom_user_name()));
		
		if (count != -1) {
		    if (nowDate.getTime() >= calendar.getTime().getTime()) {
				polFinder.closeRoom(roomUserInfoDto, conn);
				polFinder.exitAllUser(roomUserInfoDto, conn);
				polFinder.exitAllGps(roomUserInfoDto, conn);
				pol_closeRoom(roomUserInfoDto);
				SessionListener.getInstance().removeAllSession((roomUserInfoDto.getRoom_name()));
		    } else {
				Timer closeTimer = new Timer();
				TimerTask closeTask = new TimerTask() {
					@Override
					public void run() {
						polFinder.closeRoom(roomUserInfoDto, conn);
						polFinder.exitAllUser(roomUserInfoDto, conn);
						polFinder.exitAllGps(roomUserInfoDto, conn);
						pol_closeRoom(roomUserInfoDto);
						SessionListener.getInstance().removeAllSession((roomUserInfoDto.getRoom_name()));
					}
				};
				closeTimer.schedule(closeTask, new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(roomInfoDto.getRoom_close_date()));
		    }
		}
		
		return json.toJSONString().replaceAll("\\\\", "");
		
	}

	public void pol_closeRoom(RoomUserInfoDto roomUserInfoDto) {
		System.out.println("pol_closeRoom()");

		JSONObject json = new JSONObject();
		json.put("room_idx", roomUserInfoDto.getRoom_idx());
		
		this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
		this.template.convertAndSend("/exitRoom", json.toJSONString().replaceAll("\\\\", ""));
	}
	
	@RequestMapping(value = "/pol_test")
	@ResponseBody
	public void pol_test(@RequestBody String testObject) throws SQLException {
		System.out.println("pol_test()");

		this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
		this.template.convertAndSend("/pol_test", testObject.replaceAll("\\\\", ""));
		
	}

	@RequestMapping(value = "/pol_post")
	@ResponseBody
	public void pol_post(@RequestBody String testObject) throws SQLException {
		System.out.println("pol_post()");

		String body = "";
		
		try {
			HttpClient client = HttpClientBuilder.create().build(); // HttpClient 생성
			HttpPost postRequest = new HttpPost("http://192.168.100.101:9900"); // POST 메소드 URL 새성
			postRequest.setHeader("Accept", "application/json");
			postRequest.setHeader("Connection", "keep-alive");
			postRequest.setHeader("Content-Type", "application/json");
			// postRequest.addHeader("x-api-key", RestTestCommon.API_KEY); //KEY 입력
			// postRequest.addHeader("Authorization", token); // token 이용시

			postRequest.setEntity(new StringEntity(testObject)); // json 메시지 입력

			HttpResponse response = client.execute(postRequest);
			
			// Response 출력
			if (response.getStatusLine().getStatusCode() == 200) {
				ResponseHandler<String> handler = new BasicResponseHandler();
				handler.handleResponse(response);
			} else {
				System.out.println("response is error : " + response.getStatusLine().getStatusCode());
			}
		} catch (Exception e) {
			System.err.println(e.toString());
		}
		
	}

	@RequestMapping(value = "/pol_result", method = RequestMethod.POST)
	@ResponseBody
	public void pol_result(@RequestBody String tmpResponse) throws ParseException {
		System.out.println("pol_result()");
		
		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObject = (JSONObject)jsonParser.parse(tmpResponse);
		
		RoomUserInfoDto roomUserInfoDto = new RoomUserInfoDto();
		roomUserInfoDto.setRoom_isadmin(jsonObject.get("room_isadmin").toString());
		roomUserInfoDto.setRoom_name(jsonObject.get("room_name").toString());
		roomUserInfoDto.setRoom_gps(jsonObject.get("room_gps").toString());
		roomUserInfoDto.setRoom_recent_gps(jsonObject.get("room_recent_gps").toString());
		roomUserInfoDto.setRoom_user_name(jsonObject.get("room_user_name").toString());
		roomUserInfoDto.setRoom_idx(Integer.parseInt(jsonObject.get("room_idx").toString()));

		PolFinder polFinder = new PolFinder();

		if (roomUserInfoDto.getRoom_isadmin().equals("N")) {
			polFinder.insertRoomUserInfo(roomUserInfoDto, conn);
			polFinder.updateUserCount(roomUserInfoDto, conn);
			RoomGpsInfoDto roomUserInfoDto2 = polFinder.getUserInfoOne(roomUserInfoDto, conn);
			
			ObjectMapper mapper = new ObjectMapper();
			String jsonStr = "";

			try {
				jsonStr = mapper.writeValueAsString(roomUserInfoDto2);
			} catch (Exception e1) {
				System.out.println("오류 발생");
				e1.printStackTrace();
			}
			
			this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
			this.template.convertAndSend("/insertRoomUser", jsonStr.replaceAll("\\\\", ""));
		}
	}
	
	@RequestMapping(value = "/pol_insertRoomUser")
	@ResponseBody
	public String pol_insertRoomUser(@RequestBody RoomUserInfoDto roomUserInfoDto) throws IOException {
		long start = System.currentTimeMillis();
		System.out.println("pol_insertRoomUser()");
        
		PolFinder polFinder = new PolFinder();
		
		ArrayList<RoomInfoDto> list = polFinder.getRoomInfo(roomUserInfoDto, conn);
		
		int count = list.size();

		JSONObject json = new JSONObject();
		
		//System.out.println(count);
		
		if(roomUserInfoDto.getRoom_gps_time() == null) {
			roomUserInfoDto.setRoom_gps_time("now()::timestamp(0)");
		}
		
		if (count == 0) {
			json.put("count", count);
		} else {
			if (list.get(0).getRoom_pwd().equals(roomUserInfoDto.getRoom_pwd())) {
				if (roomUserInfoDto.getRoom_isadmin().equals("Y")) {
					polFinder.insertRoomUserInfo(roomUserInfoDto, conn);
					//polFinder.insertRoomGpsInfo(roomUserInfoDto, conn);
					
					if (!(roomUserInfoDto.getRoom_recent_gps().equals(""))) {
						RoomGpsInfoDto jsonObject = polFinder.insertRoomGpsInfo(roomUserInfoDto, conn);

						ObjectMapper mapper = new ObjectMapper();
						String jsonStr = "";
						if (jsonObject != null) {
							try {
								jsonStr = mapper.writeValueAsString(jsonObject);
							} catch (Exception e1) {
								System.out.println("오류 발생");
								e1.printStackTrace();
							}
							this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
							this.template.convertAndSend("/insertRoomUser", jsonStr.replaceAll("\\\\", ""));
							
							postSendFinder(jsonStr.replaceAll("\\\\", ""), roomUserInfoDto.getApp_user_group(), roomUserInfoDto.getApp_user_id());
							
						}
					}
				} else {
					int count2 = polFinder.insertRoomUserInfo(roomUserInfoDto, conn);
					
					//RoomGpsInfoDto jsonObject = polFinder.insertRoomGpsInfo(roomUserInfoDto, conn);
					//polFinder.updateRoomGpsInfo(roomUserInfoDto, conn);
					//polFinder.updateUserCount(roomUserInfoDto, conn);
					//RoomGpsInfoDto jsonObject = polFinder.getUserInfoOne(roomUserInfoDto, conn);
					
					if (!(roomUserInfoDto.getRoom_recent_gps().equals(""))) {
						RoomGpsInfoDto jsonObject = polFinder.insertRoomGpsInfo(roomUserInfoDto, conn);
						polFinder.updateRoomGpsInfo(roomUserInfoDto, conn);
						polFinder.updateUserCount(roomUserInfoDto, conn);
						
						ObjectMapper mapper = new ObjectMapper();
						String jsonStr = "";
						if (jsonObject != null) {
							try {
								jsonStr = mapper.writeValueAsString(jsonObject);
							} catch (Exception e1) {
								System.out.println("오류 발생");
								e1.printStackTrace();
							}
							this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
							this.template.convertAndSend("/insertRoomUser", jsonStr.replaceAll("\\\\", ""));
							
							postSendFinder(jsonStr.replaceAll("\\\\", ""), roomUserInfoDto.getApp_user_group(), roomUserInfoDto.getApp_user_id());
							
						}
					}
				}
				json.put("count", "done");
			} else {
				count = 1;
				json.put("count", count);
			}
		}
		
		long nano = System.currentTimeMillis();
		System.out.println("pol_insertRoomUser = " + (nano - start)/1000.0 + "초");
		return json.toJSONString().replaceAll("\\\\", "");
	}

	@RequestMapping(value = "/pol_chkLogin")
	@ResponseBody
	public String pol_chkLogin(@RequestBody RoomUserInfoDto roomUserInfoDto, HttpServletRequest request) {
		System.out.println("pol_chkLogin()");

		PolFinder polFinder = new PolFinder();
		
		ArrayList<RoomInfoDto> list = polFinder.getRoomInfo(roomUserInfoDto, conn);
		
		int count = list.size();

		JSONObject json = new JSONObject();
		
		HttpSession session = request.getSession(true);

		if (count == 0) {
			json.put("count", count);
		} else {
			if (list.get(0).getRoom_pwd().equals(roomUserInfoDto.getRoom_pwd())) {
				if (SessionListener.getInstance().isUsing((roomUserInfoDto.getRoom_name() + "_" + roomUserInfoDto.getRoom_user_name()))) {
					json.put("count", "already");
				} else {
			        session.setAttribute((roomUserInfoDto.getRoom_name() + "_" + roomUserInfoDto.getRoom_user_name()), roomUserInfoDto);
			        SessionListener.getInstance().setSession(session, (roomUserInfoDto.getRoom_name() + "_" + roomUserInfoDto.getRoom_user_name()));

					json.put("count", "done");
				}
			} else {
				count = 1;
				json.put("count", count);
			}
		}
		
		return json.toJSONString().replaceAll("\\\\", "");
	}
	
	@RequestMapping(value = "/pol_updateRoomUser", method = RequestMethod.POST)
	@ResponseBody
	public void pol_updateRoomUser(@RequestBody RoomUserInfoDto roomUserInfoDto) throws SQLException, IOException {
		System.out.println("pol_updateRoomUser()");
		
		if (roomUserInfoDto.getRoom_user_name() == null) {
			System.out.println("웹워커 테스트중 " + roomUserInfoDto.getRoom_recent_gps());
		} else {
			PolFinder polFinder = new PolFinder();

			if(roomUserInfoDto.getRoom_gps_time() == null) {
				roomUserInfoDto.setRoom_gps_time("now()::timestamp(0)");
			}

			System.out.println("유저 : " + roomUserInfoDto.getRoom_user_name() + " / 방이름 : " + roomUserInfoDto.getRoom_name()
			 + " / GPS : " + roomUserInfoDto.getRoom_recent_gps() + " / 시간 : " + roomUserInfoDto.getRoom_gps_time() + " / 그룹 : " + roomUserInfoDto.getApp_user_group() + " / id : " + roomUserInfoDto.getApp_user_id());

			//polFinder.insertRoomGpsInfo2();

			long start = System.currentTimeMillis();
			RoomGpsInfoDto roomGpsInfoDto = polFinder.insertRoomGpsInfo(roomUserInfoDto, conn);
			roomUserInfoDto.setRoom_user_idx(roomGpsInfoDto.getRoom_idx());
			
			long nano = System.currentTimeMillis();
			System.out.println("pol_updateRoomUser = " + (nano - start)/1000.0 + "초");
			
			ObjectMapper mapper = new ObjectMapper();
			String jsonStr = "";

			try {
				jsonStr = mapper.writeValueAsString(roomUserInfoDto);
			} catch (Exception e1) {
				System.out.println("오류 발생");
				e1.printStackTrace();
			}
			
			this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
			this.template.convertAndSend("/pol_update", jsonStr.replaceAll("\\\\", ""));

			try {
				jsonStr = mapper.writeValueAsString(roomGpsInfoDto);
			} catch (Exception e1) {
				System.out.println("오류 발생");
				e1.printStackTrace();
			}
			
			postSendFinder(jsonStr.replaceAll("\\\\", ""), roomUserInfoDto.getApp_user_group(), roomUserInfoDto.getApp_user_id());
		}
	}
	
	@RequestMapping(value = "/pol_exitRoom")
	@ResponseBody
	public void pol_exitRoom(@RequestBody RoomUserInfoDto roomUserInfoDto) {
		System.out.println("pol_exitRoom()");

		PolFinder polFinder = new PolFinder();
		
		if (roomUserInfoDto.getRoom_isadmin().equals("Y")) {
			polFinder.closeRoom(roomUserInfoDto, conn);
			polFinder.exitAllUser(roomUserInfoDto, conn);
			polFinder.exitAllGps(roomUserInfoDto, conn);
			JSONObject json = new JSONObject();
			json.put("room_idx", roomUserInfoDto.getRoom_idx());
			this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
			this.template.convertAndSend("/exitRoom", json.toJSONString().replaceAll("\\\\", ""));
			SessionListener.getInstance().removeAllSession((roomUserInfoDto.getRoom_name()));
		} else {
			polFinder.exitRoom(roomUserInfoDto, conn);
			polFinder.exitGps(roomUserInfoDto, conn);
			polFinder.updateUserCountMinus(roomUserInfoDto, conn);
			JSONObject json = new JSONObject();
			json.put("room_idx", roomUserInfoDto.getRoom_idx());
			json.put("room_user_name", roomUserInfoDto.getRoom_user_name());
			this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
			this.template.convertAndSend("/exitRoomUser", json.toJSONString().replaceAll("\\\\", ""));
			SessionListener.getInstance().removeSession((roomUserInfoDto.getRoom_name() + "_" + roomUserInfoDto.getRoom_user_name()));
		}
	}

	@RequestMapping(value = "/pol_getRoom")
	@ResponseBody
	public List<RoomInfoDto> pol_getRoom(AppUserInfoDto appUserInfoDto) {
		System.out.println("pol_getRoom()");

		PolFinder polFinder = new PolFinder();
		List<RoomInfoDto> list = polFinder.getAllRoomInfo(appUserInfoDto, conn);
		
		return list;
	}

	@RequestMapping(value = "/pol_searchRoom")
	@ResponseBody
	public List<RoomInfoDto> pol_searchRoom(@RequestBody Map<String, Object> login) {
		System.out.println("pol_searchRoom()");

		String keyword = login.get("keyword").toString();
		
		PolFinder polFinder = new PolFinder();
		List<RoomInfoDto> list = polFinder.getSearchRoom(keyword, conn);
		
		return list;
	}
	
	@RequestMapping(value = "/pol_getRoomUser")
	@ResponseBody
	public List<RoomGpsInfoDto> pol_getRoomUser(@RequestBody RoomInfoDto roomInfoDto) {
		System.out.println("pol_getRoomUser()");

		PolFinder polFinder = new PolFinder();
		
		//List<RoomUserInfoDto> list = polFinder.pol_getRoomUser(roomInfoDto, conn);
		
		List<RoomGpsInfoDto> list2 = polFinder.pol_getRoomGpsDistinct(roomInfoDto, conn);
		
		return list2;
	}

	@RequestMapping(value = "/pol_getRoomUserAll")
	@ResponseBody
	public List<RoomGpsInfoDto> pol_getRoomUserAll(@RequestBody RoomInfoDto roomInfoDto) {
		//System.out.println("pol_getRoomUser()");

		PolFinder polFinder = new PolFinder();
		
		List<RoomGpsInfoDto> list2 = polFinder.pol_getRoomUserAll(roomInfoDto, conn);
		
		return list2;
	}
	
	@RequestMapping(value = "/pol_make_room", method = RequestMethod.GET)
	public ModelAndView pol_make_room(ModelAndView mv, String caseNum, String analyze_content) {
		System.out.println("pol_make_room()");
		
		mv.setViewName("./pol_finder/pol_make_room");
		
		return mv;
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String police_login(Model model) {
		System.out.println("police_login()");

		return "./police/login";
	}

	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public String police_test(Model model) {
		System.out.println("police_test()");

		return "./police/test";
	}
	
	@RequestMapping(value = "/education", method = RequestMethod.GET)
	public String police_grid(Model model) {
		System.out.println("police_grid()");

		return "./police/education";
	}
	
	@RequestMapping(value = "/pol_login", method = RequestMethod.GET)
	public String pol_login(Model model) {
		System.out.println("pol_login()");

		return "./pol_finder/login";
	}
	
	// 가입되어있는 지 확인하고 로그인 시켜줌
	@RequestMapping(value = "/loginList")
	@ResponseBody
	public UserDto loginList(@RequestBody UserDto userDto) {
		System.out.println("police_loginList()");

		//System.out.println(userDto.getLogin_pw());
		
		UserDto dto = eventDao.login(userDto);
		JSONObject json = new JSONObject();
		
		if (dto == null) {
			System.out.println("가입되어있지 않은 회원");
			dto = new UserDto();
			json.put("return", "incorrect");
			dto.setJson(json);
		} else if (dto.getLogin_pw().equals("null")) {
			json.put("return", "null");
			dto.setJson(json);
		} else if (dto.getLogin_pw().equals(userDto.getLogin_pw())) {
			json.put("return", "success");
			dto.setJson(json);
		} else {
			System.out.println("예외 발생");
		}

		return dto;
	}

	// 가입되어있는 지 확인하고 로그인 시켜줌
	@RequestMapping(value = "/pol_loginData")
	@ResponseBody
	public AppUserInfoDto pol_loginData(@RequestBody AppUserInfoDto appUserInfoDto) {
		System.out.println("pol_loginData()");

		Finder finder = new Finder();
		
		AppUserInfoDto dto = finder.pol_login(appUserInfoDto, conn);
		JSONObject json = new JSONObject();
		
		if (dto == null) {
			dto = new AppUserInfoDto();
			json.put("return", "incorrect");
			dto.setJson(json);
		} else if (dto.getApp_user_pwd() == null) {
			json.put("return", "null");
			dto.setJson(json);
		} else if (dto.getApp_user_pwd().equals(appUserInfoDto.getApp_user_pwd())) {
			json.put("return", "success");
			dto.setJson(json);
		} else if (!(dto.getApp_user_pwd().equals(appUserInfoDto.getApp_user_pwd()))) {
			json.put("return", "incorrectPwd");
			dto.setJson(json);
		} else  {
			System.out.println("예외 발생");
		}

		return dto;
	}

	// 가입되어있는 지 확인하고 로그인 시켜줌
	@RequestMapping(value = "/pol_server_login")
	@ResponseBody
	public AppUserInfoDto pol_server_login(@RequestBody AppUserInfoDto appUserInfoDto) {
		System.out.println("pol_server_login()");

		Finder finder = new Finder();
		
		AppUserInfoDto dto = finder.pol_login(appUserInfoDto, conn);
		JSONObject json = new JSONObject();
		
		if (dto == null) {
			dto = new AppUserInfoDto();
			json.put("return", "incorrect");
			dto.setJson(json);
		} else if (dto.getApp_user_pwd() == null) {
			json.put("return", "null");
			dto.setJson(json);
		} else if (dto.getApp_user_pwd().equals(appUserInfoDto.getApp_user_pwd())) {
			json.put("return", "success");
			dto.setJson(json);
			JSONObject localJson = new JSONObject();
			if (localAddress.get(dto.getApp_user_group()) != null && localAddress.get(dto.getApp_user_group()) != null) {
				localJson = (JSONObject) localAddress.get(dto.getApp_user_group());
			}
			dto.setLocal_ip(appUserInfoDto.getLocal_ip());
			dto.setLocal_port(appUserInfoDto.getLocal_port());
			localJson.put(dto.getApp_user_id(), dto);
			localAddress.put(dto.getApp_user_group(), localJson);
			System.out.println("로그인 된 유저 = " + dto.getApp_user_group() + " / " + dto.getApp_user_id());
		} else {
			System.out.println("예외 발생");
		}

		return dto;
	}
	
	// 가입되어있는 지 확인하고 로그인 시켜줌
	@RequestMapping(value = "/server_login")
	@ResponseBody
	public String server_login(@RequestBody AppUserInfoDto appUserInfoDto, HttpServletRequest request) throws IOException {
		System.out.println("server_login()");

		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = "";

		VersionDto versionDto = eventDao.selectVersionInfo("server");
		
		String url = versionDto.getRequest_url().substring(0, versionDto.getRequest_url().lastIndexOf("/police"));
		
		String local_ip = url.substring(0, url.lastIndexOf(":"));
		String local_port = url.substring(url.lastIndexOf(":") + 1);
		
		appUserInfoDto.setLocal_ip(local_ip);
		appUserInfoDto.setLocal_port(local_port);
		
		try {
			jsonStr = mapper.writeValueAsString(appUserInfoDto);
		} catch (Exception e1) {
			System.out.println("오류 발생");
			e1.printStackTrace();
		}
		
		String json = "";
		
		json = postSendServer(jsonStr.replaceAll("\\\\", ""));
	    
		return json;
	}
	
	@RequestMapping(value = "/emap", method = RequestMethod.GET)
	public ModelAndView police_emap(ModelAndView mv, String case_idx) {
		System.out.println("police_emap()");

		if (case_idx != null) {
			mv.addObject("case_idx", case_idx);
		}
		mv.setViewName("./police/emap2");
		
		return mv;
	}

	@RequestMapping(value = "/galleryUpdate")
	@ResponseBody
	public void galleryUpdate(@RequestBody HashMap<String, Object> hashMap) {
		System.out.println("police_galleryUpdate()");
				
		hashMap.put("case_idx", Integer.parseInt(hashMap.get("case_num").toString().substring(4)));
		hashMap.put("case_progress", Integer.parseInt(hashMap.get("perTime").toString()));
		
		eventDao.updateCase_info(hashMap);
		
	}

	@RequestMapping(value = "/imageZipOpen", method=RequestMethod.GET)
	public void imageZipOpen(String caseNum, HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.out.println("police_imageZipOpen()");
		// 압축 파일 위치와 압축된 파일 
		String zipPath = "C:/web_server/image/"; 
		String zipFile = "알집 테스트.zip";
		
		// 압축을 해제할 위치, 압축할 파일이름 
		String unZipPath = "C:/web_server/image/"; 
		//String unZipFile = "jsmpeg-player"; 
		
		System.out.println("--------- 압축 해제 ---------"); 
	}
	
	@RequestMapping(value = "/imageDownload")
	@ResponseBody
	public String imageDownload(@RequestBody Map<String, Object> download, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		System.out.println("imageDownload()");
		//System.out.println("caseNum = " + caseNum);
		//System.out.println("login_id = " + login_id);
		
		String case_idx = download.get("case_idx").toString();
		String login_id = download.get("login_id").toString();
		String isCase = "";
		if (download.get("isCase") != null) {
			isCase = download.get("isCase").toString();
		} else {
			isCase = null;
		}
		String isNew = download.get("isNew").toString();
		
		String unZipPath = "C:/web_server/image/";
		String unZipFile = case_idx;
		
		Download down = new Download();
		
		// 압축 파일 다운로드
		File file = new File("C:/web_server/image/" + case_idx + ".zip");
		boolean isExists = file.exists(); 

		if(isExists) {
			FileUtils.deleteQuietly(file);
		}
		
		// 압축 하기
		try { 
			if (!compress("C:/web_server/image/" + case_idx, unZipPath, unZipFile, login_id, isCase, isNew)) {
				System.out.println("압축 실패");
			}
		} catch (Throwable e) {
			e.printStackTrace();
		}

		JSONObject json = new JSONObject();
		json.put("caseNum", case_idx);
		json.put("isCase", isCase);
		json.put("login_id", login_id);
		json.put("isNew", isNew);
		json.put("per", 100 + "%");
		json.put("address", "/police/webserver/image/" + case_idx + ".zip");

		this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
		this.template.convertAndSend("/imageDownload", json.toJSONString());
		
		return json.toJSONString().replaceAll("\\\\", "");
		//System.out.println(json.toJSONString());
		
		//down.downloadFile(file, response);
		
		//this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
		//this.template.convertAndSend("/imageDownload", "length");
	}

	@RequestMapping(value = "/imageDownload2")
	@ResponseBody
	public String imageDownload2(@RequestBody String caseNum2, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		System.out.println("imageDownload2()");
		//System.out.println("login_id = " + login_id);
		
		String fileName = "";
		
	    String pattern = "yyyyMMdd_HHmmss";
	    SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
		
	    fileName = "download_" + simpleDateFormat.format(new Date());
	    
		// 압축 파일 다운로드
		File file = new File("C:/web_server/image/" + fileName + ".zip");
		boolean isExists = file.exists();
		
		String fileName2 = fileName;
		
		int num = 1;
		while (isExists) {
			String tmpFileName = fileName + "(" + num + ")"; 
			file = new File("C:/web_server/image/" + fileName + "(" + num + ").zip");
			fileName2 = tmpFileName;
			num++;
		}

		String path = "C:/web_server/image/case1445/";
		
		FileOutputStream zipFileOutputStream = new FileOutputStream("C:/web_server/image/" + fileName2 + ".zip");
		ZipOutputStream zipOutputStream = new ZipOutputStream(zipFileOutputStream);

		ZipEntry zipEntry = new ZipEntry("test.txt");

		zipOutputStream.putNextEntry(zipEntry);

		File file2 = new File(path);

		// 압축 경로 체크
		if (!file2.exists()) {
			throw new Exception("Not File!");
		}
		
		// 파일의 .zip이 없는 경우, .zip 을 붙여준다.
		int pos = fileName2.lastIndexOf(".") == -1 ? fileName2.length() : fileName2.lastIndexOf(".");
		
		// outputFileName .zip이 없는 경우
		if (!fileName2.substring(pos).equalsIgnoreCase(".zip")) { 
			fileName2 += ".zip";
		} 

		try { 
			if (!compress2(path,"C:/web_server/image/", "case1445", null)) {
				System.out.println("압축 실패");
			}
		} catch (Throwable e) {
			e.printStackTrace();
		}
		
		return fileName2;
	}

	@RequestMapping(value = "/deleteCase")
	@ResponseBody
	public List<CaseDto> deleteCase(@RequestBody CaseDto caseDto) throws Throwable {
		System.out.println("deleteCase()");
		//System.out.println("login_id = " + login_id);
		
		String[] case_num = caseDto.getCase_num().split(",");
		String[] analyze_content = caseDto.getTagList().split(",");
		
		List<CaseDto> caseList = new ArrayList<CaseDto>();
		
		String login_id = caseDto.getLogin_id();
		String browserName = caseDto.getAnalyze_content();
		
		double per = 0;
		
		for (int i = 0; i < case_num.length; i++) {
			CaseDto caseDto1 = new CaseDto();
			String caseNum = case_num[i].toString();
			String anContent = analyze_content[i].toString();

			String path = "C:/web_server/image/" + caseNum; 
			
			File file = new File(path);
			
			try {
				eventDao.deleteCaseOne(caseNum);
				eventDao.deleteDashInfo(caseNum);
				eventDao.deleteGalleryInfo(caseNum);
				eventDao.deleteGpsInfo(caseNum);
				
				FileUtils.deleteQuietly(file);
				FileUtils.deleteQuietly(new File(path + ".zip"));
				
				caseDto1.setCase_num(anContent);
				caseDto1.setAnalyze_content("success");
			} catch (Exception e) {
				//System.err.println(e.toString());
				caseDto1.setCase_num(anContent);
				caseDto1.setAnalyze_content("failed");
				continue;
			}
			
			caseList.add(caseDto1);
			
//			per += (100 / case_num.length);
//			System.out.println("per = " + per);
			
			JSONObject json = new JSONObject();
			json.put("login_id", login_id);
			json.put("browserName", browserName);
			json.put("totalLength", case_num.length);
			json.put("count", (i + 1));
			
			this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
			this.template.convertAndSend("/endDeleteOne", json.toJSONString().replaceAll("\\\\", ""));
		}
		
		return caseList;
	}
	
	@RequestMapping(value = "/imageData")
	@ResponseBody
	public List<Map<String, Object>> imageData(@RequestBody Map<String, Object> map) throws ParseException {
		System.out.println("police_imageData()");
		//System.out.println("아이디 : " + user.getLogin_id());

		List<Map<String, Object>> gps_list = eventDao.selectCase_gps(Integer.parseInt(map.get("case_idx").toString()));
		
		return gps_list;
	}

	@RequestMapping(value = "/clickPage_num")
	@ResponseBody
	public List<Map<String, Object>> clickPage_num(@RequestBody Map<String, Integer> map) throws ParseException {
		System.out.println("police_clickPage_num()");
		
		List<Map<String, Object>> gps_list = eventDao.clickPage_num(map);
		
		return gps_list;
	}
	
	@RequestMapping(value = "/dashboard", method = RequestMethod.GET)
	public String police_dashboard(Model model) {
		System.out.println("police_dashboard()");

		return "./police/dashboard";
	}
/*
	@RequestMapping(value = "/insertDash")
	@ResponseBody
	public void insertDash(@RequestBody String roi) throws ParseException {
		System.out.println("police_insertDash()");
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(roi);
		JSONObject jsonObj = (JSONObject) obj;
		System.out.println(jsonObj.toString());
		RoiDto roiDto = new RoiDto();
		roiDto.setCrop_name(jsonObj.get("crop_name").toString().replaceAll("\\\\", ""));
		roiDto.setFavorites(jsonObj.get("favorites").toString());
		roiDto.setImg_name(jsonObj.get("img_name").toString().replaceAll("\\\\", ""));
		roiDto.sethHeight(jsonObj.get("hHeight").toString());
		roiDto.sethWidth(jsonObj.get("hWidth").toString());
		roiDto.setLogin_id(jsonObj.get("login_id").toString());
		roiDto.setRoiNum(jsonObj.get("roiNum").toString());
		roiDto.setRoi(jsonObj.get("roi").toString().replaceAll("\\\\", ""));
		
		System.out.println(roiDto.getRoi());
		
		eventDao.insertDash(roiDto);
	}
*/
	@RequestMapping(value = "/dashUpdate")
	@ResponseBody
	public void dashUpdate(@RequestBody HashMap hashMap) throws ParseException {
		System.out.println("police_dashUpdate()");
		eventDao.updateCase(hashMap);
		
		hashMap.put("case_idx", Integer.parseInt(hashMap.get("case_num").toString().substring(4)));
		//eventDao.updateCase_chk(hashMap);
		
		
	}

	@RequestMapping(value = "/updateAnalyzeContent")
	@ResponseBody
	public String updateAnalyzeContent(@RequestBody CaseDto info) throws ParseException {
		System.out.println("police_updateAnalyzeContent()");
		
		eventDao.updateAnalyzeContent(info);
		
		String result = "Y";
		
		return result;
	}
	
	@RequestMapping(value = "/selectCase_gallery")
	@ResponseBody
	public Map<String, List<Map<String, Object>>> selectCase_gallery(@RequestBody Map<String, Integer> map) throws ParseException {
		System.out.println("police_selectCase_gallery()");
		
		Map<String, List<Map<String, Object>>> total_list = new HashMap<>();

		List<Map<String, Object>> tag_list = eventDao.selectTag_info(map);
		
		List<Map<String, Object>> gallery_list = eventDao.selectCase_gallery(map);
		
		total_list.put("tag_list", tag_list);
		total_list.put("gallery_list", gallery_list);
		
		return total_list;

	}
	
	@RequestMapping(value = "/selectAllCase")
	@ResponseBody
	public List<Map<String, Object>> selectAllCase(@RequestBody Map<String, String> map) throws ParseException {
		System.out.println("police_selectAllCase()");

		String login_id = map.get("login_id");
		
		System.out.println("login_id = " + login_id);
		
		List<Map<String, Object>> case_info = eventDao.selectAllCase(login_id);
		
		System.out.println("caseInfo = " + case_info.size());
		
		return case_info;
	}

	@RequestMapping(value = "/selectEndCase")
	@ResponseBody
	public CaseJsonDto selectEndCase(@RequestBody CaseDto caseDto) throws ParseException {
		System.out.println("police_selectEndCase()");
		
		CaseJsonDto caseJsonDto = eventDao.selectEndCase(caseDto);
		
		return caseJsonDto;
	}
	
	@RequestMapping(value = "/popup", method = RequestMethod.GET)
	public ModelAndView police_popup(ModelAndView mv, String roiNum, String case_idx) {
		System.out.println("police_popup()");
		//System.out.println(roiNum);

		mv.addObject("case_idx", case_idx);
		mv.addObject("roiNum", roiNum);
		mv.setViewName("./police/popup");
		
		return mv;
	}

	@RequestMapping(value = "/selectRoi_image")
	@ResponseBody
	public Map<String, Object> selectRoi_image(@RequestBody Map<String, Object> map) throws ParseException {
		System.out.println("police_selectRoi_image()");

		Map<String, Object> roi_info = eventDao.selectRoi_image(map);
		
		return roi_info;
	}
	
	@RequestMapping(value = "/gallery", method = RequestMethod.GET)
	public ModelAndView police_gallery(ModelAndView mv, String case_idx) {
		System.out.println("police_gallery()");

		if (case_idx != null) {
			mv.addObject("case_idx", case_idx);
		}
		mv.setViewName("./police/gallery");
		
		return mv;
	}

	@RequestMapping(value = "/isStitchingImage")
	@ResponseBody
	public String isStitchingImage(@RequestBody Map<String, Object> stitching) {
		System.out.println("isStitchingImage()");
		
		String fileName = "C:/web_server/image/" + stitching.get("img_name").toString() + "/stitching.jpg";
		
		File f = new File(fileName);

	    if (f.isFile()) {
	    	//fileName = "/police/webserver/image/" + stitching.get("img_name").toString() + "/stitching.jpg";
	    	fileName = "/police/stitching?caseNum=" + stitching.get("img_name").toString();
	    }
	    else {
	    	fileName = "N";
	    }
	    
	    return fileName;
	}
	
	@RequestMapping(value = "/stitching", method = RequestMethod.GET)
	public ModelAndView stitching(ModelAndView mv, String case_idx) {
		System.out.println("stitching()");

		mv.addObject("case_idx", case_idx);
		mv.setViewName("./police/stitching");
		
		return mv;
	}

	@RequestMapping(value = "/situation_board", method = RequestMethod.GET)
	public String situation_board(Model mv) {
		System.out.println("situation_board()");

		return "./police/situationboard";
	}

	@RequestMapping(value = "/drone", method = RequestMethod.GET)
	public ModelAndView drone(ModelAndView mv, String case_idx) {
		System.out.println("drone()");
		
		mv.addObject("case_idx", case_idx);
		mv.setViewName("./police/drone");
		
		return mv;
	}
	
	@RequestMapping(value = "/droneData")
	@ResponseBody
	public List<Map<String, Object>> drone(@RequestBody Map<String, Object> data) {
		System.out.println("droneData()");
		
		int case_idx = Integer.parseInt(data.get("case_idx").toString());

		List<Map<String, Object>> map = eventDao.selectGps_info(case_idx);
		System.out.println("사이즈 = " + map.size());
		
		return map;
	}

	@RequestMapping(value = "/selectReceiveGpsInfoList")
	@ResponseBody
	public List<ReceiveGpsInfoDto> selectReceiveGpsInfoList(@RequestBody ReceiveGpsInfoDto receiveGpsInfoDto) throws ParseException {
		System.out.println("police_selectReceiveGpsInfoList()");

		Finder finder = new Finder();
		
		List<ReceiveGpsInfoDto> receiveInfo = finder.selectReceiveGpsInfoList(receiveGpsInfoDto, conn);
		
		return receiveInfo;
	}


	@RequestMapping(value = "/selectReceiveGpsInfoList2")
	@ResponseBody
	public List<List> selectReceiveGpsInfoList2(@RequestBody ReceiveGpsInfoDto receiveGpsInfoDto) throws ParseException {
		System.out.println("police_selectReceiveGpsInfoList2()");

		Finder finder = new Finder();

        long start = System.currentTimeMillis();
        
		List<String> receiveInfo = finder.selectReceiveGpsInfoList2(receiveGpsInfoDto, conn);

		List<ReceiveGpsInfoDto> receiveGpsInfoDto2 = finder.selectReceiveGpsInfoList3(receiveGpsInfoDto, conn);

		List<Map> caseGpsList = eventDao.findCaseGpsByProgress100(receiveGpsInfoDto);
		
		List<List> list = new ArrayList<List>();
		
		list.add(receiveInfo);
		list.add(receiveGpsInfoDto2);
		list.add(caseGpsList);
		
        long nano = System.currentTimeMillis();
        
		return list;
	}
	
	@RequestMapping(value = "/selectSituationData")
	@ResponseBody
	public List<String> selectSituationData(@RequestBody ReceiveGpsInfoDto receiveGpsInfoDto) throws ParseException {
		System.out.println("police_selectSituationData()");

		Finder finder = new Finder();
		
		List<String> galleryList = finder.selectSituationData(receiveGpsInfoDto, conn);
		
		return galleryList;
	}

	@RequestMapping(value = "/selectAnalyzeContent")
	@ResponseBody
	public CaseDto selectAnalyzeContent(@RequestBody CaseDto caseDto) {
		System.out.println("police_selectAnalyzeContent()");

		Finder finder = new Finder();
		
		String analyze_content = finder.selectAnalyzeContent(caseDto.getCase_num(), conn);
		
		caseDto.setAnalyze_content(analyze_content);
		
		return caseDto;
	}
	
	@RequestMapping(value = "/updateUserInfo")
	@ResponseBody
	public void updateUserInfo(@RequestBody UserDto userDto) {
		System.out.println("police_updateUserInfo()");
		
		eventDao.updateUserGallery(userDto);
	}

	@RequestMapping(value = "/updateFavorites")
	@ResponseBody
	public Map<String, Object> updateFavorites(@RequestBody Map<String, Object> map) {
		System.out.println("police_updateFavorites()");

		eventDao.updateFavorites(map);
		
		return map;
	}
	
	@RequestMapping(value = "/k3", method = RequestMethod.GET)
	public String police_k3(Model model) {
		System.out.println("police_k3()");

		return "./police/k3";
	}
	
	public String post(String jsonMessage) {
		System.out.println("post()");
		String body = "";
		
		try {
			postRequest.setHeader("Accept", "application/json");
			postRequest.setHeader("Connection", "keep-alive");
			postRequest.setHeader("Content-Type", "application/json");
			// postRequest.addHeader("x-api-key", RestTestCommon.API_KEY); //KEY 입력
			// postRequest.addHeader("Authorization", token); // token 이용시

			postRequest.setEntity(new StringEntity(jsonMessage)); // json 메시지 입력

			HttpResponse response = client.execute(postRequest);
			
			// Response 출력
			if (response.getStatusLine().getStatusCode() == 200) {
				ResponseHandler<String> handler = new BasicResponseHandler();
				body = handler.handleResponse(response);
			} else {
				System.out.println("response is error : " + response.getStatusLine().getStatusCode());
			}
		} catch (Exception e) {
			System.err.println(e.toString());
		}
		
		return body;
	}

	public String post(String analyze_url, String jsonMessage) {
		System.out.println("post()");
		String body = "";
		
		try {
			HttpClient client = HttpClientBuilder.create().build(); // HttpClient 생성
			HttpPost postRequest = new HttpPost(analyze_url); // POST 메소드 URL 새성

			postRequest.setHeader("Accept", "application/json");
			postRequest.setHeader("Connection", "keep-alive");
			postRequest.setHeader("Content-Type", "application/json");
			// postRequest.addHeader("x-api-key", RestTestCommon.API_KEY); //KEY 입력
			// postRequest.addHeader("Authorization", token); // token 이용시

			postRequest.setEntity(new StringEntity(jsonMessage)); // json 메시지 입력

			HttpResponse response = client.execute(postRequest);
			
			// Response 출력
			if (response.getStatusLine().getStatusCode() == 200) {
				ResponseHandler<String> handler = new BasicResponseHandler();
				body = handler.handleResponse(response);
			} else {
				System.out.println("response is error : " + response.getStatusLine().getStatusCode());
			}
		} catch (Exception e) {
			System.err.println(e.toString());
		}
		
		return body;
	}
	
	@RequestMapping(value = "/testUpload", method = RequestMethod.POST)
	public @ResponseBody String test_upload(MultipartHttpServletRequest request) {
		List<MultipartFile> fileList = request.getFiles("file");
		
		for (int i = 0; i < fileList.size(); i++) {
			MultipartFile mf = fileList.get(i);
			String originalFileName = mf.getOriginalFilename();
			//System.out.println(originalFileName);
			this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
			this.template.convertAndSend("/test", originalFileName);
		}
		//System.out.println("반복문 종료");
		
		return "success";
	}
	
	String case_num = "";
	List<MultipartFile> files = null;
	
	@RequestMapping(value = "/upload", method = RequestMethod.POST)	//String login_id, String analyze_content
	public String police_upload(MultipartHttpServletRequest request, @RequestParam Map<String, Object> map) throws IOException, ParseException, ImageProcessingException {
		System.out.println("police_upload()");
		
		String login_id = map.get("login_id").toString();
		String analyze_content = map.get("analyze_content").toString();
		
		// analyze_content : 사용자가 분석 시 입력한 타이틀
		if (analyze_content.equals("")) {	// 사용자가 타이틀을 입력하지 않았다면 현재 날짜로 만들어줌
	    	String pattern2 = "yyyy년 MM월 dd일 HH시 mm분 ss초";		// 타이틀로 만들 문자열의 형태
		    SimpleDateFormat simpleDateFormat2 = new SimpleDateFormat(pattern2);
	    	
		    analyze_content = simpleDateFormat2.format(new Date());
		    map.put("analyze_content", analyze_content);
		}

		// 업로드한 이미지들을 list에 넣음
		files = request.getFiles("file");
		
		map.put("case_image_count", files.size());
		map.put("case_time", "");
		map.put("case_taken", "");
		map.put("case_roi_count", 0);
		
		int case_idx = eventDao.insertCase_info(map);
		map.put("case_idx", case_idx);
		
		String caseNum = "case" + case_idx;	// 가장 최근의 케이스 번호를 가져옴 : 현재 이 로직은 idx가 아니라 단순 번호를 가져옴, 수정 예정
		
		// 폴더 경로 잡아줌
		String uploadPath = "C:/web_server";
		File folder = new File(uploadPath);
		
		if (!folder.exists()) {
			try {
				folder.mkdir();
				//System.out.println("폴더 생성");
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
		
		uploadPath = "C:/web_server/image";
		folder = new File(uploadPath);
		File[] fileLength = folder.listFiles();		// 현재 지정된 폴더의 파일 리스트 : 추후 용량 관련하여 삭제 등에 이용해보려 했었음
		
		if (!folder.exists()) {
			try {
				folder.mkdir();
				//System.out.println("폴더 생성");
			} catch (Exception e) {
				e.getStackTrace();
			}
		} 
		
		uploadPath = "C:/web_server/image/" + caseNum;
		folder = new File(uploadPath);
		
		if (!folder.exists()) {
			try {
				folder.mkdir();
				//System.out.println("폴더 생성");
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
		
		// 촬영한 날짜를 기준으로 오름차순 정렬
		files = sortData(files);
		
		this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
		this.template.convertAndSend("/fileCount", new ObjectMapper().writeValueAsString(map));
		this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
		this.template.convertAndSend("/fileCount2", new ObjectMapper().writeValueAsString(map));
		
		// 시간의 범위를 저장할 문자열
		String analyze_time = "";
		
		// 업로드 한 이미지들을 1개씩 작업할 반복문
		for (int i = 0; i < files.size(); i++) {
			// 이미지 파일 1개를 담음
			MultipartFile mf = files.get(i);
			// 이미지의 파일명
			String safeFile = mf.getOriginalFilename();
			// galleryinfo에 저장할 정보를 담을 json : json형 테이블에서 일반 테이블식으로 변경할 예정

			// 이미지를 base64로 인코딩함
			BASE64Encoder base64Encoder = new BASE64Encoder();
			String base64Encoderstr = base64Encoder.encode(mf.getBytes());

			/* 지정된 폴더에 원본 이미지 다운*/
			mf.transferTo(new File(uploadPath + "/" + i + ".jpg"));

			/* 객체 인식 정보 post로 보내는 과정*/
			String tmpUploadPath = "/webserver/image/" + caseNum;
			
			Map<String, Object> hashMap = new HashMap<>();
			hashMap.put("img_data", base64Encoderstr);
			hashMap.put("img_type", "jpg");
			hashMap.put("event_request", "People Detect");
			hashMap.put("img_name", "/police" + tmpUploadPath + "/" + i + ".jpg");
			hashMap.put("user_name", login_id);
			hashMap.put("user_passwd", "1234xxx");
			hashMap.put("client_code", versionDto.getClient_code());
			hashMap.put("request_url", versionDto.getRequest_url());
			
			/* 이미지 객체 인식*/
			//response = post(json.toJSONString());
			post(new ObjectMapper().writeValueAsString(hashMap));
			
			/* 썸네일 이미지  만들기 시작 */
			File f = new File(uploadPath + "/" + i + safeFile.substring(safeFile.lastIndexOf(".")));
			EasyImage easyImage = new EasyImage(f);
			// 원본 이미지 객체 생성
			BufferedImage bi = ImageIO.read(f);
			if (!easyImage.isSupportedImageFormat()) {
				System.out.println("not supported image type");
			}
			
			/*resize*/
			EasyImage resizedImage = easyImage.resize(640, 480);
			// 저장할 파일 객체 생성
			FileOutputStream out = new FileOutputStream(uploadPath + "/" + i + "_thumb" + ".jpg");
			// 파일 저장
			resizedImage.writeTo(out, "jpg");
			//easyImage.writeTo(out, "jpg");
			out.close();
			//System.out.println("썸네일 = " + uploadPath + "/" + i + "_thumb" + ".jpg");
			
			// 메타데이터 객체 생성
			Metadata metadata = ImageMetadataReader.readMetadata(f);
			
			// 메타데이터 객체에서 정보 가져옴
			ExifSubIFDDirectory directory = metadata.getDirectory(ExifSubIFDDirectory.class);
			GpsDirectory gpsDirectory = metadata.getDirectory(GpsDirectory.class);
			
			String imgTime = null;
			// 메타데이터가 없는 경우도 있음
			if (directory != null && directory.getDate(ExifSubIFDDirectory.TAG_DATETIME_ORIGINAL, TimeZone.getDefault()) != null) {
				// 반복문을 돌며 추출한 이미지의 기간 범위를 문자열로 만듬
				Date originalDate = directory.getDate(ExifSubIFDDirectory.TAG_DATETIME_ORIGINAL, TimeZone.getDefault());
				if (originalDate != null) {
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

				    if (i == 0) {
				    	String pattern2 = "yyyy년 MM월 dd일 HH시 mm분 ss초";
					    SimpleDateFormat simpleDateFormat2 = new SimpleDateFormat(pattern2);
				    	
					    analyze_time = simpleDateFormat2.format(originalDate);
				    }

				    if (i == (files.size() - 1)) {
				    	String pattern2 = "yyyy년 MM월 dd일 HH시 mm분 ss초";
					    SimpleDateFormat simpleDateFormat2 = new SimpleDateFormat(pattern2);

					    String[] startArray = analyze_time.split(" ");
					    String[] endArray = simpleDateFormat2.format(originalDate).split(" ");
					    
					    analyze_time += " ~";
					    		
					    for (int a = 0; a < startArray.length; a++) {
					    	if (a < 3) {
						    	if (!(startArray[a].equals(endArray[a]))) {
						    		analyze_time += " " + endArray[a];
						    	}
					    	} else {
					    		analyze_time += " " + endArray[a];
					    	}
					    }
					    
					    //analyze_time += " ~ " + simpleDateFormat2.format(new Date(time.toMillis()));
				    }
					imgTime = sdf.format(originalDate);
					//System.out.println("date = " + imgTime);
				}
			} else {
				// 추출한 메타데이터가 없으면 현재 시간으로 만들어줌
				BasicFileAttributes attrs;
				try {
				    attrs = Files.readAttributes(f.toPath(), BasicFileAttributes.class);
				    FileTime time = attrs.creationTime();
				    
				    String pattern = "yyyy-MM-dd HH:mm:ss";
				    SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
					
				    imgTime = simpleDateFormat.format(new Date(time.toMillis()));

				    if (i == 0) {
				    	String pattern2 = "yyyy년 MM월 dd일 HH시 mm분 ss초";
					    SimpleDateFormat simpleDateFormat2 = new SimpleDateFormat(pattern2);
				    	
					    analyze_time = simpleDateFormat2.format(new Date(time.toMillis()));
				    }
				    
				    if (i == (files.size() - 1)) {
				    	String pattern2 = "yyyy년 MM월 dd일 HH시 mm분 ss초";
					    SimpleDateFormat simpleDateFormat2 = new SimpleDateFormat(pattern2);

					    String[] startArray = analyze_time.split(" ");
					    String[] endArray = simpleDateFormat2.format(new Date(time.toMillis())).split(" ");
					    
					    analyze_time += " ~";
					    		
					    for (int a = 0; a < startArray.length; a++) {
					    	if (a < 3) {
						    	if (!(startArray[a].equals(endArray[a]))) {
						    		analyze_time += " " + endArray[a];
						    	}
					    	} else {
					    		analyze_time += " " + endArray[a];
					    	}
					    }
					    
					    //analyze_time += " ~ " + simpleDateFormat2.format(new Date(time.toMillis()));
				    }
				    
				    //System.out.println("파일 생성 날짜 및 시간은 다음과 같습니다.: " + imgTime);
				} catch (IOException e) {
				    e.printStackTrace();
				}
			}
			
			// 이미지에서 위도와 경도 가져옴
			String wtmX = null;
			String wtmY = null;
			// 없으면 null 값 그대로 넣어줌
			if (gpsDirectory != null) {
				GeoLocation geoLocation = gpsDirectory.getGeoLocation();
				if (geoLocation != null) {
					wtmY = geoLocation.toString().split(", ")[1];
					wtmX = geoLocation.toString().split(", ")[0];
				}
			}
			
			hashMap.put("imgTime", imgTime);
			hashMap.put("wtmX", wtmX);
			hashMap.put("wtmY", wtmY);
			hashMap.put("original_image", "/police" + tmpUploadPath + "/" + i + ".jpg");
			hashMap.put("image", "/police" + tmpUploadPath + "/" + i + "_thumb" + ".jpg");
			hashMap.put("login_id", login_id);
			hashMap.put("width", bi.getWidth());
			hashMap.put("height", bi.getHeight());
			hashMap.put("img_number", i);
			hashMap.put("total_count", files.size());
			hashMap.put("case_idx", case_idx);
			
			// 웹소켓으로 emap페이지에 showImage라는 url를 가진 곳으로 보내줌
			hashMap.remove("img_data");
			
			this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
			this.template.convertAndSend("/showImage", new ObjectMapper().writeValueAsString(hashMap));
			
			if (wtmX != null) {
				map.put("gps_wtmX", Double.parseDouble(wtmX));
			} else {
				map.put("gps_wtmX", null);
			}

			if (wtmY != null) {
				map.put("gps_wtmY", Double.parseDouble(wtmY));
			} else {
				map.put("gps_wtmY", null);
			}
			
			map.put("gps_image", "/police" + "/webserver/image/case" + case_idx + "/" + i + "_thumb" + ".jpg");
			map.put("gps_imgName", "/police" + "/webserver/image/case" + case_idx + "/" + i + ".jpg");
			map.put("gps_imgTime", imgTime);
			map.put("gps_color", "green");
			map.put("gps_status", "분석중");
			map.put("gps_width", bi.getWidth());
			map.put("gps_height", bi.getHeight());
			
			eventDao.insertGps_info(map);
			
		}

		map.put("case_time", analyze_time);
		eventDao.updateCase_time(map);
		
		return "./police/emap2";
	}

	// gps 정보 추가
	public void insertGpsInfo(GpsDto gpsInfo) {
		//System.out.println("insertGpsInfo()");
		//System.out.println("insertGpsInfo() = " + gpsInfo.toString());

		//System.out.println(gpsInfo.getStatus());
		
		eventDao.insertGpsInfo(gpsInfo);
	}

	// gps 정보 수정
	public void updateGpsInfo(GpsDto gpsInfo) {
		//System.out.println("updateGpsInfo()");
		//System.out.println("updateGpsInfo() = " + gpsInfo.toString());
		
		eventDao.updateGpsInfo(gpsInfo);
	}

	@RequestMapping(value = "/selectImage")
	@ResponseBody
	public void selectImage(@RequestBody GalleryDto galleryDto) {
		System.out.println("selectImage()");
		//System.out.println("updateGpsInfo() = " + gpsInfo.toString());

		JSONObject json = new JSONObject();
		
		json.put("image", galleryDto.getGallery_path());
		json.put("login_id", galleryDto.getLogin_id());
		
		this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
		this.template.convertAndSend("/selectImage", json.toJSONString());
	}

	@RequestMapping(value = "/selectImage2")
	@ResponseBody
	public void selectImage2(@RequestBody GalleryDto galleryDto) {
		System.out.println("selectImage2()");
		//System.out.println("updateGpsInfo() = " + gpsInfo.toString());

		JSONObject json = new JSONObject();
		
		json.put("image", galleryDto.getGallery_path());
		json.put("login_id", galleryDto.getLogin_id());
		
		this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
		this.template.convertAndSend("/selectImage2", json.toJSONString());
	}
	
	@RequestMapping(value = "/selectGalImage")
	@ResponseBody
	public void selectGalImage(@RequestBody GalleryDto galleryDto) {
		System.out.println("selectGalImage()");
		//System.out.println("updateGpsInfo() = " + gpsInfo.toString());

		JSONObject json = new JSONObject();
		
		json.put("image", galleryDto.getGallery_path());
		json.put("login_id", galleryDto.getLogin_id());
		json.put("caseNum", galleryDto.getTags());
		
		this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
		this.template.convertAndSend("/selectGalImage", json.toJSONString());
	}
	
	@RequestMapping(value = "/deleteAsync", method = RequestMethod.POST)
	public String delete(String login_id) {
		System.out.println("deleteAsync()");

		files = new ArrayList<MultipartFile>();
		
		String case_num = login_id.split("/")[1];
		login_id = login_id.split("/")[0];
		
		JSONObject json = new JSONObject();
		json.put("user_name", login_id);
		json.put("user_passwd", "12lsxdfq");

		CaseDto caseDto = new CaseDto();
		
		caseDto.setCase_num(case_num);
		caseDto.setIsFailed("Y");
		
		eventDao.deleteAsync(caseDto);

		VersionDto versionDto = eventDao.selectVersionInfo("finder");
		String analyze_url = versionDto.getAnalyze_url().substring(0, versionDto.getAnalyze_url().lastIndexOf("/")) + "/search_async_delete";
		System.out.println("analyze_url = " + analyze_url);
		String response = post(analyze_url, json.toJSONString());
		
		System.out.println("response = " + response);

		return "./police/emap2";
		
	}
	
	@RequestMapping(value = "/stitchingUpload", method = RequestMethod.POST)
	public String stitchingUpload(MultipartHttpServletRequest request, String stitching_id, String caseNum, String isNew, String isCase) throws IOException, ParseException, ImageProcessingException {
		System.out.println("stitchingUpload()");
		
		if (isCase.equals("")) {
			isCase = null;
		}
		
		MultipartFile file = request.getFile("file");
		file.transferTo(new File("C:/web_server/image/" + caseNum + "/stitching.jpg"));

		JSONObject json = new JSONObject();
		json.put("stitching_id", stitching_id);
		json.put("isNew", isNew);
		json.put("isCase", isCase);

		this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
		this.template.convertAndSend("/stitchingUpload", json.toJSONString());
		
		return "./police/emap2";
	}
	
	int roiNum = 0;
	ArrayList<JSONObject> tagList = null;
	
	@RequestMapping(value = "/responseEvent", method = RequestMethod.POST)
	@ResponseBody
	public void responseEvent(@RequestBody Map<String, Object> map2) throws IOException, ParseException {
		System.out.println("responseEvent()");

		Map<String, Object> map = new HashMap();
		
        long start = System.currentTimeMillis();
		String response = new ObjectMapper().writeValueAsString(map2);

		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObject = (JSONObject)jsonParser.parse(response);
		String tmpUploadPath = map2.get("img_name").toString();
        //System.out.println("이미지 경로 = " + tmpUploadPath);
        
		JSONArray object_list = (JSONArray)jsonObject.get("object_list");
		JSONObject img_size = (JSONObject) jsonObject.get("img_size");
		//ArrayList<String> color_list = (ArrayList<String>) jsonObject.get("tags");
		JSONArray test2 = (JSONArray)jsonObject.get("object_list");
		int hWidth = toIntExact((Long)img_size.get("width"));
		int hHeight = toIntExact((Long)img_size.get("height"));
		String login_id = map2.get("user_name").toString();
		
        long nano = System.currentTimeMillis();
        
		//String dron_data = eventDao.updateGallery(galleryDto);
		//JSONObject dron_jsonObject = (JSONObject)jsonParser.parse(dron_data);
		//dron_jsonObject.put("object_list", object_list);

//		if (dron_data != null) {
//			this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
//			this.template.convertAndSend("/receiveDrone", dron_jsonObject.toJSONString().replaceAll("\\\\", ""));
//		}
		
		int num = Integer.parseInt(tmpUploadPath.substring(tmpUploadPath.lastIndexOf("/") + 1, tmpUploadPath.lastIndexOf(".")));
		
		if (num == 0) {
			roiNum = 0;
		}
		
		String isTag = "N";
		String status = "분석완료";
		String color = "blue";
		
		map.put("login_id", login_id);
		
		if (object_list.size() > 0) {
			isTag = "Y";
			status = "태그발견";
			color = "red";
			File f = new File("C:/web_server/image/" + tmpUploadPath.substring(tmpUploadPath.lastIndexOf("case")));
			EasyImage easyImage = new EasyImage(f);
			BufferedImage roiImg = ImageIO.read(f);
			if (!easyImage.isSupportedImageFormat()) {
				System.out.println("not supported image type");
			}
			for (int i = 0; i < object_list.size(); i++) {
				roiNum += 1;
				GalleryImageInfoDto galleryImageInfoDto = new GalleryImageInfoDto();
				JSONObject roi = (JSONObject)object_list.get(i);
				int x = toIntExact((Long)roi.get("x"));
				int y = toIntExact((Long)roi.get("y"));
				int width = toIntExact((Long)roi.get("width"));
				int height = toIntExact((Long)roi.get("height"));
				JSONArray bbox = (JSONArray) roi.get("bbox");
				JSONArray tags = (JSONArray) roi.get("tags");
				int drawX = Integer.parseInt(bbox.get(0).toString());
				int drawY = Integer.parseInt(bbox.get(1).toString());
				int drawX2 = Integer.parseInt(bbox.get(2).toString());
				int drawY2 = Integer.parseInt(bbox.get(3).toString());
				int drawWidth = drawX2 - drawX;
				int drawHeight = drawY2 - drawY;
				
				if (x < 0) {
					x = 0;
					roi.remove("x");
					roi.put("x", x);
				}
				if (y < 0) {
					y = 0;
					roi.remove("y");
					roi.put("y", y);
				}
				
				if (x + width >= hWidth) {
					width = (int) (hWidth - x - 1);
					roi.remove("width");
					roi.put("width", width);
				}
				
				if (y + height >= hHeight) {
					height = (int) (hHeight - y - 1);
					roi.remove("height");
					roi.put("height", height);
				}

				EasyImage resizedImage = easyImage.crop(x, y, width, height);
				FileOutputStream out = new FileOutputStream("C:/web_server/image/" + tmpUploadPath.substring(tmpUploadPath.lastIndexOf("case"), tmpUploadPath.lastIndexOf(".")) + "_crop" + i + ".jpg");
				resizedImage.writeTo(out, "jpg");
				out.close();

		        Graphics2D graph = roiImg.createGraphics();
		        graph.setColor(Color.RED);
		        Stroke stroke1 = new BasicStroke(3f);
		        graph.setStroke(stroke1);
		        graph.draw(new Rectangle(drawX, drawY, drawWidth, drawHeight));
		        graph.dispose();
		        
				galleryImageInfoDto.setGallery_favorites("N");
				galleryImageInfoDto.setGallery_login_id(login_id);
				galleryImageInfoDto.setGallery_img_name(tmpUploadPath.substring(0, tmpUploadPath.lastIndexOf(".")) + ".jpg");
				galleryImageInfoDto.setGallery_crop_name(tmpUploadPath.substring(0, tmpUploadPath.lastIndexOf(".")) + "_crop" + i + ".jpg");
				
				int[] gallery_bbox = new int[bbox.size()];
				
				for (int j = 0; j < bbox.size(); j++) {
					int val = Integer.parseInt(bbox.get(j).toString());
					gallery_bbox[j] = val;
				}
				
				galleryImageInfoDto.setGallery_bbox(gallery_bbox);
				galleryImageInfoDto.setGallery_confidence((double)(roi.get("confidence")));
				galleryImageInfoDto.setGallery_x(x);
				galleryImageInfoDto.setGallery_y(y);
				galleryImageInfoDto.setGallery_class_name(roi.get("class_name").toString());
				galleryImageInfoDto.setGallery_width(width);
				galleryImageInfoDto.setGallery_height(height);

				String[] gallery_tags = new String[tags.size()];
				
				for (int j = 0; j < tags.size(); j++) {
					String val = tags.get(j).toString();
					gallery_tags[j] = val;
				}
				
				galleryImageInfoDto.setGallery_tags(gallery_tags);
				galleryImageInfoDto.setGallery_hWidth(hWidth);
				galleryImageInfoDto.setGallery_hHeight(hHeight);
				galleryImageInfoDto.setGallery_case_num(tmpUploadPath.substring(tmpUploadPath.lastIndexOf("case"), tmpUploadPath.lastIndexOf("/")));
				galleryImageInfoDto.setGallery_roiNum(roiNum - 1);
				
				Finder finder = new Finder();
				finder.insertDashInfo(galleryImageInfoDto);
				
				map.put("gallery_crop_name", tmpUploadPath.substring(0, tmpUploadPath.lastIndexOf(".")) + "_crop" + i + ".jpg");
				map.put("gallery_imgName", tmpUploadPath.substring(0, tmpUploadPath.lastIndexOf(".")) + ".jpg");
				map.put("gallery_roiNum", roiNum - 1);
				
				map.put("gallery_confidence", (double)(roi.get("confidence")));
				map.put("gallery_class_name", roi.get("class_name").toString());
				map.put("gallery_colors", "{" + Arrays.toString(gallery_tags).substring(1, Arrays.toString(gallery_tags).length() - 1) + "}");
				map.put("case_idx", Integer.parseInt(tmpUploadPath.substring(tmpUploadPath.lastIndexOf("case") + 4, tmpUploadPath.lastIndexOf("/"))));
				
				map.put("gallery_x", x);
				map.put("gallery_y", y);
				map.put("gallery_width", width);
				map.put("gallery_height", height);
				
				int gallery_idx = eventDao.insertGallery_info(map);

				map.put("gallery_idx", gallery_idx);
				
				this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
				this.template.convertAndSend("/showImage1", new ObjectMapper().writeValueAsString(map));
				
				for (String tag_color : gallery_tags) {
					map.put("tag_color", tag_color);
					eventDao.insertTag_info(map);
				}
			}
			ImageIO.write(roiImg, "jpg", new File("C:/web_server/image/" + tmpUploadPath.substring(tmpUploadPath.lastIndexOf("case"), tmpUploadPath.lastIndexOf(".")) + "_roi" + ".jpg"));
						
			map.put("case_roi_count", object_list.size());
			eventDao.updateCase_roi_count(map);
		}
		
		map.put("num", num);
		map.put("case_idx", tmpUploadPath.substring(tmpUploadPath.lastIndexOf("case") + 4, tmpUploadPath.lastIndexOf("/")));
		map.put("isTag", isTag);
		
		this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
		this.template.convertAndSend("/endAnalyse", new ObjectMapper().writeValueAsString(map));
		
		map.put("gps_imgname", tmpUploadPath.substring(0, tmpUploadPath.lastIndexOf(".")) + ".jpg");
		map.put("gps_color", color);
		map.put("gps_status", status);
		
		eventDao.updateGps_info(map);
		
		this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
		this.template.convertAndSend("/endProcess", new ObjectMapper().writeValueAsString(map));

		this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
		this.template.convertAndSend("/selectEndCase", new ObjectMapper().writeValueAsString(map));
	}

	@Resource(name = "uploadPath")
	private String uploadPath;

	@RequestMapping(value = "/resize")
	public void police_resize() throws IOException {
		System.out.println("police_resize");
		File f = new File("C:/web_server/image/case17/7 - 복사본 (2).jpg");
		//System.out.println(f.getName());
		EasyImage easyImage = new EasyImage(f);
		if (!easyImage.isSupportedImageFormat()) {
			System.out.println("not supported image type");
		}
		/*resize*/
		EasyImage resizedImage = easyImage.resize(640, 480);
		FileOutputStream out = new FileOutputStream("C:/web_server/image/case17/123456.jpg");
		resizedImage.writeTo(out, "jpg");
	}

	/** * @description 압축 메소드 * @param path 압축할 폴더 경로 * @param outputFileName 출력파일명 */
	public boolean compress(String path, String outputPath, String outputFileName, String login_id, String isCase, String isNew) throws Throwable {
		// 파일 압축 성공 여부
		boolean isChk = false; 

		File file = new File(path);

		// 압축 경로 체크
		if (!file.exists()) {
			throw new Exception("Not File!");
		}
		
		// 파일의 .zip이 없는 경우, .zip 을 붙여준다.
		int pos = outputFileName.lastIndexOf(".") == -1 ? outputFileName.length() : outputFileName.lastIndexOf(".");
		
		// outputFileName .zip이 없는 경우
		if (!outputFileName.substring(pos).equalsIgnoreCase(".zip")) { 
			outputFileName += ".zip";
		} 
		
		// 출력 스트림 
		FileOutputStream fos = null;
		// 압축 스트림
		ZipOutputStream zos = null; 
		
		try { 
			fos = new FileOutputStream(new File(outputPath + outputFileName));
			zos = new ZipOutputStream(fos);
			
			// 디렉토리 검색를 통한 하위 파일과 폴더 검색
			searchDirectory(file, file.getPath(), zos, login_id, isCase, isNew); 
			
			// 압축 성공.
			isChk = true;
		} catch (Throwable e) {
			throw e; 
		} finally {
			if (zos != null)
				zos.close();
			if (fos != null)
				fos.close(); 
		} 
		return isChk; 
	} 

	public boolean compress2(String path, String outputPath, String outputFileName, String login_id) throws Throwable {
		// 파일 압축 성공 여부
		boolean isChk = false; 

		File file = new File(path);

		// 압축 경로 체크
		if (!file.exists()) {
			throw new Exception("Not File!");
		}
		
		// 파일의 .zip이 없는 경우, .zip 을 붙여준다.
		int pos = outputFileName.lastIndexOf(".") == -1 ? outputFileName.length() : outputFileName.lastIndexOf(".");
		
		// outputFileName .zip이 없는 경우
		if (!outputFileName.substring(pos).equalsIgnoreCase(".zip")) { 
			outputFileName += ".zip";
		} 
		
		// 출력 스트림 
		FileOutputStream fos = null;
		// 압축 스트림
		ZipOutputStream zos = null; 
		
		try { 
			fos = new FileOutputStream(new File(outputPath + outputFileName));
			zos = new ZipOutputStream(fos);
			
			// 디렉토리 검색를 통한 하위 파일과 폴더 검색
			searchDirectory2(file, file.getPath(), zos, login_id); 
			
			// 압축 성공.
			isChk = true;
		} catch (Throwable e) {
			throw e; 
		} finally {
			if (zos != null)
				zos.close();
			if (fos != null)
				fos.close(); 
		} 
		return isChk; 
	} 
	
	/** * @description 디렉토리 탐색 * @param file 현재 파일 * @param root 루트 경로 * @param zos 압축 스트림 */
	private void searchDirectory(File file, String root, ZipOutputStream zos, String login_id, String isCase, String isNew) throws Exception { 
		// 지정된 파일이 디렉토리인지 파일인지 검색
		if (file.isDirectory()) {
			// 디렉토리일 경우 재탐색(재귀) 
			File[] files = file.listFiles(); 
			int length = files.length;
			
			int count = 0;
			for (File f : files) {
				count++;
				int per = 100 * count / length;
				//System.out.println(per);
				
				if (count == length) { 
					per = 100;
				} else {
					if (login_id != null) {
						JSONObject json = new JSONObject();
						json.put("login_id", login_id);
						json.put("per", per + "%");
						json.put("isCase", isCase);
						json.put("isNew", isNew);

						this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
						this.template.convertAndSend("/imageDownload", json.toJSONString());
					}
				}
								
				//System.out.println("file = > " + f);
				//System.out.println("per = " + per);
				//this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
				//this.template.convertAndSend("/imageDownload", length);
				searchDirectory(f, root, zos, login_id, isCase, isNew);
			}
		} else { 
			// 파일일 경우 압축을 한다.
			try {
				compressZip(file, root, zos, null); 
			} catch (Throwable e) { 
				// TODO Auto-generated catch block 
				e.printStackTrace(); 
			}
		} 
	} 

	/** * @description 디렉토리 탐색 * @param file 현재 파일 * @param root 루트 경로 * @param zos 압축 스트림 */
	private void searchDirectory2(File file, String root, ZipOutputStream zos, String login_id) throws Exception { 
		// 지정된 파일이 디렉토리인지 파일인지 검색
			
			// 파일일 경우 압축을 한다.
			try {
				compressZip2(file, root, zos); 
			} catch (Throwable e) { 
				// TODO Auto-generated catch block 
				e.printStackTrace(); 
			}
	} 
	
	/** * @description압축 메소드 * @param file * @param root * @param zos * @throws Throwable */
	private void compressZip(File file, String root, ZipOutputStream zos, String chkMulti) throws Throwable {
		FileInputStream fis = null;
		try {
			String zipName = "";
			zipName = file.getPath().replace(root + "\\", "");
			// 파일을 읽어드림 
			fis = new FileInputStream(file);
			//System.out.println("file = " + file);
			// Zip엔트리 생성(한글 깨짐 버그) 
			ZipEntry zipentry = new ZipEntry(zipName); 
			// 스트림에 밀어넣기(자동 오픈) 
			zos.putNextEntry(zipentry); 
			int length = (int) file.length(); 
			byte[] buffer = new byte[length];
			// 스트림 읽어드리기 
			fis.read(buffer, 0, length); 
			// 스트림 작성 
			zos.write(buffer, 0, length); 
			// 스트림 닫기 
			zos.closeEntry(); 
		} catch (Throwable e) {
			throw e;
		} finally { 
			if (fis != null)
				fis.close();
		} 
	} 
	/** * @description압축 메소드 * @param file * @param root * @param zos * @throws Throwable */
	private void compressZip2(File file, String root, ZipOutputStream zos) throws Throwable {
		FileInputStream fis = null;
		try {
			String zipName = "";
			zipName = file.getPath().replace(root + "\\", "");
			// 파일을 읽어드림 
			fis = new FileInputStream(file);
			//System.out.println("file = " + file);
			// Zip엔트리 생성(한글 깨짐 버그) 
			ZipEntry zipentry = new ZipEntry(zipName); 
			// 스트림에 밀어넣기(자동 오픈) 
			zos.putNextEntry(zipentry); 
			int length = (int) file.length(); 
			byte[] buffer = new byte[length];
			// 스트림 읽어드리기 
			fis.read(buffer, 0, length); 
			// 스트림 작성 
			zos.write(buffer, 0, length); 
			// 스트림 닫기 
			zos.closeEntry(); 
		} catch (Throwable e) {
			throw e;
		} finally { 
			if (fis != null)
				fis.close();
		} 
	} 
	public File convert(MultipartFile multipartFile) throws IOException {
		//System.out.println("convert()");
	    File file= new File(multipartFile.getOriginalFilename());
	    file.createNewFile();
	    FileOutputStream fos = new FileOutputStream(file);
	    fos.write(multipartFile.getBytes());
	    fos.close();
	    return file;
	}
	
	public List<MultipartFile> sortData(List<MultipartFile> sortFiles) throws IOException, ImageProcessingException {
		List<MultipartFile> fileData = new ArrayList<MultipartFile>();
		JSONArray jsonArray = new JSONArray();
		List<JSONObject> jsonList = new ArrayList<JSONObject>();
		
		for (int i = 0; i < sortFiles.size(); i++) {
			File file = convert(sortFiles.get(i));
			String file_name = file.getName();
			if (file_name.substring(file_name.lastIndexOf(".") + 1).equals("jpg") || file_name.substring(file_name.lastIndexOf(".") + 1).equals("JPG")) {
				Metadata metadata = ImageMetadataReader.readMetadata(file);
				
				ExifSubIFDDirectory directory = metadata.getDirectory(ExifSubIFDDirectory.class);
				
				String imgTime = null;
				if (directory != null && directory.getDate(ExifSubIFDDirectory.TAG_DATETIME_ORIGINAL, TimeZone.getDefault()) != null) {
					Date originalDate = directory.getDate(ExifSubIFDDirectory.TAG_DATETIME_ORIGINAL, TimeZone.getDefault());
					if (originalDate != null) {
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
						imgTime = sdf.format(originalDate);
					    //System.out.println("예외 없음 : " + imgTime);
					}
				} else {
					BasicFileAttributes attrs;
					try {
					    attrs = Files.readAttributes(file.toPath(), BasicFileAttributes.class);
					    FileTime time = attrs.creationTime();
					    
					    String pattern = "yyyy-MM-dd HH:mm:ss";
					    SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
						
					    imgTime = simpleDateFormat.format( new Date( time.toMillis() ) );

					    //System.out.println("예외 있음 : " + imgTime);
					} catch (IOException e) {
					    e.printStackTrace();
					}
				}
				
				JSONObject json = new JSONObject();
				json.put("imgTime", imgTime);
				json.put("num", i);
				jsonArray.add(json);
				jsonList.add(json);
//				System.out.println("정렬 전 = " + jsonArray.get(i).toString());
			}
		    file.delete();
		}
		
		Collections.sort(jsonList, new Comparator<JSONObject>() {
		    public int compare(JSONObject a, JSONObject b) {
		        String valA = new String();
		        String valB = new String();

	            valA = (String) a.get("imgTime");
	            valB = (String) b.get("imgTime");

		        return valA.compareTo(valB);
		    }
		});
		
		for (int j = 0; j < jsonList.size(); j++) {
			//System.out.println("정렬 후 = " + jsonList.get(j).toJSONString());
			int num = (Integer)jsonList.get(j).get("num");
			fileData.add(sortFiles.get(num));
		}
		
		return fileData;
	}
	
	@RequestMapping(value = "/download", method = RequestMethod.GET)
	public void police_download() {
		System.out.println("police_download()");

		File savefile;
		String savePathName;
		String fileName = "test.jpg";
		
		JFileChooser chooser = new JFileChooser();
		chooser.setCurrentDirectory(new File("C:\\"));
		chooser.setFileSelectionMode(chooser.DIRECTORIES_ONLY);
		
		int re = chooser.showSaveDialog(null);
		if (re == JFileChooser.APPROVE_OPTION) {
			
		}
	}

	@RequestMapping(value = "/receiveGps")	// finder에서 pol_finder로부터 받을 메서드
	@ResponseBody
	public void insertData(@RequestBody RoomGpsInfoDto roomGpsInfoDto) {
		System.out.println("receiveGps()");

		System.out.println("파인더에서 받은 데이터 = " + roomGpsInfoDto.getRoom_gps_time());

		Finder finder = new Finder();
		
		ReceiveGpsInfoDto receiveGpsInfoDto = finder.insertReceiveGpsInfo(roomGpsInfoDto, conn);
		
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = "";

		try {
			jsonStr = mapper.writeValueAsString(receiveGpsInfoDto);
		} catch (Exception e1) {
			System.out.println("오류 발생");
			e1.printStackTrace();
		}

		this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
		this.template.convertAndSend("/receiveGps", jsonStr.replaceAll("\\\\", ""));
	}

	@RequestMapping(value = "/pol_receiveGps")	// pol_finder에서 finder로부터 받을 메서드
	@ResponseBody
	public void pol_insertData(@RequestBody RoomGpsInfoDto roomGpsInfoDto) {
		System.out.println("pol_receiveGps()");

		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = "";

		try {
			jsonStr = mapper.writeValueAsString(roomGpsInfoDto);
		} catch (Exception e1) {
			System.out.println("오류 발생");
			e1.printStackTrace();
		}

		this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
		this.template.convertAndSend("/pol_update", jsonStr.replaceAll("\\\\", ""));
	}
	
	public void postSendPol(final String jsonMessage) throws IOException {		// post로 데이터를 보내는 메서드
		System.out.println("postSendPol()");

		URL url = new URL(sendPolUrl);
		
		Runnable runnable = new Runnable() {
			@Override
		    public void run() {
		        //스레드에게 시킬 작업 내용
                long start = System.currentTimeMillis();
				try {
					ignoreSsl();

					HttpsURLConnection sendPolConn = (HttpsURLConnection)url.openConnection();
					
					sendPolConn.setRequestMethod("POST");

					sendPolConn.setDoInput(true);

					sendPolConn.setDoOutput(true);

					sendPolConn.setRequestProperty("Content-Type", "application/json");

					OutputStream outputStream = sendPolConn.getOutputStream();
                    BufferedWriter bufferedWriter = new BufferedWriter(new OutputStreamWriter(outputStream, "UTF-8"));

                    bufferedWriter.write(jsonMessage);

                    bufferedWriter.flush();

                    bufferedWriter.close();

                    outputStream.close();
                    
					sendPolConn.connect();
					
                    StringBuilder responseStringBuilder = new StringBuilder();
                    if (sendPolConn.getResponseCode() == HttpURLConnection.HTTP_OK){
                        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(sendPolConn.getInputStream()));
                        bufferedReader.close();
                    }
                    sendPolConn.disconnect();
				} catch (Exception e) {
					e.printStackTrace();
				}

                long nano = System.currentTimeMillis();
                System.out.println("폴파인더로 데이터 전송 시간 = " + (nano - start)/1000.0 + "초");
		    }
		};
		//스레드풀에게 작업 처리 요청
		executorService.submit(runnable);
	}
	
	public void postSendFinder(final String jsonMessage, String group, String id) throws IOException {
		System.out.println("postSendFinder()");

		if (localAddress.get(group) != null) {
			JSONObject jsonObject = (JSONObject) localAddress.get(group);
			Iterator<String> iter = jsonObject.keySet().iterator();
		
			System.out.println("로컬 그룹 = " + group);
			
			while(iter.hasNext()) {
				String key = iter.next();
				
				AppUserInfoDto appUserInfoDto = (AppUserInfoDto) jsonObject.get(key);

				Runnable runnable = new Runnable() {
					@Override
				    public void run() {
				        //스레드에게 시킬 작업 내용
		                long start = System.currentTimeMillis();
						try {
							ignoreSsl();
							
							URL url = new URL(appUserInfoDto.getLocal_ip() + ":" + appUserInfoDto.getLocal_port() + "/police/receiveGps");

							HttpsURLConnection sendFinderConn = (HttpsURLConnection)url.openConnection();
							
							System.out.println(sendFinderConn.getURL());
							
							sendFinderConn.setRequestMethod("POST");

							sendFinderConn.setDoInput(true);

							sendFinderConn.setDoOutput(true);

							sendFinderConn.setRequestProperty("Content-Type", "application/json");
							
							OutputStream outputStream = sendFinderConn.getOutputStream();
		                    BufferedWriter bufferedWriter = new BufferedWriter(new OutputStreamWriter(outputStream, "UTF-8"));

		                    bufferedWriter.write(jsonMessage);

		                    bufferedWriter.flush();

		                    bufferedWriter.close();

		                    outputStream.close();
		                    
							sendFinderConn.connect();

		                    StringBuilder responseStringBuilder = new StringBuilder();
		                    if (sendFinderConn.getResponseCode() == HttpURLConnection.HTTP_OK){
		                        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(sendFinderConn.getInputStream()));
		                        bufferedReader.close();
		                    }
		                    
		                    sendFinderConn.disconnect();
						} catch (Exception e) {
							e.printStackTrace();
						}

		                long nano = System.currentTimeMillis();
		                System.out.println("파인더로 데이터 전송 시간 = " + (nano - start)/1000.0 + "초");
				    }
				};
				//스레드풀에게 작업 처리 요청
				executorService.submit(runnable);
			}
		}
		
	}
	public static void ignoreSsl() throws Exception{
        HostnameVerifier hv = new HostnameVerifier() {
        	public boolean verify(String urlHostName, SSLSession session) {
                return true;
            }
        };
        trustAllHttpsCertificates();
        HttpsURLConnection.setDefaultHostnameVerifier(hv);
    }
	private static void trustAllHttpsCertificates() throws Exception {
	    TrustManager[] trustAllCerts = new TrustManager[1];
	    TrustManager tm = new miTM();
	    trustAllCerts[0] = tm;
	    SSLContext sc = SSLContext.getInstance("SSL");
	    sc.init(null, trustAllCerts, null);
	    HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());
	}
	
	static class miTM implements TrustManager,X509TrustManager {
	    public X509Certificate[] getAcceptedIssuers() {
	        return null;
	    }
	
	    public boolean isServerTrusted(X509Certificate[] certs) {
	        return true;
	    }
	
	    public boolean isClientTrusted(X509Certificate[] certs) {
	        return true;
	    }
	
	    public void checkServerTrusted(X509Certificate[] certs, String authType)
	            throws CertificateException {
	        return;
	    }
	
	    public void checkClientTrusted(X509Certificate[] certs, String authType)
	            throws CertificateException {
	        return;
	    }
	}

	public String postSendServer(String jsonMessage) throws IOException {		// post로 데이터를 보내는 메서드
		System.out.println("postSendServer()");

		VersionDto versionDto = eventDao.selectVersionInfo("server");
		
		String serverUrl = versionDto.getAnalyze_url();
		
		URL url = new URL(serverUrl);
		
		String json = "";

        //스레드에게 시킬 작업 내용
        long start = System.currentTimeMillis();
		try {
			ignoreSsl();

			HttpsURLConnection sendPolConn = (HttpsURLConnection)url.openConnection();
			
			sendPolConn.setRequestMethod("POST");

			sendPolConn.setDoInput(true);

			sendPolConn.setDoOutput(true);

			sendPolConn.setRequestProperty("Content-Type", "application/json");

			OutputStream outputStream = sendPolConn.getOutputStream();
            BufferedWriter bufferedWriter = new BufferedWriter(new OutputStreamWriter(outputStream, "UTF-8"));

            bufferedWriter.write(jsonMessage);

            bufferedWriter.flush();

            bufferedWriter.close();

            outputStream.close();
            
			sendPolConn.connect();
			
            StringBuilder responseStringBuilder = new StringBuilder();
            if (sendPolConn.getResponseCode() == HttpURLConnection.HTTP_OK){
                BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(sendPolConn.getInputStream()));
                String output;
                while ((output = bufferedReader.readLine()) != null) {
                	json += output;
                }
                bufferedReader.close();
            }
            sendPolConn.disconnect();
		} catch (Exception e) {
			e.printStackTrace();
		}

        long nano = System.currentTimeMillis();
        System.out.println("폴파인더로 데이터 전송 시간 = " + (nano - start)/1000.0 + "초");
        
        return json;
	}

	JSONObject insert_case = new JSONObject(); 
	
	@RequestMapping(value = "/insertImage", method = RequestMethod.POST)
	@ResponseBody
	public void police_insertImage(@RequestBody InsertImageDto insertImageDto) throws IOException, ParseException, ImageProcessingException, java.text.ParseException {
		System.out.println("police_insertImage()");

		String analyze_content = insertImageDto.getAnalyze_content();
		String login_id = insertImageDto.getLogin_id();
		int max_frame = insertImageDto.getMax_frame();
		int img_num = insertImageDto.getImg_num();
		
		if (insertImageDto.getImg_data() == null || insertImageDto.getImg_data().equals("")) {
			System.out.println("이미지 없음");
		} else {
			String img_data = insertImageDto.getImg_data();
			if (analyze_content.equals("")) {
		    	String pattern2 = "yyyy년 MM월 dd일 HH시 mm분 ss초";
			    SimpleDateFormat simpleDateFormat2 = new SimpleDateFormat(pattern2);
		    	
			    analyze_content = simpleDateFormat2.format(new Date());
			    insertImageDto.setAnalyze_content(analyze_content);
			}
			
			String caseNum = eventDao.selectRecentCase();
			
			if (insertImageDto.getImg_num() == 0) {
				if (caseNum == null) {
					caseNum = "case1";
				} else {
					int caseNumber = Integer.parseInt(caseNum.substring(caseNum.lastIndexOf("e") + 1));
					caseNum = caseNum.substring(caseNum.indexOf("case"), caseNum.indexOf("e") + 1) + (caseNumber + 1);
				}

				insert_case.put(login_id, caseNum);
				
				// 폴더 경로 잡아줌
				String uploadPath = "C:/web_server";
				File folder = new File(uploadPath);
				
				if (!folder.exists()) {
					try {
						folder.mkdir();
						//System.out.println("폴더 생성");
					} catch (Exception e) {
						e.getStackTrace();
					}
				} else {
					//System.out.println("폴더가 이미 존재합니다.");
				}
				
				uploadPath = "C:/web_server/image";
				folder = new File(uploadPath);
				File[] fileLength = folder.listFiles();
				
				if (!folder.exists()) {
					try {
						folder.mkdir();
						//System.out.println("폴더 생성");
					} catch (Exception e) {
						e.getStackTrace();
					}
				} else {
					//System.out.println("폴더가 이미 존재합니다.");
				}
				
				uploadPath = "C:/web_server/image/" + caseNum;
				folder = new File(uploadPath);
				
				if (!folder.exists()) {
					try {
						folder.mkdir();
						//System.out.println("폴더 생성");
					} catch (Exception e) {
						e.getStackTrace();
					}
				} else {
					//System.out.println("폴더가 이미 존재합니다.");
				}
				// 폴더 경로 잡아줌 끝

				// caseinfo에 login_id, case_num, count 넣어줌 
				
				JSONObject tmpJson = new JSONObject();
				tmpJson.put("count", max_frame);
				tmpJson.put("login_id", login_id);
				tmpJson.put("case_num", caseNum);
				tmpJson.put("checkedTrash", "N");
				tmpJson.put("checkedGray", "N");
				tmpJson.put("checkedYellow", "N");
				tmpJson.put("checkedConfidence", "N");
				//tmpJson.put("isFailed", "N");
				tmpJson.put("analyze_content", analyze_content);
				eventDao.insertCase(tmpJson.toJSONString());
				
				// post로 보낼 정보들 담을 json
				JSONObject json = new JSONObject();
				// post로 보내고 난 결과를 담을 문자열
				String response = "";

				InetAddress local; 
				String ip = "";
				
				try { 
					local = InetAddress.getLocalHost(); 
					ip = local.getHostAddress(); 
				} catch (UnknownHostException e1) {
					e1.printStackTrace();
				}

				this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
				this.template.convertAndSend("/fileCount", tmpJson.toString());
				this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
				this.template.convertAndSend("/fileCount2", tmpJson.toString());
			}

			System.out.println("insertImage = " + img_num + " / " + max_frame);
			
			caseNum = insert_case.get(login_id).toString();
			
			String data = img_data;
			
			byte[] imageBytes = DatatypeConverter.parseBase64Binary(data);

			try {
		        File lOutFile = new File(uploadPath + "/" + caseNum + "/" + img_num + ".jpg");
		        
		        FileOutputStream lFileOutputStream = new FileOutputStream(lOutFile);

		        lFileOutputStream.write(imageBytes);

		        lFileOutputStream.close();

			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("원본 이미지 저장 안됨");
			}

			File f = new File(uploadPath + "/" + caseNum + "/" + img_num + ".jpg");
			String thumb_name = uploadPath + "/" + caseNum + "/" + img_num + "_thumb.jpg";
			JSONObject exifJson = new JSONObject();
			
			try {
				EasyImage easyImage = new EasyImage(f);
				BufferedImage bi = ImageIO.read(f);
				
				if (!easyImage.isSupportedImageFormat()) {
					System.out.println("not supported image type");
				}

				exifJson.put("width", bi.getWidth());
				exifJson.put("height", bi.getHeight());
				
				if (bi.getWidth() < 640 || bi.getHeight() < 480) {       
			        File lOutFile = new File(thumb_name);

			        FileOutputStream lFileOutputStream = new FileOutputStream(lOutFile);

			        lFileOutputStream.write(imageBytes);

			        lFileOutputStream.close();
			        
				} else {
					// resize
					EasyImage resizedImage = easyImage.resize(640, 480);
					
					FileOutputStream out = new FileOutputStream(thumb_name);
					
					resizedImage.writeTo(out, "jpg");
					
					out.close();
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println("썸네일 이미지 저장 안됨");
			}
					
			// 업로드 한 이미지들을 1개씩 작업할 반복문
			VersionDto versionDto = eventDao.selectVersionInfo("finder");
			String analyze_time = "";
			// 이미지 파일 1개를 담음

			/* 객체 인식 정보 보내는 과정*/
			
			String tmpUploadPath = "/webserver/image/" + caseNum;
			
			JSONObject json = new JSONObject();
			
			json.put("img_data", img_data);
			json.put("img_type", "jpg");
			json.put("event_request", "People Detect");
			json.put("img_name", "/police" + tmpUploadPath + "/" + img_num + ".jpg");
			json.put("user_name", login_id);
			json.put("user_passwd", "1234xxx");
			json.put("client_code", versionDto.getClient_code());
			//json.put("client_code", "poldrone");
			json.put("request_url", versionDto.getRequest_url());
			//json.put("request_url", "https://192.168.100.101:20101/police/responseEvent");

			/* 이미지 객체 인식*/
			String response = post(versionDto.getAnalyze_url(), json.toJSONString());

			Calendar cal = Calendar.getInstance();
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			String first_date = insertImageDto.getImg_time();
			
			String img_play_time = insertImageDto.getImg_play_time();
			
			String play_hour = img_play_time.split(":")[0]; 
			String play_minute = img_play_time.split(":")[1];
			String play_sec = img_play_time.split(":")[2];
			
			Date endTime = sdf.parse(first_date);
			
			cal.setTime(endTime);
			cal.add(Calendar.HOUR_OF_DAY, Integer.parseInt(play_hour));
			cal.add(Calendar.MINUTE, Integer.parseInt(play_minute));
			cal.add(Calendar.SECOND, Integer.parseInt(play_sec));
			
			String end_date = sdf.format(cal.getTime());
			
			analyze_time = first_date + " ~ " + end_date;
			
			String wtmX = insertImageDto.getWtmX();
			String wtmY = insertImageDto.getWtmY();
			
			exifJson.put("imgTime", insertImageDto.getImg_time());
			exifJson.put("wtmX", wtmX);
			exifJson.put("wtmY", wtmY);
			exifJson.put("original_image", "/police" + tmpUploadPath + "/" + img_num + ".jpg");
			exifJson.put("image", "/police" + tmpUploadPath + "/" + img_num + "_thumb" + ".jpg");
			exifJson.put("login_id", login_id);
			
			eventDao.insertGallery(exifJson.toString().replaceAll("\\\\", ""));

			//System.out.println("showImage = " + exifJson.toString().replaceAll("\\\\", ""));
			this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
			this.template.convertAndSend("/showImage", exifJson.toString().replaceAll("\\\\", ""));
			
			GpsDto gpsDto = new GpsDto();
			gpsDto.setCaseNum(caseNum);
			gpsDto.setStatus("분석중");
			gpsDto.setTmpNum(img_num + "");
			gpsDto.setColor("green");
			
			insertGpsInfo(gpsDto);
			
			CaseDto caseDto = new CaseDto();
			caseDto.setCase_num(caseNum);
			caseDto.setImage_time(analyze_time);
			caseDto.setAnalyze_content(analyze_content);
			eventDao.updateImageTime(caseDto);
			
			//System.out.println("이미지 시작과 끝 시간 = " + analyze_time);
			//System.out.println("수색 내용 = " + analyze_content);
			
		}
	}

	@RequestMapping(value = "/selectChkImage")
	@ResponseBody
	public List<Map<String, Object>> selectChkImage(@RequestBody Map<String, Object> map) {
		System.out.println("police_selectChkImage()");

		ArrayList<String> arrayList = (ArrayList<String>) map.get("chk_tag");

		if (map.get("checked") != null) {
			//eventDao.updateColorChecked(map);
		}
		
		List<Map<String, Object>> gallery_list = eventDao.selectChkImage(map);
		System.out.println("selectChkImage = " + gallery_list.size());
		
		
		return gallery_list;
		
	}
}
