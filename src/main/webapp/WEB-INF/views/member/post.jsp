<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 쓴 게시글</title>
</head>
<body>
<div class="container">
	<h1>
	내가 쓴 게시글
	</h1>
	
	<form action="<c:url value="/mypage/post"/>" method="get" class="input-group" id="searchForm">
		<div class="input-group mb-1">
			<select name="type" class="input-group-prepend" >
				<option value="all" <c:if test='${pm.cri.type == "all"}'>selected</c:if>>전체</option>
				<option value="text" <c:if test='${pm.cri.type == "text"}'>selected</c:if>>제목+내용</option>
				<option value="writer" <c:if test='${pm.cri.type == "writer"}'>selected</c:if>>작성자</option>
			</select>
			<input type="text" name="search" class="form-control" value="${pm.cri.search}">
			<button type="submit" class="input-group-append btn btn-outline-success">검색</button>
		</div>
	</form>

	<table class="table table-hover text-center">
		<thead>
			<tr>
				<th class="col-1">번호</th>
				<th class="col-2">게시판</th>
				<th>제목</th>
				<th class="col-2">작성자</th>
				<th class="col-1">조회수</th>
				<th class="col-1">좋아요</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${postList}" var="post" varStatus="vs">
				<c:if test="${post.po_num > 0}">
					<tr>
				  		<td>${pm.totalCount - vs.index - pm.cri.pageStart}</td>
				  		<td>${post.ca_name}</td>
				  		<td> 
				  			<c:url value="/post/detail" var="detailUrl">
				  				<c:param name="num">${post.po_num}</c:param>
				  				<c:param name="page" value="${pm.cri.page}"/>
								<c:param name="type" value="${pm.cri.type}"/>
								<c:param name="search" value="${pm.cri.search}"/>
				  			</c:url>
				  			<a href="${detailUrl}">${post.po_title}</a> <span class="ml-4">[${post.po_co_count}]</span>
				  		</td>
				  		<td>
				  			<a href="#">${post.me_nick}</a> 
			  			</td>
				  		<td>${post.po_view}</td>
				  		<td>${post.po_totalHeart}</td>
					</tr>
				</c:if>
			</c:forEach>
		</tbody>
	</table>
	<c:if test="${pm.totalCount == 0}">
		<h1 class="text-center">등록된 게시글이 없습니다.</h1>
	</c:if>
	<ul class="pagination justify-content-center">
		<c:if test="${pm.prev}">
		    <li class="page-item">
		    	<c:url value="/mypage/post" var="prev">
		    		<c:param name="type" value="${pm.cri.type}" />
		    		<c:param name="search" value="${pm.cri.search}" />
		    		<c:param name="page" value="${pm.startPage - 1}"/>
		    	</c:url>
		    	<a class="page-link" href="${prev}">이전</a>
	    	</li>
		</c:if>
    	<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
    		<c:url value="/mypage/post" var="url">
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
		    	<c:url value="/mypage/post" var="next">
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