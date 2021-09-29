<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Свободные заказы</title>
</head>
<body>
<c:forEach var="order" items="${vacantOrders}">
    <p>${order.name}</p>
    <p>${order.description}</p>
    <p>${order.tag}</p>
    <a href="/employee/newProposal${order.id}">Просмотреть заказ</a>
</c:forEach>
</body>
</html>
