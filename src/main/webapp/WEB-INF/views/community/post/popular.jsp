<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>인기글 목록</title>
	<script src="https://kit.fontawesome.com/6830e64ec8.js" crossorigin="anonymous"></script>
	<style type="text/css">
		
		.hovertext1-box{
			position: relative;
		}
		.hovertext1 {
			display: inline-block;
		    overflow: hidden;
			text-overflow: ellipsis;
			white-space: nowrap;
			width: 250px;
			height: 20px;
		}
		
		.hovertext1-box:before {
		    content: attr(data-hover);
		    visibility: hidden;
		    opacity: 0;
		    width: max-content;
		    background-color: black;
		    color: #fff;
		    text-align: center;
		    border-radius: 5px;
		    padding: 5px 5px;
		    transition: opacity 0.5s ease-in-out;
		
		    position: absolute;
		    z-index: 100;
		    left: 0;
		    top: 110%;
		}
		
		.hovertext1-box:hover:before {
		    opacity: 1;
		    visibility: visible;
		}
		.title-box:hover {
			cursor: pointer;
		}
		.btn-list-order{
			cursor: pointer;
		}
	</style>
	
</head>
<body>
<div>
	<h1>인기글 목록</h1>
	<form action="<c:url value="/post/popular"/>" method="get" class="input-group" id="searchForm">
		<input style="display: none;" name="ca" value="-1">
		<input name="order" style="display: none;" value="${pm.cri.order}">
		<input name="role" style="display: none;" value="${pm.cri.role}">
		<div class="input-group mb-1 w-50 ms-auto">
			<input type="text" name="search" class="form-control" style="border-left-color: #777; border-top-color: #777; border-bottom-color: #777; " value="${pm.cri.search}">
			<button type="submit" class="input-group-append btn btn-success search-btn"><i class="fa-solid fa-magnifying-glass mr-1 mt-1"  style="--fa-animation-duration: 1.5s;"></i>검색</button>
		</div>
	 	
	</form>
	<span class="ms-3" style="font-size: small; color: gray">※ <i class="fa-solid fa-check-to-slot" style="color: #ee9953;"></i> : 투표중인 게시글</span>
	<table class="table table-hover text-center">
		<thead class="table-secondary">
			<tr>
				<th class="col-2">게시판</th>
				<th>제목</th>
				<th class="col-2">작성자</th>
				<th class="col-1.5 btn-list-order order-new" data-order="new">작성일</th>
				<th class="btn-list-order order-view" data-order="view">조회수</th>
				<th class="btn-list-order order-heart" data-order="heart">좋아요</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${postList}" var="post">
				<c:if test="${post.po_num > 0}">
					<tr>
				  		
				  		<td>${post.ca_name}</td>
				  		<td class="hovertext1-box title-box" data-hover="${post.po_title}"> 
				  			<c:url value="/post/detail" var="detailUrl">
				  				<c:param name="num">${post.po_num}</c:param>
				  			</c:url>
				  			
				  			<a href="${detailUrl}" style="cursor: pointer; color: black; text-decoration: none;" class="hovertext1">
					  			<c:if test="${post.po_votePost}">
					  				<i class="fa-solid fa-check-to-slot" style="color: #ee9953;"></i>
					  			</c:if>
				  				${post.po_title}
				  			</a> 
				  			
			  				<span class="mr-auto">[${post.po_co_count}]</span>
				  		</td>
				  		<td>
			  				<div class="dropdown">
			  					<c:if test="${post.me_mr_num == 0}">
									<img width="18" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEMAAABDCAYAAADHyrhzAAAACXBIWXMAAAsTAAALEwEAmpwYAAAEnklEQVR4nO2c3UsrRxTAtx8PLeU+9KnQQmn/hNK3vvheaJ8qZs/ZJBrFqBUVPzCLiohexIg+iNpaEY31G4sffdEqFIuIilQULPZB8CsKohaUoMaPucxyM7hxk5ukue7OZg+ch5ydPXPyy8w5s6OzghBBnE7nB6IofgcAPwPAnwDwDyLu8KYA8C8A/AUAPgDIcLlcL4RYJT09/T0AyEVEPyISsykA/AcAlfTHjgrC5XK9AIApvQN+Jl232+2fa4KQJOkjRPzbAEE+p+7abLZPnsBAxN8MEJweupiWlvY+AyGK4rcGCEo3pTmSwQCAVb0D0ln9tHAIGRkZXxggGKK3iqKYJrwuoyTVFQBeUhgNegeCBlAA+JVWkS69A0EDKADM0pHRrXcgaAAFgHkLBlowiDUy0JomxMoZqFMCLSgoICMjI0/U4/EkNePLsqzZD+3fMNWkurqaaMny8nJSYaysrGj2Q/s3PIzb21uSl5eXFBDUTzAY5BcGlf7+/qTAGBwcJJHEsDCCwSDZ399nn/f29pICw+/3M5+Hh4d8wKAyNDREkhlsXV3dW/X/VmFUVFSo5vfc3Nz/8r+wsMB80RHS1NTED4zS0lJV5g8EAiQrKysh3zk5OeT6+pr5GhgYIK2trfzAqKysJM3NzSpbZ2dnQr57enpU1Sk/P5+0t7fzA8Pj8RC73U5OT0+ZbWtrKyHfOzs7zMfq6qpi6+rq4geGLMuKfXp6mtkeHh6U6ROPXwr1sXi9XsXe29vLD4yqqirFXlZWpkAIycTERFx+Z2Zm2L1nZ2fKaKN2mje4gVH9KLjt7W1mp9Mm9IXepJmZmeTy8pLdOzk5ya4NDw/zCaO7u1t1jZbFWHx2dHREnGLcwsjOziZXV1dxP7zRhBsp+XILA8MWTaHyGM1fSUmJKteEl2WuYdTX18f18DY1NRV1wcY1DEQkR0dH7PrBwUFEXw6Hg5yfn0ddynMPY2xsTNWmpqZG01dLS4tmmTYVjMLCQnJ/f8/azM/Pa/paW1tjbehWgFYb7mEgItnY2IiaC+he5t3dHWvj8/nMC6OtrU3VLrxKjI6OxrRlaAoYTqeTXFxcaK4fJEkix8fH7NrS0lLE/kwBAxHJ7Oys5sqyoaFB5aOxsdH8MGRZVrUNPbwtLi4y28nJiTJSTA8DEcnu7i5rS9cUbreb3NzcMNv4+HjU+00Fw+fzqdqvr6+rpk5xcXHqwHC73RH/ILS5ufnG/kwFAxGVp1ctoeU35WB4vd4nIOhmDi2/KQdDkiTVhjEVus0XS3+mg4Fhj+qPN5K5hpGbm6vM9ZDSz7HcV1RUxP7Hoq+vL+b+ysvLE+rvWWCgCdSCgRYMYo0MtKYJsXIGJp5A2/TO5GgM/Z3CkA0QCDGA/kTPm3xvgECI3goARfSE84cAENA7GL1VkqQvQ2daf0nxUfEHO8rpcDg+S9XRAQD3Npvtq/ATzz8g4kMKwpA1z8MjoifFgHQKgvBOxDclAEA6Ip6bfDQEAODHqK+MCAkAfIyITQBwZDIIp3Q02Gy2T4V4pba29l0A+FoURUTEUvoSDg61HADskiR9o5x3jyKvAHbQX3wyaiWpAAAAAElFTkSuQmCC">
								</c:if>
								<c:if test="${post.me_mr_num == 1}">
									<img width="18" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEMAAABDCAYAAADHyrhzAAAACXBIWXMAAAsTAAALEwEAmpwYAAAEjElEQVR4nO2c30/bVRTAG50vPrmHxcT4D+jr4nxconBvk21OXWZQZ5Ys8cX4YtRoFk0l7t7ya8tKxoSxGbMRo8icgoDcW9rRymSMbaV2bEXK5oAyJrABK4P+OubeFew3pQiY9rb9fk9y3trm3E/OOffce3quybSKNFt2PskofoURfJBRXM0Irss35RQf5wR/wWnxfjt56WnTesVZZn6WE1TPCJrnFEPhKIoxgrj9ENq2JhAdxLyPUxRSb3jmlBEcZwTZnJbtm9KCYAQfVG1oVpWg1r66rU+kgLCT4hJBTLmBWfcSVKMB8Yt1x2ZO8ZRqw5SpFRctw+AEVyo3SK139EoQFovlMUbQuGqDVKudmJ83ddDiF1UbwnNAmRV9kthK1RujWhlFJ02MoA9VG8JzQQlq1V9tQdMpshswqAEDDM+gRpiAkTNoniRQR+VuuPL9ZxBwN0DQy+Du4O/w91Av3LnugtGrrfCn4xR4mkqh6+gbhbubdNlKYORyC0QWQrA2icPsRAAGHSfBVf1m4cDwNJVCeH4WNioCSEHA8J6jEI/HNIuLhh/ChL8bAu4z4OdfwWBnPQx3fytDJTQ1qvWPeAxc1W/lPwz3sX0pYTHqaQfn4df+83sD7TaYvu2V+STz3psFGLd6ftCA+Ovi2XX/hr1sR2HACCW5fPjhHHRW7MrCwnIShhli0cgyDLGFql+0IhidFbs0ITLuc+TAopV5BoZYZHEZxv2Ra/qGMRP0/7tFxqKy8NItjIC7QRMqoo4QuUSXMLpsJbLAShZRbDkPv64/GJxi8LVUpZTX4fkZGDr/DTiP7NEXDE6xPFusJNHwAox5foWLX7+vHxicYrja+DksPpiGdCKS7UCbTR7xCx4GF3cZVa9CwHUGIgsP0kJZDN2XdxrZrVYV3o47KnfDQNtRmBm7kRbK/HQQ+ho+LnwYPEm7aw/Io/zC3FQKEFGb+Jor9AODJ1SEhZ/XpoRQPBaB3tMf6AsGT+hvx/fD7J0hDZB7Iz59wuCJYm0xdE8DxF3zjj5h8BUuhvp/PKRfGP1nv9TAuNFRo18YfQ0faWDcvPCdfmH4mssNz+AJGOJ0myw9p97LX8+w/49bbdF0Eh21JQlNjmTYEzMMw9NUCnMTw7JBdOHEu2v6Tmf5Tvn5WDSs8QpxyMt7GMkiym3RELrV0yR3hj9+LpOL9J4j4LfXQdDLV2xBbqTXkvMw1iviXCKuDbNzTZhhGN21B2AycCmlz7oWCKLHktmEmWUYPKHnj+yR4RBwnYaxfgZTw5dhZnwQ5u7elB03cYyfHO6D25d+kleEmf/7gUIYPC/UgAEGDGp4BhhhQo2cARtMoMZUAV+aKuAUva1+W8PqlaB6E6fmF5QbQnNkEknMqHGKgqqNUa2srOi5R8O9FJXrGsTS9KKcfbdsf0rPc62MmF/Wjn5bzXv1OPHMKTq24iw8J+hTPQFhBLes+jgAl1tt4b+SwCmuamzc+3haEEvCyoue4RSfKDgoBEUZwe0dVrTVtF5pTrys8ih8kE31KykbfVmFUWQRw8xtxLxltQX/AwTfUMDaNhZhAAAAAElFTkSuQmCC">
								</c:if>
								<c:if test="${post.me_mr_num == 2}">
									<c:if test="${post.me_gr_num == 2}">
										<img width="25"  src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAABJElEQVR4nO2ZTWoCQRCF+xiWie4kS4/hBXISYQpc6wVcZu/KDFnmDlkY6BZEELfqRvwBEUSs0IREAs6iW5juJu+DWs97U696hi6lAAAgWqrtcY3Y5MR6T2yk3NL7Cuu3aqafvMVXWK/LF27+lNXwwPrR2cD3mw8rnq419DAQIjamKE47nw5ITKVggNEBQYRcCB0ZimGIm92J9N6Xstie0jLQ6s/kdbSR0/kiPyRjYLo6yi2SMVBEMgY2h7MMPtby/DJP00C9M77ZjWQMUEGcYMAVdIARIcEQE06hKzhGXcExyvd/ySn0rwQMMDpggkeH/vEM6HgudzOzdTZglwvBhfNv5c4G7GYkmgVH9tlQPtjNiF0u2Pv58sVr+8zcWzwAAKgy+ALGkks5M3xO2gAAAABJRU5ErkJggg==">
									</c:if>
									<c:if test="${post.me_gr_num == 3}">
										<img width="25"  src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAABqUlEQVR4nO2Zy4rCMBSG8yAzy2EeR5JSRQRREZe+gY+gK9F1t4N04VY3Cq7c6ULwBcSFMF4q9vRyhlSm1QHRVmlTJj8cKGlp/+/kJCkJIVJSUlLC6pjJvAOlPZOxHTCGcYZ5/qZ+UtXPyOZNSjdxG4e/IJRuDErfQgPwzCdtHoL4Cg2QRNnA7V7Yhu8BAYzDRUgAkD3AZAmF0v8dxIqCdreL7nKJuN97wa/tTse7JzaAoqAzHuMtOaOR2AB2q4X3ZDeb4gK4s1mQ7cEAoVxGKBTQGQ79dv6MsABoGL5RKBb9dqtWC7rAMMQFgFtRqQQAu136AGxNC0poPk8XgFWtIh6PwSBut1MEkM16Gfezv1oh5HIpAVBVdCaTi0XAQavRiPw+EitAPo/OdHo9/2vaUwkhsQGUSuguFtcrcL//dDmSOACseh3d9fravK4/P5ZYXAvZ4XD3V8Jb5IQFeFAS4BG9om5fGSSskjYMEoAln3WQJcRSPIhNsTZ3v6PMQnrSxuE3KO2FBuAnI6IccJwY+yBRxE9G+OEC359PwPiWZz6yeSkpKSkSh34A766mybHzuzMAAAAASUVORK5CYII=">
									</c:if>
									<c:if test="${post.me_gr_num == 4}">
										<img width="25"  src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAABiElEQVR4nO2ZwUrEMBCG8yB6FA824M0XUHwUD+7DKI3C6mW9SvGgfQL1UterNq4rrLRepAvu0ihUSmSKjahUTcU2wfnhh5JL/y8zaUuHEBQKhTJWW9cLs4w7nsvplHEqm7QL9wzpwXZI538Rno6bDs4+e7w5oDPaALDzBoSXr97XBmijbViVQzqpUQEDgvM3IwDDClBsIS3960Psxx0ZizOZ5Y+FYxEUa1YAnCe7skr9ZMdsAD/uyO9UtxKkCQBom1Kj9Fj2hsuFR+mJWo9EYC5AlgsVFIKX673hilrP8tRcAFbhvZtVBSCeE3sAuoMleRityfunSwVwNfHtAfioaXb3rrUYAnwhbCFu4SHObH+MxiJQQeHlBcHBt+mpHS8y/wefEkfRurkAjNPig61K/aRb+5FMmgIoKwGtAmcCDNd1d561AfAXJgjAsQISW0hH1h9i16Cfu27oPGgDwHCh7eBM2fG0AWAyYsqAY+NicY7UEUxGYLgA/+cbDx7CPR2vdngUCoUiTegFU2aJ1Yt8CosAAAAASUVORK5CYII=">
									</c:if>
									<c:if test="${post.me_gr_num == 5}">
										<img width="25"  src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAABMUlEQVR4nO2ZTQrCQAyFe4yO1aUIKngYjyYi4g1EPIPSClO3HsG6FPzDTeNERrRaiuAU6UwgD7Lppu97STYTz2OxWCxnhctaA0IxS0NxgkhglZU+/unPMaq1SptPQ39ftXEogPh7lEHdGEAnb9s8vGtqDGBjbOD7OB3NO+CAcfgoBgDugOARMpLtkQHrSyzbiHDCT5ECUNtBzjwtAKnTP9MFUMmwYJ4OQNzJ0leHFT0AlYwyw7dNnxhA3EWES5a+/kYKQO3GufRpAax7iLdrLn1SAGo3KaRPCgCf6f8iNwFQUQdA2gDwA5jTOwAMINzswL/KY4CIO4A8QiYiv8SpW4+7B2MAfVywbRxeFYqZMYC+jDhz4FgETWOAB4QM6vq4oN/nLYzNUSdf2jyLxWJ5VegOSOS+C4MgG8YAAAAASUVORK5CYII=">
									</c:if>
									<c:if test="${post.me_gr_num == 6}">
										<img width="25"  src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAABf0lEQVR4nO2ZsUoDQRCG90G00V1S+Qhq7QPIbVDsTKGWWtjamT7BZ5Bw4COIRTq1SOUjCCEmahR27kZG1BVMPHbBvV2cH4ZLFeab+Wfv2BGCxWKxolW2jIuZgp6WZqIVYNCQZpJJyDcb2PBOXkszDJ64+gEy3JK44A5Ala87efUV584AtdhGzY5MmbE7QASJ62/BAJo7AGwhJ/3bIT47LrBKUQPknTJtgKuLxAHuri3AyXaR3gyM7m2lD9YhLYCdFcDyowH0fBwhvk4RB/0S260ifoDDDfjV+3m3jBugc1R9hPp2QoQAmBV7q4A3l3awyU5JAWgFuL9mrTV9ivwY1XMiiffAy7NNkqyTXAcGfet18j0lTnGbygy0W9Wn0Olu5KdQ3p3/LUQfer7/K0IBfHaCrEIzQUG/fSuv6wD4ixAMoLgDyBZyUfpDLOO53NXKPDgD0HKh/sThPeiq3xmANiOxLDiaS6iEj2gzQssFup8PX3Uzpsp7J89isVgihN4AZZD+JaDC0u8AAAAASUVORK5CYII=">
									</c:if>
								</c:if>
								<a type="button" class="dropdown-toggle" data-bs-toggle="dropdown" style="cursor: pointer; color: black; text-decoration: none;">
							    	${post.me_nick}
								</a>
								<div class="dropdown-menu">
									<c:url value="/post/list" var="targetUrl">
										<c:param name="type" value="target" />
										<c:param name="search" value="${post.me_nick}" />
									</c:url>
									<a class="dropdown-item" href="${targetUrl}">작성글</a>
									<c:if test="${user.me_id != post.po_me_id && user.me_mr_num == 2 && post.me_mr_num == 2}">
										<a href="#" class="dropdown-item btn-report" data-bs-toggle="modal" data-bs-target="#reportingModal" class="reportingModal" data-writer="${post.me_nick}" data-what="po" data-num="${post.po_num}">게시글 신고</a>
									</c:if>
									<c:if test="${user.me_id != post.po_me_id && user.me_mr_num <= 1 && post.me_mr_num == 2}">
										<c:url value="/popup/member/punish" var="popupURL">
											<c:param name="nick" value="${post.me_nick}"/>
										</c:url>
										<a class="dropdown-item member-punish-btn" type="button" data-url="${popupURL}">활동정지</a>
									</c:if>
								</div>
							</div>
			  			</td>
			  			<td>
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
									
			  			</td>
				  		<td>${post.po_view}</td>
				  		<td>${post.po_totalHeart}</td>
					</tr>
				</c:if>
			</c:forEach>
		</tbody>
	</table>
	<c:if test="${pm.totalCount == 0}">
		<h1 class="text-center">조건에 해당하는 인기글이 없습니다.</h1>
	</c:if>
	<ul class="pagination justify-content-center">
		
    	<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
    		<c:url value="/post/popular" var="url">
    			<c:param name="type" value="${pm.cri.type}" />
	    		<c:param name="search" value="${pm.cri.search}" />
	    		<c:param name="order" value="${pm.cri.order}"/>
	    		<c:param name="role" value="${pm.cri.role}"/>
	    		<c:param name="page" value="${i}"/>
	    	</c:url>
	    	<c:set var="active" value="${pm.cri.page == i ? 'active' : '' }"/>
    		<li class="page-item ${active}">
    			<a class="page-link" href="${url}">${i}</a>
   			</li>
    	</c:forEach>
    	
	</ul>
	<c:url value="/post/insert" var="insertUrl">
		<c:param name="ca" value="${pm.cri.ca}"/>
	</c:url>
	<a class="btn btn-outline-primary" href="${insertUrl}">글 작성</a>
	
	<!-- 신고 Modal -->
	<div class="modal fade" id="reportingModal">
		<div class="modal-dialog modal-lg modal-dialog-scrollable">
			<div class="modal-content">
	   
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">신고</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				
				<!-- Modal body -->
				<div class="modal-body">
					<div class="report-container">
						
					</div>
				
				
				</div>
	
				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary btn-reporting" data-dismiss="modal">신고하기</button>
				</div>
	
			</div>
		</div>
	</div>
	
	
