<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Мои активные заказы</title>
</head>
<body>
<c:forEach var="order" items="${orders}">
    <p>${order.name}</p>
    <a href="/employee/activeOrder${order.id}">Просмотр заказа</a>
</c:forEach>

</body>
</html>
