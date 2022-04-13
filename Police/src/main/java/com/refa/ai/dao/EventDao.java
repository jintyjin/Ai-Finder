package com.refa.ai.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.refa.ai.dto.CaseDto;
import com.refa.ai.dto.CaseJsonDto;
import com.refa.ai.dto.Case_info;
import com.refa.ai.dto.GalleryDto;
import com.refa.ai.dto.GpsDto;
import com.refa.ai.dto.ReceiveGpsInfoDto;
import com.refa.ai.dto.RoiDto;
import com.refa.ai.dto.UserDto;
import com.refa.ai.dto.VersionDto;

@Repository
public class EventDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public UserDto login(UserDto userDto) {
		return sqlSession.selectOne("sql.login", userDto);
	}

	public String selectRecentCase() {
		return sqlSession.selectOne("sql.selectRecentCase");
	}
	
	public void insertCase(String caseInfo) {
		sqlSession.insert("sql.insertCase", caseInfo);
	}

	public void insertGallery(String info) {
		sqlSession.insert("sql.insertGallery", info);
	}

	public String updateGallery(GalleryDto updateGallery) {
		return sqlSession.selectOne("sql.updateGallery", updateGallery);
	}
	public void updateCase(HashMap hashMap) {
		//System.out.println(updateCase.getCheckedTrash());
		sqlSession.insert("sql.updateCase", hashMap);
	}
	public void updateCase2(HashMap<String, Object> hashMap) {
		sqlSession.insert("sql.updateCase2", hashMap);
	}
	public void updateCase3(CaseDto updateCase) {
		sqlSession.insert("sql.updateCase3", updateCase);
	}
	public void deleteAsync(CaseDto updateCase) {
		sqlSession.insert("sql.deleteAsync", updateCase);
	}
	public void updateDash(CaseDto update) {
		sqlSession.insert("sql.updateDash", update);
	}
	
	public List<String> listGallery(String caseNum) {
		return sqlSession.selectList("sql.listGallery", caseNum);
	}

	public String selectCaseInfo(UserDto userDto) {
		return sqlSession.selectOne("sql.selectCaseInfo", userDto);
	}
	
	public void updateUserGallery(UserDto userDto) {
		sqlSession.insert("sql.updateUserGallery", userDto);
	}

	public void updateFavorites(Map<String, Object> map) {
		sqlSession.insert("sql.updateFavorites", map);
	}
	
	public void insertRoi(String roiInfo) {
		sqlSession.insert("sql.insertRoi", roiInfo);
	}

	public void insertDash(String dashInfo) {
		sqlSession.insert("sql.insertDash", dashInfo);
	}

	public List<String> listDash(String caseNum) {
		return sqlSession.selectList("sql.listDash", caseNum);
	}

	public List<String> selectGpsInfo(String caseNum) {
		return sqlSession.selectList("sql.selectGpsInfo", caseNum);
	}
	
	public void insertGpsInfo(GpsDto gpsInfo) {
		sqlSession.insert("sql.insertGpsInfo", gpsInfo);
	}

	public void updateGpsInfo(GpsDto gpsInfo) {
		sqlSession.insert("sql.updateGpsInfo", gpsInfo);
	}

	public VersionDto selectVersionInfo(String version_name) {
		return sqlSession.selectOne("sql.selectVersionInfo", version_name);
	}
	
	public void updateCode(VersionDto versionDto) {
		sqlSession.insert("sql.updateCode", versionDto);
	}

	public List<Map<String, Object>> selectAllCase(String login_id) {
		return sqlSession.selectList("sql.selectAllCase", login_id);
	}
	
	public void updateImageTime(CaseDto caseDto) {
		sqlSession.insert("sql.updateImageTime", caseDto);
	}

	public CaseJsonDto selectEndCase(CaseDto caseDto) {
		return sqlSession.selectOne("sql.selectEndCase", caseDto);
	}

	public String selectCase(UserDto userDto) {
		return sqlSession.selectOne("sql.selectCase", userDto);
	}

	public void updateAnalyzeContent(CaseDto updateCase) {
		sqlSession.insert("sql.updateAnalyzeContent", updateCase);
	}
	
	public void deleteCaseOne(String caseNum) {
		sqlSession.insert("sql.deleteCaseOne", caseNum);
	}

	public void deleteDashInfo(String caseNum) {
		sqlSession.insert("sql.deleteDashInfo", caseNum);
	}

	public void deleteGalleryInfo(String caseNum) {
		sqlSession.insert("sql.deleteGalleryInfo", caseNum);
	}

	public void deleteGpsInfo(String caseNum) {
		sqlSession.insert("sql.deleteGpsInfo", caseNum);
	}
	
	// json테이블을 일반 테이블 형식으로 수정 후
	public int insertCase_info(Map<String, Object> map) {
		return sqlSession.selectOne("sql.insertCase_info", map);
	}
	
	public void insertGps_info(Map<String, Object> map) {
		sqlSession.insert("sql.insertGps_info", map);
	}

	public void updateCase_time(Map<String, Object> map) {
		sqlSession.insert("sql.updateCase_time", map);
	}

	public int insertGallery_info(Map<String, Object> map) {
		return sqlSession.selectOne("sql.insertGallery_info", map);
	}
	
	public void insertTag_info(Map<String, Object> map) {
		sqlSession.insert("sql.insertTag_info", map);
	}

	public void updateGps_info(Map<String, Object> map) {
		sqlSession.insert("sql.updateGps_info", map);
	}
	
	public void updateCase_roi_count(Map<String, Object> map) {
		sqlSession.insert("sql.updateCase_roi_count", map);
	}

	public void updateCase_info(HashMap hashMap) {
		sqlSession.insert("sql.updateCase_info", hashMap);
	}

	public void updateCase_chk(HashMap hashMap) {
		sqlSession.insert("sql.updateCase_chk", hashMap);
	}

	public List<Map<String, Object>> selectGps_info(int case_idx) {
		return sqlSession.selectList("sql.selectGps_info", case_idx);
	}

	// e-map 페이지
	public List<Map<String, Object>> selectCase_gps(int case_idx) {
		return sqlSession.selectList("sql.selectCase_gps", case_idx);
	}

	public List<Map<String, Object>> clickPage_num(Map<String, Integer> map) {
		return sqlSession.selectList("sql.clickPage_num", map);
	}
	
	// gallery 페이지
	public List<Map<String, Object>> selectTag_info(Map<String, Integer> map) {
		return sqlSession.selectList("sql.selectTag_info", map);
	}
	
	public List<Map<String, Object>> selectCase_gallery(Map<String, Integer> map) {
		return sqlSession.selectList("sql.selectCase_gallery", map);
	}

	public Map<String, Object> selectRoi_image(Map<String, Object> map) {
		return sqlSession.selectOne("sql.selectRoi_image", map);
	}

	public List<Map<String, Object>> selectChkImage(Map<String, Object> map) {
		return sqlSession.selectList("sql.selectChkImage", map);
	}
	public void updateColorChecked(Map<String, Object> map) {
		sqlSession.insert("sql.updateColorChecked", map);
	}
	public String findCaseContentByCaseIdx(int case_idx) {
		return sqlSession.selectOne("sql.findCaseContentByCaseIdx", case_idx);
	}
	public List<Map> findCaseGpsByProgress100(ReceiveGpsInfoDto receiveGpsInfoDto) {
		return sqlSession.selectList("sql.findCaseGpsByProgress100", receiveGpsInfoDto);
	}
}
