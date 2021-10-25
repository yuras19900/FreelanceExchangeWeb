<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <meta charset="utf-8">
    <title><spring:message code="viewOrders.title"/></title>
</head>
<body>
<div class="container-fluid" style="background-color: aliceblue; height: 100vh;">
    <jsp:include page="../../navbar.jsp"/>
    <div class="container" style="background-color: #c4f2ce; padding: 10px; border-radius: 10px">
        <h2><spring:message code="viewOrders.title"/></h2>
        <c:forEach items="${orders}" var="order">
            <div style="border: 1px solid black; border-radius: 10px; padding: 10px">
                    ${order.name} ${order.dateTime}<br>
                <p>
                        <spring:message code="myOrders.order.status"/>
                    <c:choose>

                    <c:when test="${order.closed == true}">
                <div style="border-radius: 5px; border: 1px solid black; width: max-content; padding: 10px; background-color: darkgray">
                    <spring:message code="order.status.closed"/>
                </div>
                </c:when>

                <c:when test="${order.locked == true}">
                    <div style="border-radius: 5px; border: 1px solid black; width: max-content; padding: 10px; background-color: red">
                        <spring:message code="order.status.blocked"/>
                    </div>
                </c:when>
                <c:when test="${order.issue == true}">
                    <div style="border-radius: 5px; border: 1px solid black; width: max-content; padding: 10px; background-color: palevioletred">
                        <spring:message code="order.status.issue"/>
                    </div>
                </c:when>
                <c:when test="${order.vacant == true}">
                    <div style="border-radius: 5px; border: 1px solid black; width: max-content; padding: 10px; background-color: yellow">
                        <spring:message code="order.status.vacant"/>
                    </div>
                </c:when>
                <c:when test="${order.vacant == false}">
                    <c:choose>
                        <c:when test="${order.paid == true}">
                            <c:choose>
                                <c:when test="${order.ready == false}">
                                    <div style="border-radius: 5px; border: 1px solid black; width: max-content; padding: 10px; background-color: coral">
                                        <spring:message code="order.status.rework"/>
                                    </div>
                                </c:when>
                                <c:when test="${order.ready == true}">
                                    <div style="border-radius: 5px; border: 1px solid black; width: max-content; padding: 10px; background-color: green">
                                        <spring:message code="order.status.paid"/>
                                    </div>
                                </c:when>
                            </c:choose>
                        </c:when>
                        <c:when test="${order.ready == true}">
                            <div style="border-radius: 5px; border: 1px solid black; width: max-content; padding: 10px; background-color: lightgreen">
                                <spring:message code="order.status.ready"/>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div style="border-radius: 5px; border: 1px solid black; width: max-content; padding: 10px; background-color: lightskyblue">
                                <spring:message code="order.status.work"/>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                </c:choose>
                </p>
                <p><a href="/manager/issue-order${order.id}"><spring:message
                        code="myOrders.order.view"/></a></p>
            </div>
            <br>
        </c:forEach>
    </div>
</div>
</body>
</html>
