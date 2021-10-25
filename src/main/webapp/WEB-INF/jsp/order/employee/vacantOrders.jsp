<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <meta charset="utf-8">
    <title><spring:message code="vacantOrders.title"/></title>
</head>
<body>
<div class="container-fluid" style="background-color: aliceblue; height: 100vh;">
    <jsp:include page="../../navbar.jsp"/>
    <div class="container" style="background-color: #c4f2ce; padding: 10px; border-radius: 10px">
        <h3><spring:message code="vacantOrders.title"/></h3>
        <form method="post" action="/employee/filter">
            <input type="text" name="filter" placeholder="Поиск по тегу">
            <button type="submit" style="border-radius: 5px"><spring:message code="vacantOrders.find"/></button>
        </form>
        <c:forEach var="order" items="${vacantOrders}">
            <div style="border: 1px solid black; border-radius: 10px; padding: 10px">
                <p>${order.name} ${order.dateTime}</p>
                <p>${order.tag}</p>
                <a href="/employee/new-proposal${order.id}"><spring:message code="vacantOrders.view"/></a>
            </div>
            <br>
        </c:forEach>
    </div>
</div>
</body>
</html>
