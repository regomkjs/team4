<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>등급 관리</title>
</head>
<body>
<div class="container">
	<table>
		<thead>
			<tr>
				<th>등급명</th>
				<th>할인율</th>
				<th>대출조건</th>
				<th>게시글조건</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${gradeList}" var="grade" begin="1" end="5">
				<tr class="grade-list">
					<td class="col-2 grade-item">${grade.gr_name }</td>
					<td class="col-2 grade-item">${grade.gr_discount }%</td>
					<td class="col-2 grade-item">${grade.gr_loan_condition }개</td>
					<td class="col-2 grade-item">${grade.gr_post_condition }개</td>
					<td class="col-4">
						<div class="btn-category-group">
							<a href="<c:url value="/grade/update?num=${grade.gr_num}"/>" class="btn btn-outline-warning btn-update">수정</a>
						</div>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<a href="<c:url value="/grade/insert"/>" class="btn btn-outline-success">등급 추가</a>
</div>
</body>
<script type="text/javascript">
	
</script>
</html>