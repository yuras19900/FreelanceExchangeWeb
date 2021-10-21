<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Рассмотр жалобы</title>
</head>
<body>
<p>№: ${issueOrder.id} ${issueOrder.name} ${issueOrder.dateTime}</p>
<p>${issueOrder.description}</p>
<p>Принятое предложение:</p>
<p>${acceptedProposal.description}</p>
<p>${acceptedProposal.cost} BYN</p>
<p>Результаты выполнения:</p>
<c:forEach var="result" items="${results}">
    ${result.description}
    <a href="/download${result.filename}" download>Скачать результат</a>
</c:forEach>
<p>Жалобы:</p>
<c:forEach var="report" items="${reports}">
    ${report.description}
</c:forEach>
<c:if test="${issueOrder.issue == true}">
<p>Примите решение по заказу</p>
<form:form method="post" modelAttribute="answerForm"  action="send-for-revision${issueOrder.id}">
    <form:input type="text" path="description" required="true"
                placeholder="Опишите ваше решение"></form:input>
    <button type="submit">Отправить на доработку</button>
    <button type="submit" formaction="close-customer${issueOrder.id}">Закрыть в пользу заказчика</button>
    <button type="submit" formaction="close-employee${issueOrder.id}">Закрыть в пользу исполнителя</button>
</form:form>
<form:form method="post" action="closeEmployee">
</form:form>
</c:if>
</body>
</html>
