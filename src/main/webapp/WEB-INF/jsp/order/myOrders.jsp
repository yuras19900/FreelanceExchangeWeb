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
        <td><a href="/new-order">Новый заказ</a></td>
    </tr>
</table>
<p>Активные заказы</p>
<c:forEach var="activeOrder" items="${activeOrders}">
    <p>${activeOrder.name}</p>
    <p>Статус заказа:
      <c:if test="${activeOrder.vacant == false}">
            <c:if test="${activeOrder.ready == false}">

            </c:if>

    </c:if></p>
    <a href="/order${activeOrder.id}">Просмотр заказа</a>
</c:forEach>
<p>Выполненные заказы</p>
<c:forEach var="closedOrder" items="${closedOrders}">
    <p>${closedOrder.name}</p>
    <p>Статус заказа:
        <c:if test="${closedOrder.vacant == false}">
            <c:if test="${closedOrder.ready == false}">

            </c:if>

        </c:if></p>
    <a href="/order${closedOrder.id}">Просмотр заказа</a>
</c:forEach>
</body>
</html>
