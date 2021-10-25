<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <meta charset="utf-8">
    <title><spring:message code="order.browse.title"/>${order.id}</title>
</head>
<body>
<div class="container-fluid" style="background-color: aliceblue; height: 100vh;">
    <jsp:include page="../../navbar.jsp"/>
    <div class="container" style="background-color: #c4f2ce; padding: 10px; border-radius: 10px">
        <h2><spring:message code="order.number"/>${order.id}</h2>
        <p><spring:message code="order.name"/>:<br>
            ${order.name} ${order.dateTime}</p>
        <p><spring:message code="order.description"/>:<br>
            ${order.description}</p>
        <p><spring:message code="order.tag"/>:<br>
            ${order.tag}</p>
        <div>
            <c:forEach var="myProposal" items="${myProposals}">
                ${myProposal.dateTime}
                ${myProposal.description}
                ${myProposal.cost} BYN
                <c:if test="${myProposal.declined == true}"><spring:message code="newProposal.declined"/></c:if><br>
            </c:forEach>
        </div>
        <div>
            <form:form method="post" modelAttribute="proposalForm" action="/employee/new-proposal">
                <h2><spring:message code="newProposal.create.proposal"/></h2>
                    <spring:message code="newProposal.description"/>:<br>
                    <input type="number" name="orderId" hidden  value="${order.id}">
                    <form:input type="text" path="description" required="true"
                                autofocus="true" cssStyle="border-radius: 5px; width: 80%; height: 40px"></form:input>
                </div>
                <div>
                    <spring:message code="newProposal.price"/>:<br>
                    <form:input type="text" path="cost" required="true" pattern="[0-9]{1,5}"
                                cssStyle="border-radius: 5px"></form:input> BYN
                </div>
                <br>
                <button type="submit" style="border-radius: 5px"><spring:message code="newProposal.send"/></button>
                <a href="/employee/vacant-orders"><spring:message code="newProposal.return"/></a>
            </form:form>
        </div>
    </div>
</div>
</body>
</html>
