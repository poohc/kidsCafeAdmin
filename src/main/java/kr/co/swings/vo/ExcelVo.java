package kr.co.swings.vo;

import java.util.Map;

import org.codehaus.jackson.map.ObjectMapper;

public class ExcelVo {
	
	private String sheetName;
	private String[] columnNameArray;
	private String[] dbColumnNameArray;
	private int[] columnWidthArray;
	
	public String getSheetName() {
		return sheetName;
	}
	public void setSheetName(String sheetName) {
		this.sheetName = sheetName;
	}
	public String[] getColumnNameArray() {
		return columnNameArray;
	}
	public void setColumnNameArray(String[] columnNameArray) {
		this.columnNameArray = columnNameArray;
	}
	public int[] getColumnWidthArray() {
		return columnWidthArray;
	}
	public void setColumnWidthArray(int[] columnWidthArray) {
		this.columnWidthArray = columnWidthArray;
	}
	public String[] getDbColumnNameArray() {
		return dbColumnNameArray;
	}
	public void setDbColumnNameArray(String[] dbColumnNameArray) {
		this.dbColumnNameArray = dbColumnNameArray;
	}
	
	@Override
	public String toString() {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> stringMap = mapper.convertValue(this, Map.class);
		return stringMap.toString();
	}
	
}