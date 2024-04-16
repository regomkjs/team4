<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
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
	<form action="<c:url value="/find/id"/>" method="post">
		<h2 style="margin-bottom: 50px; font-weight: bold">아이디 찾기</h2>
		<div class="form-group" style="margin-bottom: 10px">
			<input type="text" class="form-control" id="email" name="me_email" placeholder="이메일">
			<label id="email-error" class="error text-danger" for="email"></label>
		</div>
		<div class="form-group">
			<input type="text" class="form-control" id="phone" name="me_phone" placeholder="전화번호">
			<label id="phone-error" class="error text-danger" for="phone"></label>
		</div>
		<button class="btn btn-outline-success col-12 btn-submit" style="margin-top: 40px">아이디 찾기</button>
	</form>
</div>
<script type="text/javascript">
$("form").validate({
	rules : {
		me_email : {
			required : true,
			email : true
		},
		me_phone : {
			required : true,
			regex : /^\d{3}-\d{3,4}-\d{4}$/
		}
	},
	messages : {
		me_email : {
			required : "필수 항목입니다.",
			email : "이메일 형식이 아닙니다."
		},
		me_phone : {
			required : "필수 항목입니다.",
			regex : "전화번호는 010-XXXX-XXXX 형식으로 입력하세요."
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
</body>
</html>