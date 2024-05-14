<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container">
	<div id="nav">
	</div>
	<h1>
	내가 신고한 내역
	</h1>
	
	<form action="<c:url value="/mypage/report"/>" method="get" class="input-group" id="searchForm">
		<div class="input-group mb-1">
			<select name="type" class="input-group-prepend" >
				<option value="all" <c:if test='${pm.cri.type == "all"}'>selected</c:if>>전체</option>
			</select>
			<input type="text" name="search" class="form-control" value="${pm.cri.search}">
			<button type="submit" class="input-group-append btn btn-outline-success">검색</button>
		</div>
	</form>

	<table class="table table-hover text-center">
		<thead>
			<tr>
				<th class="col-1">번호</th>
				<th class="col-2">신고유형</th>
				<th class="col-2">신고내용</th>
				<th class="col-2">신고</th>
				<th class="col-2">상태</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${reportList}" var="report" varStatus="vs">
				<c:if test="${report.rp_num > 0}">
					<tr>
				  		<td>${pm.totalCount - vs.index - pm.cri.pageStart}</td>
				  		<td>${report.rp_type}</td>
				  		<td>${report.rp_note}</td>
				  		<td>${report.rp_writer_nick}</td>
				  		<td>
					  		<c:choose>
						  		<c:when test="${report.rp_state == 0}">
						  			<span>접수</span>
						  		</c:when>
					  			<c:when test="${report.rp_state == 1}">
						  			<span>게시글 삭제</span>
						  		</c:when>
						  		<c:when test="${report.rp_state == 2}">
						  			<span>피신고자 처리</span>
						  		</c:when>
						  		<c:when test="${report.rp_state == 3}">
						  			<span>신고자 처리</span>
						  		</c:when>
						  		<c:when test="${report.rp_state == 4}">
						  			<span>신고 반려</span>
						  		</c:when>
					  		</c:choose>
				  		</td>
					</tr>
				</c:if>
			</c:forEach>
		</tbody>
	</table>
	<c:if test="${pm.totalCount == 0}">
		<h1 class="text-center">신고한 내역이 없습니다.</h1>
	</c:if>
	<ul class="pagination justify-content-center">
		<c:if test="${pm.prev}">
		    <li class="page-item">
		    	<c:url value="/mypage/report" var="prev">
		    		<c:param name="type" value="${pm.cri.type}" />
		    		<c:param name="search" value="${pm.cri.search}" />
		    		<c:param name="page" value="${pm.startPage - 1}"/>
		    	</c:url>
		    	<a class="page-link" href="${prev}">이전</a>
	    	</li>
		</c:if>
    	<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
    		<c:url value="/mypage/report" var="url">
    			<c:param name="type" value="${pm.cri.type}" />
	    		<c:param name="search" value="${pm.cri.search}" />
	    		<c:param name="page" value="${i}"/>
	    	</c:url>
	    	<c:set var="active" value="${pm.cri.page == i ? 'active' : '' }"/>
    		<li class="page-item ${active}">
    			<a class="page-link" href="${url}">${i}</a>
   			</li>
    	</c:forEach>
    	<c:if test="${pm.next}">
			<li class="page-item">
		    	<c:url value="/mypage/report" var="next">
		    		<c:param name="type" value="${pm.cri.type}" />
		    		<c:param name="search" value="${pm.cri.search}" />
		    		<c:param name="page" value="${pm.endPage + 1}"/>
		    	</c:url>
		    	<a class="page-link" href="${next}">다음</a>
	    	</li>
		</c:if>
	</ul>
</div>
</body>
</html>