<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>게시글 상세</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
	<script src="https://kit.fontawesome.com/6830e64ec8.js" crossorigin="anonymous"></script>
	
	<style type="text/css">
		.line-hr{
			border: 2px solid;
			border-color: #555;
		}
		.reply-a{
			cursor: pointer; 
			color: #555; 
			text-decoration: none;
		}
		.reply-a:hover {
			font-weight: bold;
			color: black;
		}
	</style>
	
</head>
<body>
<c:set var="now" value="<%=new java.util.Date()%>" />
<c:set var="today">
	<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" />
</c:set>
<c:set var="time">
	<fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm:ss" />
</c:set>
<input value="${today}" id="today" readonly style="display: none;">
<input value="${time}" id="time" readonly style="display: none;">
<div>
	<div class="container mt-3 mb-3">
		
		<div class="mb-3 mt-3">
			<div class="d-flex mb-1">
				<div class="ms-auto">
					<c:if test="${user.me_id == post.po_me_id}">
						<c:url value="/post/update" var="updateUrl">
							<c:param name="ca">${pm.cri.ca}</c:param>
							<c:param name="num"  value="${post.po_num}"/>
						</c:url>
						<a href="${updateUrl}" class="btn btn-sm btn-success me-2">수정</a>
					</c:if>
					<c:if test="${user.me_mr_num < 2 || user.me_id == post.po_me_id}">					
						<c:url value="/post/delete" var="deleteUrl">
							<c:param name="num"  value="${post.po_num}"/>
						</c:url>
						<a href="${deleteUrl}" class="btn btn-sm btn-danger">삭제</a>
					</c:if>	
				</div>
			</div>
			<div style="display: block; border: 1px solid; padding: 10px; border-radius: 5px">
				<div>
					<div id="title" style="font-size: 25px; font-weight: bold; word-break: break-all; overflow-wrap: break-word;">[${post.ca_name}] ${post.po_title}</div>
				</div>
				<div class="mt-2 d-flex justify-content-between">
					<div id="writer">
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
						<a type="button" class="dropdown-toggle" data-bs-toggle="dropdown" style="cursor: pointer; color: black; text-decoration: none; font-size: large;">
					    	${post.me_nick}
						</a>
						<div class="dropdown-menu">
							<c:url value="/post/list" var="targetUrl">
								<c:param name="type" value="target" />
								<c:param name="search" value="${post.me_nick}" />
							</c:url>
							<a class="dropdown-item" href="${targetUrl}">작성글</a>
							<c:if test="${user.me_id != post.po_me_id && user.me_mr_num <= 1 && post.me_mr_num == 2}">
								<c:url value="/popup/member/punish" var="popupURL">
									<c:param name="nick" value="${post.me_nick}"/>
								</c:url>
								<a class="dropdown-item member-punish-btn" type="button" data-url="${popupURL}">활동정지</a>
							</c:if>
						</div>
						<div id="date-box" style="font-size: small;" data-datetime="${post.po_datetime}" data-view="${post.po_view}">${post.po_datetime} 조회 ${post.po_view}</div>
					</div>
					<div class="mr-3"></div> 
				</div>
			</div>
		</div>
		
		<div class="mb-3">
			<div style="min-height: 250px; display: block; border: 1px solid; padding: 10px; border-radius: 5px">
				<c:if test="${voteList.size() != 0 && voteList != null}">
					<div class="vote-container d-flex flex-wrap align-items-end">
						<c:forEach items="${voteList}" var="vote">
							<c:if test="${vote.vo_state == 1}">
								<div class="vote-box mb-3" style="margin: 0 auto; height: 100%; width: 30%; min-width: 300px" data-num="${vote.vo_num}" data-date="${vote.vo_date}">
									<c:if test="${vote.vo_dup}">
										<div class="d-flex mt-1" style="margin-bottom: 0">
											<label class="ml-auto" style="font-size: small; color: gray;">다중선택 허용</label>
											<input value="${vote.vo_dup}" id="vo_dup" readonly style="display: none;">
										</div>	
									</c:if>
									<c:if test="${vote.vo_title != null && vote.vo_title.length() != 0}">
										<div class="input-group mt-1">
											<div class="input-group-prepend">
												<label for="vote-title" class="input-group-text">투표명</label>				
											</div>
											<div id="vote-title" class="input-group form-control" style="word-break: break-all; overflow-wrap: break-word;">${vote.vo_title}</div>
										</div>
									</c:if>
									<div class="input-group mb-2 mt-1">
										<div class="input-group-prepend">
											<label for="vote-date" class="input-group-text">투표기한</label>				
										</div>
										<div id="vote-date" class="input-group form-control">${vote.vo_date}</div>
									</div>
									<div class="select-list">
										<c:forEach items="${itemList}" var="item">
											<c:if test="${vote.vo_num == item.it_vo_num}">
												<button class="select-item form-control btn btn-outline-secondary mb-1" value="${item.it_num}" name="${item.it_num}" type="button" data-dup="${item.vo_dup}">${item.it_name}</button>
											</c:if>
										</c:forEach>
									</div>
									<c:if test="${post.po_me_id == user.me_id}">
										<button class="btn btn-outline-success form-control mt-2 mb-2 btn-close-vote" type="button">투표 마감</button>
									</c:if>
									<div class="d-flex mt-1" style="margin-bottom: 0">
										<label class="ms-auto mr-2 member-count-label" style="font-size: small;">${vote.vo_totalMember}명 참여중</label>
									</div>	
								</div>
							</c:if>
							<c:if test="${vote.vo_state == 0}">
								<div class="vote-box mb-3" data-num="${vote.vo_num}" data-date="${vote.vo_date}" style="margin: 0 auto; height: 100%; width: 30%; min-width: 300px"">
									<c:if test="${vote.vo_dup}">
										<div class="d-flex mt-1" >
											<label class="ml-auto" style="font-size: small; color: gray;">다중선택 허용</label>
										</div>	
									</c:if>
									<c:if test="${vote.vo_title != null && vote.vo_title.length() != 0}">
										<div class="input-group mt-1">
											<div class="input-group-prepend">
												<label for="vote-title" class="input-group-text">투표명</label>				
											</div>
											<div id="vote-title" class="input-group form-control">${vote.vo_title}</div>
										</div>
									</c:if>
									<c:forEach items="${itemList}" var="item">
										<c:if test="${vote.vo_num == item.it_vo_num}">
											<div class="item-group" style="margin-bottom: 3px; border: 1px solid #dadada;">
												<div >${item.it_name}:</div>
												<c:if test="${item.it_count == 0}">
													<div class="ms-1">0표</div>
												</c:if>
												<c:if test="${item.it_count != 0}">
													<div class="progress" style="height:30px; background-color: white;">
														<div class="progress-bar bg-success" style="width: ${item.it_count / vote.vo_totalMember * 100}%; height: 100%; font-size: large;">${item.it_count}표</div>
													</div>
												</c:if>
											</div>
										</c:if>
									</c:forEach>
									<div class="d-flex mt-1" style="margin-bottom: 0">
										<label class="ms-auto mr-2" style="font-size: small;">총 ${vote.vo_totalMember}명 참여</label>
									</div>	
								</div>
							</c:if>
						</c:forEach>
					</div>
					<hr class="line-hr">
				</c:if>
				<div class="container" >
					<div style="min-height: 150px">
						${post.po_content}
					</div>
				</div>
			</div>
		</div>
		<div class="mb-3 mt-3 d-flex justify-content-between">
			<div class="d-flex">
				<i class="bi-heart btn-heart me-2" style="font-size:1.7rem; color: red; cursor: pointer;"></i>
				<div style="font: bolder; font-size: x-large;" class="text-heart">${post.po_totalHeart}</div> 
			</div>
			
			<div>
				<c:if test="${user.me_id != post.po_me_id && user.me_mr_num == 2 && post.me_mr_num == 2}">
					<a href="#" class="btn btn-danger btn-report" data-bs-toggle="modal" data-bs-target="#reportingModal" class="reportingModal" data-writer="${post.me_nick}" data-what="po" data-num="${post.po_num}">신고</a>
				</c:if>
			</div>
		</div>
		
		<div class="mt-3 mb-3 comment-box container">
			<h4>댓글(<span class="comment-total">0</span>)</h4>
			<hr class="line-hr">
			<!-- 댓글 리스트를 보여주는 박스 -->
			<div class="comment-list">
				
			</div>
			<!-- 댓글 페이지네이션 박스 -->
			<div class="comment-pagination">
				<ul class="pagination justify-content-center">
				
				</ul>
			</div>
			<!-- 댓글 입력 박스 -->
			<div class="comment-input-box">
				<div class="input-group">
					<textarea rows="4" class="form-control comment-content" style="border-left-color: #777; border-top-color: #777; border-bottom-color: #777; resize: none;"></textarea>
					<button type="button" class="btn btn-outline-success col-2 btn-comment-insert">등록</button>
				</div>
			</div>

		</div>
	</div>
