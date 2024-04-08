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
  <div class="modal fade" id="myModal">
    <div class="modal-dialog">
      <div class="modal-content">
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">도서 추가</h4>
          <button type="button" class="close" data-dismiss="modal">×</button>
        </div>
        <!-- Modal body -->
        <div class="modal-body">
          몸통
        </div>
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  
</div>
<script type="text/javascript">
	$(".test").click(function() {
		$.ajax({
			async : true,
			url : "https://dapi.kakao.com/v3/search/book", 
			//url:"/BookAPI",
			type : "get", 
			data :{query:"미움받을 용기",size:1}, 
			headers: { "Authorization":"KakaoAK ${api}" },
			dataType :"json", 
			success : function (data){
				console.log(data);
				let str="";
				str+=`
				<div class="form-group">
					<label>도서명</label>
					<input type="text" class="form-control" readonly
					value="\${data.title}">
					<label>내용</label>
					<input type="text" class="form-control" readonly
					value="\${data.contents}">
					<label>출판사</label>
					<input type="text" class="form-control" readonly
					value="\${data.publisher}">
				</div>
				`;
				$(".modal-body").html(str);
			}, 
			error : function(jqXHR, textStatus, errorThrown){

			}
		});
	})
</script>
</body>
