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
</head>
<body>
<div class="container col-5 p-5 mt-3 card-1" style="padding: 50px;">
	<form action="<c:url value="/signup"/>" method="post">
		<h2 style="margin-bottom: 50px; font-weight: bold">회원가입</h2>
		<div class="form-group" style="margin-bottom: 10px">
			<div class="input-group">
				<input type="text" class="form-control" id="id" name="me_id" placeholder="아이디">
			</div>
			<label id="id-error" class="error text-danger" for="id"></label>
			<label id="id-error2" class="error text-danger"></label>
		</div>
		<div class="form-group" style="margin-bottom: 10px">
			<div class="input-group">
				<input type="text" class="form-control" id="nickName" name="me_nick" placeholder="닉네임">
			</div>
			<label id="nickName-error" class="error text-danger" for="nickName"></label>
		</div>
		<div class="form-group" style="margin-bottom: 10px">
			<input type="password" class="form-control" id="pw" name="me_pw" placeholder="비밀번호">
			<label id="pw-error" class="error text-danger" for="pw"></label>
		</div>
		<div class="form-group" style="margin-bottom: 10px">
			<input type="password" class="form-control" id="pw2" name="me_pw2" placeholder="비밀번호 확인">
			<label id="pw2-error" class="error text-danger" for="pw2"></label>
		</div>
		<div class="form-group" style="margin-bottom: 10px">
			<input type="text" class="form-control" id="email" name="me_email" placeholder="이메일">
			<label id="email-error" class="error text-danger" for="email"></label>
		</div>
		<div class="form-group">
			<input type="text" class="form-control" id="phone" name="me_phone" placeholder="전화번호">
			<label id="phone-error" class="error text-danger" for="phone"></label>
		</div>
		<button class="btn btn-outline-success col-12 btn-submit" style="margin-top: 40px">회원가입</button>
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
		me_id : {
			required : true,
			regex : /^(?=.*[0-9]+)[a-zA-Z][a-zA-Z0-9]{5,11}$/
		},
		me_pw : {
			required : true,
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
		me_id : {
			required : "필수 항목입니다.",
			regex : "영문으로 시작하고, 영문자와 숫자 조합의 6~12길이 아이디를 입력하세요."
		},
		me_pw : {
			required : "필수 항목입니다.",
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

<!-- 아이디 중복 검사 -->
<script type="text/javascript">
function idCheckDup(){
	$("#id-error2").text("");
	$("#id-error2").hide();
	//입력된 아이디를 가져옴
	let id = $('[name=me_id]').val();
	let obj = {
		id : id
	}
	let idRegex = /^(?=.*[0-9]+)[a-zA-Z][a-zA-Z0-9]{5,11}$/;
	if(!idRegex.test(id)){
		return false;
	}
	let result = false;
	//서버에 아이디를 전송해서 사용 가능/불가능 처리
	$.ajax({
		async : false,
		url : '<c:url value="/id/check/dup"/>', 
		type : 'get', 
		data : obj, 
		dataType : "json", 
		success : function (data){
			result = data.result;
			if(!result){
				$("#id-error2").text("이미 사용중인 아이디입니다.");
				$("#id-error2").show();
			}
		}, 
		error : function(jqXHR, textStatus, errorThrown){

		}
	});
	return result;
}
$('[name=me_id]').on('input',function(){
	idCheckDup();
})
</script>
</body>
</html>