</div>


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
				<button type="button" class="btn btn-secondary btn-reporting" data-bs-dismiss="modal">신고하기</button>
			</div>

		</div>
	</div>
</div>


<!-- 문자열 자르기 스크립트 -->
<script type="text/javascript">
getTime() 
function getTime() {
	let datetime = $("#date-box").data("datetime").substring(0,16)
	let view = $("#date-box").data("view")
	let tmpStr = datetime +' 조회 ' +view ;
	$("#date-box").text(tmpStr);
}
</script>

<!-- 좋아요 구현 스크립트 -->
<script type="text/javascript">

$(document).on("mouseover", ".btn-heart", function () {
	$(this).addClass("fa-beat")
})



$(document).on("mouseleave", ".btn-heart", function () {
	$(this).removeClass("fa-beat")
})



$(".btn-heart").on("click", function(){
	if('${user.me_id}' == ''){
		if(confirm("로그인이 필요한 서비스 입니다. 로그인으로 이동하시겠습니까?")){
			location.href = "<c:url value='/login'/>"
			return;
		}
		else{
			return;
		}
	}
	
	if('${user.me_block}' >= today){
		alert("커뮤니티 이용이 정지됐습니다.\n정지기한 : "+'${user.me_block}');
		$(".comment-content").val("");
		return;
	}
	
	let po_num = ${post.po_num};
	$.ajax({
		url : '<c:url value="/post/heart"/>',
		method : "post",
		data : {
			"po_num" : po_num
		},
		success : function (data) {
			switch (data.result) {
			case 1:
				alert("게시글을 추천했습니다.");
				break;
			case 0:
				alert("추천을 취소했습니다.");
				break;
			case -1:
				alert("추천에 실패했습니다.");
				break;
			}
			getHeart();
		},
		error : function (a,b,c) {
			alert("추천에 실패했습니다.");
			location.reload(true);
		}
	});
	
});


function getHeart() {
	let po_num = ${post.po_num};
	$.ajax({
		url : '<c:url value="/post/countHeart"/>',
		method : "post",
		data : {
			"po_num" : po_num
		},
		success : function (data) {
			displayHeart(data.result);
			displayUpdateHeart(data.totalCountHeart);
		},
		error : function (a,b,c) {
			console.error("에러 발생1");
		}
	});
}

