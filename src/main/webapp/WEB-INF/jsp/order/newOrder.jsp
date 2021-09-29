<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Создание заказа</title>
</head>
<body>
<div>
    <form:form method="post" modelAttribute="orderForm" action="/newOrder">
        <h2>Создание нового заказа</h2>
        <div>
            <form:input type="text" path="name" placeholder="Название заказа"
                        autofocus="true"></form:input>
        </div>
        <div>
            <form:input type="text" path="tag" placeholder="Выберите тематику заказа(необязательно)"></form:input>
        </div>
        <div>
            <form:input type="text" path="description"
                        placeholder="Описание заказа"></form:input>
            ${requiredFieldError}
        </div>

        <button type="submit">Оставить заказ</button>
    </form:form>
    <a href="/">На главную</a>
</div>
</body>
</html>