</div>

<script type="text/javascript">
$("[name=order]").change(function () {
	$("#searchForm").submit();
});
	
</script>

<script type="text/javascript">
$(document).on("click",".member-punish-btn",function(){
	let url = $(this).data("url");
	const options = 'width=500, height=300, top=300, left=500, scrollbars=yes'
	
	window.open(url,'_blank',options)
})
</script>

<script type="text/javascript">
$(document).on("mouseover", ".search-btn", function () {
	$(this).find("i").addClass("fa-beat")
})



$(document).on("mouseleave", ".search-btn", function () {
	$(this).find("i").removeClass("fa-beat")
})

$(document).on("click", ".title-box", function () {
	$(this).find("a").get(0).click();
})
</script>

<!-- 신고 스크립트 -->
<script type="text/javascript">
$(document).on("click",".btn-report",function(){
	if('${user.me_id}' == ''){
		if(confirm("로그인이 필요한 서비스 입니다. 로그인으로 이동하시겠습니까?")){
			location.href = "<c:url value='/login'/>"
			return;
		}
		else{
			return;
		}
	}
	
	
	let who = $(this).data("writer");
	let what = $(this).data("what");
	let num = $(this).data("num");
	let str ="";
	str += 
	`
		<div>
			<div class="input-group mb-2">
				<div class="input-group-prepend">
					<label class="input-group-text ">닉네임</label>
				</div>
				<input type="text" class="report-nick input-group form-control" value="\${who}" readonly>
			</div>
			<input hidden type="text" value="\${what+'_'+num}" class="report-target">
			<div class="input-group mb-2">
				<div class="input-group-prepend">
					<label class="input-group-text ">신고 항목</label>
				</div>
				<select class="form-control report-type">
					<option>부적절한 닉네임</option>
					<option>욕설 사용</option>
					<option>광고성 글 작성</option>
					<option>게시판에 맞지 않는 글</option>
				</select>
			</div>
			<label>신고 내용:</label>
			<textarea class="form-control report-note mb-2" placeholder="신고 이유를 자세하게 적어주세요."></textarea>
			
		</div>
	`
	$(".report-container").html(str);
	
})

