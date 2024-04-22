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
	
	<form action="<c:url value="/post/list"/>" method="get" class="input-group" id="searchForm">
		<input name="ca" style="display: none;" value="${pm.cri.ca}">
		<div class="input-group mb-1">
			<select name="type" class="input-group-prepend" >
				<option value="all" <c:if test='${pm.cri.type == "all"}'>selected</c:if>>전체</option>
				<option value="text" <c:if test='${pm.cri.type == "text"}'>selected</c:if>>제목+내용</option>
				<option value="writer" <c:if test='${pm.cri.type == "writer"}'>selected</c:if>>작성자</option>
			</select>
			<input type="text" name="search" class="form-control" value="${pm.cri.search}">
			<button type="submit" class="input-group-append btn btn-outline-success">검색</button>
		</div>
	 	<select class="form-control col-4 offset-8 mt-1 mb-2" name="order">
	 		<option value="new" <c:if test='${pm.cri.order == "new"}'>selected</c:if>>최신순</option>
	 		<option value="view" <c:if test='${pm.cri.order == "view"}'>selected</c:if>>조회수순</option>
	 		<option value="heart" <c:if test='${pm.cri.order == "heart"}'>selected</c:if>>좋아요순</option>
	 	</select>
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
					<tr>		<!-- pm.cri.perPageNum * (pm.cri.page-1)) == pm.cri.startPage -->
				  		<td>${(pm.totalCount - (pm.cri.perPageNum * (pm.cri.page-1))) - vs.index}</td>
				  		<td>${post.ca_name}</td>
				  		<td> 
				  			<c:url value="/post/detail" var="detailUrl">
				  				<c:param name="num">${post.po_num}</c:param>
				  			</c:url>
				  			
				  			<a href="${detailUrl}">${post.po_title}</a> 
				  			<c:if test="${post.po_votePost}">
				  				<span class="ml-1" style="font-size: x-small;">(투표중)</span>
				  				<span class="ml-4">[${post.po_co_count}]</span>
				  			</c:if>
				  			<c:if test="${!post.po_votePost}">
				  				<span class="ml-4">[${post.po_co_count}]</span>
				  			</c:if>
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
	<c:url value="/post/insert" var="insertUrl">
		<c:param name="ca" value="${pm.cri.ca}"/>
	</c:url>
	<a class="btn btn-outline-primary" href="${insertUrl}">글 작성</a>
	
</div>

<script type="text/javascript">
$("[name=order]").change(function () {
	$("#searchForm").submit();
});
	
</script>

</body>
</html>
