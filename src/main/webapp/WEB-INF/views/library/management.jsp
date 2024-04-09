<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<body>
<div class="container mt-5">
  <div class="search input-group">
    <input type="text" class="form-control" placeholder="Search">
    <div class="input-group-append">
      <button class="btn btn-success" type="button">검색</button>
    </div>
  </div>
  <div class="insert">
    <button type="button" class="btn btn-primary" 
    data-toggle="modal" data-target="#myModal">추가</button>
  </div>
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
  <div class="pagunation">
  	<button class="test" type="button">api적용확인 콘솔확인</button>
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
		$.ajax({
			async : true,
			url :'<c:url value="/management/insert" />', 
			type : 'post' ,
			data : JSON.stringify(selectBook),
			contentType : "application/json; charset=utf-8",
			dataType : "json",
			success : function (data){
				console.log(data);
			}, 
			error : function(jqXHR, textStatus, errorThrown){

			}
		});
	});
	
	
	
	$(".test").click(function() {
		$.ajax({
			async : true,
			url : "https://dapi.kakao.com/v3/search/book", 
			//url:"/BookAPI",
			type : "get", 
			data :{query:"미움받을 용기",size:5}, 
			headers: { "Authorization":"KakaoAK ${api}" },
			dataType :"json", 
			success : function (data){
				console.log(data);
				let str="";
				book=[]
				for(let i=0;i<data.documents.length;i++){
					book.push(data.documents[i]);
					str+=`
						<tr>
					    	<td>
					          <input type="checkbox" data-index="\${i}" class="chkBtn"/>
					        </td>
					        <td>\${data.documents[i].title}</td>
					      	<td>\${data.documents[i].isbn}</td>
					       	<td>\${data.documents[i].publisher}</td>
					      	<td>\${data.documents[i].authors}</td>
					      	<td>\${data.documents[i].translators}</td>
					      	<td>\${toStringFormatting(data.documents[i].datetime)}</td>
					    </tr>	
					`;
				}
				console.log(book);
				$(".modal-body>.list>table>tbody").html(str);
			}, 
			error : function(jqXHR, textStatus, errorThrown){

			}
		});
	})
	
	
	
	
	//호출
	
	function displayBookView(cri) {
		$.ajax({
			async : true,
			url : '<c:url value=""/>', 
			type : 'post', 
			data : JSON.stringify(cri),
			contentType : "application/json; charset=utf-8",
			dataType : "json", 
			success : function (data){
				
			}, 
			error : function(jqXHR, textStatus, errorThrown){

			}
		});
	}
	
	//날짜 표기
	function toStringFormatting(source){
      var  date = new Date(source);
      const year = date.getFullYear();
      const month = leftPad(date.getMonth() + 1);
      const day = leftPad(date.getDate());
      return [year, month, day].join('-');
	}
	
	function leftPad(value){
		if (Number(value) >= 10) {
			return value;
		}
		return "0" + value;
	}
</script>
</body>
