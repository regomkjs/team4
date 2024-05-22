<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보</title>
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/additional-methods.min.js"></script>
<style type="text/css">
	.login-box {
	    margin: auto;
	    margin-top: 100px;
	    width: 500px;
	    height : 400px;
	    background-color: #EEEFF1;
	    border-radius: 5px;
	    text-align: center;
	    padding: 20px;
	}
	
	.login-box input {
	    width: 100%;
	    padding: 10px;
	    box-sizing: border-box;
	    border-radius: 5px;
	    border: none;
	    margin-top : 10px;
	}
	
	.login-box .in {
	    margin-bottom: 10px;
	}
	
	.login-box #btn {
	    background-color: #1BBC9B;
	    margin-bottom: 30px;
	    color: white;
	}
	
	.login-box a {
	    text-decoration: none;
	    color: #9B9B9B;
	    font-size: 12px;
	}
	
	.card-1 {
		padding: 30px;
	  box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
	  transition: all 0.3s cubic-bezier(.25,.8,.25,1);
	}
	.card-1:hover {
	  box-shadow: 0 14px 28px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);
	}
	
	hr{ margin-bottom: 35px; margin-top: 40px;}
	
	img{ width: 35px;}
	
    .input-group img:hover {
        transform: scale(1.1);
    }

    .form-group label {
        display: block;
        margin-bottom: 5px;
        font-size: 18px;
        color: #333;
    }

    .form-group {
        margin-bottom: 20px;
        background-color: #f9f9f9;
        padding: 10px;
        border-radius: 5px;
        border: 1px solid #ddd;
    }
