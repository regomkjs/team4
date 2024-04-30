<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>팝업</title>
</head>
<body>
<div class="container">
	<h3 class="mt-3">커뮤 이용 제한 변경</h3>
	<div class="input-group mt-2">
		<div class="input-group-prepend">
			<span class="input-group-text">회원</span>
		</div>
		<input class="form-control input-id" value="${member.me_id}" readonly style="background-color: white;">
	</div>
	<div class="input-group">
		<div class="input-group-prepend">
			<span class="input-group-text">닉네임</span>
		</div>
		<input class="form-control input-nick" value="${member.me_nick}" readonly style="background-color: white;">
	</div>
	<c:if test="${member.me_block != null && member.me_ms_num != 1}">
		<div class="input-group">
			<div class="input-group-prepend">
				<span class="input-group-text">정지기한</span>
			</div>
			<input class="form-control" value="${member.me_block}" readonly style="background-color: white;">
		</div>
	</c:if>
	<c:if test="${member.me_ms_num == 1}">
		<div class="input-group">
			<div class="input-group-prepend">
				<span class="input-group-text">상태</span>
			</div>
			<input class="form-control" value="영구정지" readonly style="background-color: white;">
		</div>
	</c:if>
	<c:if test="${member.me_block != null && member.me_ms_num != 1}">
		<div class="top-box">
			<div class="input-group">
				<div class="input-group-prepend">
					<span class="input-group-text">옵션</span>
				</div>
				<select class="form-control text-center input-group option-select">
					<option value="decrease">기한 감면</option>
					<option value="permanent">영구정지로 변경</option>
				</select>
			</div>
			<div class="input-group after-select-box">
				<div class="input-group-prepend">
					<span class="input-group-text">감면일수</span>
				</div>
				<select class="form-control text-center input-group select-day">
					<option value="1">1일</option>
					<option value="3">3일</option>
					<option value="7">일주일(7일)</option>
					<option value="30">한달(30일)</option>
					<option value="365">일년(365일)</option>
				</select>
			</div>
			<button class="btn form-control btn-primary btn-action mt-2">확정</button>
		</div>
	</c:if>
	<c:if test="${member.me_ms_num == 1}">
		<div class="top-box">
			<div class="input-group">
				<div class="input-group-prepend">
					<span class="input-group-text">옵션</span>
				</div>
				<select class="form-control text-center input-group option-select">
					<option value="delete">영구정지 해제</option>
					<option value="change">기한정지로 변경</option>
				</select>
			</div>
			<div class="input-group after-select-box" hidden>
				<div class="input-group-prepend">
					<span class="input-group-text">기한정지</span>
				</div>
				<select class="form-control text-center input-group select-day">
					<option value="1">1일</option>
					<option value="3">3일</option>
					<option value="7">일주일(7일)</option>
					<option value="30">한달(30일)</option>
					<option value="365">일년(365일)</option>
				</select>
			</div>
			<button class="btn form-control btn-primary btn-action mt-2">확정</button>
		</div>
	</c:if>
	<button class="btn btn-success close-btn form-control mt-2">나가기</button>
</div>

<!-- 나가기버튼 -->	
<script type="text/javascript">
$(".close-btn").click(function () {
	window.close();
})
</script>


<!-- 옵션변경 스크립트 -->
<script type="text/javascript">
$(".option-select").change(function () {
	let value = $(this).val();
	if(value == "change" || value == "decrease"){
		$(".after-select-box").removeAttr("hidden");
	}
	else{
		$(".after-select-box").attr("hidden",true);
	}	
})
</script>


<!-- 변경 확정 스크립트 -->
<script type="text/javascript">
$(".btn-action").click(function () {
	let me_id = $(".input-id").val()
	let me_nick = $(".input-nick").val();
	let option = $(this).parents(".top-box").find(".option-select").val()
	let day = $(this).parents(".top-box").find(".select-day").val()
	let text = "";
	if(option == "decrease"){
		text += "닉네임 : "+ me_nick + "\n감면할 정지일수 : "+ day + "일\n이대로 실행 하시겠습니까?" ;
	}
	else if(option == "permanent"){
		text += "닉네임 : "+ me_nick + "\n작업 내용: 영구정지\n이대로 실행 하시겠습니까?" ;
	}
	else if(option == "delete"){
		text += "닉네임 : "+ me_nick + "\n작업 내용: 영구정지 해제\n이대로 실행 하시겠습니까?" ;
	}
	else {
		text += "닉네임 : "+ me_nick + "\n영구정지 해제 후 부여할 기한 정지일수 : "+ day + "일\n이대로 실행 하시겠습니까?" ;
	}
	
	if(confirm(text)){
		$.ajax({
			url : '<c:url value="/member/block/update"/>',
			method : "post",
			data : {
				"me_id" : me_id,
				"option" : option,
				"day" : day
			},
			dataType : "json",
			success : function (data) {
				let res = data.result;
				if(res == 1){
					alert("작업 실패")	
					window.close();
				}
				else if(res == 2){
					let tmp = "";
					if(option == "decrease"){
						tmp += "정지일에서 " + day + "일 감면했습니다.";
					}
					else if(option == "permanent"){
						tmp += "영구정지로 변경됐습니다.";
					}
					else if(option == "delete"){
						tmp += "영구정지가 해제됐습니다.";
					}
					else {
						tmp += "기한정지 "+day+"일로 변경됐습니다.";
					}
					alert(tmp)		
					window.close();
				}
				else if(res == 3){
					alert("운영자는 정지할 수 없습니다.")		
					window.close();
				}
				else{
					alert("변경에 실패했습니다.")
					window.close();
				}
			},
			error : function (a,b,c) {
				console.error("에러 발생");
			}
		})
	}
	
	
})


</script>

</body>
</html>