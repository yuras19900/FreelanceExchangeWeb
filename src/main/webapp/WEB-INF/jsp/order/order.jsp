<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Просмотр заказа №${order.id}</title>
</head>
<body>
<h2>Заказ №${order.id}</h2>
<p>Название заказа</p>
${order.name}
<p>Описание заказа</p>
${order.description}
<p>Тег заказа</p>
${order.tag}
<br>
<c:if test="${order.vacant == true}">
    <h3>Заявки на выполнение</h3>
    <c:if test="${proposals == null}">
        <p>Заявки на выполнение отсутствуют, ожидайте</p>
    </c:if>
    <c:forEach var="proposal" items="${proposals}">
        <p>Отправитель:${proposal.user.username}</p>
        <p>Описание: ${proposal.description}</p>
        <p>Стоимость выполнения: ${proposal.cost} BYN</p>
        <form method="post" action="acceptProposal${proposal.id}for${order.id}">
            <button type="submit">Принять заявку и внести предоплату</button>
        </form>
    </c:forEach>
</c:if>
<c:if test="${order.vacant == false}">
    <h3>Предоплата внесена, исполнитель работает с заказом</h3>
    <p>Информация о заявке:</p>
    <p>Цена:${acceptedProposal.cost}</p>
    <p>Описание:${acceptedProposal.description}</p>
</c:if>

</body>
</html>
