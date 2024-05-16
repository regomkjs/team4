<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>	
	
<style>
.main ul{padding: 0;}
.nav .nav-item{border: 1px solid #000; width: 19% ; margin-top: 10px;}
.nav .nav-item>a{line-height: 50px; text-align: center; color:#000; text-decoration: none;}
.nav{display: flex;justify-content :space-between;}
.category-list{border-bottom: 2px solid #ccc; border-top: 2px solid #ccc; }
.genre-list{display:block; width: 20%;}
.genre-list>li{line-height:30px; border-bottom: 1px solid #ccc; margin: 5px; position: relative;
 height: 30px;}
 .genre-list>li>span{ display:block; width:70%;
 overflow: hidden; text-overflow: ellipsis; white-space: nowrap;}
.add-box{text-align: right;}
.management-add-type{display: inline;}

.fa-solid{position: absolute; font-size:14px; top: 7px; right: 25px; cursor: pointer;}
.type-del-btn{
	position: absolute; font-size:14px; top: 3px; right: 0px;
}
.fa-regular{ margin-right: 5px;}
</style>
<body>
	<div class="container">
		<div id="nav"></div>
		<div class="main  mt-5">
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
					    <a class="nav-link category-control" href="#" data-bs-toggle="modal" data-bs-target="#myModal">
					    카테고리 관리</a>
					</li>			
				</ul>
			</div>
			<div class="add-box  mt-5 ">
		
			</div>
			<div class="category-list mb-5 mt-2 cf">
				
		   
			</div>
		</div>
	</div>
	<!-- The Modal -->
	<div class="modal fade " id="myModal">
		<div class="modal-dialog modal-xl ">
      		<div class="modal-content modal-dialog modal-xl">
        	<!-- Modal Header -->
        		<div class="modal-header">
          			<h4 class="modal-title"></h4>
          			<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        		</div>
        		<!-- Modal body -->
        		<div class="modal-body">
        			
		        </div>
        		<!-- Modal footer -->
        		<div class="modal-footer">
        		</div>
      		</div>
    	</div>
	</div>
	<!-- 카테고리 관리 클릭시 -->
	<script type="text/javascript">
	$(".category-control").click(function() {
		let str=`
			<h4 class="modal-title">카테고리 관리</h4>
  			<button type="button" class="btn-close" data-bs-dismiss="modal"></button>`;
  		$(".modal-header").html(str);
  		
  		str=`
  		<div class="input-group ca-menu">
			<a href="#" class="management-add-category btn">카테고리 추가</a>
			<a href="#" class="management-del-category btn">카테고리 삭제</a>
		</div>
		<div class="event-box"></div>`;
  		$(".modal-body").html(str);
	});
	</script>
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
							str+=`</ul><ul class="genre-list left cf">`;
							num++;
						}
						str+=`
					        <li>
								<span>
								[\${un.un_up_num}\${un.un_code<10?'0'+un.un_code:un.un_code}] \${un.un_name}
								</span>
					        <i class="fa-solid fa-wrench" data-bs-toggle="modal" data-bs-target="#myModal"
					        	data-num="\${un.un_num}"></i>
					        <button type="button" class="btn-close type-del-btn" data-num="\${un.un_num}"></button></li>
						`; 
						if(un.un_code/10>=num){
							str+=`</ul>`;
							num++;
						}
					}
					$(".category-list").html(str);
					str=`
					<div class="management-add-type click" data-bs-toggle="modal" data-bs-target="#myModal">
						 <i class="fa-regular fa-square-plus"></i>장르추가
					</div>
					`;
					$(".add-box").html(str);
				}, 
				error : function(jqXHR, textStatus, errorThrown){

				}
			});
		}
	</script>
	<!-- 카테고리 추가 -->
	<script type="text/javascript">
	$(document).on("click",".management-add-category",function() {
		$(".modal-title").text("카테고리 추가");
		let str=`
		<div class="input-group">
			<input type="text" class="form-control" placeholder="등록번호" name="caNum">
			<input type="text" class="form-control" placeholder="카테고리명" name="caName">
		</div>`;
		$(".modal-body>.event-box").html(str);
		str=`<button type="button" class="btn btn-danger category-add-btn" data-bs-dismiss="modal">등록</button>`;
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
	$(document).on("click",".management-del-category",function() {
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
		str=`<button type="button" class="btn btn-danger category-del-btn" data-bs-dismiss="modal">삭제</button>`;
		$(".modal-footer").html(str);
	});
	
	//카테고리 삭제
	$(document).on("click",".category-del-btn",function(){
		let res=confirm("삭제 하시겠습니까?");
		if(res){
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
		}else{
			alert("취소 했습니다");
		}
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
		$(".modal-body").html(str);
		str=`<button type="button" class="btn btn-danger type-add-btn" data-bs-dismiss="modal">등록</button>`;
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
		let res=confirm("삭제 하시겠습니까?");
		if(res){
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
		}else{
			alert("취소했습니다");
		}
	});
	
	let unNum;
	$(document).on("click",".fa-solid",function(){
		unNum=$(this).data('num');
		$(".modal-title").text("장르 수정");
		$(".ca-menu").hide();
		let str=`
		<div class="input-group">
			<input type="text" class="form-control" placeholder="장르명" name="tyName">
		</div>`;
		$(".modal-body").html(str);
		str=`<button type="button" class="btn btn-danger type-update-btn" data-bs-dismiss="modal">등록</button>`;
		$(".modal-footer").html(str);
	});
	
	$(document).on("click",".type-update-btn",function(){
			$.ajax({
				async : true,
				url : '<c:url value="/management/bookType/update"/>', 
				type : 'post', 
				data : {unNum,
					name:$('input[name=tyName]').val()
					}, 
				success : function (data){
					if(data.res){
						alert("수정 되었습니다");
					}else{
						alert("수정에 실패했습니다");
					}
					displayTypeView(upNum);
				}, 
				error : function(jqXHR, textStatus, errorThrown){
	
				}
			});
	});
	
	$('.nav-link').click(function(e)
	{
		e.preventDefault();   
	});
	</script>
</body>