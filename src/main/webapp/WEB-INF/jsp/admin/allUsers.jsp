<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <meta charset="utf-8">
    <title><spring:message code="allUsers.title"/></title>
</head>
<body>
<div class="container-fluid" style="background-color: aliceblue; height: 100vh;">
    <jsp:include page="../navbar.jsp"/>
    <div class="container" style="background-color: #c4f2ce; padding: 10px; border-radius: 10px">
        <h2><spring:message code="allUsers.title"/></h2>
        <c:forEach var="user" items="${users}">
            <p>id: ${user.id}. ${user.username} <c:if test="${user.active== true}"><spring:message code="user.active"/></c:if><c:if
                    test="${user.active == false}"><spring:message code="user.unactive"/></c:if></p>
            <form action="/admin/block" method="post">
                <input type="number" name="userId" hidden value="${user.id}">
                <button type="submit">
                    <c:if test="${user.active == true}"><spring:message code="order.user.lock"/></c:if>
                    <c:if test="${user.active == false}"><spring:message code="order.user.unlock"/></c:if>
                </button>
            </form>
        </c:forEach>
    </div>
</div>

</body>
</html>
