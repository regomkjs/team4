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

   .card-1 {
      box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
      transition: all 0.3s cubic-bezier(.25,.8,.25,1);
   }
   
   .card-1:hover {
      box-shadow: 0 14px 28px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);
   }
   
   .error {
   	  font-size: 10pt;
   	  font-weight: bold;
   }
</style>
</head>
<body>
<div class="container col-5 p-5 mt-3 card-1" style="padding: 50px; margin-bottom: 50px">
	<form action="<c:url value="/signup"/>" method="post">
		<h2 style="margin-bottom: 50px; font-weight: bold">회원가입</h2>
		<div class="form-group" style="margin-bottom: 10px">
			<label for="phone">아이디</label>
			<div class="input-group">
				<input type="text" class="form-control" id="id" name="me_id" placeholder="아이디">
			</div>
			<label id="id-error" class="error text-danger" for="id"></label>
			<label id="id-error2" class="error text-danger"></label>
		</div>
		<div class="form-group" style="margin-bottom: 10px">
			<label for="phone">닉네임</label>
			<div class="input-group">
				<input type="text" class="form-control" id="nickName" name="me_nick" placeholder="닉네임">
			</div>
			<label id="nickName-error" class="error text-danger" for="nickName"></label>
			<label id="nickName-error2" class="error text-danger"></label>
		</div>
		<div class="form-group" style="margin-bottom: 10px">
			<label for="phone">비밀번호</label>
			<input type="password" class="form-control" id="pw" name="me_pw" placeholder="비밀번호">
			<label id="pw-error" class="error text-danger" for="pw"></label>
		</div>
		<div class="form-group" style="margin-bottom: 10px">
			<label for="phone">비밀번호 확인</label>
			<input type="password" class="form-control" id="pw2" name="me_pw2" placeholder="비밀번호 확인">
			<label id="pw2-error" class="error text-danger" for="pw2"></label>
		</div>
		<div class="form-group" style="margin-bottom: 10px">
			<label for="phone">이메일</label>
			<input type="text" class="form-control" id="email" name="me_email" placeholder="이메일">
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
$('[name=me_id]').on('input',function(){
	idCheckDup();
})
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
			}else{
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
<!-- 전화번호 인증 -->
<script type="text/javascript">
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
function validatePhoneNumber(input_str) {
	let pattern = /^\d{2,3}-\d{3,4}-\d{4}$/;
	return pattern.test(input_str);
}

</script>
<!-- 인증 -->
<script type="text/javascript">
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
				$('[name=me_phone]').attr('readonly', true);
				$('[name=code]').attr('readonly', true);
			}
			else{
				alert("인증 실패")
			}
			
		}, 
		error : function(jqXHR, textStatus, errorThrown){

		}
	});
});
</script>
<script type="text/javascript">
$(document).on("click", ".btn-submit", function() {
	
	let input = document.getElementById('code');
	
	 if (!input.hasAttribute('readonly')) {
         alert('인증을 완료해주세요.');
         return false;
     }
})
</script>
</body>
</html>