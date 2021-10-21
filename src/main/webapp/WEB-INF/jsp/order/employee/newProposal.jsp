<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <meta charset="utf-8">
    <title>Просмотр заказа №${order.id}</title>
</head>
<body>
<h2>Заказ №${order.id}</h2>
<p>Название заказа</p>
${order.name} ${order.dateTime}
<p>Описание заказа</p>
${order.description}
<p>Тег заказа</p>
${order.tag}
<div>
    <c:forEach var="myProposal" items="${myProposals}">
        ${myProposal.dateTime}
        ${myProposal.description}
        ${myProposal.cost} BYN
        <c:if test="${myProposal.declined == true}">Заявка отклонена</c:if><br>
    </c:forEach>
</div>
<div>
    <form:form method="post" modelAttribute="proposalForm" action="/employee/new-proposal${order.id}">
    <h2>Создание заявки на выполнение заказа</h2>
    <div>
        <form:input type="text" path="description" placeholder="Описание вашего предложения" required="true"
                    autofocus="true"></form:input>
    </div>
    <div>
        <form:input type="text" path="cost" required="true" placeholder="Введите сумму за выполенение заказа" pattern="[0-9]{1,5}"></form:input> BYN
    </div>

    <button type="submit">Отправить заявку</button>
    <a href="/employee/vacant-orders">Вернуться к поиску заказа</a>
    </form:form>
</div>
</body>
</html>
