<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<!-- jquery validtaion -->	
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
</style>
</head>
<body>
<div class="container col-5 p-5 mt-3 card-1" style="padding: 50px;">
	<form action="<c:url value="/login"/>" method="post">
		<h2 style="margin-bottom: 50px; font-weight: bold">로그인</h2>
		<div class="form-group" style="margin-bottom: 10px">
			<div class="form-group">
				<input type="text" class="form-control" id="id" name="id" placeholder="아이디">
			</div>
		</div>
		<div class="form-group" style="margin-bottom: 10px">
			<input type="password" class="form-control" id="pw" name="pw" placeholder="비밀번호">
		</div>
		<div class="form-check mb-2 mt-2" style="color: gray;">
			<label class="form-check-label">
		   		<input type="checkbox" class="form-check-input" value="true" name="autoLogin">로그인 상태 유지
	 		</label>
		</div>
		<div class="text-center" style="width: 100%">
			<a href="<c:url value="/find/id"/>" style="color: gray;">아이디찾기</a>
		    <span style="color: gray; opacity: 60%">|</span>
		    <a href="<c:url value="/find/pw"/>" style="color: gray;">비밀번호찾기</a>
		</div>
		<button class="btn btn-outline-success col-12 btn-submit" style="margin-top: 40px">로그인</button>
	</form>
</div>
</body>
</html>