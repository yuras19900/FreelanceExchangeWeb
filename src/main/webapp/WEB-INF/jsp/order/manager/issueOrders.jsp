<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <meta charset="utf-8">
    <title>Заказы с жалобами</title>
</head>
<body>
<h1>Заказы, на которые поступили жалобы</h1>
<c:forEach var="issueOrder" items="${issueOrders}">
    <p>Заказ № ${issueOrder.id} <a href=""></a>  Название: ${issueOrder.name} ${issueOrder.dateTime}</p>
    <p><a href="/manager/issue-order${issueOrder.id}">Просмотреть заказ</a> </p>
</c:forEach>

</body>
</html>
