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
	내가 예약한 도서
	</h1>
	
	<form action="<c:url value="/mypage/reserve"/>" method="get" class="input-group" id="searchForm">
		<div class="input-group mb-1">
			<select name="type" class="input-group-prepend" >
				<option value="all" <c:if test='${pm.cri.type == "all"}'>selected</c:if>>전체</option>
				<option value="title" <c:if test='${pm.cri.type == "title"}'>selected</c:if>>제목</option>
				<option value="publisher" <c:if test='${pm.cri.type == "publisher"}'>selected</c:if>>출판사</option>
			</select>
			<input type="text" name="search" class="form-control" value="${pm.cri.search}">
			<button type="submit" class="input-group-append btn btn-outline-success">검색</button>
		</div>
	</form>

	<table class="table table-hover text-center">
		<thead>
			<tr>
				<th class="col-1">번호</th>
				<th class="col-2">이미지</th>
				<th class="col-2">제목</th>
				<th class="col-2">출판사</th>
				<th class="col-2">도서코드</th>
				<th class="col-1">만기일</th>
				<th class="col-1">대출상태</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${reserveList}" var="reserve" varStatus="vs">
				<c:if test="${reserve.bo_num > 0}">
					<tr>
				  		<td>${pm.totalCount - vs.index - pm.cri.pageStart}</td>
				  		<td>
				  			<c:url value="/library/book/detail?num=${reserve.bo_num}" var="detailUrl">
				  				<c:param name="num">${reserve.bo_num}</c:param>
				  				<c:param name="page" value="${pm.cri.page}"/>
								<c:param name="type" value="${pm.cri.type}"/>
								<c:param name="search" value="${pm.cri.search}"/>
				  			</c:url>
					  		<a href="${detailUrl }">
						  		<img src="${reserve.bo_thumbnail}">
					  		</a>
				  		</td>
				  		<td> 
				  			<c:url value="/library/book/detail?num=${reserve.bo_num}" var="detailUrl">
				  				<c:param name="num">${reserve.bo_num}</c:param>
				  				<c:param name="page" value="${pm.cri.page}"/>
								<c:param name="type" value="${pm.cri.type}"/>
								<c:param name="search" value="${pm.cri.search}"/>
				  			</c:url>
				  			<a href="${detailUrl}">${reserve.bo_title}</a>
				  		</td>
				  		<td>${reserve.bo_publisher}</td>
				  		<td>${reserve.bo_code}</td>
				  		<td>
				  			<fmt:formatDate value="${reserve.re_date}" pattern="yy/MM/dd"/><br/>
			  			</td>
				  		<td>
				  			<c:if test="${reserve.lo_state == 1}">
				  				<span style="color: red;">대출중</span>
				  			</c:if>
				  			<c:if test="${reserve.lo_state == 0}">
				  				<span style="color: red;">반납</span>
				  			</c:if>
				  		</td>
					</tr>
				</c:if>
			</c:forEach>
		</tbody>
	</table>
	<c:if test="${pm.totalCount == 0}">
		<h1 class="text-center">예약한 책이 없습니다.</h1>
	</c:if>
	<ul class="pagination justify-content-center">
		<c:if test="${pm.prev}">
		    <li class="page-item">
		    	<c:url value="/mypage/reserve" var="prev">
		    		<c:param name="type" value="${pm.cri.type}" />
		    		<c:param name="search" value="${pm.cri.search}" />
		    		<c:param name="page" value="${pm.startPage - 1}"/>
		    	</c:url>
		    	<a class="page-link" href="${prev}">이전</a>
	    	</li>
		</c:if>
    	<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
    		<c:url value="/mypage/reserve" var="url">
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
		    	<c:url value="/mypage/reserve" var="next">
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