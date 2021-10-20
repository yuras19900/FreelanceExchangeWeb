<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
        <form method="post" action="accept-proposal${proposal.id}for${order.id}">
            <button type="submit">Принять заявку и внести предоплату</button>
        </form>
    </c:forEach>
</c:if>
<c:if test="${order.vacant == false}">
    <c:if test="${order.ready == false}">
        <h3>Предоплата внесена, исполнитель работает с заказом</h3>
        <p>Информация о заявке:</p>
        <p>Цена:${acceptedProposal.cost}</p>
        <p>Описание:${acceptedProposal.description}</p>
    </c:if>
    <c:if test="${order.ready == true}">
        <c:if test="${order.paid == false}">
            <p> Заказ выполнен. Для получения доступа к файлу, оплатите оставшуюся часть заказа</p>
            <form method="post" action="payOrder${order.id}">
                <button type="submit">Оплатить</button>
            </form>
        </c:if>
    </c:if>
    <c:if test="${order.paid == true}">
        <p>Заказ выполнен.</p>
        <c:forEach var="result" items="${results}">
            <p>Описание: ${result.description}
            <p><a href="/download${result.filename}" download>Скачать</a></p>
        </c:forEach>

        <c:if test="${order.closed == false}">
        <c:if test="${order.issue == false}">
            <p>Если вы удовлетворены выполнением заказа, и результат соответсвует ранее обговоренным требованиям,
                нажмите клавишу "Закрыть заказ".</p>
            <form method="post" action="/close-order${order.id}">
                <button type="submit">Закрыть заказ</button>
            </form>
            <p>Если выполненный заказ не соответствует заявленным требованиям, вы в праве оставить жалобу, заполнив
                форму, которая находится снизу.</p>
            <div>
                <form:form method="post" modelAttribute="reportForm" action="/new-report${order.id}">
                    <p>Жалоба на выполненный заказ</p>
                    <div>
                        <form:input type="text" path="description" required="true"
                                    placeholder="Описание жалобы"></form:input>
                    </div>
                    <button type="submit">Оставить жалобу</button>
                </form:form>
            </div>
        </c:if>
        </c:if>
        <c:if test="${order.issue == true}">Жалоба успешно отправлена, ожидайте, в скором времени наши менеджеры рассмотрят ваш заказ и примут по нему решение.</c:if>
    </c:if>
</c:if>
<c:forEach var="anwser" items="${answers}">
    <p>Решение по жалобе</p>
    ${anwser.description}
</c:forEach>
<c:if test="${order.closed == true}">
    <p>Ваш заказ выполнен. Если у вас какие-то вопросы по поводу заказа, свяжитесь с нашими менеджерами. Спасибо, что воспользовались нашими услугами!</p>
</c:if>

</body>
</html>