function displayUpdateHeart(totalCountHeart) {
	$(".text-heart").text(totalCountHeart);
}

function displayHeart(result) {
	$('.btn-heart').addClass("bi-heart");
	$('.btn-heart').removeClass("bi-heart-fill");
	if(result){
		$('.btn-heart').addClass("bi-heart-fill");
		$('.btn-heart').removeClass("bi-heart");
	
	}else{
		$('.btn-heart').addClass("bi-heart");
		$('.btn-heart').removeClass("bi-heart-fill");
	}
	
}
getHeart();
</script>

<!-- 댓글 리스트 출력 스크립트 -->
<script type="text/javascript">
let today = $("#today").val();
let cri = {
	page : 1,
	poNum : '${post.po_num}'
}
getCommentList(cri, today)
function getCommentList(cri, today) {
	$.ajax({
		url : '<c:url value="/comment/list"/>',
		method : "post",
		data : JSON.stringify(cri),
		contentType : "application/json; charset=utf-8",
		dataType : "json", 
		success : function(data){
			if(!data.result){
				location.reload(true);
				return;
			}
			let commentList = data.list;
			let str = '';
			let count = 0;
			if(commentList == null || commentList.length == 0){
				str = '<div class="container text-center mb-3 mt-3">아직 등록된 댓글이 없습니다.</div>';
			}
			for(comment of commentList){
				if(comment.co_state == 0 && comment.co_num == comment.co_ori_num){
					count++;
					str +=
						`
						<div class="comment-container text-center" style="min-height: 70px; ">
							<h3 class="text-center" style="padding-top:15px">삭제된 댓글입니다.</h3>
						</div>	
						<hr>
						`
				}
				else if(comment.co_state == -1 && comment.co_num == comment.co_ori_num){
					count++;
					str +=
						`
						<div class="comment-container text-center" style="min-height: 70px; ">
							<h3 class="text-center" style="padding-top:15px">운영자에 의해 삭제된 댓글입니다.</h3>
						</div>	
						<hr>
						`
				}
				else if(comment.co_state == -1 && comment.co_num != comment.co_ori_num){
					count++;
					str +=
						`
						<i class="bi bi-arrow-return-right ml-2 mr-2" style="font-size:2.5rem; color: gray; float:left"></i>
						<div class="comment-container text-center" style="min-height: 70px; ">
							<h3 class="text-center" style="margin-left: 100px; padding-top:15px;">운영자에 의해 삭제된 댓글입니다.</h3>
						</div>	
						<hr>
						`
				}
				
				else{
					let btns = "";
					if('${user.me_id}' == comment.co_me_id){
						btns += 
						`
						<div class="btn-comment-group ml-auto">
							<button class="btn btn-outline-warning btn-comment-update me-2" data-num="\${comment.co_num}">수정</button>
							<button class="btn btn-outline-danger btn-comment-delete " data-num="\${comment.co_num}">삭제</button>
						</div>
						`
					}
					else if(('${user.me_mr_num}' == 1 || '${user.me_mr_num}' == 0) && '${user}' != ''){
						btns += 
						`
						<div class="btn-comment-group ml-auto ">
							<button class="btn btn-outline-danger btn-comment-delete " data-num="\${comment.co_num}">삭제</button>
						</div>
						`
					}
					else{
						
					}
					
					
					
					if(comment.co_num == comment.co_ori_num){
						str +=
						`
							<div class="comment-container">
								<div class="input-group mb-3 box-comment">
									<div class="col-2 d-flex"><h5 class="me-2">
						`
					}
					else{
						str +=
						`
							<i class="bi bi-arrow-return-right ms-2" style="font-size:2.5rem; color: #555; float:left"></i>
							<div class="comment-container" style="margin-left: 80px;">
								<div class="input-group mb-3 box-comment">
									<div class="col-2 d-flex"><h5 class="me-2">
						`
					}
					if(comment.me_mr_num == 0){
						str += 
						`
							<img width="18" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEMAAABDCAYAAADHyrhzAAAACXBIWXMAAAsTAAALEwEAmpwYAAAEnklEQVR4nO2c3UsrRxTAtx8PLeU+9KnQQmn/hNK3vvheaJ8qZs/ZJBrFqBUVPzCLiohexIg+iNpaEY31G4sffdEqFIuIilQULPZB8CsKohaUoMaPucxyM7hxk5ukue7OZg+ch5ydPXPyy8w5s6OzghBBnE7nB6IofgcAPwPAnwDwDyLu8KYA8C8A/AUAPgDIcLlcL4RYJT09/T0AyEVEPyISsykA/AcAlfTHjgrC5XK9AIApvQN+Jl232+2fa4KQJOkjRPzbAEE+p+7abLZPnsBAxN8MEJweupiWlvY+AyGK4rcGCEo3pTmSwQCAVb0D0ln9tHAIGRkZXxggGKK3iqKYJrwuoyTVFQBeUhgNegeCBlAA+JVWkS69A0EDKADM0pHRrXcgaAAFgHkLBlowiDUy0JomxMoZqFMCLSgoICMjI0/U4/EkNePLsqzZD+3fMNWkurqaaMny8nJSYaysrGj2Q/s3PIzb21uSl5eXFBDUTzAY5BcGlf7+/qTAGBwcJJHEsDCCwSDZ399nn/f29pICw+/3M5+Hh4d8wKAyNDREkhlsXV3dW/X/VmFUVFSo5vfc3Nz/8r+wsMB80RHS1NTED4zS0lJV5g8EAiQrKysh3zk5OeT6+pr5GhgYIK2trfzAqKysJM3NzSpbZ2dnQr57enpU1Sk/P5+0t7fzA8Pj8RC73U5OT0+ZbWtrKyHfOzs7zMfq6qpi6+rq4geGLMuKfXp6mtkeHh6U6ROPXwr1sXi9XsXe29vLD4yqqirFXlZWpkAIycTERFx+Z2Zm2L1nZ2fKaKN2mje4gVH9KLjt7W1mp9Mm9IXepJmZmeTy8pLdOzk5ya4NDw/zCaO7u1t1jZbFWHx2dHREnGLcwsjOziZXV1dxP7zRhBsp+XILA8MWTaHyGM1fSUmJKteEl2WuYdTX18f18DY1NRV1wcY1DEQkR0dH7PrBwUFEXw6Hg5yfn0ddynMPY2xsTNWmpqZG01dLS4tmmTYVjMLCQnJ/f8/azM/Pa/paW1tjbehWgFYb7mEgItnY2IiaC+he5t3dHWvj8/nMC6OtrU3VLrxKjI6OxrRlaAoYTqeTXFxcaK4fJEkix8fH7NrS0lLE/kwBAxHJ7Oys5sqyoaFB5aOxsdH8MGRZVrUNPbwtLi4y28nJiTJSTA8DEcnu7i5rS9cUbreb3NzcMNv4+HjU+00Fw+fzqdqvr6+rpk5xcXHqwHC73RH/ILS5ufnG/kwFAxGVp1ctoeU35WB4vd4nIOhmDi2/KQdDkiTVhjEVus0XS3+mg4Fhj+qPN5K5hpGbm6vM9ZDSz7HcV1RUxP7Hoq+vL+b+ysvLE+rvWWCgCdSCgRYMYo0MtKYJsXIGJp5A2/TO5GgM/Z3CkA0QCDGA/kTPm3xvgECI3goARfSE84cAENA7GL1VkqQvQ2daf0nxUfEHO8rpcDg+S9XRAQD3Npvtq/ATzz8g4kMKwpA1z8MjoifFgHQKgvBOxDclAEA6Ip6bfDQEAODHqK+MCAkAfIyITQBwZDIIp3Q02Gy2T4V4pba29l0A+FoURUTEUvoSDg61HADskiR9o5x3jyKvAHbQX3wyaiWpAAAAAElFTkSuQmCC">
						`
					}
					else if(comment.me_mr_num == 1){
						str += 
						`
							<img width="18" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEMAAABDCAYAAADHyrhzAAAACXBIWXMAAAsTAAALEwEAmpwYAAAEjElEQVR4nO2c30/bVRTAG50vPrmHxcT4D+jr4nxconBvk21OXWZQZ5Ys8cX4YtRoFk0l7t7ya8tKxoSxGbMRo8icgoDcW9rRymSMbaV2bEXK5oAyJrABK4P+OubeFew3pQiY9rb9fk9y3trm3E/OOffce3quybSKNFt2PskofoURfJBRXM0Irss35RQf5wR/wWnxfjt56WnTesVZZn6WE1TPCJrnFEPhKIoxgrj9ENq2JhAdxLyPUxRSb3jmlBEcZwTZnJbtm9KCYAQfVG1oVpWg1r66rU+kgLCT4hJBTLmBWfcSVKMB8Yt1x2ZO8ZRqw5SpFRctw+AEVyo3SK139EoQFovlMUbQuGqDVKudmJ83ddDiF1UbwnNAmRV9kthK1RujWhlFJ02MoA9VG8JzQQlq1V9tQdMpshswqAEDDM+gRpiAkTNoniRQR+VuuPL9ZxBwN0DQy+Du4O/w91Av3LnugtGrrfCn4xR4mkqh6+gbhbubdNlKYORyC0QWQrA2icPsRAAGHSfBVf1m4cDwNJVCeH4WNioCSEHA8J6jEI/HNIuLhh/ChL8bAu4z4OdfwWBnPQx3fytDJTQ1qvWPeAxc1W/lPwz3sX0pYTHqaQfn4df+83sD7TaYvu2V+STz3psFGLd6ftCA+Ovi2XX/hr1sR2HACCW5fPjhHHRW7MrCwnIShhli0cgyDLGFql+0IhidFbs0ITLuc+TAopV5BoZYZHEZxv2Ra/qGMRP0/7tFxqKy8NItjIC7QRMqoo4QuUSXMLpsJbLAShZRbDkPv64/GJxi8LVUpZTX4fkZGDr/DTiP7NEXDE6xPFusJNHwAox5foWLX7+vHxicYrja+DksPpiGdCKS7UCbTR7xCx4GF3cZVa9CwHUGIgsP0kJZDN2XdxrZrVYV3o47KnfDQNtRmBm7kRbK/HQQ+ho+LnwYPEm7aw/Io/zC3FQKEFGb+Jor9AODJ1SEhZ/XpoRQPBaB3tMf6AsGT+hvx/fD7J0hDZB7Iz59wuCJYm0xdE8DxF3zjj5h8BUuhvp/PKRfGP1nv9TAuNFRo18YfQ0faWDcvPCdfmH4mssNz+AJGOJ0myw9p97LX8+w/49bbdF0Eh21JQlNjmTYEzMMw9NUCnMTw7JBdOHEu2v6Tmf5Tvn5WDSs8QpxyMt7GMkiym3RELrV0yR3hj9+LpOL9J4j4LfXQdDLV2xBbqTXkvMw1iviXCKuDbNzTZhhGN21B2AycCmlz7oWCKLHktmEmWUYPKHnj+yR4RBwnYaxfgZTw5dhZnwQ5u7elB03cYyfHO6D25d+kleEmf/7gUIYPC/UgAEGDGp4BhhhQo2cARtMoMZUAV+aKuAUva1+W8PqlaB6E6fmF5QbQnNkEknMqHGKgqqNUa2srOi5R8O9FJXrGsTS9KKcfbdsf0rPc62MmF/Wjn5bzXv1OPHMKTq24iw8J+hTPQFhBLes+jgAl1tt4b+SwCmuamzc+3haEEvCyoue4RSfKDgoBEUZwe0dVrTVtF5pTrys8ih8kE31KykbfVmFUWQRw8xtxLxltQX/AwTfUMDaNhZhAAAAAElFTkSuQmCC">
						`	
					}
					else{
						switch (comment.me_gr_num) {
						case 2:
							str += 
							`
								<img width="25"  src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAABJElEQVR4nO2ZTWoCQRCF+xiWie4kS4/hBXISYQpc6wVcZu/KDFnmDlkY6BZEELfqRvwBEUSs0IREAs6iW5juJu+DWs97U696hi6lAAAgWqrtcY3Y5MR6T2yk3NL7Cuu3aqafvMVXWK/LF27+lNXwwPrR2cD3mw8rnq419DAQIjamKE47nw5ITKVggNEBQYRcCB0ZimGIm92J9N6Xstie0jLQ6s/kdbSR0/kiPyRjYLo6yi2SMVBEMgY2h7MMPtby/DJP00C9M77ZjWQMUEGcYMAVdIARIcEQE06hKzhGXcExyvd/ySn0rwQMMDpggkeH/vEM6HgudzOzdTZglwvBhfNv5c4G7GYkmgVH9tlQPtjNiF0u2Pv58sVr+8zcWzwAAKgy+ALGkks5M3xO2gAAAABJRU5ErkJggg==">
							`		
							break;
						case 3:
							str += 
							`
								<img width="25"  src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAABqUlEQVR4nO2Zy4rCMBSG8yAzy2EeR5JSRQRREZe+gY+gK9F1t4N04VY3Cq7c6ULwBcSFMF4q9vRyhlSm1QHRVmlTJj8cKGlp/+/kJCkJIVJSUlLC6pjJvAOlPZOxHTCGcYZ5/qZ+UtXPyOZNSjdxG4e/IJRuDErfQgPwzCdtHoL4Cg2QRNnA7V7Yhu8BAYzDRUgAkD3AZAmF0v8dxIqCdreL7nKJuN97wa/tTse7JzaAoqAzHuMtOaOR2AB2q4X3ZDeb4gK4s1mQ7cEAoVxGKBTQGQ79dv6MsABoGL5RKBb9dqtWC7rAMMQFgFtRqQQAu136AGxNC0poPk8XgFWtIh6PwSBut1MEkM16Gfezv1oh5HIpAVBVdCaTi0XAQavRiPw+EitAPo/OdHo9/2vaUwkhsQGUSuguFtcrcL//dDmSOACseh3d9fravK4/P5ZYXAvZ4XD3V8Jb5IQFeFAS4BG9om5fGSSskjYMEoAln3WQJcRSPIhNsTZ3v6PMQnrSxuE3KO2FBuAnI6IccJwY+yBRxE9G+OEC359PwPiWZz6yeSkpKSkSh34A766mybHzuzMAAAAASUVORK5CYII=">
							`
							break;
						case 4:
							str += 
							`
								<img width="25"  src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAABiElEQVR4nO2ZwUrEMBCG8yB6FA824M0XUHwUD+7DKI3C6mW9SvGgfQL1UterNq4rrLRepAvu0ihUSmSKjahUTcU2wfnhh5JL/y8zaUuHEBQKhTJWW9cLs4w7nsvplHEqm7QL9wzpwXZI538Rno6bDs4+e7w5oDPaALDzBoSXr97XBmijbViVQzqpUQEDgvM3IwDDClBsIS3960Psxx0ZizOZ5Y+FYxEUa1YAnCe7skr9ZMdsAD/uyO9UtxKkCQBom1Kj9Fj2hsuFR+mJWo9EYC5AlgsVFIKX673hilrP8tRcAFbhvZtVBSCeE3sAuoMleRityfunSwVwNfHtAfioaXb3rrUYAnwhbCFu4SHObH+MxiJQQeHlBcHBt+mpHS8y/wefEkfRurkAjNPig61K/aRb+5FMmgIoKwGtAmcCDNd1d561AfAXJgjAsQISW0hH1h9i16Cfu27oPGgDwHCh7eBM2fG0AWAyYsqAY+NicY7UEUxGYLgA/+cbDx7CPR2vdngUCoUiTegFU2aJ1Yt8CosAAAAASUVORK5CYII=">
							`
							break;
						case 5:
							str += 
							`
								<img width="25"  src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAABMUlEQVR4nO2ZTQrCQAyFe4yO1aUIKngYjyYi4g1EPIPSClO3HsG6FPzDTeNERrRaiuAU6UwgD7Lppu97STYTz2OxWCxnhctaA0IxS0NxgkhglZU+/unPMaq1SptPQ39ftXEogPh7lEHdGEAnb9s8vGtqDGBjbOD7OB3NO+CAcfgoBgDugOARMpLtkQHrSyzbiHDCT5ECUNtBzjwtAKnTP9MFUMmwYJ4OQNzJ0leHFT0AlYwyw7dNnxhA3EWES5a+/kYKQO3GufRpAax7iLdrLn1SAGo3KaRPCgCf6f8iNwFQUQdA2gDwA5jTOwAMINzswL/KY4CIO4A8QiYiv8SpW4+7B2MAfVywbRxeFYqZMYC+jDhz4FgETWOAB4QM6vq4oN/nLYzNUSdf2jyLxWJ5VegOSOS+C4MgG8YAAAAASUVORK5CYII=">
							`
							break;
						case 6:
							str += 
							`
								<img width="25"  src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAABf0lEQVR4nO2ZsUoDQRCG90G00V1S+Qhq7QPIbVDsTKGWWtjamT7BZ5Bw4COIRTq1SOUjCCEmahR27kZG1BVMPHbBvV2cH4ZLFeab+Wfv2BGCxWKxolW2jIuZgp6WZqIVYNCQZpJJyDcb2PBOXkszDJ64+gEy3JK44A5Ala87efUV584AtdhGzY5MmbE7QASJ62/BAJo7AGwhJ/3bIT47LrBKUQPknTJtgKuLxAHuri3AyXaR3gyM7m2lD9YhLYCdFcDyowH0fBwhvk4RB/0S260ifoDDDfjV+3m3jBugc1R9hPp2QoQAmBV7q4A3l3awyU5JAWgFuL9mrTV9ivwY1XMiiffAy7NNkqyTXAcGfet18j0lTnGbygy0W9Wn0Olu5KdQ3p3/LUQfer7/K0IBfHaCrEIzQUG/fSuv6wD4ixAMoLgDyBZyUfpDLOO53NXKPDgD0HKh/sThPeiq3xmANiOxLDiaS6iEj2gzQssFup8PX3Uzpsp7J89isVgihN4AZZD+JaDC0u8AAAAASUVORK5CYII=">
							`
							break;
						}
					}
						
					str +=
					`
						\${comment.me_nick}</h5>
					`
								
					if(comment.co_me_id != '${user.me_id}' && comment.me_mr_num == 2 && '${user.me_mr_num}' == 2){
						str +=
						`
							<a href="#" style="height: 20px; margin-top: 5px; margin-left: 10px" class="badge bg-danger btn-report" data-bs-toggle="modal" data-bs-target="#reportingModal" class="reportingModal" data-writer="\${comment.me_nick}" data-what="co" data-num="\${comment.co_num}"><i class="fa-solid fa-handcuffs" style="color: #fffff;"></i></a>						
						`
					}
					str +=
					`
							</div>
							<div class="co_content col-8">\${comment.co_content}</div>
							\${btns}
						</div>
					`
					if(today == comment.co_datetime.substring(0,10)){
						str +=
						`
							<span style="font-size: small;" class="me-4">\${comment.co_datetime.substring(11,16)}</span>
						`
					}
					else{
						str +=
						`
							<span style="font-size: small;" class="me-4">\${comment.co_datetime.substring(0,10)}</span>
						`
					}
					if(comment.co_num == comment.co_ori_num){
						str +=
						`
							<a href="javascript:void(0);" class="reply reply-a" data-ori="\${comment.co_ori_num}">답글쓰기</a>
						`
					}
					str +=
					`
							<hr class="line-hr">
						</div>				
					`
				}
			}
			
			$(".comment-list").html(str);
			let pm = data.pm;
			let pmStr = "";
			//이전 버튼 활성화 여부
			if(pm.prev){
				pmStr += `
				<li class="page-item">
					<a class="page-link" href="javascript:void(0);" data-page="\${pm.startPage-1}">이전</a>
				</li>
				`;
			}
			//숫자 페이지
			for(let i = pm.startPage; i<= pm.endPage; i++){
				let active = pm.cri.page == i ? "active" : "";
				pmStr += `
			    <li class="page-item \${active}">
					<a class="page-link" href="javascript:void(0);" data-page="\${i}">\${i}</a>
				</li>
				`
			}
			//다음 버튼 활성화 여부
			if(pm.next){
				pmStr += `
				<li class="page-item">
					<a class="page-link" href="javascript:void(0);" data-page="\${pm.endPage + 1}">다음</a>
				</li>
				`
			}
			$(".comment-pagination>ul").html(pmStr);
			$('.comment-total').text(pm.totalCount - count);
		},
		error : function (a,b,c) {
			alert("댓글을 불러오는데 실패했습니다.")
			location.reload(true);
		}
	});
}

