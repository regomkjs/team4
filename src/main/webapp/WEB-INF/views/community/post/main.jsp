<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>메인</title>
	<style type="text/css">
		.banner-box{
			display: flex;
		}
		
		.carousel-inner{
			background-color: #dcdcdc;
			margin: 0 auto;
			width: 80%;
			height: 150px;
		}	
		.carousel-item>img{
			width: 100%;
			height: 150px;
			object-fit: contain;
		}
		.carousel-item>a>img{
			width: 100%;
			height: 150px;
			object-fit: contain;
		}
		.carousel-control-prev-icon, .carousel-control-next-icon {
			filter: invert(35%) sepia(100%) saturate(7500%) hue-rotate(5deg)
				brightness(0%) contrast(101%);
		}
		.community-container{padding: 30px 0; width: 100%; margin-left: 0px;}
		.community-box{ width: 50%; max-height:500px; }
		.boardname {
			color: #046582;
			text-decoration: none;
		}
		
		.aTag-home {
		
			text-decoration: none;
			color: #046582;
		}
		
		.aTag-home:hover {
			text-decoration: underline;
			color: #848484;
		}
			
	
	</style>
	
</head>
<body>
<div>
	<!-- 카페 메인 carousel -->
	<div id="demo" class="carousel slide banner-box"
		data-bs-ride="carousel">
		<div class="carousel-inner">
			<div class="carousel-item active">
				<a href="<c:url value="/library/book/list"/>"><img src="<c:url value="resources/img/오픈.jpg"/>" alt="1" class="d-block"></a>
			</div>
			<div class="carousel-item">
				<img
					src="<c:url value="resources/img/토론.jpg"/>"
					alt="2" class="d-block">
			</div>
			<div class="carousel-item">
				<img
					src="<c:url value="resources/img/이벤트.jpg"/>"
					alt="3" class="d-block">
			</div>
			<div class="carousel-item">
				<img
					src="<c:url value="resources/img/main.png"/>"
					alt="4" class="d-block">
			</div>
		</div>
		<!-- Left and right controls/icons -->
		<button class="carousel-control-prev" type="button"
			data-bs-target="#demo" data-bs-slide="prev">
			<span class="carousel-control-prev-icon"></span>
		</button>
		<button class="carousel-control-next" type="button"
			data-bs-target="#demo" data-bs-slide="next">
			<span class="carousel-control-next-icon"></span>
		</button>
	</div>
	<div class="container">
		<div class="row justify-content-between community-container">
			<div class="community-box">
				<table class="table table-hover table-bordered">
					<thead>
						<tr>
							<th style="text-align: left;"><a
								href="<c:url value="/post/list?ca=1"/>" class="boardname">공지사항</a>
							</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${noticeList}" var="post">
							<tr>
								<td style="text-align: left;" class="d-flex">
									<span style="max-width: 275px; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">
										<a class="aTag-home"
										href="<c:url value="/post/detail?ca=0&num=${post.po_num}"/>">${post.po_title}</a>
									</span>
									<span class="ms-auto">
										<c:set var="now" value="<%=new java.util.Date()%>" />
										<c:set var="today">
											<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" />
										</c:set>
										<c:set var="postdate" value="${post.po_datetime}"/>
										<c:choose>
											<c:when test="${fn:substring(postdate,0,10) == today}">
												${fn:substring(postdate,11,16)}
											</c:when>
											<c:otherwise>
												${fn:substring(postdate,0,10)}
											</c:otherwise>
										</c:choose>
									</span>
								</td>
							</tr>
						</c:forEach>
						<c:if test="${noticeList.size() == 0}">
							<tr>
								<td>등록된 공지가 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
				<hr class="d-sm-none">
			</div>
			<div class="community-box">
				<table class="table table-hover table-bordered">
					<thead>
						<tr>
							<th style="text-align: left;"><a
								href="<c:url value="/post/list?ca=0" />" class="boardname">최신게시글</a>
							</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${newPostList}" var="post">
							<tr>
								<td style="text-align: left; " class="d-flex">
									<span style="max-width: 275px; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">
									<a class="aTag-home"
									href="<c:url value="/post/detail?ca=0&num=${post.po_num}"/>">[${post.ca_name}] ${post.po_title}</a>
									</span>
									<span style="color: #FA5858; font-weight: bold;" class="ms-1">${post.po_totalHeart}</span>
									<span class="ms-auto">
								 		<c:set var="now" value="<%=new java.util.Date()%>" />
										<c:set var="today">
											<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" />
										</c:set>
										<c:set var="postdate" value="${post.po_datetime}"/>
										<c:choose>
											<c:when test="${fn:substring(postdate,0,10) == today}">
												${fn:substring(postdate,11,16)}
											</c:when>
											<c:otherwise>
												${fn:substring(postdate,0,10)}
											</c:otherwise>
										</c:choose>
									</span>
								</td>
							</tr>
						</c:forEach>
						<c:if test="${newPostList.size() == 0}">
							<tr>
								<td>등록된 글이 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
				<hr class="d-sm-none">
			</div>
			<div class="community-box">
				<table class="table table-hover table-bordered">
					<thead>
						<tr>
							<th style="text-align: left;"><a
								href="<c:url value="/post/popular?ca=-1" />" class="boardname">인기게시글</a>
							</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${hotList}" var="post">
							<c:if test="${post.po_totalHeart >= 1}">
								<tr>
									<td style="text-align: left; " class="d-flex">
										<span style="max-width: 275px; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">
										<a class="aTag-home"
										href="<c:url value="/post/detail?ca=0&num=${post.po_num}"/>">[${post.ca_name}] ${post.po_title}</a>
										</span>
										<span style="color: #FA5858; font-weight: bold;" class="ms-1">${post.po_totalHeart}</span>
										<span class="ms-auto">
									 		<c:set var="now" value="<%=new java.util.Date()%>" />
											<c:set var="today">
												<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" />
											</c:set>
											<c:set var="postdate" value="${post.po_datetime}"/>
											<c:choose>
												<c:when test="${fn:substring(postdate,0,10) == today}">
													${fn:substring(postdate,11,16)}
												</c:when>
												<c:otherwise>
													${fn:substring(postdate,0,10)}
												</c:otherwise>
											</c:choose>
										</span>
									</td>
								</tr>
							</c:if>
						</c:forEach>
						<c:if test="${hotList.size() == 0}">
							<tr>
								<td>등록된 인기글이 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
				<hr class="d-sm-none">
			</div>
			<div class="community-box">
				<table class="table table-hover table-bordered">
					<thead>
						<tr>
							<th style="text-align: left;">
								<span class="boardname">진행중인 투표게시글</span>
							</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${votePostList}" var="post">
							<tr>
								<td style="text-align: left; " class="d-flex">
									<span style="max-width: 275px; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">
										<a class="aTag-home"
										href="<c:url value="/post/detail?ca=0&num=${post.po_num}"/>">[${post.ca_name}] ${post.po_title}</a>
									</span>
									<span style="color: #FA5858; font-weight: bold;" class="ms-1">${post.po_totalHeart}</span>
									<span class="ms-auto">
								 		<c:set var="now" value="<%=new java.util.Date()%>" />
										<c:set var="today">
											<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" />
										</c:set>
										<c:set var="postdate" value="${post.po_datetime}"/>
										<c:choose>
											<c:when test="${fn:substring(postdate,0,10) == today}">
												${fn:substring(postdate,11,16)}
											</c:when>
											<c:otherwise>
												${fn:substring(postdate,0,10)}
											</c:otherwise>
										</c:choose>
									</span>
								</td>
							</tr>
						</c:forEach>
						<c:if test="${votePostList.size() == 0}">
							<tr>
								<td>진행중인 투표글이 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
				<hr class="d-sm-none">
			</div>
		</div>
	</div>
</div>



</body>
</html>
