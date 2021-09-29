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
${order.name}
<p>Описание заказа</p>
${order.description}
<p>Тег заказа</p>
${order.tag}

<div>
    <form:form method="post" modelAttribute="proposalForm" action="/employee/newProposal${order.id}">
    <h2>Создание нового заказа</h2>
    <div>
        <form:input type="text" path="description" placeholder="Описание вашего предложения"
                    autofocus="true"></form:input>
    </div>
    <div>
        <form:input type="text" path="cost" placeholder="Введите сумму за выполенение заказа в BYN"></form:input>
    </div>

    <button type="submit">Отправить заявку</button>
    <a href="/employee/vacantOrders">Вернуться к поиску заказа</a>
    </form:form>
</body>
</html>
