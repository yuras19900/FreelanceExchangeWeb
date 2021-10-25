<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html>
<head>
    <meta charset="utf-8">
    <title><spring:message code="newOrder.creating.title"/></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</head>
<body>
<jsp:include page="../navbar.jsp" />
<div class="container" style="background-color: #c4f2ce; padding: 10px; border-radius: 10px">
    <form:form method="post" modelAttribute="orderForm" action="/new-order">
        <h2><spring:message code="newOrder.creating"/></h2>
        <div>
            <p><spring:message code="order.name"/>:</p>
            <form:input type="text" path="name" required="true"
                        autofocus="true" cssStyle="width: 500px; border-radius: 5px"></form:input>
        </div>
        <br>
        <div>
            <p title="Тег позволяет исполнителю быстрее найти тематический заказ"><spring:message code="order.tag"/>:</p>
            <form:input type="text" path="tag" cssStyle="width: 500px; border-radius: 5px"></form:input>
        </div>
        <br>
        <div>
            <p><spring:message code="newOrder.description"/></p>
            <form:input type="text" path="description" required="true"
                        cssStyle="width: 80%; height: 40px; border-radius: 5px; box-sizing: border-box; padding-top: 1px; padding-left: 10px; line-height: 1em; text-align: top" ></form:input>
        </div>
        <br>
        <button type="submit"><spring:message code="newOrder.leave.submit"/></button>
    </form:form>
</div>

</body>
</html>
