<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style type="text/css">
ul{padding: 0;}
.main-box {
	display: flex;
	justify-content: space-around;
	align-items: flex-start;
	background-color: #f0f0f0;
	padding-bottom: 30px;
}

.banner-box {
	margin-top: 20px;
	width: 60%;
	height: 350px;
}

.carousel-item img {
	width: 100%;
	height: 100%:
	overflow: auto;
}

.login-box {
	margin-top: 60px;
	border: 1px solid black;
	border-radius: 10px;
	width: 30%;
	height: 150px;
	position: relative;
	background-color:#fff;
}

.profile-box {
	margin-top: 60px;
	border: 1px solid black;
	border-radius: 10px;
	width: 30%;
	height: 250px;
	position: relative;
	box-sizing: border-box;
	background-color:#fff;
}

.main-post {
	display: flex;
	justify-content: space-around;
	margin-bottom: 20px;
}

.notice, .hot-post {
	width: 45%;
	height: 150px;
	background: #f2f2f2;
	text-align: center;
	line-height: 150px;
}

.book-tab {
	display: flex;
	flex-direction: column;
	align-items: center;
	border-bottom: 2px solid #f36c4f;
	position: relative;
	margin-top: 20px;
}

.new-btn, .loan-btn, .hot-btn {
	border-left: 0;
	border-top: 0;
	border-bottom: 3px solid skyblue;
	border-right: 1px solid skyblue;
	text-align: center;
	padding: 10px;
	background: #d5d5d5;
	color: inherit;
	text-decoration: none;
	position: relative;
	float: left;
	display: block;
}

.active-btn {
	background-color: aliceblue;
	padding: 15px;
}

.carousel-control-prev-icon, .carousel-control-next-icon {
	filter: invert(35%) sepia(100%) saturate(7500%) hue-rotate(5deg)
		brightness(0%) contrast(101%);
}

.boardname {
	color: #046582;
	text-decoration: none;
}

.aTag-home {
	text-decoration: none;
	color: #046582;
	max-width: 300px;
	white-space:nowrap; overflow:hidden; text-overflow:ellipsis;
}

.aTag-home:hover {
	text-decoration: underline;
	color: #848484;
}

.modal {
  display: none;
  position: fixed;
  z-index: 10;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgb(0,0,0);
  background-color: rgba(0,0,0,0.4);
}

.modal-content {
  background-color: #fefefe;
  margin: 15% auto;
  padding: 20px;
  border: 1px solid #888;
  width: 50%;
  height: 350px;
}

.close {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
}

