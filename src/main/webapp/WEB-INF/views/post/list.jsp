<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>게시글 목록</title>
</head>
<body>
<div class="container">
	<h1>
		게시글 목록
	</h1>
	<table class="table table-hover">
		<thead>
			<tr>
				<th>번호</th>
				<th>게시판</th>
				<th>제목</th>
				<th>작성자</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${postList}" var="post" varStatus="vs">
				<tr>		<!-- pm.cri.perPageNum * (pm.cri.page-1)) == pm.cri.startPage -->
			  		<td>${(pm.totalCount - (pm.cri.perPageNum * (pm.cri.page-1))) - vs.index}</td>
			  		<td>${post.ca_name}</td>
			  		<td> 
			  			<c:url value="/post/detail" var="detailUrl">
			  				<c:param name="num">${post.po_num}</c:param>
			  			</c:url>
			  			<a href="${detailUrl}">${post.po_title}</a>
			  		</td>
			  		<td>
			  			<a href="#">${post.po_me_id}</a> 
		  			</td>
			  		<td>${post.po_view}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<c:if test="${postList == null || postList.size() == 0}">
		<h1 class="text-center">등록된 게시글이 없습니다.</h1>
	</c:if>
	<ul class="pagination justify-content-center">
		<c:if test="${pm.prev}">
		    <li class="page-item">
		    	<c:url value="/post/list" var="prev">
		    		<c:param name="ca" value="${pm.cri.ca}"/>
		    		<c:param name="type" value="${pm.cri.type}" />
		    		<c:param name="search" value="${pm.cri.search}" />
		    		<c:param name="page" value="${pm.startPage - 1}"/>
		    	</c:url>
		    	<a class="page-link" href="${prev}">이전</a>
	    	</li>
		</c:if>
    	<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
    		<c:url value="/post/list" var="url">
	    		<c:param name="ca" value="${pm.cri.ca}"/>
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
		    	<c:url value="/post/list" var="next">
		    		<c:param name="ca" value="${pm.cri.ca}"/>
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