$(document).on("click", ".comment-pagination .page-link", function () {
	cri.page = $(this).data("page");
	getCommentList(cri, today);
})

</script>

<!-- 댓글 작성 스크립트 -->
<script type="text/javascript">
//댓글 등록 버튼 클릭 이벤트를 등록
$(".btn-comment-insert").click(function () {
	if('${user.me_id}' == ''){
		if(confirm("로그인이 필요한 서비스 입니다. 로그인으로 이동하시겠습니까?")){
			location.href = "<c:url value='/login'/>"
			return;
		}
		else{
			return;
		}
	}
	
	if('${user.me_block}' >= today){
		alert("커뮤니티 이용이 정지됐습니다.\n정지기한 : "+'${user.me_block}');
		$(".comment-content").val("");
		return;
	}
	
	let content = $(".comment-content").val();
	let poNum = '${post.po_num}';
	
	$.ajax({
		url : '<c:url value="/comment/insert"/>',
		method : "post",
		data : {
			"content" : content,
			"po_num" : poNum
		},
		success : function (data) {
			if(data.result){
				alert("댓글이 등록되었습니다.");
				cri.page = 1;
				getCommentList(cri, today);
				$(".comment-content").val("");
			}else{
				alert("댓글 등록에 실패했습니다.");
				location.reload(true);
			}
		},
		error : function (a,b,c) {
			alert("댓글 등록에 실패했습니다.")
			location.reload(true);
		}
	});		
});
</script>