.community-container{padding: 30px 0; border-bottom: 1px solid #000; border-top:1px solid #000; width: 100%; margin-left: 0px;}
.community-box{ width: 50%;  max-height:500px;}

.book-tap {
    display: flex;
}

.book-tap span{margin-left: 5px;}

.book-list {
    display: flex;
    flex-wrap: wrap;
    padding: 30px 0; border-bottom: 1px solid #000;  border-top: 1px solid #000;
    
}

.book-item {
   	width:15%; margin: 0 2.5%;
    text-align: center; background-color: #f0f0f0;}
.book-item ul{margin: 0; padding: 0;}
.book-item ul li{text-overflow: ellipsis; overflow: hidden;  white-space: nowrap; width: 100%; margin: 5px 0;}
.book-item img{ width:100%; height: 270px;}
.book-item ul li:nth-child(2){font-weight: 700;}


</style>
<body>
	<div class="container">
		<div class="main">
			<div id="nav">
			</div>
			<div class="main-box">
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
				<c:if test="${user == null}">
					<div class="login-box text-center">
						<a href="<c:url value='/login'/>"
							class="btn btn-outline-success login-btn col-8 mt-5">로그인</a>
						<div style="width: 100%;" class="mt-2">
							<a href="<c:url value="/find/id"/>" style="color: gray;">아이디찾기</a>
							<span style="color: gray; opacity: 60%">|</span> <a
								href="<c:url value="/find/pw"/>" style="color: gray;">비밀번호찾기</a>
							<span style="color: gray; opacity: 60%">|</span> <a
								href="<c:url value="/signup"/>" style="color: gray;">회원가입</a>
						</div>
					</div>
				</c:if>
				<c:if test="${user != null}">
					<div class="profile-box text-center">
						<ul style="text-align: center;">
							<li>[회원 정보]</li>
							<li>닉네임 : ${user.me_nick}</li>
							<li>가입일 : ${user.me_date}</li>
							<hr>
							<li>
								<c:forEach items="${gradeList}" var="grade">
									<c:if test="${user.me_mr_num == 0}">
										<img width="18" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEMAAABDCAYAAADHyrhzAAAACXBIWXMAAAsTAAALEwEAmpwYAAAEnklEQVR4nO2c3UsrRxTAtx8PLeU+9KnQQmn/hNK3vvheaJ8qZs/ZJBrFqBUVPzCLiohexIg+iNpaEY31G4sffdEqFIuIilQULPZB8CsKohaUoMaPucxyM7hxk5ukue7OZg+ch5ydPXPyy8w5s6OzghBBnE7nB6IofgcAPwPAnwDwDyLu8KYA8C8A/AUAPgDIcLlcL4RYJT09/T0AyEVEPyISsykA/AcAlfTHjgrC5XK9AIApvQN+Jl232+2fa4KQJOkjRPzbAEE+p+7abLZPnsBAxN8MEJweupiWlvY+AyGK4rcGCEo3pTmSwQCAVb0D0ln9tHAIGRkZXxggGKK3iqKYJrwuoyTVFQBeUhgNegeCBlAA+JVWkS69A0EDKADM0pHRrXcgaAAFgHkLBlowiDUy0JomxMoZqFMCLSgoICMjI0/U4/EkNePLsqzZD+3fMNWkurqaaMny8nJSYaysrGj2Q/s3PIzb21uSl5eXFBDUTzAY5BcGlf7+/qTAGBwcJJHEsDCCwSDZ399nn/f29pICw+/3M5+Hh4d8wKAyNDREkhlsXV3dW/X/VmFUVFSo5vfc3Nz/8r+wsMB80RHS1NTED4zS0lJV5g8EAiQrKysh3zk5OeT6+pr5GhgYIK2trfzAqKysJM3NzSpbZ2dnQr57enpU1Sk/P5+0t7fzA8Pj8RC73U5OT0+ZbWtrKyHfOzs7zMfq6qpi6+rq4geGLMuKfXp6mtkeHh6U6ROPXwr1sXi9XsXe29vLD4yqqirFXlZWpkAIycTERFx+Z2Zm2L1nZ2fKaKN2mje4gVH9KLjt7W1mp9Mm9IXepJmZmeTy8pLdOzk5ya4NDw/zCaO7u1t1jZbFWHx2dHREnGLcwsjOziZXV1dxP7zRhBsp+XILA8MWTaHyGM1fSUmJKteEl2WuYdTX18f18DY1NRV1wcY1DEQkR0dH7PrBwUFEXw6Hg5yfn0ddynMPY2xsTNWmpqZG01dLS4tmmTYVjMLCQnJ/f8/azM/Pa/paW1tjbehWgFYb7mEgItnY2IiaC+he5t3dHWvj8/nMC6OtrU3VLrxKjI6OxrRlaAoYTqeTXFxcaK4fJEkix8fH7NrS0lLE/kwBAxHJ7Oys5sqyoaFB5aOxsdH8MGRZVrUNPbwtLi4y28nJiTJSTA8DEcnu7i5rS9cUbreb3NzcMNv4+HjU+00Fw+fzqdqvr6+rpk5xcXHqwHC73RH/ILS5ufnG/kwFAxGVp1ctoeU35WB4vd4nIOhmDi2/KQdDkiTVhjEVus0XS3+mg4Fhj+qPN5K5hpGbm6vM9ZDSz7HcV1RUxP7Hoq+vL+b+ysvLE+rvWWCgCdSCgRYMYo0MtKYJsXIGJp5A2/TO5GgM/Z3CkA0QCDGA/kTPm3xvgECI3goARfSE84cAENA7GL1VkqQvQ2daf0nxUfEHO8rpcDg+S9XRAQD3Npvtq/ATzz8g4kMKwpA1z8MjoifFgHQKgvBOxDclAEA6Ip6bfDQEAODHqK+MCAkAfIyITQBwZDIIp3Q02Gy2T4V4pba29l0A+FoURUTEUvoSDg61HADskiR9o5x3jyKvAHbQX3wyaiWpAAAAAElFTkSuQmCC">
										마스터
									</c:if>
									<c:if test="${user.me_mr_num == 1}">
										<img width="18" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEMAAABDCAYAAADHyrhzAAAACXBIWXMAAAsTAAALEwEAmpwYAAAEjElEQVR4nO2c30/bVRTAG50vPrmHxcT4D+jr4nxconBvk21OXWZQZ5Ys8cX4YtRoFk0l7t7ya8tKxoSxGbMRo8icgoDcW9rRymSMbaV2bEXK5oAyJrABK4P+OubeFew3pQiY9rb9fk9y3trm3E/OOffce3quybSKNFt2PskofoURfJBRXM0Irss35RQf5wR/wWnxfjt56WnTesVZZn6WE1TPCJrnFEPhKIoxgrj9ENq2JhAdxLyPUxRSb3jmlBEcZwTZnJbtm9KCYAQfVG1oVpWg1r66rU+kgLCT4hJBTLmBWfcSVKMB8Yt1x2ZO8ZRqw5SpFRctw+AEVyo3SK139EoQFovlMUbQuGqDVKudmJ83ddDiF1UbwnNAmRV9kthK1RujWhlFJ02MoA9VG8JzQQlq1V9tQdMpshswqAEDDM+gRpiAkTNoniRQR+VuuPL9ZxBwN0DQy+Du4O/w91Av3LnugtGrrfCn4xR4mkqh6+gbhbubdNlKYORyC0QWQrA2icPsRAAGHSfBVf1m4cDwNJVCeH4WNioCSEHA8J6jEI/HNIuLhh/ChL8bAu4z4OdfwWBnPQx3fytDJTQ1qvWPeAxc1W/lPwz3sX0pYTHqaQfn4df+83sD7TaYvu2V+STz3psFGLd6ftCA+Ovi2XX/hr1sR2HACCW5fPjhHHRW7MrCwnIShhli0cgyDLGFql+0IhidFbs0ITLuc+TAopV5BoZYZHEZxv2Ra/qGMRP0/7tFxqKy8NItjIC7QRMqoo4QuUSXMLpsJbLAShZRbDkPv64/GJxi8LVUpZTX4fkZGDr/DTiP7NEXDE6xPFusJNHwAox5foWLX7+vHxicYrja+DksPpiGdCKS7UCbTR7xCx4GF3cZVa9CwHUGIgsP0kJZDN2XdxrZrVYV3o47KnfDQNtRmBm7kRbK/HQQ+ho+LnwYPEm7aw/Io/zC3FQKEFGb+Jor9AODJ1SEhZ/XpoRQPBaB3tMf6AsGT+hvx/fD7J0hDZB7Iz59wuCJYm0xdE8DxF3zjj5h8BUuhvp/PKRfGP1nv9TAuNFRo18YfQ0faWDcvPCdfmH4mssNz+AJGOJ0myw9p97LX8+w/49bbdF0Eh21JQlNjmTYEzMMw9NUCnMTw7JBdOHEu2v6Tmf5Tvn5WDSs8QpxyMt7GMkiym3RELrV0yR3hj9+LpOL9J4j4LfXQdDLV2xBbqTXkvMw1iviXCKuDbNzTZhhGN21B2AycCmlz7oWCKLHktmEmWUYPKHnj+yR4RBwnYaxfgZTw5dhZnwQ5u7elB03cYyfHO6D25d+kleEmf/7gUIYPC/UgAEGDGp4BhhhQo2cARtMoMZUAV+aKuAUva1+W8PqlaB6E6fmF5QbQnNkEknMqHGKgqqNUa2srOi5R8O9FJXrGsTS9KKcfbdsf0rPc62MmF/Wjn5bzXv1OPHMKTq24iw8J+hTPQFhBLes+jgAl1tt4b+SwCmuamzc+3haEEvCyoue4RSfKDgoBEUZwe0dVrTVtF5pTrys8ih8kE31KykbfVmFUWQRw8xtxLxltQX/AwTfUMDaNhZhAAAAAElFTkSuQmCC">
										운영진
									</c:if>
									<c:if test="${user.me_mr_num == 2}">
										<c:if test="${user.me_gr_num == 2}">
											<img width="25"  src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAABJElEQVR4nO2ZTWoCQRCF+xiWie4kS4/hBXISYQpc6wVcZu/KDFnmDlkY6BZEELfqRvwBEUSs0IREAs6iW5juJu+DWs97U696hi6lAAAgWqrtcY3Y5MR6T2yk3NL7Cuu3aqafvMVXWK/LF27+lNXwwPrR2cD3mw8rnq419DAQIjamKE47nw5ITKVggNEBQYRcCB0ZimGIm92J9N6Xstie0jLQ6s/kdbSR0/kiPyRjYLo6yi2SMVBEMgY2h7MMPtby/DJP00C9M77ZjWQMUEGcYMAVdIARIcEQE06hKzhGXcExyvd/ySn0rwQMMDpggkeH/vEM6HgudzOzdTZglwvBhfNv5c4G7GYkmgVH9tlQPtjNiF0u2Pv58sVr+8zcWzwAAKgy+ALGkks5M3xO2gAAAABJRU5ErkJggg==">
										</c:if>
										<c:if test="${user.me_gr_num == 3}">
											<img width="25"  src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAABqUlEQVR4nO2Zy4rCMBSG8yAzy2EeR5JSRQRREZe+gY+gK9F1t4N04VY3Cq7c6ULwBcSFMF4q9vRyhlSm1QHRVmlTJj8cKGlp/+/kJCkJIVJSUlLC6pjJvAOlPZOxHTCGcYZ5/qZ+UtXPyOZNSjdxG4e/IJRuDErfQgPwzCdtHoL4Cg2QRNnA7V7Yhu8BAYzDRUgAkD3AZAmF0v8dxIqCdreL7nKJuN97wa/tTse7JzaAoqAzHuMtOaOR2AB2q4X3ZDeb4gK4s1mQ7cEAoVxGKBTQGQ79dv6MsABoGL5RKBb9dqtWC7rAMMQFgFtRqQQAu136AGxNC0poPk8XgFWtIh6PwSBut1MEkM16Gfezv1oh5HIpAVBVdCaTi0XAQavRiPw+EitAPo/OdHo9/2vaUwkhsQGUSuguFtcrcL//dDmSOACseh3d9fravK4/P5ZYXAvZ4XD3V8Jb5IQFeFAS4BG9om5fGSSskjYMEoAln3WQJcRSPIhNsTZ3v6PMQnrSxuE3KO2FBuAnI6IccJwY+yBRxE9G+OEC359PwPiWZz6yeSkpKSkSh34A766mybHzuzMAAAAASUVORK5CYII=">
										</c:if>
										<c:if test="${user.me_gr_num == 4}">
											<img width="25"  src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAABiElEQVR4nO2ZwUrEMBCG8yB6FA824M0XUHwUD+7DKI3C6mW9SvGgfQL1UterNq4rrLRepAvu0ihUSmSKjahUTcU2wfnhh5JL/y8zaUuHEBQKhTJWW9cLs4w7nsvplHEqm7QL9wzpwXZI538Rno6bDs4+e7w5oDPaALDzBoSXr97XBmijbViVQzqpUQEDgvM3IwDDClBsIS3960Psxx0ZizOZ5Y+FYxEUa1YAnCe7skr9ZMdsAD/uyO9UtxKkCQBom1Kj9Fj2hsuFR+mJWo9EYC5AlgsVFIKX673hilrP8tRcAFbhvZtVBSCeE3sAuoMleRityfunSwVwNfHtAfioaXb3rrUYAnwhbCFu4SHObH+MxiJQQeHlBcHBt+mpHS8y/wefEkfRurkAjNPig61K/aRb+5FMmgIoKwGtAmcCDNd1d561AfAXJgjAsQISW0hH1h9i16Cfu27oPGgDwHCh7eBM2fG0AWAyYsqAY+NicY7UEUxGYLgA/+cbDx7CPR2vdngUCoUiTegFU2aJ1Yt8CosAAAAASUVORK5CYII=">
										</c:if>
										<c:if test="${user.me_gr_num == 5}">
											<img width="25"  src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAABMUlEQVR4nO2ZTQrCQAyFe4yO1aUIKngYjyYi4g1EPIPSClO3HsG6FPzDTeNERrRaiuAU6UwgD7Lppu97STYTz2OxWCxnhctaA0IxS0NxgkhglZU+/unPMaq1SptPQ39ftXEogPh7lEHdGEAnb9s8vGtqDGBjbOD7OB3NO+CAcfgoBgDugOARMpLtkQHrSyzbiHDCT5ECUNtBzjwtAKnTP9MFUMmwYJ4OQNzJ0leHFT0AlYwyw7dNnxhA3EWES5a+/kYKQO3GufRpAax7iLdrLn1SAGo3KaRPCgCf6f8iNwFQUQdA2gDwA5jTOwAMINzswL/KY4CIO4A8QiYiv8SpW4+7B2MAfVywbRxeFYqZMYC+jDhz4FgETWOAB4QM6vq4oN/nLYzNUSdf2jyLxWJ5VegOSOS+C4MgG8YAAAAASUVORK5CYII=">
										</c:if>
										<c:if test="${user.me_gr_num == 6}">
											<img width="25"  src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAABf0lEQVR4nO2ZsUoDQRCG90G00V1S+Qhq7QPIbVDsTKGWWtjamT7BZ5Bw4COIRTq1SOUjCCEmahR27kZG1BVMPHbBvV2cH4ZLFeab+Wfv2BGCxWKxolW2jIuZgp6WZqIVYNCQZpJJyDcb2PBOXkszDJ64+gEy3JK44A5Ala87efUV584AtdhGzY5MmbE7QASJ62/BAJo7AGwhJ/3bIT47LrBKUQPknTJtgKuLxAHuri3AyXaR3gyM7m2lD9YhLYCdFcDyowH0fBwhvk4RB/0S260ifoDDDfjV+3m3jBugc1R9hPp2QoQAmBV7q4A3l3awyU5JAWgFuL9mrTV9ivwY1XMiiffAy7NNkqyTXAcGfet18j0lTnGbygy0W9Wn0Olu5KdQ3p3/LUQfer7/K0IBfHaCrEIzQUG/fSuv6wD4ixAMoLgDyBZyUfpDLOO53NXKPDgD0HKh/sThPeiq3xmANiOxLDiaS6iEj2gzQssFup8PX3Uzpsp7J89isVgihN4AZZD+JaDC0u8AAAAASUVORK5CYII=">
										</c:if>
										${grade.gr_name}
									</c:if>
								</c:forEach>
								<a href="#" id="gradeInfoLink" class="grade-info" style="color: gray; opacity: 60%; text-decoration: none;">등급 안내</a>
							</li>
							<li>내가 쓴 게시글 : ${user.me_post_count}개</li>
							<li>내가 대출한 책 : ${user.me_loan_count}권</li>
						</ul>
						<a href="<c:url value="logout"/>"
							class="btn btn-outline-success col-8">로그아웃</a>
					</div>
				</c:if>
			</div>
			<div id="gradeModal" class="modal">
			  <div class="modal-content">
			    <span class="close">&times;</span>
			    <table class="grade-container table-hover">
			<thead>
				<tr>
					<th></th>
					<th>등급명</th>
					<th>할인율</th>
					<th>대출조건</th>
					<th>게시글조건</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${grade}" var="grade" begin="1" end="5" varStatus="status">
					<tr class="grade-list">
						<td class="col-1">
							<c:choose>
								<c:when test="${status.index == 1}">
									<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAABJElEQVR4nO2ZTWoCQRCF+xiWie4kS4/hBXISYQpc6wVcZu/KDFnmDlkY6BZEELfqRvwBEUSs0IREAs6iW5juJu+DWs97U696hi6lAAAgWqrtcY3Y5MR6T2yk3NL7Cuu3aqafvMVXWK/LF27+lNXwwPrR2cD3mw8rnq419DAQIjamKE47nw5ITKVggNEBQYRcCB0ZimGIm92J9N6Xstie0jLQ6s/kdbSR0/kiPyRjYLo6yi2SMVBEMgY2h7MMPtby/DJP00C9M77ZjWQMUEGcYMAVdIARIcEQE06hKzhGXcExyvd/ySn0rwQMMDpggkeH/vEM6HgudzOzdTZglwvBhfNv5c4G7GYkmgVH9tlQPtjNiF0u2Pv58sVr+8zcWzwAAKgy+ALGkks5M3xO2gAAAABJRU5ErkJggg==">
								</c:when>
								<c:when test="${status.index == 2}">
									<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAABqUlEQVR4nO2Zy4rCMBSG8yAzy2EeR5JSRQRREZe+gY+gK9F1t4N04VY3Cq7c6ULwBcSFMF4q9vRyhlSm1QHRVmlTJj8cKGlp/+/kJCkJIVJSUlLC6pjJvAOlPZOxHTCGcYZ5/qZ+UtXPyOZNSjdxG4e/IJRuDErfQgPwzCdtHoL4Cg2QRNnA7V7Yhu8BAYzDRUgAkD3AZAmF0v8dxIqCdreL7nKJuN97wa/tTse7JzaAoqAzHuMtOaOR2AB2q4X3ZDeb4gK4s1mQ7cEAoVxGKBTQGQ79dv6MsABoGL5RKBb9dqtWC7rAMMQFgFtRqQQAu136AGxNC0poPk8XgFWtIh6PwSBut1MEkM16Gfezv1oh5HIpAVBVdCaTi0XAQavRiPw+EitAPo/OdHo9/2vaUwkhsQGUSuguFtcrcL//dDmSOACseh3d9fravK4/P5ZYXAvZ4XD3V8Jb5IQFeFAS4BG9om5fGSSskjYMEoAln3WQJcRSPIhNsTZ3v6PMQnrSxuE3KO2FBuAnI6IccJwY+yBRxE9G+OEC359PwPiWZz6yeSkpKSkSh34A766mybHzuzMAAAAASUVORK5CYII=">
								</c:when>
								<c:when test="${status.index == 3}">
									<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAABiElEQVR4nO2ZwUrEMBCG8yB6FA824M0XUHwUD+7DKI3C6mW9SvGgfQL1UterNq4rrLRepAvu0ihUSmSKjahUTcU2wfnhh5JL/y8zaUuHEBQKhTJWW9cLs4w7nsvplHEqm7QL9wzpwXZI538Rno6bDs4+e7w5oDPaALDzBoSXr97XBmijbViVQzqpUQEDgvM3IwDDClBsIS3960Psxx0ZizOZ5Y+FYxEUa1YAnCe7skr9ZMdsAD/uyO9UtxKkCQBom1Kj9Fj2hsuFR+mJWo9EYC5AlgsVFIKX673hilrP8tRcAFbhvZtVBSCeE3sAuoMleRityfunSwVwNfHtAfioaXb3rrUYAnwhbCFu4SHObH+MxiJQQeHlBcHBt+mpHS8y/wefEkfRurkAjNPig61K/aRb+5FMmgIoKwGtAmcCDNd1d561AfAXJgjAsQISW0hH1h9i16Cfu27oPGgDwHCh7eBM2fG0AWAyYsqAY+NicY7UEUxGYLgA/+cbDx7CPR2vdngUCoUiTegFU2aJ1Yt8CosAAAAASUVORK5CYII=">
								</c:when>
								<c:when test="${status.index == 4}">
									<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAABMUlEQVR4nO2ZTQrCQAyFe4yO1aUIKngYjyYi4g1EPIPSClO3HsG6FPzDTeNERrRaiuAU6UwgD7Lppu97STYTz2OxWCxnhctaA0IxS0NxgkhglZU+/unPMaq1SptPQ39ftXEogPh7lEHdGEAnb9s8vGtqDGBjbOD7OB3NO+CAcfgoBgDugOARMpLtkQHrSyzbiHDCT5ECUNtBzjwtAKnTP9MFUMmwYJ4OQNzJ0leHFT0AlYwyw7dNnxhA3EWES5a+/kYKQO3GufRpAax7iLdrLn1SAGo3KaRPCgCf6f8iNwFQUQdA2gDwA5jTOwAMINzswL/KY4CIO4A8QiYiv8SpW4+7B2MAfVywbRxeFYqZMYC+jDhz4FgETWOAB4QM6vq4oN/nLYzNUSdf2jyLxWJ5VegOSOS+C4MgG8YAAAAASUVORK5CYII=">
								</c:when>
								<c:when test="${status.index == 5}">
									<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAABf0lEQVR4nO2ZsUoDQRCG90G00V1S+Qhq7QPIbVDsTKGWWtjamT7BZ5Bw4COIRTq1SOUjCCEmahR27kZG1BVMPHbBvV2cH4ZLFeab+Wfv2BGCxWKxolW2jIuZgp6WZqIVYNCQZpJJyDcb2PBOXkszDJ64+gEy3JK44A5Ala87efUV584AtdhGzY5MmbE7QASJ62/BAJo7AGwhJ/3bIT47LrBKUQPknTJtgKuLxAHuri3AyXaR3gyM7m2lD9YhLYCdFcDyowH0fBwhvk4RB/0S260ifoDDDfjV+3m3jBugc1R9hPp2QoQAmBV7q4A3l3awyU5JAWgFuL9mrTV9ivwY1XMiiffAy7NNkqyTXAcGfet18j0lTnGbygy0W9Wn0Olu5KdQ3p3/LUQfer7/K0IBfHaCrEIzQUG/fSuv6wD4ixAMoLgDyBZyUfpDLOO53NXKPDgD0HKh/sThPeiq3xmANiOxLDiaS6iEj2gzQssFup8PX3Uzpsp7J89isVgihN4AZZD+JaDC0u8AAAAASUVORK5CYII=">
								</c:when>
							</c:choose>
						</td>
						<td class="col-2 grade-item">
							<input type="text" readonly value="${grade.gr_name}" style="width: 170px; border: 0;" maxlength="10" class="name edit-input" readonly>
						</td>
						<td class="col-2 grade-item">
							<input type="text" readonly value="${grade.gr_discount}" style="width: 50px; border: 0; text-align: right;" maxlength="5" class="discount edit-input" readonly>%
						</td>
						<td class="col-2 grade-item">
							<input type="text" readonly value="${grade.gr_loan_condition}" style="width: 50px; border: 0; text-align: right;" maxlength="5" class="loan edit-input" readonly>개
						</td>
						<td class="col-2 grade-item">
							<input type="text" readonly value="${grade.gr_post_condition}" style="width: 50px; border: 0; text-align: right;" maxlength="5" class="post edit-input" readonly>개
						</td>
					</tr>
				</c:forEach>
				<tr>
					<td class="col-1">
						<img width="30" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEMAAABDCAYAAADHyrhzAAAACXBIWXMAAAsTAAALEwEAmpwYAAAEnklEQVR4nO2c3UsrRxTAtx8PLeU+9KnQQmn/hNK3vvheaJ8qZs/ZJBrFqBUVPzCLiohexIg+iNpaEY31G4sffdEqFIuIilQULPZB8CsKohaUoMaPucxyM7hxk5ukue7OZg+ch5ydPXPyy8w5s6OzghBBnE7nB6IofgcAPwPAnwDwDyLu8KYA8C8A/AUAPgDIcLlcL4RYJT09/T0AyEVEPyISsykA/AcAlfTHjgrC5XK9AIApvQN+Jl232+2fa4KQJOkjRPzbAEE+p+7abLZPnsBAxN8MEJweupiWlvY+AyGK4rcGCEo3pTmSwQCAVb0D0ln9tHAIGRkZXxggGKK3iqKYJrwuoyTVFQBeUhgNegeCBlAA+JVWkS69A0EDKADM0pHRrXcgaAAFgHkLBlowiDUy0JomxMoZqFMCLSgoICMjI0/U4/EkNePLsqzZD+3fMNWkurqaaMny8nJSYaysrGj2Q/s3PIzb21uSl5eXFBDUTzAY5BcGlf7+/qTAGBwcJJHEsDCCwSDZ399nn/f29pICw+/3M5+Hh4d8wKAyNDREkhlsXV3dW/X/VmFUVFSo5vfc3Nz/8r+wsMB80RHS1NTED4zS0lJV5g8EAiQrKysh3zk5OeT6+pr5GhgYIK2trfzAqKysJM3NzSpbZ2dnQr57enpU1Sk/P5+0t7fzA8Pj8RC73U5OT0+ZbWtrKyHfOzs7zMfq6qpi6+rq4geGLMuKfXp6mtkeHh6U6ROPXwr1sXi9XsXe29vLD4yqqirFXlZWpkAIycTERFx+Z2Zm2L1nZ2fKaKN2mje4gVH9KLjt7W1mp9Mm9IXepJmZmeTy8pLdOzk5ya4NDw/zCaO7u1t1jZbFWHx2dHREnGLcwsjOziZXV1dxP7zRhBsp+XILA8MWTaHyGM1fSUmJKteEl2WuYdTX18f18DY1NRV1wcY1DEQkR0dH7PrBwUFEXw6Hg5yfn0ddynMPY2xsTNWmpqZG01dLS4tmmTYVjMLCQnJ/f8/azM/Pa/paW1tjbehWgFYb7mEgItnY2IiaC+he5t3dHWvj8/nMC6OtrU3VLrxKjI6OxrRlaAoYTqeTXFxcaK4fJEkix8fH7NrS0lLE/kwBAxHJ7Oys5sqyoaFB5aOxsdH8MGRZVrUNPbwtLi4y28nJiTJSTA8DEcnu7i5rS9cUbreb3NzcMNv4+HjU+00Fw+fzqdqvr6+rpk5xcXHqwHC73RH/ILS5ufnG/kwFAxGVp1ctoeU35WB4vd4nIOhmDi2/KQdDkiTVhjEVus0XS3+mg4Fhj+qPN5K5hpGbm6vM9ZDSz7HcV1RUxP7Hoq+vL+b+ysvLE+rvWWCgCdSCgRYMYo0MtKYJsXIGJp5A2/TO5GgM/Z3CkA0QCDGA/kTPm3xvgECI3goARfSE84cAENA7GL1VkqQvQ2daf0nxUfEHO8rpcDg+S9XRAQD3Npvtq/ATzz8g4kMKwpA1z8MjoifFgHQKgvBOxDclAEA6Ip6bfDQEAODHqK+MCAkAfIyITQBwZDIIp3Q02Gy2T4V4pba29l0A+FoURUTEUvoSDg61HADskiR9o5x3jyKvAHbQX3wyaiWpAAAAAElFTkSuQmCC">
					</td>
					<td class="col-2">
						마스터입니다
					</td>
					<td class="col-1">
						<img width="30" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEMAAABDCAYAAADHyrhzAAAACXBIWXMAAAsTAAALEwEAmpwYAAAEjElEQVR4nO2c30/bVRTAG50vPrmHxcT4D+jr4nxconBvk21OXWZQZ5Ys8cX4YtRoFk0l7t7ya8tKxoSxGbMRo8icgoDcW9rRymSMbaV2bEXK5oAyJrABK4P+OubeFew3pQiY9rb9fk9y3trm3E/OOffce3quybSKNFt2PskofoURfJBRXM0Irss35RQf5wR/wWnxfjt56WnTesVZZn6WE1TPCJrnFEPhKIoxgrj9ENq2JhAdxLyPUxRSb3jmlBEcZwTZnJbtm9KCYAQfVG1oVpWg1r66rU+kgLCT4hJBTLmBWfcSVKMB8Yt1x2ZO8ZRqw5SpFRctw+AEVyo3SK139EoQFovlMUbQuGqDVKudmJ83ddDiF1UbwnNAmRV9kthK1RujWhlFJ02MoA9VG8JzQQlq1V9tQdMpshswqAEDDM+gRpiAkTNoniRQR+VuuPL9ZxBwN0DQy+Du4O/w91Av3LnugtGrrfCn4xR4mkqh6+gbhbubdNlKYORyC0QWQrA2icPsRAAGHSfBVf1m4cDwNJVCeH4WNioCSEHA8J6jEI/HNIuLhh/ChL8bAu4z4OdfwWBnPQx3fytDJTQ1qvWPeAxc1W/lPwz3sX0pYTHqaQfn4df+83sD7TaYvu2V+STz3psFGLd6ftCA+Ovi2XX/hr1sR2HACCW5fPjhHHRW7MrCwnIShhli0cgyDLGFql+0IhidFbs0ITLuc+TAopV5BoZYZHEZxv2Ra/qGMRP0/7tFxqKy8NItjIC7QRMqoo4QuUSXMLpsJbLAShZRbDkPv64/GJxi8LVUpZTX4fkZGDr/DTiP7NEXDE6xPFusJNHwAox5foWLX7+vHxicYrja+DksPpiGdCKS7UCbTR7xCx4GF3cZVa9CwHUGIgsP0kJZDN2XdxrZrVYV3o47KnfDQNtRmBm7kRbK/HQQ+ho+LnwYPEm7aw/Io/zC3FQKEFGb+Jor9AODJ1SEhZ/XpoRQPBaB3tMf6AsGT+hvx/fD7J0hDZB7Iz59wuCJYm0xdE8DxF3zjj5h8BUuhvp/PKRfGP1nv9TAuNFRo18YfQ0faWDcvPCdfmH4mssNz+AJGOJ0myw9p97LX8+w/49bbdF0Eh21JQlNjmTYEzMMw9NUCnMTw7JBdOHEu2v6Tmf5Tvn5WDSs8QpxyMt7GMkiym3RELrV0yR3hj9+LpOL9J4j4LfXQdDLV2xBbqTXkvMw1iviXCKuDbNzTZhhGN21B2AycCmlz7oWCKLHktmEmWUYPKHnj+yR4RBwnYaxfgZTw5dhZnwQ5u7elB03cYyfHO6D25d+kleEmf/7gUIYPC/UgAEGDGp4BhhhQo2cARtMoMZUAV+aKuAUva1+W8PqlaB6E6fmF5QbQnNkEknMqHGKgqqNUa2srOi5R8O9FJXrGsTS9KKcfbdsf0rPc62MmF/Wjn5bzXv1OPHMKTq24iw8J+hTPQFhBLes+jgAl1tt4b+SwCmuamzc+3haEEvCyoue4RSfKDgoBEUZwe0dVrTVtF5pTrys8ih8kE31KykbfVmFUWQRw8xtxLxltQX/AwTfUMDaNhZhAAAAAElFTkSuQmCC">
					</td>
					<td class="col-2">
						운영진입니다
					</td>
				</tr>
			</tbody>
		</table>
			  </div>
			</div>
				<div class="row justify-content-center community-container">
					<div class="community-box">
						<table class="table table-hover table-bordered">
							<thead>
								<tr>
									<th style="text-align: left;"><a
										href="<c:url value="/post/list?ca=1"/>" class="boardname">공지게시판</a>
									</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${noticeList}" var="post">
									<tr>
										<td style="text-align: left;" class="d-flex">
											<span style="max-width: 300px; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">
												<a class="aTag-home"
												href="<c:url value="/post/detail?ca=1&num=${post.po_num}"/>">${post.po_title}</a> 
											</span>
											<span class="ms-auto">
										 		<fmt:parseDate value="${post.po_datetime}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedDate"/>
	                							<fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd"/>
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
										href="<c:url value="/post/popular?ca=-1" />" class="boardname">인기글게시판</a>
									</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${hotList}" var="post">
									<c:if test="${post.po_totalHeart >= 1}">
										<tr>
											<td style="text-align: left;" class="d-flex">
												<span style="max-width: 300px; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">
													<a class="aTag-home"
													href="<c:url value="/post/detail?ca=-1&num=${post.po_num}"/>">[${post.ca_name}] ${post.po_title}</a>
												</span>
												<span style="color: #FA5858; font-weight: bold;" class="ms-1">${post.po_totalHeart}</span>
												<span class="ms-auto">
											 		<fmt:parseDate value="${post.po_datetime}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedDate"/>
		                							<fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd"/>
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
				</div>
			</div>
			<div class="main-book mt-4">
			    <div class="book-tap">
			        <button class="new-btn active-btn">새로 들어온 책<span class="badge bg-success">New</span></button>
			        <button class="loan-btn">대출이 많은 책<span class="badge bg-danger">Hot</span></button>
			        <button class="hot-btn">인기 많은 책<span class="badge bg-warning">Best</span></button>
			    </div>
			    <div class="book-list new-books">
			    </div>
			    <div class="book-list loan-books" style="display: none;">
			        <c:forEach items="${book}" var="book">
			            <c:if test="${book != null}">
			                <div class="book-item">
				                <ul>
			                   		<a href="<c:url value="/library/book/detail?num=${book.bo_num}"/>">
				                   		<li><img src="${book.bo_thumbnail}"></li>
				                   		<li>${book.bo_title}</li>
			                   		</a>
				                </ul>
			                </div>
			            </c:if>
			            <c:if test="${book == null}">
			                <h1>대출된 책이 없습니다.</h1>
			            </c:if>
			        </c:forEach>
			    </div>
			    <div class="book-list best-books" style="display: none;">
			    </div>
			</div>
		</div>
</body>
<!-- 대출 책 -->
<script type="text/javascript">
	$(document).on("click", ".loan-btn", function(e) {
		e.preventDefault();
		
		$(".new-btn, .loan-btn, .hot-btn").removeClass("active-btn");
		
		$(this).addClass("active-btn");
		$(".book-list").hide();
		$(".loan-books").show();;
	});
</script>
<!-- 신규 책 -->
<script type="text/javascript">
	$(document).on("click", ".new-btn", function(e) {
		e.preventDefault();
		
		$(".new-btn, .loan-btn, .hot-btn").removeClass("active-btn");

		$(this).addClass("active-btn");
		$(".book-list").hide();
		$(".new-books").show();;
	});
</script>
<!-- 배스트샐러 -->
<script type="text/javascript">
	$(document).on("click", ".hot-btn", function(e) {
		e.preventDefault();

		$(".new-btn, .loan-btn, .hot-btn").removeClass("active-btn");

		$(this).addClass("active-btn");
		$(".book-list").hide();
		$(".best-books").show();;
	});
</script>
<!-- 등급 안내 -->
<script type="text/javascript">
let modal = document.getElementById("gradeModal");

let link = document.getElementById("gradeInfoLink");

let span = document.getElementsByClassName("close")[0];

link.onclick = function() {
  modal.style.display = "block";
}

span.onclick = function() {
  modal.style.display = "none";
}

window.onclick = function(event) {
  if (event.target == modal) {
    modal.style.display = "none";
  }
}
</script>
<!-- 출력 -->
<script type="text/javascript">
newBook();
function newBook() {
	let cri={
		search:"",
		type:'all',
		page:1,
		bo_code:4
	}
	$.ajax({
		async : true,
		url : '<c:url value="/management/manager/list"/>', 
		type : 'post', 
		data : JSON.stringify(cri),
		contentType : "application/json; charset=utf-8",
		dataType : "json", 
		success : function (data){
			let a=new Date();
			a.setMonth(a.getMonth()-3);
			let res=true;
			let str="";
			console.log(data);
			for(let i=0;i<5;i++){
				if(toStringFormatting(data.bookList[i].bo_in_date)>=toStringFormatting(a)){
					str+=`
					<div class="book-item">
						 <a href='<c:url value="/library/book/detail?num=\${data.bookList[i].bo_num}"/>'>
							 <ul>
							 	<li><img src="\${data.bookList[i].bo_thumbnail}" alt="\${data.bookList[i].bo_title}"></li>
							 	<li>\${data.bookList[i].bo_title}</li>
							 </ul>
						 </a>
					</div>
					`;
					res=false;
				}
			}
			if(res){
				str=`<h1 style="text-align:center;">3개월 동안 추가된 책이 없습니다.</h1>`;
			}
			$(".new-books").html(str);
		}, 
		error : function(jqXHR, textStatus, errorThrown){

		}
	});
}
	
Bestseller();
function Bestseller() {
	let APIdata={
			TTBKey:"${api}",
			QueryType:"Bestseller",
			SearchTarget:"Book",
			Start:1,
			MaxResults:5,
			Cover:"Big",
			Output:"JS",
			Version:20131101
		};
	
	$.ajaxPrefilter('json',function(options,orig,jqXHR){
		return 'jsonp';
	});
	$.ajax({
		url :"http://www.aladin.co.kr/ttb/api/ItemList.aspx" , 
		type : "get", 
		data: APIdata,
		dataType :"json",
		crossDomain:true,
		xhrFields: { 
	    	withCredentials: true // 클라이언트와 서버가 통신할때 쿠키와 같은 인증 정보 값을 공유하겠다는 설정
	    },
		success : function (data,testStatus,jqXHR){
			let str="";
			for(book of data.item){
				str+=`
				<div class="book-item">
					 <a href='<c:url value="/library/bookSale/detail?isbn=\${book.isbn13}"/>'>
						 <ul>
						 	<li><img src="\${book.cover}" alt="\${book.title}"></li>
						 	<li>\${book.title}</li>
						 	<li>\${priceToString(book.priceStandard)}</li>
						 </ul>
					 </a>
				</div>
				`;
			}
			$(".best-books").html(str);
		}, 
		error : function(jqXHR, textStatus, errorThrown){

		}
	});
}

function priceToString(price) {
    return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')+"원";
}

function toStringFormatting(source){
	  let milliseconds = source;
    var  date = new Date(milliseconds);
    const year = date.getFullYear();
    const month = leftPad(date.getMonth() + 1);
    const day = leftPad(date.getDate());
    return year+"-"+month+"-"+day;
	}
	

	function leftPad(value){
		if (Number(value) >= 10) {
			return value;
		}
		return "0" + value;
	}
	
	$(document).ready(function(){ $("#nav").load("/../team4/nav.html");});
	
</script>
