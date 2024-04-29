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
	<h3 class="mt-3">커뮤니티 이용제한</h3>
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
	<c:if test="${member.me_ms_num != 1}">
		<c:if test="${member.me_block != null}">
			<div class="input-group">
				<div class="input-group-prepend">
					<span class="input-group-text">정지기한</span>
				</div>
				<input class="form-control" value="${member.me_block}" readonly style="background-color: white;">
			</div>
		</c:if>
		<div class="input-group">
			<div class="input-group-prepend">
				<span class="input-group-text">정지일수</span>
			</div>
			<select class="form-control text-center">
				<option value="1">1일</option>
				<option value="3">3일</option>
				<option value="7">일주일(7일)</option>
				<option value="30">한달(30일)</option>
				<option value="365">일년(365일)</option>
				<option value="999">영구정지</option>
			</select>
			<div class="input-group-append">
				<button class="btn btn-primary btn-action">확정</button>
			</div>
		</div>
	</c:if>
	<c:if test="${member.me_ms_num == 1}">
		<div class="input-group">
			<div class="input-group-prepend">
				<span class="input-group-text">정지기한</span>
			</div>
			<input class="form-control" value="영구정지" readonly style="background-color: white;">
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

<!-- 정지 확정 스크립트 -->
<script type="text/javascript">
$(".btn-action").click(function () {
	let me_id = $(".input-id").val()
	let me_nick = $(".input-nick").val()
	let day = $(this).parents(".input-group").find("select").val();
	let daylong = "";
	if(day < 400){
		daylong = day+"일"
	}else{
		daylong = "영구정지"
	}
	
	if(confirm("닉네임 : "+ me_nick + "\n설정할 정지일수 : "+ daylong + "\n이대로 실행 하시겠습니까?" )){
		$.ajax({
			url : '<c:url value="/member/block/insert"/>',
			method : "post",
			data : {
				"me_id" : me_id,
				"day" : day
			},
			dataType : "json",
			success : function (data) {
				let res = data.result;
				if(res == 1){
					alert("새로 정지일을 설정했습니다.")	
					window.close();
				}
				else if(res == 2){
					alert("기존 정지일에 추가됐습니다.")		
					window.close();
				}
				else if(res == 3){
					alert("운영자를 정지할 수 없습니다.")		
					window.close();
				}
				else if(res == 4){
					alert("영구정지 되었습니다.")		
					window.close();
				}
				else{
					alert("정지일 설정에 실패했습니다.")
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