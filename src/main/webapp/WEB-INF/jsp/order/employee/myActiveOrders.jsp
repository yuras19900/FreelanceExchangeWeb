<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <meta charset="utf-8">
    <title><spring:message code="myOrders.active.orders"/></title>
</head>
<body>
<div class="container-fluid" style="background-color: aliceblue; height: 100vh;">
    <jsp:include page="../../navbar.jsp"/>
    <div class="container" style="background-color: #c4f2ce; padding: 10px; border-radius: 10px">
        <h3><spring:message code="myOrders.active.orders"/></h3>
        <c:forEach var="activeOrder" items="${activeOrders}">
            <div style="border: 1px solid black; border-radius: 10px; padding: 10px">
                <p>${activeOrder.name} ${activeOrder.dateTime}</p>
                <spring:message code="myOrders.order.status"/>
                <c:choose>
                    <c:when test="${activeOrder.issue == true}">
                        <div style="border-radius: 5px; border: 1px solid black; width: max-content; padding: 10px; background-color: palevioletred">
                            <spring:message code="order.status.issue"/>
                        </div>
                    </c:when>
                    <c:when test="${activeOrder.paid == true}">
                        <c:choose>
                            <c:when test="${activeOrder.ready == false}">
                                <div style="border-radius: 5px; border: 1px solid black; width: max-content; padding: 10px; background-color: coral">
                                    <spring:message code="order.status.rework"/>
                                </div>
                            </c:when>
                            <c:when test="${activeOrder.ready == true}">
                                <div style="border-radius: 5px; border: 1px solid black; width: max-content; padding: 10px; background-color: green">
                                    <spring:message code="order.status.paid"/>
                                </div>
                            </c:when>
                        </c:choose>
                    </c:when>
                    <c:when test="${activeOrder.ready == true}">
                        <div style="border-radius: 5px; border: 1px solid black; width: max-content; padding: 10px; background-color: lightgreen">
                            <spring:message code="order.status.ready"/>
                        </div>
                    </c:when>
                    <c:when test="${activeOrder.ready == false}">
                        <div style="border-radius: 5px; border: 1px solid black; width: max-content; padding: 10px; background-color: yellow">
                            <spring:message code="order.status.work"/>
                        </div>
                    </c:when>
                </c:choose>
                <a href="/employee/active-order${activeOrder.id}"><spring:message code="myOrders.order.view"/></a>
            </div>
            <br>
        </c:forEach>
        <h4><spring:message code="myOrders.finished.orders"/></h4>
        <c:forEach var="closedOrder" items="${closedOrders}">
            <div style="border: 1px solid black; border-radius: 10px; padding: 10px">
                <p>${closedOrder.name} ${closedOrder.dateTime}</p>
                <spring:message code="myOrders.order.status"/>
                <c:choose>
                    <c:when test="${closedOrder.locked == true}">
                        <div style="border-radius: 5px; border: 1px solid black; width: max-content; padding: 10px; background-color: red">
                            <spring:message code="order.status.blocked"/>
                        </div>
                    </c:when>
                    <c:when test="${closedOrder.closed == true}">
                        <div style="border-radius: 5px; border: 1px solid black; width: max-content; padding: 10px; background-color: darkgray">
                            <spring:message code="order.status.closed"/>
                        </div>
                    </c:when>
                </c:choose>
                <a href="/employee/active-order${closedOrder.id}"><spring:message code="myOrders.order.view"/></a>
            </div>
            <br>
        </c:forEach>
    </div>
</div>
</body>
</html>
