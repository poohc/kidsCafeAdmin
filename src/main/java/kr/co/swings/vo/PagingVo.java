package kr.co.swings.vo;

import java.util.List;
import java.util.Map;

import org.codehaus.jackson.map.ObjectMapper;

public class PagingVo {
	int currentPage;
	int pageCount;
	String searchKeyword;
	String franchiseNum;
	String franchiseStatus;
	String searchMonth;
	List<String> franchiseNumList;
	
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getPageCount() {
		return pageCount;
	}
	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	public String getFranchiseNum() {
		return franchiseNum;
	}
	public void setFranchiseNum(String franchiseNum) {
		this.franchiseNum = franchiseNum;
	}
	public String getFranchiseStatus() {
		return franchiseStatus;
	}
	public void setFranchiseStatus(String franchiseStatus) {
		this.franchiseStatus = franchiseStatus;
	}
	public String getSearchMonth() {
		return searchMonth;
	}
	public void setSearchMonth(String searchMonth) {
		this.searchMonth = searchMonth;
	}
	public List<String> getFranchiseNumList() {
		return franchiseNumList;
	}
	public void setFranchiseNumList(List<String> franchiseNumList) {
		this.franchiseNumList = franchiseNumList;
	}
	
	@Override
	public String toString() {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> stringMap = mapper.convertValue(this, Map.class);
		return stringMap.toString();
	}
}