package kr.co.swings.vo;

import java.util.List;

public class MemberVo {
	
	private String cellPhone;
	private String mcode;
	private String name;
	private String password;
	private String familyCnt;
	private List<String> familyKorA;
	private List<String> familyName;
	
	public String getCellPhone() {
		return cellPhone;
	}
	
	public void setCellPhone(String cellPhone) {
		this.cellPhone = cellPhone;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getFamilyCnt() {
		return familyCnt;
	}
	
	public void setFamilyCnt(String familyCnt) {
		this.familyCnt = familyCnt;
	}
	
	public List<String> getFamilyKorA() {
		return familyKorA;
	}
	
	public void setFamilyKorA(List<String> familyKorA) {
		this.familyKorA = familyKorA;
	}
	
	public List<String> getFamilyName() {
		return familyName;
	}
	
	public void setFamilyName(List<String> familyName) {
		this.familyName = familyName;
	}
	
	public String getMcode() {
		return mcode;
	}

	public void setMcode(String mcode) {
		this.mcode = mcode;
	}

	@Override
	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append("cellPhone : " + cellPhone + "\n");
		sb.append("name : " + name + "\n");
		sb.append("password : " + password + "\n");
		sb.append("familyCnt : " + familyCnt + "\n");
		sb.append("mcode : " + mcode + "\n");
		
		for(String kidsOrAdult : familyKorA) {
			sb.append("familyKorA : " + kidsOrAdult + "\n");
		}
		
		for(String fName : familyName) {
			sb.append("familyName : " + fName + "\n");
		}
		return sb.toString();
	}
	
}