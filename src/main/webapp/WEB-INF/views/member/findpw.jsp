<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비번 찾기</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
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
	.container-spinner{
	position: fixed; top:0; bottom:0; left:0; right:0;
	background: rgba(0,0,0,0.3);
	display: none;
	text-align: center; color : white;
	line-height: 100vh
	}
</style>
</head>
<body>
<div class="container col-5 p-5 mt-3 card-1" style="padding: 50px;">
	<h2 style="margin-bottom: 50px; font-weight: bold">비밀번호 찾기</h2>
	<div class="form-group">
		<label for="id">아이디</label>
		<input type="text" class="form-control" id="id" name="id">
	</div>
	<button class="btn btn-outline-success col-12 btn-find" style="margin-top: 40px">비밀번호 찾기</button>
	<div class="container-spinner">
	찾기 중
	<span class="spinner-border text-danger"></span>
	</div>
</div>
<script type="text/javascript">
$(".btn-find").click(function() {
	let obj = {
		id : $('[name=id]').val()
	}
	$(".container-spinner").show();
	$.ajax({
		async : true,
		url : '<c:url value="/find/pw"/>', 
		type : 'post', 
		data : obj,
		dataType : "json", 
		success : function (data){
			if(data.result){
				alert("새 비번이 이메일로 전송됐습니다.")
				$("").val();
			}else{
				alert("가입된 회원이 아니거나 이메일이 잘못됐습니다.")
			}
			$(".container-spinner").hide();
		}, 
		error : function(jqXHR, textStatus, errorThrown){

		}
	});
});
</script>
</body>
</html>