$(document).on("click",".btn-reporting",function(){
	if('${user.me_id}' == ''){
		if(confirm("세션이 만료되었습니다. 로그인으로 이동하시겠습니까?")){
			location.href = "<c:url value='/login'/>"
			return;
		}
		else{
			return;
		}
	}
	
	let writer = $(this).parents(".modal-content").find(".report-nick").val()
	let target = $(this).parents(".modal-content").find(".report-target").val()
	let type = $(this).parents(".modal-content").find(".report-type").val()
	let note = $(this).parents(".modal-content").find(".report-note").val()
	if(note == null){
		note = "";
	}
	
	console.log(writer);
	console.log(target);
	console.log(type);
	console.log(note);
	
	$.ajax({
		url : '<c:url value="/report/insert"/>',
		method : "post",
		data : {
			"writer" : writer,
			"target" : target,
			"type" : type,
			"note" : note
		},
		dataType : "json", 
		success : function (data) {
			let result = data.result;
			let message = data.message;
			alert(message);
		},
		error : function (a,b,c) {
			console.error("에러 발생2");
		}
	});
	
})

</script>

<script type="text/javascript">
let li_cri = {
	order : $("[name=order]").val(),
	role : $("[name=role]").val()
}

function toggleListRole(li_cri) {
	if(li_cri.role == "asc"){
		$("[name=role]").val("desc");
		li_cri.role = "desc";
	}else{
		$("[name=role]").val("asc");
		li_cri.role = "asc";
	}
}
$(document).ready(function () {
	let text = $('.order-'+li_cri.order).text();
	markCaret(text, li_cri)
})


function markCaret(text, li_cri) {
	$(".li-order-icon").remove();
	let caret = "";
	if(li_cri.role == "asc"){
		caret += text + `<i class="fa-solid fa-caret-up li-order-icon ms-1"></i>` 
	}
	else{
		caret += text + `<i class="fa-solid fa-caret-down li-order-icon ms-1"></i>` 
	}
	$('.order-'+li_cri.order).html(caret);
}

$(document).on("click",".btn-list-order", function () {
	let order = $(this).data("order");
	let text = $(this).text();
	if(order == li_cri.order){
		toggleListRole(li_cri);
		$("[name=role]").val(li_cri.role);
	}else{
		$("[name=order]").val(order);
		li_cri.order = order;
		$("[name=role]").val("desc");
		li_cri.role = "desc";
	}
	
	$("#searchForm").submit();
})
</script>


</body>
</html>
