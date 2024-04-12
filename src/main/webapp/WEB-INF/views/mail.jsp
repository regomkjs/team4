<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>문자 메시지 보내기</title>
    <meta charset="UTF-8">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <h2>문자 메시지 보내기</h2>
    <form id="smsForm" action="<c:url value="/mail"/>" method="post">
        <div>
            <label for="phone">수신 전화번호:</label>
            <input type="text" id="phone" name="phone" required>
        </div>
        <div>
            <label for="content">메시지 내용:</label>
            <textarea id="content" name="content" required></textarea>
        </div>
        <button type="submit">문자 보내기</button>
    </form>

    <script>
        $(document).ready(function() {
            $('#smsForm').on('submit', function(e) {
                e.preventDefault();

                var phone = $('#phone').val();
                var content = $('#content').val();

                $.ajax({
                    url: '<c:url value="/mail"/>',
                    type: 'POST',
                    data: {
                        phone: phone,
                        content: content
                    },
                    success: function(response) {
                        alert('문자 메시지가 성공적으로 전송되었습니다.');
                        $('#phone').val('');
                        $('#content').val('');
                    },
                    error: function(xhr, status, error) {
                        alert('문자 메시지 전송에 실패하였습니다: ' + error);
                    }
                });
            });
        });
    </script>
</body>
</html>