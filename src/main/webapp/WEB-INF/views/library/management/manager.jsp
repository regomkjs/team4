<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.book-list thead{background-color: #ddd;}
.book-list thead  th:nth-child(1){width: 10%;}
.book-list thead  th:nth-child(2){width: 20%;}
.book-list thead  th:nth-child(3){width: 20%;}
.book-list thead  th:nth-child(4){width: 10%;}
.book-list thead  th:nth-child(5){width: 10%;}
.book-list thead  th:nth-child(6){width: 10%;}
.book-list thead  th:nth-child(7){width: 10%;}
.book-list img{height: 100px; max-width: 100px}
table{text-align: center;}
.book-list tbody td{  display: table-cell;
    vertical-align: middle}

.modal-body table thead th:nth-child(1){width: 30px;}
.modal-body table thead th:nth-child(2){width: 30%-30px;}
.modal-body table thead th:nth-child(3){width: 20%;}
.modal-body table thead th:nth-child(4){width: 10%;}
.modal-body table thead th:nth-child(5){width: 10%;}
.modal-body table thead th:nth-child(6){width: 10%;}
.modal-body table thead th:nth-child(7){width: 10%;}
.modal-body table tbody td{display: table-cell;
    vertical-align: middle}
    
.updateBook-btn{border: 2px solid #83c67a; border-radius: 5px; box-sizing: border-box; 
margin-bottom: 10px;}
.updateBook-btn:hover{color: #fff; background-color: #cae39a; font-weight: bold;}
.deleteBook-btn{border: 2px solid #e18393; border-radius: 5px; box-sizing: border-box;}
.deleteBook-btn:hover{color: #fff; background-color: #e594a1; font-weight: bold;}

.fa-solid{margin-left:5px; }
</style>
<body>
<div class="container ">
	<div id="nav"></div>
	<div class="search input-group  mt-5">
	  	<select  class="form-control" name="type">
	  		<option value="all">전체</option>
	  		<option value="title">도서명</option>
	  		<option value="authors">저자</option>
	  		<option value="publisher">출판사</option>
	  	</select>
	    <input type="text" class="form-control w-75" placeholder="도서 검색"
	    name="search">
	    <div class="input-group-append ">
	      <button class="btn btn-success list-btn" type="button">검색</button>
	    </div>
	</div>
	<div class="insert mt-4 right">
	    <a class="btn-addBook" data-bs-toggle="modal" data-bs-target="#myModal">
	    <i class="fa-regular fa-square-plus"></i> 도서 추가</a>
	</div>
	<div class="main">
		<div class="book-list">
		    <table class="table table-bordered">
		    	<thead>
		        	<tr>
			          	<th>이미지</th>
			          	<th>도서명</th>
			          	<th class="order-by click">도서코드<i class="fa-solid fa-book"></i></th>
			          	<th>표준번호</th>
			          	<th>출판사</th>
			          	<th>저자</th>
			          	<th>역자</th>
			          	<th></th>
		        	</tr>
		      	</thead>
		      	<tbody>
		        	
		   	  	</tbody>
		    </table>
		</div>
		<div class="pagination-box">
		  	<ul class="pagination justify-content-center pagination-sm"></ul>
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
          			<button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
        		</div>
      		</div>
    	</div>
	</div>
</div>
<!-- 모달 창 변경, 책 수정 -->
<script type="text/javascript">

//추가버튼 클릭시
$(".btn-addBook").click(function() {
	$(".modal-title").text("도서 추가");
	bookSearch.target="all";
	let str="";
	str+=`
	<div class="input-group">
		<select class="bookTarget form-control" name="type">
			<option value="all">전체</option>
			<option value="title">제목</option>
			<option value="publisher">출판사</option>
			<option value="person">저자</option>
			<option value="isbn">ISBN</option>
		</select>
	    <input type="text" class="form-control" placeholder="도서 검색"
	    name="bookName">
	    <div class="input-group-append">
	      <button class="btn btn-success search-btn2" type="button">검색</button>
	    </div>
	</div>
  	<div class="list mt-4">
  	 	<table class="table table-bordered">
			<thead>
				<tr>
					<th>
						<input type="checkbox" class="allChkBtn"/>
					</th>
				    <th>도서명</th>
				    <th>표준번호</th>
				    <th>출판사</th>
				    <th>저자</th>
				    <th>역자</th>
				    <th>출판일</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
		<div class="kakaoSearchPage">
			<ul class="pagination justify-content-center pagination-sm""></ul>
		</div>
  	</div>
	`;
	$(".modal-body").html(str);
	str="";
	str+=`<button type="button" class="btn btn-danger addBook" 
		data-bs-dismiss="modal">가져오기</button>`;
	$(".modal-footer").html(str);
});

//수정 클릭시
let boNum;
$(document).on("click",".updateBook-btn",function() {
	boNum=$(this).data("num");
	$(".modal-title").text("도서 수정");
	let str="";
	str=`
	<div class="input-group">
		<select class="form-control category w-50">
			<option value="none">카테고리 선택</option>
	    	<c:forEach items="${upList}" var="up">
	    	 	<option value="${up.up_num}">[${up.up_num}] ${up.up_name}</option>
	    	</c:forEach>
		</select>
		<select class="form-control type w-50">
			<option>카테고리를 정해주세요</option>
		</select>
	</div>
	`;
	$(".modal-body").html(str);
	str="";
	str+=`<button type="button" class="btn btn-danger updateBook"
		data-bs-dismiss="modal">수정하기</button>`;
	$(".modal-footer").html(str);
});

$(document).on("change",".category",function(){
	let num=$(this).val();
	$.ajax({
		async : true,
		url : '<c:url value="/management/manager/category" />', 
		type : 'post', 
		data : {num}, 
		success : function (data){
			let str="";
			for(un of data.list){
			str+=`
		    	<option value="\${un.un_code}">[\${un.un_code}] \${un.un_name}</option>
			`;
			}
			$(".type").html(str);
		}, 
		error : function(jqXHR, textStatus, errorThrown){

		}
	});
});

//책 수정(책 코드)
$(document).on("click",".updateBook",function(){
	let caNum=$(".category").val();
	let tyNum=$(".type").val();
	if(caNum=="none"){
		alert("카테고리를 선택해 주세요");
		return;
	}
	$.ajax({
		async : true,
		url : '<c:url value="/management/manager/update" />', 
		type : 'post', 
		data : {caNum,tyNum,boNum}, 
		success : function (data){
			if(data){
				alert("수정이 되었습니다");
				displayBookView(cri);
			}else{
				alert("잘못된 오류입니다");
			}
		}, 
		error : function(jqXHR, textStatus, errorThrown){

		}
	});
});
</script>

<!-- 책 추가 검색 -->
<script type="text/javascript">
	let book=new Array();
	let selectedBook= [];

	//체크박스 클릭
	$(document).on('change','.chkBtn',function(){
		var checked = $(this).is(':checked');
		if(checked){
			$('.allChkBtn').prop('checked',true);
			selectedBook.push($(this).data("index"));
		}else{
			if($(".chkBtn:checked").length==0){
				$('.allChkBtn').prop('checked',false);
			}
			let value=$(this).data("index");
			for(let i = 0; i < selectedBook.length; i++) {
			    if (selectedBook[i] === value) {
			    	selectedBook.splice(i, 1);
			    }
			}
		}
	});
	
	$(document).on("change",".allChkBtn",function() {
		var checked = $(this).is(':checked');
		if(checked){
			$('input:checkbox').prop('checked',true);
			selectedBook=[];
			$(".chkBtn:checked").each(function() {
				selectedBook.push($(this).data("index"));
			  })
		}else{
			$('input:checkbox').prop('checked',false);
			selectedBook=[];
		}
	});
	
	//책 db추가
	$(document).on("click",".addBook",function() {
		let selectBook=[];
		selectedBook.forEach((value)=>{
			selectBook.push(book[value]);
		});
		
		console.log(selectBook);
		console.log(selectedBook);
		if(selectBook.length==0){
			alert("선택된 책이 없습니다");
			return;
		}
		$.ajax({
			async : true,
			url :'<c:url value="/management/manager/insert" />', 
			type : 'post' ,
			data : JSON.stringify(selectBook),
			contentType : "application/json; charset=utf-8",
			dataType : "json",
			success : function (data){
				if(data){
					alert("추가가 되었습니다");
					displayBookView(cri);
				}else{
					alert("추가가 하지 못 했습니다");
				}
				//내용삭제
				$('input:checkbox').prop('checked',false);
				selectedBook=[];
				$("input[name=bookName]").val("");
				let str=""
				$(".modal-body>.list>table>tbody").html(str);
			}, 
			error : function(jqXHR, textStatus, errorThrown){

			}
		});
	});
	
	//추가할 책 검색
	let bookSearch={
		page:1,
		search:null,
		target:"all"
	};
	let bookCri={
		endPage:0,
		startPage:1,
		perPage:10
	}
	$(document).on("keypress","[name=bookName]",function(key){
		if(key.keyCode==13){	
			$('.search-btn2').click();
		}
	});
	$(document).on("change",".bookTarget",function(){
		bookSearch.target=$(this).val();
		bookCri.endPage=0;
		bookCri.startPage=1;
		bookCri.perPage=10;
	});
	$(document).on("click",".search-btn2",function() {
		bookSearch.search=$("input[name=bookName]").val();	
		if(bookSearch.search==null){
			return;
		}
		bookSearch.page=1;
		bookCri.endPage=0;
		bookCri.startPage=1;
		bookCri.perPage=10;
		searchBook(bookSearch);
	});
	
	function searchBook(bookSearch) {
		console.log(bookSearch);
		$.ajax({
			async : true,
			url : "https://dapi.kakao.com/v3/search/book", 
			type : "get", 
			data :{
				query:bookSearch.search,
				page:bookSearch.page,
				target:bookSearch.target
				}, 
			headers: { "Authorization":"KakaoAK ${api}" },
			dataType :"json", 
			success : function (data){
				console.log(data);//
				let str="";
				book=[]
				for(let i=0;i<data.documents.length;i++){
					book.push(data.documents[i]);
					book[i].isbn=toStringSplit(data.documents[i].isbn);
					str+=`
						<tr>
					    	<td>
					          <input type="checkbox" data-index="\${i}" class="chkBtn"/>
					        </td>
					        <td>\${book[i].title}</td>
					      	<td>\${book[i].isbn}</td>
					       	<td>\${book[i].publisher}</td>
					      	<td>\${book[i].authors}</td>
					      	<td>\${book[i].translators}</td>
					      	<td>\${toStringFormatting(book[i].datetime)}</td>
					    </tr>	
					`;
				}
				console.log(book);//
				$(".modal-body>.list>table>tbody").html(str);
				$('input:checkbox').prop('checked',false);
				selectedBook=[];
				//페이지네이션
				let pm="";
				if(bookSearch.page>10){
					pm+=`
					<li class="page-item"><a class="page-link search-page" data-page="\${bookCri.startPage-1}">이전</a></li>
					`;
				}
				bookCri.endPage=Math.ceil(data.meta.total_count/10);
				if(bookCri.perPage>bookCri.endPage){
					bookCri.perPage=bookCri.endPage;
				}
				for(let i=bookCri.startPage;i<=bookCri.perPage;i++){
					let active = bookSearch.page == i ? 'active' : '';
					pm+=`
					<li class="page-item \${active}"><a class="page-link search-page" data-page="\${i}">\${i}</a></li>
					`;
				}
				if(bookCri.perPage!=bookCri.endPage){
					pm+=`
					<li class="page-item"><a class="page-link search-page" data-page="\${bookCri.perPage+1}">다음</a></li>
					`;
				}
				$(".kakaoSearchPage>.pagination").html(pm);
			}, 
			error : function(jqXHR, textStatus, errorThrown){

			}
		});
	}
	
	$(document).on('click',".search-page",function(){
		bookSearch.page=$(this).data('page');
		if(bookSearch.page>bookCri.perPage){
			bookCri.startPage+=10;
			bookCri.perPage+=10;
		}else if(bookSearch.page<bookCri.startPage){
			bookCri.startPage-=10;
			bookCri.perPage-=10;
		}
		searchBook(bookSearch);
	});
	
	let cri={
		search:null,
		type:'all',
		page:1,
		bo_code:1
	}
		
	//등록된 책 목록 보여주기
	$('[name=type]').change(function() {
		cri.type=$(this).val();
	});
	$(".list-btn").click(function() {
		displayBookView(cri);
	});
	$(document).on("keypress","[name=search]",function(key){
		if(key.keyCode==13){	
			$('.list-btn').click();
		}
	});
	$(".order-by").click(function() {
		if(cri.bo_code==3){
			let str=`도서 번호<i class="fa-solid fa-book"></i>`;
			$(this).html(str);
			cri.bo_code=1
		}else{
			let str=`미정 도서<i class="fa-solid fa-tag"></i>`;
			$(this).html(str);
			cri.bo_code=3
		}
		displayBookView(cri);
	});
	
	function displayBookView(cri) {
		cri.search=$("input[name=search]").val();
		$.ajax({
			async : true,
			url : '<c:url value="/management/manager/list"/>', 
			type : 'post', 
			data : JSON.stringify(cri),
			contentType : "application/json; charset=utf-8",
			dataType : "json", 
			success : function (data){
				console.log(data);//
				let str="";
				for(book of data.bookList){
					str+=`
						<tr>
				          <td><img alt="\${book.bo_title}" src="\${book.bo_thumbnail}"></td>
				          <td>\${book.bo_title}</td>
				          <td>\${book.bo_code}</td>
				      	  <td>\${book.bo_isbn}</td>
				      	  <td>\${book.bo_publisher}</td>
				      	  <td>\${book.bo_au_name}</td>
				      	  <td>\${book.bo_tr_name}</td>
				      	  <td>
				       		<div class="updateBook-btn click" data-num="\${book.bo_num}"
				       		data-bs-toggle="modal" data-bs-target="#myModal">수정</div>
				       		<div class="deleteBook-btn click" data-num="\${book.bo_num}">삭제</div>
				      	  </td>
				     	</tr>
					`;
				}
				$(".book-list>table>tbody").html(str);
				let pm = data.pm;
				let pmStr = "";
				if(pm.prev){
					pmStr += `
					<li class="page-item">
						<a class="page-link display-page" href="javascript:void(0);" data-page="\${pm.startPage-1}">이전</a>
					</li>
					`;
				}
				for(i = pm.startPage; i<= pm.endPage; i++){
					let active = pm.cri.page == i ? "active" :"";
					pmStr += `
					<li class="page-item \${active}">
						<a class="page-link display-page" href="javascript:void(0);" data-page="\${i}">\${i}</a>
					</li>
					`
				}
				if(pm.next){
					pmStr += `
					<li class="page-item">
						<a class="page-link display-page" href="javascript:void(0);" data-page="\${pm.endPage+1}">다음</a>
					</li>
					`;
				}
				$(".pagination-box>ul").html(pmStr);
			}, 
			error : function(jqXHR, textStatus, errorThrown){

			}
		});
	}
	
	$(document).on('click',".display-page",function(){
		cri.page = $(this).data('page');
		displayBookView(cri);
	});
	
	displayBookView(cri);
	//날짜 표기
	function toStringFormatting(source){
      var  date = new Date(source);
      const year = date.getFullYear();
      const month = leftPad(date.getMonth() + 1);
      const day = leftPad(date.getDate());
      return [year, month, day].join('-');
	}
	
	//문자열 자르기
	function toStringSplit(source){
		let str=source;
		if(source.length>20){
	   		str=source.split(" ",1);
		}
	   	return str.toString();
	}
	
	function leftPad(value){
		if (Number(value) >= 10) {
			return value;
		}
		return "0" + value;
	}
</script>

<!-- 책 삭제 -->
<script type="text/javascript">
$(document).on("click",".deleteBook-btn",function(){
	if(confirm("삭제 하시겠습니까?")){
		let num=$(this).data("num");
		$.ajax({
			async : true,
			url : '<c:url value="/management/manager/LoanCheck"/>', 
			type : 'post', 
			data : {num},
			dataType : "json", 
			success : function (data){
				console.log(data);
				if(data.res){
					deleteBook(num);
				}else{
					let check = confirm("대출 내역이 있습니다. 삭제하시겠습니까?");
					if(check){
						deleteBook(num);
					}else{
						alert("취소했습니다");
					}
				}
			},error : function(jqXHR, textStatus, errorThrown){

			}
		});
	}
});

function deleteBook(num) {
	$.ajax({
		async : true,
		url : '<c:url value="/management/manager/delete"/>', 
		type : 'post', 
		data : {num},
		dataType : "json", 
		success : function (data){
			if(data){
				alert("삭제가 되었습니다");
				displayBookView(cri);
			}else{
				alert("삭제가 실패됬습니다");
			}
		},error : function(jqXHR, textStatus, errorThrown){

		}
	});
}
</script>
</body>
