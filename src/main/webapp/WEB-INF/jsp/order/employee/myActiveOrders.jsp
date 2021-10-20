<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Мои активные заказы</title>
</head>
<body>
<p>Активные заказы</p>
<c:forEach var="activeOrder" items="${activeOrders}">
    <p>${activeOrder.name}</p>
    <a href="/employee/active-order${activeOrder.id}">Просмотр заказа</a>
</c:forEach>

<p>Выполненные заказы</p>
<c:forEach var="closedOrder" items="${closedOrders}">
    <p>${closedOrder.name}</p>
    <a href="/employee/active-order${closedOrder.id}">Просмотр заказа</a>
</c:forEach>

</body>
</html>
