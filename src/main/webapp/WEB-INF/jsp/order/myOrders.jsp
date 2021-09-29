<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Мои заказы</title>
</head>
<body>
<table style="width:100%">
    <tr>
        <td><a href="/newOrder">Новый заказ</a></td>
    </tr>
</table>

<c:forEach var="order" items="${orders}">
    <p>${order.name}</p>
    <a href="/order${order.id}">Просмотр заказа</a>
</c:forEach>
</body>
</html>
