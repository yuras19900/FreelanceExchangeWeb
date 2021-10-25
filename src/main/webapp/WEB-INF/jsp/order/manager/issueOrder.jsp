<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <meta charset="utf-8">
    <title><spring:message code="issueOrder.title"/></title>
</head>
<body>
<div class="container-fluid" style="background-color: aliceblue; height: 100vh;">
    <jsp:include page="../../navbar.jsp"/>
    <div class="container" style="background-color: #c4f2ce; padding: 10px; border-radius: 10px">
        <p>№: ${issueOrder.id} ${issueOrder.name} ${issueOrder.dateTime}</p>
        <p>${issueOrder.description}</p>
        <p><spring:message code="issueOrder.accepted.proposal"/>:</p>
        <p>${acceptedProposal.dateTime}</p>
        <p>${acceptedProposal.description}</p>
        <p>${acceptedProposal.cost} BYN</p>
        <p><spring:message code="issueOrder.results"/>:</p>
        <c:forEach var="result" items="${results}">
            ${result.description}
            <a href="/download${result.filename}" download><spring:message code="order.ready.download"/></a>
        </c:forEach>
        <p><spring:message code="issueOrder.complaint"/>:</p>
        <c:forEach var="report" items="${reports}">
            ${report.description}
        </c:forEach>
        <c:if test="${issueOrder.issue == true}">
            <p><spring:message code="issueOrder.decision"/></p>
            <form:form method="post" modelAttribute="answerForm" action="send-for-revision">
                <form:input type="text" path="description" required="true"></form:input>
                <input type="number" name="orderId" hidden value="${issueOrder.id}">
                <button type="submit"><spring:message code="issueOrder.decision.rework"/></button>
                <button type="submit" formaction="close-customer"><spring:message
                        code="issueOrder.decision.user"/>
                </button>
                <button type="submit" formaction="close-employee"><spring:message
                        code="issueOrder.decision.employee"/>
                </button>
            </form:form>
            <form:form method="post" action="closeEmployee">
            </form:form>
        </c:if>
        <c:if test="${issueOrder.closed == false}">
        <form action="/manager/lock" method="post">
            <input type="number" name="orderId" hidden value="${issueOrder.id}">
            <button type="submit">
                <c:if test="${issueOrder.locked == true}"><spring:message code="order.user.unlock"/></c:if>
                <c:if test="${issueOrder.locked == false}"><spring:message code="order.user.lock"/></c:if>
            </button>
        </form>
        </c:if>
    </div>
</div>
</body>
</html>
