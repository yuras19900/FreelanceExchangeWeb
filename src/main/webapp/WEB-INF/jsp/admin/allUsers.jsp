<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Просмотр пользователей</title>
</head>
<body>
<p>Список всех пользователей</p>
<c:forEach var="user" items="${users}">
    <p>id: ${user.id}. ${user.username} ${user.active}
    <form action="/admin/block${user.id}" method="post">
        <button type="submit">
            <c:if test="${user.active == true}">Заблокировать</c:if>
            <c:if test="${user.active == false}">Разблокировать</c:if>
        </button>
    </form>
</c:forEach>

</body>
</html>