<!-- 댓글 수정 스크립트 -->
<script type="text/javascript">
$(document).on("click",".btn-comment-update",function(){
	if('${user.me_block}' >= today){
		alert("커뮤니티 이용이 정지됐습니다.\n정지기한 : "+'${user.me_block}');
		$(".comment-content").val("");
		return;
	}
	
	initComment()
	// 현재 댓글 보여주는 창이 textarea태그로 변경
	// 기존 댓글 창을 감춤
	$(this).parents(".box-comment").find(".co_content").hide();
	let comment = $(this).parents(".box-comment").find(".co_content").text();
	let textarea =
	`
	<textarea rows="3" class="form-control com-input" style="resize: none;">\${comment}</textarea>
	`
	$(this).parents(".box-comment").find(".co_content").after(textarea);
	// 수정 삭제 버튼 대신 수정 완료 버튼으로 변경
	$(this).parents(".btn-comment-group").hide();
	let num = $(this).data("num");
	let btn = 
	`
	<button class="btn btn-outline-success btn-complete" data-num="\${num}" type="button">수정완료</button>
	`
	$(this).parent().after(btn);
});

$(document).on("click",".btn-complete",function(){
	if('${user.me_block}' >= today){
		alert("커뮤니티 이용이 정지됐습니다.\n정지기한 : "+'${user.me_block}');
		$(".comment-content").val("");
		return;
	}
	
	let num = $(this).data("num");
	let content = $(".com-input").val();
	$.ajax({
		url : '<c:url value="/comment/update"/>',
		method : "post",
		data : {
			"num" : num,
			"content" : content
		},
		success : function (data) {
			if(data.result){
				alert("댓글을 수정했습니다.");
				getCommentList(cri, today);
			}
			else{
				alert("댓글 수정에 실패했습니다.");
				location.reload(true);
			}
		},
		error : function (a, b, c) {
			alert("댓글을 찿을 수 없습니다.")
			location.reload(true);
		}
	});
});


