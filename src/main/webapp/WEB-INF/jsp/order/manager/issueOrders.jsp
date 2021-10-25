<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <meta charset="utf-8">
    <title><spring:message code="issueOrders.title"/></title>
</head>
<body>
<div class="container-fluid" style="background-color: aliceblue; height: 100vh;">
    <jsp:include page="../../navbar.jsp"/>
    <div class="container" style="background-color: #c4f2ce; padding: 10px; border-radius: 10px">
        <h2><spring:message
                code="issueOrders.complaint"/></h2>
        <c:forEach var="issueOrder" items="${issueOrders}">
            <div style="border: 1px solid black; border-radius: 10px; padding: 10px">
                <p>№ ${issueOrder.id} ${issueOrder.name} ${issueOrder.dateTime}</p>
                <p><a href="/manager/issue-order${issueOrder.id}"><spring:message
                        code="issueOrders.view.complaint"/></a></p>
            </div>
        </c:forEach>
    </div>
</div>

</body>
</html>