</style>
</head>
<body>
<div class="container col-5 p-5 mt-3 card-1" style="padding: 50px;">
	<form action="<c:url value="/mypage"/>" method="post">
		<h4 style="margin-bottom: 30px; font-weight: bold">내 정보</h4>
		<div class="form-group" style="margin-bottom: 10px">
			<label for="grade">등급</label>
			<div class="input-group">
				<c:forEach items="${gradeList }">
					<c:if test="${user.me_mr_num == 0}">
						<img width="18" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEMAAABDCAYAAADHyrhzAAAACXBIWXMAAAsTAAALEwEAmpwYAAAEnklEQVR4nO2c3UsrRxTAtx8PLeU+9KnQQmn/hNK3vvheaJ8qZs/ZJBrFqBUVPzCLiohexIg+iNpaEY31G4sffdEqFIuIilQULPZB8CsKohaUoMaPucxyM7hxk5ukue7OZg+ch5ydPXPyy8w5s6OzghBBnE7nB6IofgcAPwPAnwDwDyLu8KYA8C8A/AUAPgDIcLlcL4RYJT09/T0AyEVEPyISsykA/AcAlfTHjgrC5XK9AIApvQN+Jl232+2fa4KQJOkjRPzbAEE+p+7abLZPnsBAxN8MEJweupiWlvY+AyGK4rcGCEo3pTmSwQCAVb0D0ln9tHAIGRkZXxggGKK3iqKYJrwuoyTVFQBeUhgNegeCBlAA+JVWkS69A0EDKADM0pHRrXcgaAAFgHkLBlowiDUy0JomxMoZqFMCLSgoICMjI0/U4/EkNePLsqzZD+3fMNWkurqaaMny8nJSYaysrGj2Q/s3PIzb21uSl5eXFBDUTzAY5BcGlf7+/qTAGBwcJJHEsDCCwSDZ399nn/f29pICw+/3M5+Hh4d8wKAyNDREkhlsXV3dW/X/VmFUVFSo5vfc3Nz/8r+wsMB80RHS1NTED4zS0lJV5g8EAiQrKysh3zk5OeT6+pr5GhgYIK2trfzAqKysJM3NzSpbZ2dnQr57enpU1Sk/P5+0t7fzA8Pj8RC73U5OT0+ZbWtrKyHfOzs7zMfq6qpi6+rq4geGLMuKfXp6mtkeHh6U6ROPXwr1sXi9XsXe29vLD4yqqirFXlZWpkAIycTERFx+Z2Zm2L1nZ2fKaKN2mje4gVH9KLjt7W1mp9Mm9IXepJmZmeTy8pLdOzk5ya4NDw/zCaO7u1t1jZbFWHx2dHREnGLcwsjOziZXV1dxP7zRhBsp+XILA8MWTaHyGM1fSUmJKteEl2WuYdTX18f18DY1NRV1wcY1DEQkR0dH7PrBwUFEXw6Hg5yfn0ddynMPY2xsTNWmpqZG01dLS4tmmTYVjMLCQnJ/f8/azM/Pa/paW1tjbehWgFYb7mEgItnY2IiaC+he5t3dHWvj8/nMC6OtrU3VLrxKjI6OxrRlaAoYTqeTXFxcaK4fJEkix8fH7NrS0lLE/kwBAxHJ7Oys5sqyoaFB5aOxsdH8MGRZVrUNPbwtLi4y28nJiTJSTA8DEcnu7i5rS9cUbreb3NzcMNv4+HjU+00Fw+fzqdqvr6+rpk5xcXHqwHC73RH/ILS5ufnG/kwFAxGVp1ctoeU35WB4vd4nIOhmDi2/KQdDkiTVhjEVus0XS3+mg4Fhj+qPN5K5hpGbm6vM9ZDSz7HcV1RUxP7Hoq+vL+b+ysvLE+rvWWCgCdSCgRYMYo0MtKYJsXIGJp5A2/TO5GgM/Z3CkA0QCDGA/kTPm3xvgECI3goARfSE84cAENA7GL1VkqQvQ2daf0nxUfEHO8rpcDg+S9XRAQD3Npvtq/ATzz8g4kMKwpA1z8MjoifFgHQKgvBOxDclAEA6Ip6bfDQEAODHqK+MCAkAfIyITQBwZDIIp3Q02Gy2T4V4pba29l0A+FoURUTEUvoSDg61HADskiR9o5x3jyKvAHbQX3wyaiWpAAAAAElFTkSuQmCC">
					</c:if>
					<c:if test="${user.me_mr_num == 1}">
						<img width="18" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEMAAABDCAYAAADHyrhzAAAACXBIWXMAAAsTAAALEwEAmpwYAAAEjElEQVR4nO2c30/bVRTAG50vPrmHxcT4D+jr4nxconBvk21OXWZQZ5Ys8cX4YtRoFk0l7t7ya8tKxoSxGbMRo8icgoDcW9rRymSMbaV2bEXK5oAyJrABK4P+OubeFew3pQiY9rb9fk9y3trm3E/OOffce3quybSKNFt2PskofoURfJBRXM0Irss35RQf5wR/wWnxfjt56WnTesVZZn6WE1TPCJrnFEPhKIoxgrj9ENq2JhAdxLyPUxRSb3jmlBEcZwTZnJbtm9KCYAQfVG1oVpWg1r66rU+kgLCT4hJBTLmBWfcSVKMB8Yt1x2ZO8ZRqw5SpFRctw+AEVyo3SK139EoQFovlMUbQuGqDVKudmJ83ddDiF1UbwnNAmRV9kthK1RujWhlFJ02MoA9VG8JzQQlq1V9tQdMpshswqAEDDM+gRpiAkTNoniRQR+VuuPL9ZxBwN0DQy+Du4O/w91Av3LnugtGrrfCn4xR4mkqh6+gbhbubdNlKYORyC0QWQrA2icPsRAAGHSfBVf1m4cDwNJVCeH4WNioCSEHA8J6jEI/HNIuLhh/ChL8bAu4z4OdfwWBnPQx3fytDJTQ1qvWPeAxc1W/lPwz3sX0pYTHqaQfn4df+83sD7TaYvu2V+STz3psFGLd6ftCA+Ovi2XX/hr1sR2HACCW5fPjhHHRW7MrCwnIShhli0cgyDLGFql+0IhidFbs0ITLuc+TAopV5BoZYZHEZxv2Ra/qGMRP0/7tFxqKy8NItjIC7QRMqoo4QuUSXMLpsJbLAShZRbDkPv64/GJxi8LVUpZTX4fkZGDr/DTiP7NEXDE6xPFusJNHwAox5foWLX7+vHxicYrja+DksPpiGdCKS7UCbTR7xCx4GF3cZVa9CwHUGIgsP0kJZDN2XdxrZrVYV3o47KnfDQNtRmBm7kRbK/HQQ+ho+LnwYPEm7aw/Io/zC3FQKEFGb+Jor9AODJ1SEhZ/XpoRQPBaB3tMf6AsGT+hvx/fD7J0hDZB7Iz59wuCJYm0xdE8DxF3zjj5h8BUuhvp/PKRfGP1nv9TAuNFRo18YfQ0faWDcvPCdfmH4mssNz+AJGOJ0myw9p97LX8+w/49bbdF0Eh21JQlNjmTYEzMMw9NUCnMTw7JBdOHEu2v6Tmf5Tvn5WDSs8QpxyMt7GMkiym3RELrV0yR3hj9+LpOL9J4j4LfXQdDLV2xBbqTXkvMw1iviXCKuDbNzTZhhGN21B2AycCmlz7oWCKLHktmEmWUYPKHnj+yR4RBwnYaxfgZTw5dhZnwQ5u7elB03cYyfHO6D25d+kleEmf/7gUIYPC/UgAEGDGp4BhhhQo2cARtMoMZUAV+aKuAUva1+W8PqlaB6E6fmF5QbQnNkEknMqHGKgqqNUa2srOi5R8O9FJXrGsTS9KKcfbdsf0rPc62MmF/Wjn5bzXv1OPHMKTq24iw8J+hTPQFhBLes+jgAl1tt4b+SwCmuamzc+3haEEvCyoue4RSfKDgoBEUZwe0dVrTVtF5pTrys8ih8kE31KykbfVmFUWQRw8xtxLxltQX/AwTfUMDaNhZhAAAAAElFTkSuQmCC">
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
					</c:if>
				</c:forEach>
			</div>
		</div>
		<c:if test="${!fn:contains(user.me_id, '!')}">
			<div class="form-group" style="margin-bottom: 10px">
				<label for="id">아이디</label>
				<div class="input-group">
					<input type="text" class="form-control" id="id" name="me_id" readonly value="${user.me_id }">
				</div>
			</div>
		</c:if>
		<div class="form-group" style="margin-bottom: 10px">
			<label for="id">커뮤니티 정지일</label>
			<div class="input-group">
				<c:if test="${user.me_block != null}">
					<input type="text" class="form-control" id="block" name="me_block" readonly value="${user.me_block}">
				</c:if>
				<c:if test="${user.me_block == null}">
					<input type="text" class="form-control" id="block" name="me_block" readonly value="X">
				</c:if>
			</div>
		</div>
		<div class="form-group" style="margin-bottom: 10px">
			<label for="id">도서 정지일</label>
			<div class="input-group">
				<c:if test="${user.me_loan_block != null}">
					<input type="text" class="form-control" id="loan_block" name="me_loan_block" readonly value="<fmt:formatDate value="${user.me_loan_block}" pattern="yy/MM/dd"/>">
				</c:if>
				<c:if test="${user.me_loan_block == null}">
					<input type="text" class="form-control" id="block" name="me_block" readonly value="X">
				</c:if>
			</div>
		</div>
		<hr>
		<h4 style="margin-bottom: 30px; font-weight: bold">내 정보 수정</h4>
		<div class="form-group" style="margin-bottom: 10px">
			<label for="nick">닉네임</label>
			<div class="input-group">
				<input type="text" class="form-control" id="nickName" name="me_nick" value="${user.me_nick }">
			</div>
			<label id="nickName-error" class="error text-danger" for="nickName"></label>
			<label id="nickName-error2" class="error text-danger"></label>
		</div>
		<c:if test="${!fn:contains(user.me_id, '!')}">
			<div class="form-group" style="margin-bottom: 10px">
				<label for="pw">비밀번호</label>
				<input type="password" class="form-control" id="pw" name="me_pw" placeholder="비밀번호">
				<label id="pw-error" class="error text-danger" for="pw"></label>
			</div>
			<div class="form-group" style="margin-bottom: 10px">
				<label for="pw2">비밀번호 확인</label>
				<input type="password" class="form-control" id="pw2" name="me_pw2" placeholder="비밀번호 확인">
				<label id="pw2-error" class="error text-danger" for="pw2"></label>
			</div>
		</c:if>
		<div class="form-group" style="margin-bottom: 10px">
			<label for="email">이메일</label>
			<input type="text" class="form-control" id="email" name="me_email" value="${user.me_email }">
			<label id="email-error" class="error text-danger" for="email"></label>
			<label id="email-error2" class="error text-danger"></label>
		</div>
		<div class="form-group phone-group">
		    <label for="phone">전화번호</label>
		    <div class="row">
		        <div class="col-8">
		            <input type="text" class="form-control" id="phone" name="me_phone" value="${user.me_phone }">
		            <label id="phone-error" class="error text-danger" for="phone"></label>
		        </div>
		        <div class="col-4">
		            <button type="button" class="btn btn-outline-primary check-phone">인증번호 보내기</button>
		        </div>
		    </div>
		</div>
		<div class="form-group" id="verification-section">
		    <label for="code">인증번호</label>
		    <div class="row">
		        <div class="col-8">
		            <input type="text" class="form-control" id="code" name="code" placeholder="인증번호">
		            <label id="code-error" class="error text-danger" for="code"></label>
		        </div>
		        <div class="col-4">
		            <button type="button" class="btn btn-outline-primary complete-phone" id="verifyButton">확인</button>
		        </div>
		    </div>
		</div>
		<button class="btn btn-outline-success col-12 btn-submit" style="margin-top: 40px">내 정보 수정</button>
	</form>
