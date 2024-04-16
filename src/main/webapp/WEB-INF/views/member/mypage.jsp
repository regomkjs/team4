<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
</style>
</head>
<body>
<div class="container col-5 p-5 mt-3 card-1" style="padding: 50px;">
	<form action="<c:url value="/mypage"/>" method="post">
		<h2 style="margin-bottom: 50px; font-weight: bold">내 정보</h2>
		<div class="form-group" style="margin-bottom: 10px">
			<label for="id">아이디</label>
			<div class="input-group">
				<input type="text" class="form-control" id="id" name="me_id" readonly value="${user.me_id }">
			</div>
		</div>
		<div class="form-group" style="margin-bottom: 10px">
			<label for="nick">닉네임</label>
			<div class="input-group">
				<input type="text" class="form-control" id="nickName" name="me_nick" value="${user.me_nick }">
			</div>
			<label id="nickName-error" class="error text-danger" for="nickName"></label>
			<label id="nickName-error2" class="error text-danger"></label>
		</div>
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
		<div class="form-group" style="margin-bottom: 10px">
			<label for="email">이메일</label>
			<input type="text" class="form-control" id="email" name="me_email" value="${user.me_email }">
			<label id="email-error" class="error text-danger" for="email"></label>
		</div>
		<div class="form-group">
			<label for="phone">전화번호</label>
			<input type="text" class="form-control" id="phone" name="me_phone" value="${user.me_phone }">
			<label id="phone-error" class="error text-danger" for="phone"></label>
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
			email : true
		},
		me_phone : {
			required : true,
			regex : /^\d{3}-\d{3,4}-\d{4}$/
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
</body>
</html>