function initComment() {
	//감추었던 댓글 내용을 보여줌
	$(".co_content").show();
	$(".reply").show();
	//감추었던 수정 삭제 버튼을 보여줌
	$(".btn-comment-group").show();
	//textarea 삭제
	$(".com-input").remove();
	$(".reply-box").remove();
	//수정 버튼 
	$(".btn-complete").remove();
}

</script>

<!-- 댓글 삭제 스크립트 -->
<script type="text/javascript">
$(document).on("click",".btn-comment-delete",function(){
	if('${user.me_id}' == ''){
		if(confirm("로그인이 필요한 서비스 입니다. 로그인으로 이동하시겠습니까?")){
			location.href = "<c:url value='/login'/>"
			return;
		}
		else{
			return;
		}
	}
	
	if('${user.me_block}' >= today){
		alert("커뮤니티 이용이 정지됐습니다.\n정지기한 : "+'${user.me_block}');
		$(".comment-content").val("");
		return;
	}
	
	let num = $(this).data("num");
	$.ajax({
		url : '<c:url value="/comment/delete"/>',
		method : "post",
		data : {
			"num" : num
		},
		dataType : "json", 
		success : function (data) {
			if(data.result){
				alert("댓글이 삭제되었습니다.");
				getCommentList(cri, today);
			}
			else{
				alert(data.message);
				location.reload(true);
			}
		},
		error : function (a,b,c) {
			alert("댓글을 찾을 수 없습니다.")
			location.reload(true);
		}
	});
});
</script>

