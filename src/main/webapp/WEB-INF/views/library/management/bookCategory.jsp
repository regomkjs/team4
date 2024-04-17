<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<body>
	<div class="container mt-5">
		<div class="main">
			<div class="select">
				<ul class="nav">
					<c:forEach items="${upList}" var="category">
						<c:if test="${category.up_num != 100 }">
							<li class="nav-item">
					    		<a class="nav-link category-btn" href="#" data-num="${category.up_num}">
					    		[${category.up_num}] ${category.up_name}</a>
					  		</li>			
						</c:if>	
					</c:forEach>
					<li class="nav-item">
					    <a class="nav-link" href="#" data-toggle="modal" data-target="#myModal">
					    카테고리 관리</a>
					</li>			
				</ul>
			</div>
			<div class="list">
				
		    </table>
			</div>
		</div>
	</div>
	<!-- The Modal -->
	<div class="modal fade " id="myModal">
		<div class="modal-dialog modal-xl ">
      		<div class="modal-content modal-dialog modal-xl">
        	<!-- Modal Header -->
        		<div class="modal-header">
          			<h4 class="modal-title">카테고리 관리</h4>
          			<button type="button" class="close" data-dismiss="modal">×</button>
        		</div>
        		<!-- Modal body -->
        		<div class="modal-body">
        			<div class="input-group ca-menu">
						<a href="#" class="management-add-category btn">카테고리 추가</a>
						<a href="#" class="management-del-category btn">카테고리 삭제</a>
					</div>
					<div class="event-box"></div>
		        </div>
        		<!-- Modal footer -->
        		<div class="modal-footer">
        		</div>
      		</div>
    	</div>
	</div>
	<!-- 카테고리 클릭시 목록출력 -->
	<script type="text/javascript">
	let upNum;
		//카테고리에 맞는 장르를 추가함
		$(".category-btn").click(function() {
			upNum=$(this).data("num");
			displayTypeView(upNum);
		});
		
		function displayTypeView(upNum) {
			$.ajax({
				async : true,
				url : '<c:url value="/management/manager/category" />', 
				type : 'post', 
				data : {num:upNum}, 
				success : function (data){
					let str="";
					let num=0;
					for(un of data.list){
						if(un.un_code%10==0){
							str+=`</ul><ul>`;
							num++;
						}
						str+=`
					        <li>[\${un.un_up_num}\${un.un_code<10?'0'+un.un_code:un.un_code}] \${un.un_name}
					        <button type="button" class="close type-del-btn" data-num="\${un.un_num}">&times;</button></li>
						`;
						if(un.un_code/10>=num){
							str+=`</ul>`;
							num++;
						}
					}
					str+=`</ul>
					<ul>
						<li class="management-add-type"
						 data-toggle="modal" data-target="#myModal">장르 추가 +</li>
					</ul>`;
					$(".list").html(str);
				}, 
				error : function(jqXHR, textStatus, errorThrown){

				}
			});
		}
	</script>
	<!-- 카테고리 추가 -->
	<script type="text/javascript">
	$(".management-add-category").click(function() {
		$(".modal-title").text("카테고리 추가");
		let str=`
		<div class="input-group">
			<input type="text" class="form-control" placeholder="등록번호" name="caNum">
			<input type="text" class="form-control" placeholder="카테고리명" name="caName">
		</div>`;
		$(".modal-body>.event-box").html(str);
		str=`<button type="button" class="btn btn-danger category-add-btn" data-dismiss="modal">등록</button>`;
		$(".modal-footer").html(str);
	});
	
	//카테고리 추가
	$(document).on("click",".category-add-btn",function(){
		$.ajax({
			async : true,
			url : '<c:url value="/management/bookCategory/insert" />', 
			type : 'post', 
			data : {
				caNum:$("input[name=caNum]").val(),
				caName:$("input[name=caName]").val()
			}, 
			success : function (data){
				if(data.res){
					alert("등록이 되었습니다");
				}else{
					alert("등록이 실패했습니다");
				}
				location.reload();
			}, 
			error : function(jqXHR, textStatus, errorThrown){

			}
		});
	});
	</script>
	<!-- 카테고리 삭제 -->
	<script type="text/javascript">
	$(".management-del-category").click(function() {
		$(".modal-title").text("카테고리 삭제");
		let str=`<select class="form-control category">
			<option value="none">카테고리 선택</option>
			<c:forEach items="${upList}" var="category">
			<c:if test="${category.up_num != 100 }">
				<option value="${category.up_num}">
		    		[${category.up_num}] ${category.up_name}
		  		</option>			
			</c:if>	
		</c:forEach></select>`;
		$(".modal-body>.event-box").html(str);
		str=`<button type="button" class="btn btn-danger category-del-btn" data-dismiss="modal">삭제</button>`;
		$(".modal-footer").html(str);
	});
	
	//카테고리 삭제
	$(document).on("click",".category-del-btn",function(){
		$.ajax({
			async : true,
			url : '<c:url value="/management/bookCategory/delete"/>', 
			type : 'post', 
			data : {
				caNum:$(".category").val()
			}, 
			success : function (data){
				if(data.res){
					alert("삭제가 되었습니다");
				}else{
					alert("삭제에 실패했습니다");
				}
				location.reload();
			}, 
			error : function(jqXHR, textStatus, errorThrown){

			}
		});
	});
	</script>
	<!-- 장르 추가,삭제 -->
	<script type="text/javascript">	
	$(document).on("click",".management-add-type",function(){
		$(".modal-title").text("장르 추가");
		$(".ca-menu").hide();
		let str=`
		<div class="input-group">
			<input type="text" class="form-control" placeholder="장르코드" name="code">
			<input type="text" class="form-control" placeholder="장르명" name="tyName">
		</div>`;
		$(".modal-body>.event-box").html(str);
		str=`<button type="button" class="btn btn-danger type-add-btn" data-dismiss="modal">등록</button>`;
		$(".modal-footer").html(str);
	});
	
	//장르 추가
	$(document).on("click",".type-add-btn",function(){
		let tydata={
			un_upNum:upNum,
			unName:$("input[name=tyName]").val(),
			unCode:$("input[name=code]").val()	
		}
		if(tydata.unCode>100){
			alert("두자리 숫자만 가능합니다");
			return;
		}
		$(".ca-menu").show();
		console.log(tydata);
		$.ajax({
			async : true,
			url : '<c:url value="/management/bookType/insert "/>', 
			type : 'post', 
			data : JSON.stringify(tydata), 
			contentType : "application/json; charset=utf-8",
			dataType : "json",
			success : function (data){
				if(data.res){
					alert("추가가 되었습니다");
				}else{
					alert("추가에 실패했습니다");
				}
				displayTypeView(upNum);
			}, 
			error : function(jqXHR, textStatus, errorThrown){

			}
		});
	});
	
	//장르 삭제
	$(document).on("click",".type-del-btn",function(){
		$.ajax({
			async : true,
			url : '<c:url value="/management/bookType/delete "/>', 
			type : 'post', 
			data : {num:$(this).data("num")}, 
			success : function (data){
				if(data.res){
					alert("삭제가 되었습니다");
				}else{
					alert("삭제에 실패했습니다");
				}
				displayTypeView(upNum);
			}, 
			error : function(jqXHR, textStatus, errorThrown){

			}
		});
	});
	</script>
</body>