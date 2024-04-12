<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 쓴 댓글</title>
</head>
<body>
	<h1>
	내가 쓴 댓글
	</h1>
	
	<form action="<c:url value="/mypage/comment"/>" method="get" class="input-group" id="searchForm">
		<input name="poNum" style="display: none;" value="${pm.cri.poNum}">
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
				<th class="col-3">번호</th>
				<th class="col-3">게시글</th>
				<th>댓글 내용</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${commentList}" var="comment" varStatus="vs">
				<c:if test="${comment.co_num > 0}">
					<tr>		<!-- pm.cri.perPageNum * (pm.cri.page-1)) == pm.cri.startPage -->
				  		<td>${(pm.totalCount - (pm.cri.perPageNum * (pm.cri.page-1))) - vs.index}</td>
				  		<td> 
				  			<c:url value="/post/detail" var="detailUrl">
				  				<c:param name="num">${comment.co_po_num}</c:param>
				  			</c:url>
				  			<a href="${detailUrl}">${comment.po_title}</a>
				  		</td>
				  		<td>${comment.co_content}</td>
					</tr>
				</c:if>
			</c:forEach>
		</tbody>
	</table>
	<c:if test="${pm.totalCount == 0}">
		<h1 class="text-center">등록된 댓글이 없습니다.</h1>
	</c:if>
	<ul class="pagination justify-content-center">
		<c:if test="${pm.prev}">
		    <li class="page-item">
		    	<c:url value="/mypage/comment" var="prev">
		    		<c:param name="poNum" value="${pm.cri.poNum}"/>
		    		<c:param name="type" value="${pm.cri.type}" />
		    		<c:param name="search" value="${pm.cri.search}" />
		    		<c:param name="page" value="${pm.startPage - 1}"/>
		    	</c:url>
		    	<a class="page-link" href="${prev}">이전</a>
	    	</li>
		</c:if>
    	<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
    		<c:url value="/mypage/comment" var="url">
	    		<c:param name="poNum" value="${pm.cri.poNum}"/>
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
		    	<c:url value="/mypage/comment" var="next">
		    		<c:param name="poNum" value="${pm.cri.poNum}"/>
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