</div>
<!-- 유효성 검사 -->
<script type="text/javascript">
$("form").validate({
	rules : {
		me_nick : {
			required : true,
			regex : /^[가-힣a-zA-Z0-9]{2,12}$/
		},
		me_pw : {
			regex : /^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$])[A-Za-z\d!@#%^&*]{6,15}$/
		},
		me_pw2 : {
			equalTo : pw // name이 아닌 id를 써 줌
		},
		me_email : {
			required : true,
			regex : /^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,6}$/
		},
		me_phone : {
			required : true,
			regex : /^\d{3}-\d{3,4}-\d{4}$/
		},
		code :{
			required : true,
			regex : /^[0-9]{4}$/
		}
	},
	messages : {
		me_nick : {
			required : "필수 항목입니다.",
			regex : "한글,영어,숫자로 이루어진 2~12글자 닉네임을 입력하세요."
		},
		me_pw : {
			regex : "영문 대문자, 소문자, 숫자, 특수문자(!@#$) 각각 1개 이상을 포함한 6~15글자 비밀번호를 입력하세요."
		},
		me_pw2 : {
			equalTo : "비밀번호가 일치하지 않습니다."
		},
		me_email : {
			required : "필수 항목입니다.",
			regex : "이메일 형식이 아닙니다."
		},
		me_phone : {
			required : "필수 항목입니다.",
			regex : "전화번호는 010-XXXX-XXXX 형식으로 입력하세요."
		},
		code : {
			required : "인증하세요.",
			regex : "4자리 숫자로 입력하세요."
		}
	}
});