<!-- 대댓글 작성 스크립트 -->
<script type="text/javascript">
$(document).on("click",".reply",function(){
	initComment();
	if('${user.me_id}' == ''){
		if(confirm("로그인이 필요한 서비스 입니다. 로그인으로 이동하시겠습니까?")){
			location.href = "<c:url value='/login'/>"
			return;
		}
		else{
			return;
		}
	}
	
	if('${user.me_block}' >= today){
		alert("커뮤니티 이용이 정지됐습니다.\n정지기한 : "+'${user.me_block}');
		$(".comment-content").val("");
		return;
	}
	
	let ori = $(this).data("ori");
	
	$(this).hide();
	let textarea = 
		`
			<div class="input-group reply-box mt-3 mb-3">
				<textarea rows="3" class="form-control reply-content"></textarea>
				<button type="button" class="btn btn-outline-success col-2 btn-reply-insert" data-ori="\${ori}">등록</button>
			</div>
		`;
	$(this).parent().after(textarea);
});

$(document).on("click",".btn-reply-insert",function(){
	if('${user.me_block}' >= today){
		alert("커뮤니티 이용이 정지됐습니다.\n정지기한 : "+'${user.me_block}');
		$(".comment-content").val("");
		return;
	}
	
	
	let ori = $(this).data("ori");
	let content = $(".reply-content").val();
	let po_num = '${post.po_num}';
	
	$.ajax({
		url : '<c:url value="/reply/insert"/>',
		method : "post",
		data : {
			"ori" : ori,
			"content" : content,
			"po_num" : po_num
		},
		success : function (data) {
			if(data.result){
				alert("댓글이 등록되었습니다.");
				cri.page = 1;
				initComment();
				getCommentList(cri, today);
			}else{
				alert("댓글 등록에 실패했습니다.");
				location.reload(true);
			}
		},
		error : function (a,b,c) {
			alert("댓글 등록에 실패했습니다.")
			location.reload(true);
		}
	});		
	
});
</script>

<!-- 투표 항목 선택 스크립트 -->
<script type="text/javascript">
getChooseByPost();

