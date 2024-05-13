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
	<h1>
	내가 대출한 도서
	</h1>
	
	<form action="<c:url value="/mypage/loan"/>" method="get" class="input-group" id="searchForm">
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
				<th class="col-1">대출일</th>
				<th class="col-1">만기일</th>
				<th>D-day</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${loanList}" var="loan" varStatus="vs">
				<c:if test="${loan.bo_num > 0}">
					<tr>
				  		<td>${pm.totalCount - vs.index - pm.cri.pageStart}</td>
				  		<td>
				  			<c:url value="/library/book/detail?num=${loan.bo_num}" var="detailUrl">
				  				<c:param name="num">${loan.bo_num}</c:param>
				  				<c:param name="page" value="${pm.cri.page}"/>
								<c:param name="type" value="${pm.cri.type}"/>
								<c:param name="search" value="${pm.cri.search}"/>
				  			</c:url>
					  		<a href="${detailUrl }">
						  		<img src="${loan.bo_thumbnail}">
					  		</a>
				  		</td>
				  		<td> 
				  			<c:url value="/library/book/detail?num=${loan.bo_num}" var="detailUrl">
				  				<c:param name="num">${loan.bo_num}</c:param>
				  				<c:param name="page" value="${pm.cri.page}"/>
								<c:param name="type" value="${pm.cri.type}"/>
								<c:param name="search" value="${pm.cri.search}"/>
				  			</c:url>
				  			<a href="${detailUrl}">${loan.bo_title}</a>
				  		</td>
				  		<td>${loan.bo_publisher}</td>
				  		<td>${loan.bo_code}</td>
				  		<td>
				  			<fmt:formatDate value="${loan.lo_date}" pattern="yy/MM/dd"/><br/>
			  			</td>
				  		<td>
				  			<fmt:formatDate value="${loan.lo_limit}" pattern="yy/MM/dd"/><br/>
				  		</td>
				  		<td style="color: red;">
				  			<c:if test="${loan.lo_day == 0 }">
				  				d-day
				  			</c:if>
				  			<c:if test="${loan.lo_day < 0 }">
				  				만기일 지남
				  			</c:if>
				  			<c:if test="${loan.lo_day > 0 }">
					  			${loan.lo_day}일
				  			</c:if>
				  		</td>
					</tr>
				</c:if>
			</c:forEach>
		</tbody>
	</table>
	<c:if test="${pm.totalCount == 0}">
		<h1 class="text-center">대출한 책이 없습니다.</h1>
	</c:if>
	<ul class="pagination justify-content-center">
		<c:if test="${pm.prev}">
		    <li class="page-item">
		    	<c:url value="/mypage/loan" var="prev">
		    		<c:param name="type" value="${pm.cri.type}" />
		    		<c:param name="search" value="${pm.cri.search}" />
		    		<c:param name="page" value="${pm.startPage - 1}"/>
		    	</c:url>
		    	<a class="page-link" href="${prev}">이전</a>
	    	</li>
		</c:if>
    	<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
    		<c:url value="/mypage/loan" var="url">
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
		    	<c:url value="/mypage/loan" var="next">
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
<script type="text/javascript">

</script>
</html>