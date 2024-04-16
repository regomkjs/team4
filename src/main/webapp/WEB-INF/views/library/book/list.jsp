<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<body>
	<div class="container mt-5">
		<div class="input-group">
			<select class="form-control" name="type">
				<option value="all">전체</option>
				<option value="title">도서명</option>
				<option value="authors">저자</option>
				<option value="publisher">출판사</option>
			</select> 
			<input type="text" class="form-control" placeholder="검색" name="search">
			<div class="input-group-append">
				<button class="btn btn-success search-btn" type="button">검색</button>
			</div>
		</div>
		<div class="main">
			<div class="side-bar">
				<c:forEach items="${upList}" var="category">
					<c:if test="${category.up_num != 100 }">
						<div class="dropdown">
						  <button type="button" class="btn btn-primary dropdown-toggle list-btn" data-toggle="dropdown"
						  data-num="${category.up_num}">
						    ${category.up_name}
						  </button>
						  <div class="dropdown-menu type-btn">
						   
						  </div>
						</div>
					</c:if>	
				</c:forEach>
			</div>
			<div class="book-main">
				<div class="book-list">
					
				</div>
				<div class="pagination-box">
					<ul class="pagination justify-content-center pagination-sm""></ul>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		let cri={
			search:null,
			type:'all',
			page:1,
			bo_code:2	
		};
		
		$("select[name=type]").change(function() {
			cri.type=$(this).val();
		});
		
		$(".search-btn").click(function() {
			cri.search=$("input[name=search]").val();
			displayBookView(cri);
		})
		
		//카테고리에 맞는 장르를 추가함
		$(".list-btn").click(function() {
			$.ajax({
				async : true,
				url : '<c:url value="/management/manager/category" />', 
				type : 'post', 
				data : {num:$(this).data("num")}, 
				success : function (data){
					let str="";
					for(un of data.list){
					str+=`
				    	<a value='\${un.un_num}' class="dropdown-item select-btn">[\${un.un_code}] \${un.un_name}</a>
					`;
					}
					$(".type-btn").html(str);
				}, 
				error : function(jqXHR, textStatus, errorThrown){

				}
			});
		});
		
		$(document).on("click",".select-btn",function() {
			cri.type="code";
			cri.search=$(this).attr('value');	
			displayBookView(cri);
		});
		
	
	</script>
	<!--책 목록을 출력-->
	<script type="text/javascript">
		function displayBookView(cri){
			console.log(cri);
			$.ajax({
				async : true,
				url : '<c:url value="/management/manager/list"/>', 
				type : 'post', 
				data : JSON.stringify(cri),
				contentType : "application/json; charset=utf-8",
				dataType : "json", 
				success : function (data){
					let str="";
					for(book of data.bookList){
						str+=`
							<div class="book clearfix">
								<div class="float-left">
									<img alt="\${book.bo_title}" src="\${book.bo_thumbnail}"/>
								</div>
								<a class="float-right" href='<c:url value="/library/book/detail?num=\${book.bo_num}"/>'>
									\${book.bo_title}
								</a>
							</div>
						`;
					}
					$(".book-main>.book-list").html(str);
					let pm = data.pm;
					let pmStr = "";
					if(pm.prev){
						pmStr += `
						<li class="page-item">
							<a class="page-link" href="javascript:void(0);" data-page="\${pm.startPage-1}">이전</a>
						</li>
						`;
					}
					for(i = pm.startPage; i<= pm.endPage; i++){
						let active = pm.cri.page == i ? "active" :"";
						pmStr += `
						<li class="page-item \${active}">
							<a class="page-link" href="javascript:void(0);" data-page="\${i}">\${i}</a>
						</li>
						`
					}
					if(pm.next){
						pmStr += `
						<li class="page-item">
							<a class="page-link" href="javascript:void(0);" data-page="\${pm.endPage+1}">다음</a>
						</li>
						`;
					}
					$(".pagination-box>ul").html(pmStr);
				}, 
				error : function(jqXHR, textStatus, errorThrown){

				}
			});
		}	
	</script>
</body>