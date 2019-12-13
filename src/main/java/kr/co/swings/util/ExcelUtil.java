package kr.co.swings.util;

import java.util.List;
import java.util.Map;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFDataFormat;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.co.swings.vo.ExcelVo;

@Repository
public class ExcelUtil {
	
	private static final Logger logger = LoggerFactory.getLogger(ExcelUtil.class);
	
	public SXSSFWorkbook createExcelWorkbook(ExcelVo excelVo, List<Map<String, Object>> list) {
		SXSSFWorkbook workbook = new SXSSFWorkbook();
        
		 //엑셀 스타일 설정
        Font headerFont = workbook.createFont();
        headerFont.setFontName("나눔고딕");
        headerFont.setFontHeight((short)300);
        headerFont.setColor(IndexedColors.BLACK.getIndex());
        headerFont.setBold(true);
            
        CellStyle headerStyle = workbook.createCellStyle();
        headerStyle.setAlignment(HorizontalAlignment.LEFT);
        headerStyle.setVerticalAlignment(VerticalAlignment.BOTTOM);
        headerStyle.setBorderLeft(BorderStyle.DASH_DOT);
        headerStyle.setBorderBottom(BorderStyle.MEDIUM);
        headerStyle.setBorderRight(BorderStyle.MEDIUM_DASH_DOT);
        headerStyle.setFont(headerFont);
            
        CellStyle bodyStyle = workbook.createCellStyle();
        bodyStyle.setAlignment(HorizontalAlignment.CENTER);
        bodyStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        bodyStyle.setBorderTop(BorderStyle.THIN);
        bodyStyle.setBorderBottom(BorderStyle.THIN);
        bodyStyle.setBorderLeft(BorderStyle.THIN);
        bodyStyle.setBorderRight(BorderStyle.THIN);
        XSSFDataFormat format = (XSSFDataFormat) workbook.createDataFormat();
        bodyStyle.setDataFormat(format.getFormat("#,##0"));
		
        // 시트 생성
        SXSSFSheet sheet = workbook.createSheet(excelVo.getSheetName());
        
        for(int columnWidth : excelVo.getColumnWidthArray()) {
        	//시트 열 너비 설정
        	sheet.setColumnWidth(0, 10000);
        }
        
        // 헤더 행 생
        Row headerRow = sheet.createRow(0);
        
        Cell headerCell;
        for(int i=0; i < excelVo.getColumnNameArray().length; i++) {
        	headerCell = headerRow.createCell(i);
        	headerCell.setCellValue(excelVo.getColumnNameArray()[i]);
        	headerCell.setCellStyle(bodyStyle);
        }
        
        // 과일표 내용 행 및 셀 생성
        Row bodyRow = null;
        Cell bodyCell = null;
        
        for(int i=0; i<list.size(); i++) {
            // 행 생성
            bodyRow = sheet.createRow(i+1);
            
            Map<String, Object> dataMap  = list.get(i);
            
            for(int j=0; j<excelVo.getDbColumnNameArray().length; j++) {
            	bodyCell = bodyRow.createCell(j);
                
            	if(!"null".equals(String.valueOf(dataMap.get(excelVo.getDbColumnNameArray()[j])))) {
            		bodyCell.setCellValue(String.valueOf(dataMap.get(excelVo.getDbColumnNameArray()[j])));
            	} else {
            		bodyCell.setCellValue(" ");
            	}
            	bodyCell.setCellStyle(bodyStyle);
            }
        }
        
        return workbook;
	}
	
}
