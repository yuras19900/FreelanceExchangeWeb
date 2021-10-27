<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <meta charset="utf-8">
    <title><spring:message code="activeOrder.title"/>${order.id}</title>
</head>
<body>
<div class="container-fluid" style="background-color: aliceblue; height: 100vh;">
    <jsp:include page="../../navbar.jsp"/>
    <div class="container" style="background-color: #c4f2ce; padding: 10px; border-radius: 10px">
        <p><spring:message code="activeOrder.customer"/>${order.user.username}</p>
        <p><spring:message code="activeOrder.name"/>${order.name} ${order.dateTime}</p>
        <p><spring:message code="activeOrder.description"/>${order.description}</p>
        <p><spring:message code="activeOrder.price"/>${proposal.cost} BYN</p>

        <c:forEach var="result" items="${results}">
        <div style="border-radius: 5px; border: 1px solid black; padding: 10px">
            <p>${result.dateTime}<br>
                    ${result.description}</p>
            <a href="/download/${result.filename}"><spring:message code="order.ready.download"/></a>
        </div>
        <br>
        </c:forEach>
        <c:if test="${order.ready == false}">
        <div>
            <form:form method="post" modelAttribute="resultForm" action="/employee/add-result" enctype="multipart/form-data">
                <h2><spring:message code="activeOrder.send.result"/></h2>
                <div>
                    <form:input type="text" path="description" required="true" placeholder="Описание итоговой работы"
                                cssStyle="border-radius: 5px; width: 80%; height: 40px"
                                autofocus="true"></form:input>
                </div>
                <br>
                <div>
                    <input type="number" name="orderId" hidden value="${order.id}">
                    <input type="file" name="file" required>
                </div>
                <br>
                <button type="submit" style="border-radius: 5px"><spring:message
                        code="activeOrder.send.results"/></button>
            </form:form>
        </div>
        </c:if>
        <c:if test="${order.issue == true}">
        <p><spring:message code="activeOrder.issue"/></p>
        </c:if>
        <c:forEach var="anwser" items="${answers}">
        <div style="border-radius: 5px; border: 1px solid black; padding: 10px">
            <p><spring:message code="activeOrder.decision"/></p>
            <p>${anwser.dateTime}</p>
            <p>${anwser.description}</p>
        </div>
        </c:forEach>
</body>
</html>
