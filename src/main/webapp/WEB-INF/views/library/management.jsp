<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<body>
<div class="container mt-5">
  <div class="search input-group">
  	<select  class="form-control">
  		<option value="all">전체</option>
  		<option value="title">도서명</option>
  		<option value="authors">저자</option>
  		<option value="publisher">출판사</option>
  	</select>
    <input type="text" class="form-control" placeholder="Search"
    name="search">
    <div class="input-group-append">
      <button class="btn btn-success list-btn" type="button">검색</button>
    </div>
  </div>
  <div class="insert">
    <button type="button" class="btn btn-primary" 
    data-toggle="modal" data-target="#myModal">추가</button>
  </div>
  <div class="main">
	  <div class="list">
	    <table class="table table-bordered">
	      <thead>
	        <tr>
	          <th>도서명</th>
	          <th>도서코드</th>
	          <th>표준번호</th>
	          <th>출판사</th>
	          <th>저자</th>
	          <th>역자</th>
	          <th></th>
	        </tr>
	      </thead>
	      <tbody>
	        <tr>
	          <td></td>
	          <td></td>
	      	  <td></td>
	      	  <td></td>
	      	  <td></td>
	      	  <td></td>
	      	  <td>
	       		<a>수정</a><span>/</span><a>삭제</a>
	      	  </td>
	     	</tr>
	   	  </tbody>
	    </table>
	  </div>
	  <div class="pagination-box">
	 	<ul class="pagination justify-content-center pagination-sm""></ul>
	  </div>
  </div>
  <!-- The Modal -->
  <div class="modal fade " id="myModal">
    <div class="modal-dialog modal-xl ">
      <div class="modal-content modal-dialog modal-xl">
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">도서 추가</h4>
          <button type="button" class="close" data-dismiss="modal">×</button>
        </div>
        <!-- Modal body -->
        <div class="modal-body">
        	<div class="input-group">
			    <input type="text" class="form-control" placeholder="도서 검색"
			    name="bookName">
			    <div class="input-group-append">
			      <button class="btn btn-success search-btn2" type="button">검색</button>
			    </div>
			</div>
          <div class="list">
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
          </div>
        </div>
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-danger addBook" >가져오기</button>
          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
 
</div>
<script type="text/javascript">
	let book=new Array();
	let selectedBook= [];
	let cri={
		search:null,
		type:'all',
		page:1
	}
	
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
	
	$(".allChkBtn").change(function() {
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
	
	//책 추가
	$(".addBook").click(function() {
		let selectBook=[];
		selectedBook.forEach((value)=>{
			selectBook.push(book[value]);
		})
		console.log(selectBook);
		if(selectBook.length==0){
			alert("선택된 책이 없습니다");
			return;
		}
		$.ajax({
			async : true,
			url :'<c:url value="/management/insert" />', 
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
			}, 
			error : function(jqXHR, textStatus, errorThrown){

			}
		});
	});
	
	//추가할 책 검색
	$(document).on("keypress","[name=bookName]",function(key){
		if(key.keyCode==13){	
			$('.search-btn2').click();
		}
	});
	$(".search-btn2").click(function() {
		let search=$("input[name=bookName]").val();	
		$.ajax({
			async : true,
			url : "https://dapi.kakao.com/v3/search/book", 
			type : "get", 
			data :{
				query:search,
				size:5}, 
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
			}, 
			error : function(jqXHR, textStatus, errorThrown){

			}
		});
	})
	
	//등록된 책 목록 보여주기
	$("select").change(function() {
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
	function displayBookView(cri) {
		cri.search=$("input[name=search]").val();
		$.ajax({
			async : true,
			url : '<c:url value="/management/list"/>', 
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
				          <td>\${book.bo_title}</td>
				          <td>\${book.bo_code}</td>
				      	  <td>\${book.bo_isbn}</td>
				      	  <td>\${book.bo_publisher}</td>
				      	  <td>\${book.bo_au_name}</td>
				      	  <td>\${book.bo_tr_name}</td>
				      	  <td>
				       		<div>수정</div>
				       		<span>/</span>
				       		<div>삭제</div>
				      	  </td>
				     	</tr>
					`;
				}
				$(".main>.list>table>tbody").html(str);
				
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
	
	$(document).on('click','.pagination .page-link',function(){
		cri.page = $(this).data('page');
		printMember(cri);
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
</body>