$.validator.addMethod(
	"regex",
	function (value, element, regexp){
		var re = new RegExp(regexp);
		return this.optional(element) || re.test(value);
	},
	"정규표현식에 맞지 않습니다."
)
</script>
<!-- 닉네임 중복 검사 -->
<script type="text/javascript">
function nickNameCheckDup(){
	$("#nickName-error2").text("");
	$("#nickName-error2").hide();
	let nickName = $('[name=me_nick]').val();
	let obj = {
		nickName : nickName
	}
	let nickNameRegex = /^[가-힣a-zA-Z0-9]{2,12}$/;
	if(!nickNameRegex.test(nickName)){
		return false;
	}
	let result = false;
	$.ajax({
		async : false,
		url : '<c:url value="/nickName/check/dup"/>', 
		type : 'get', 
		data : obj, 
		dataType : "json", 
		success : function (data){
			result = data.result;
			if(!result){
				$("#nickName-error2").text("이미 사용중인 닉네임입니다.");
				$("#nickName-error2").show();
				$(".btn-submit").prop('disabled', true);
			}else{
				$(".btn-submit").prop('disabled', false);
			}
		}, 
		error : function(jqXHR, textStatus, errorThrown){

		}
	});
	return result;
}
$('[name=me_nick]').on('input',function(){
	nickNameCheckDup();
})
</script>
<!-- 전화번호 인증 -->
<script type="text/javascript">
$(document).ready(function() {
    var initialPhone = $('[name=me_phone]').val();

    $('[name=me_phone]').change(function() {
        if ($(this).val() !== initialPhone) {
            $('#verification-section').show();
        } else {
            $('#verification-section').hide();
            $('[name=code]').val('').removeAttr('readonly');
        }
    });

    $('#verification-section').hide();

    $(document).on("click", ".check-phone", function() {
    	
    	let phone = $('[name=me_phone]').val();
    	 
    	if(validatePhoneNumber(phone)) {
    		let obj = {
    			phone
    		}
    		$.ajax({
    			async : true,
    			url : '<c:url value="/send/mail/phone"/>', 
    			type : 'get', 
    			data : obj, 
    			dataType : "json", 
    			success : function (data){
    				if(data.result){
    					alert("입력하신 번호로 메시지를 전송했습니다.")
    				}
    				else{
    					alert("유효하지 않은 전화번호입니다. 전화번호를 다시 확인해주세요.")
    				}
    				
    			}, 
    			error : function(jqXHR, textStatus, errorThrown){
    	
    			}
    		});
    	 }else{
    		 alert("유효하지 않은 전화번호입니다.")
    	 }
    });
});

