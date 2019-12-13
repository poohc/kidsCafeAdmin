package kr.co.swings.util;

import kr.co.swings.vo.PagingVo;

public class PagingUtil {

	private final static int PAGE_COUNT = 10;
	
	/**
	 * 페이징 처리
	 * @param pagingVo
	 * @param totalCount
	 * @return
	 */
	public static String createPaging(PagingVo pagingVo, int totalCount) {
		int pageCount = PAGE_COUNT;
		int totalPage = 0;
		int firstPage = 1;
		int lastPage = 0;
		int currentPage = 0;
		int prevPage = 0;
		int nextPage = 0;
		
		int startPage = 1;
		int endPage = 1;
		
		if(pagingVo.getCurrentPage() == 0) {
			pagingVo.setCurrentPage(1);
		}
		
		pagingVo.setPageCount(pageCount);
		currentPage = pagingVo.getCurrentPage();
		
		if(totalCount % pageCount == 0) {
			totalPage = totalCount / pageCount;	
		} else {
			totalPage = (totalCount / pageCount) + 1;
		}
		
		lastPage = totalPage;
		
		if(currentPage <= pageCount) {
			prevPage = 1;
			startPage = 1;
		} else {
			prevPage = (((currentPage - 1) / pageCount) - 1) * pageCount + 1;
			startPage = (((currentPage - 1) / pageCount) - 1) * pageCount + (1 + pageCount);
		}
		
		if(totalPage <= pageCount) {
			nextPage = totalPage;
			endPage = totalPage;
		} else {
			nextPage = (((currentPage - 1) / pageCount) + 1) * pageCount + 1;
			endPage = ((currentPage - 1) / pageCount) * pageCount + 10;
			
			if(nextPage >= totalPage) {
				nextPage = totalPage;
			}
			
			if(endPage >= totalPage) {
				endPage = totalPage;
			}
			
		}
		
		StringBuffer pageSb = new StringBuffer();
		pageSb.append("<a class=\"arrow l cur\" onclick=\"movePage("+prevPage+")\">이전</a>");
		
		for(int i = startPage;i <= endPage;i++) {
			if(i == currentPage) {
				pageSb.append("<em class=\"cur\">"+i+"</em>");	
			} else {
				pageSb.append("<a class=\"btnPage\" onclick=\"movePage("+i+")\">"+i+"</a>");
			}	
		}
		
		pageSb.append("<a class=\"arrow r\" onclick=\"movePage("+nextPage+")\">다음</a>");
		return pageSb.toString();
	}
	
}
