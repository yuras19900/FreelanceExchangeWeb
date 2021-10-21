<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Работа с заказом №${order.id}</title>
</head>
<body>
<p>Заказчик: ${order.user.username}</p>
<p>Название заказа: ${order.name} ${order.dateTime}</p>
<p>Описание заказа: ${order.description}</p>
<p>Стоимость заказа: ${proposal.cost}BYN</p>

    <c:forEach var="result" items="${results}">
        <p>${result.dateTime}</p>
        <p>${result.description}</p>
        <a href="/download${order.id}">Скачать файл</a>
    </c:forEach>
<c:if test="${order.ready == false}">
<div>
    <form:form method="post" modelAttribute="resultForm" action="/employee/add-result${order.id}" enctype="multipart/form-data">
        <h2>Отправка результата</h2>
        <div>
            <form:input type="text" path="description" required="true" placeholder="Описание итоговой работы"
                        autofocus="true"></form:input>
        </div>
        <div>
            <input type="file" name="file" required>
        </div>
        <button type="submit">Отправить результат</button>
    </form:form>
    ${emptyFileError}
</div>
</c:if>
<c:if test="${order.issue == true}">
    <p>На результаты выполнения вашего заказа была отправлена жалоба. Ожидайте, менеджер рассмотрит жалобу и примет решение.</p>
</c:if>
<c:forEach var="anwser" items="${answers}">
    <p>Решение по жалобе</p>
    <p>${anwser.dateTime}</p>
    <p>${anwser.description}</p>
</c:forEach>
</body>
</html>