function getChooseByPost() {
	let po_num = ${post.po_num}
	$.ajax({
		url : '<c:url value="/vote/chooselist"/>',
		method : "post",
		data : {
			"po_num" : po_num
		},
		success : function (data) {
			refreshSelectItem();
			selectedItem(data.chooseList);
		},
		error : function (a,b,c) {
			console.error("에러 발생2");
		}
	})
}

function refreshSelectItem() {
	$(".select-item").removeClass("btn-secondary");
	$(".select-item").addClass("btn-outline-secondary");
}

function selectedItem(chooseList) {
	for(choose of chooseList){
		if(choose != null){
			$("[name=" + choose.ch_it_num + "]").addClass("btn-secondary");
			$("[name=" + choose.ch_it_num + "]").removeClass("btn-outline-secondary");
			//투표 완료시 인덱스를 이용할 수 없음
			//document.getElementsByClassName("select-item")[chooseList.indexOf(choose)].classList.add("btn-secondary");
			//document.getElementsByClassName("select-item")[chooseList.indexOf(choose)].classList.remove("btn-outline-secondary");
		}
	}
}


$(document).on("click",".select-item", function(){
	if('${user.me_id}' == ''){
		if(confirm("로그인이 필요한 서비스 입니다. 로그인으로 이동하시겠습니까?")){
			location.href = "<c:url value='/login'/>"
			return;
		}
		else{
			return;
		}
	}
	
	
	if('${user.me_block}' >= today){
		alert("커뮤니티 이용이 정지됐습니다.\n정지기한 : "+'${user.me_block}');
		$(".comment-content").val("");
		return;
	}
	
	let label = $(this).parents(".vote-box").find(".member-count-label");
	let it_num = $(this).val();
	let vo_dup = $(this).data("dup");
	$.ajax({
		url : '<c:url value="/select/item"/>',
		method : "post",
		data : {
			"it_num" : it_num,
			"vo_dup" : vo_dup
		},
		dataType : "json", 
		success : function (data) {
			let totalMember = data.totalMember;
			switch (data.result) {
			case 0:
				alert("투표 실패");
				location.reload(true);
				break;
			case 1:
				alert("투표 성공");
				break;
			case 2:
				alert("투표 취소");
				break;
			case 3:
				alert("투표 수정");
				break;
			}
			getChooseByPost();
			let str = `\${totalMember}명 참여중`;
			label.text(str);
		},
		error : function (a,b,c) {
			alert("이미 없는 투표입니다.");
			location.reload(true);
		}
	})
})



</script>

<!-- 투표 상태 변경 스크립트(투표완료, 기한만료) -->
<script type="text/javascript">
let time = $('#time').val();

$(document).on("click",".btn-close-vote",function(){
	if('${user.me_id}' == ''){
		alert("세션이 만료되었습니다.")
		location.href = "<c:url value='/login'/>"
		return;
	}
	
	if('${user.me_block}' >= today){
		alert("커뮤니티 이용이 정지됐습니다.\n정지기한 : "+'${user.me_block}');
		$(".comment-content").val("");
		return;
	}
	
	let vo_num = $(this).parents(".vote-box").data("num");
	let vote_box = $(this).parents(".vote-box");
	let vote = {
		"vo_num" : vo_num,
		"vo_po_num" : '${post.po_num}'
	}
	$.ajax({
		url : '<c:url value="/vote/close"/>',
		method : "post",
		data : JSON.stringify(vote),
		contentType : "application/json; charset=utf-8",
		dataType : "json", 
		success : function(data){
			let itemList = data.itemList;
			let vote = data.vote;
			if(data.result){
				vote_box.empty();
				let str = '';
				if(vote.vo_dup){
					str +=
					`
						<div class="d-flex mt-1" >
							<label class="ms-auto" style="font-size: small; color: gray;">다중선택 허용</label>
						</div>
					`
				}
				if(vote.vo_title.length != 0 && vote.vo_title != null){
					str += 
					`
						<div class="input-group mt-1">
							<div class="input-group-prepend">
								<label for="vote-title" class="input-group-text">투표명</label>				
							</div>
							<div id="vote-title" class="input-group form-control">\${vote.vo_title}</div>
						</div>
					`
				}
				for(item of itemList){
					str +=
					`
						<div class="item-group">
							<div class="mr-1 col-2">
								<label>\${item.it_name} :</label>
							</div>
							<div class="flex-grow-1">
								<div class="progress mt-1" style="height:25px">
									<div class="progress-bar bg-success" style="width: \${item.it_count / vote.vo_totalMember * 100}%; height: 100%">\${item.it_count}표</div>
								</div>
							</div>
						</div>
					`
				}
				str +=
				`
					<div class="d-flex mt-1" style="margin-bottom: 0">
						<label class="ms-auto mr-2" style="font-size: small;">총 \${vote.vo_totalMember}명 참여</label>
					</div>	
				`
				vote_box.html(str);
			}
			else{
				
			}
		},
		error : function (a,b,c) {
			alert("투표를 찾을 수 없습니다.");
			location.reload(true);
		}
	});
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
					<option>게시판에 맞지 않는 내용의 글</option>
				</select>
			</div>
			<label>신고 내용:</label>
			<textarea class="form-control report-note mb-2" placeholder="신고 이유를 자세하게 적어주세요." style="resize: none;"></textarea>
			
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
			if(result){
				location.reload(true);
			}
		},
		error : function (a,b,c) {
			alert("이미 삭제되어 신고할 수 없습니다.");
			location.reload(true);
		}
	});
	
})

</script>

</body>
</html>