function validatePhoneNumber(input_str) {
	let pattern = /^\d{2,3}-\d{3,4}-\d{4}$/;
	return pattern.test(input_str);
}

</script>
<!-- 인증 -->
<script type="text/javascript">
var isVerified = false;

$(".complete-phone").click(function() {
	let num = $('[name=code]').val();
	let obj = {
			num : num,
	}
	$.ajax({
		async : true,
		url : '<c:url value="/check/mail/phone"/>', 
		type : 'post', 
		data : obj, 
		dataType : "json", 
		success : function (data){
			if(data.result){
				alert("인증 성공")
				$('[name=code]').attr('readonly', true);
				isVerified = true;
			}
			else{
				alert("인증 실패")
			}
			
		}, 
		error : function(jqXHR, textStatus, errorThrown){
			alert("인증번호를 먼저 보내주세요.")
		}
	});
	
	$(".btn-submit").click(function(e) {
        if (!isVerified) {
            alert("인증을 먼저 완료해주세요.");
            e.preventDefault();
            return false;
        }
    });
});
</script>
<!-- 이메일 중복 확인 -->
<script type="text/javascript">
function emailCheckDup(){
	$("#email-error2").text("");
	$("#email-error2").hide();
	let email = $('[name=me_email]').val();
	let obj = {
		email : email
	}
	let emailRegex = /^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,6}$/;
	if(!emailRegex.test(email)){
		return false;
	}
	let result = false;
	$.ajax({
		async : false,
		url : '<c:url value="/email/check/dup"/>', 
		type : 'get', 
		data : obj, 
		dataType : "json", 
		success : function (data){
			result = data.result;
			if(!result){
				$("#email-error2").text("이미 사용중인 이메일입니다.");
				$("#email-error2").show();
				$(".btn-submit").prop('disabled', true);
			}
			else{
				$(".btn-submit").prop('disabled', false);
			}
		}, 
		error : function(jqXHR, textStatus, errorThrown){
			
		}
	});
	return result;
}
$('[name=me_email]').on('input',function(){
	emailCheckDup();
})
</script>
</body>
</html>