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
<div class="container">
	<div id="nav">
	</div>
	<h1>
	내가 쓴 댓글
	</h1>
	<form action="<c:url value="/mypage/comment"/>" method="get" class="input-group" id="searchForm">
		<input name="poNum" style="display: none;" value="${pm.cri.poNum}">
	</form>
	<table class="table table-hover text-center">
		<thead>
			<tr>
				<th class="col-2">번호</th>
				<th class="col-4">게시글</th>
				<th class="col-3">댓글 내용</th>
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
		    		<c:param name="page" value="${pm.startPage - 1}"/>
		    	</c:url>
		    	<a class="page-link" href="${prev}">이전</a>
	    	</li>
		</c:if>
    	<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
    		<c:url value="/mypage/comment" var="url">
	    		<c:param name="poNum" value="${pm.cri.poNum}"/>
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
		    		<c:param name="page" value="${pm.endPage + 1}"/>
		    	</c:url>
		    	<a class="page-link" href="${next}">다음</a>
	    	</li>
		</c:if>
	</ul>
</div>
</body>
</html>