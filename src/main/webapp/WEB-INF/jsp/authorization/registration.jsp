<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Регистрация</title>
</head>
<body>
<div>
<form:form method="post" modelAttribute="userForm">
    <h2>Регистрация нового пользователя</h2>
    <div>
        <form:input type="text" path="username" placeholder="Логин"
                    autofocus="true"></form:input>
        <form:errors path="username"></form:errors>
            ${usernameError}
    </div>
    <div>
        <form:input type="password" path="password" placeholder="Пароль"></form:input>
    </div>
    <div>
        <form:input type="password" path="passwordConfirm"
                    placeholder="Подтвердите пароль"></form:input>
        <form:errors path="password"></form:errors>
            ${passwordError}
    </div>
    <div>
        <input type="radio" id="user" name="role" value="ROLE_USER" checked>
        <label for="user">Заказчик</label>
    </div>
    <div>
        <input type="radio" id="employee" name="role" value="ROLE_EMPLOYEE">
        <label for="employee">Исполнитель</label>
    </div>
    <button type="submit">Зарегистрироваться</button>
</form:form>
    <a href="/">На главную</a>
</div>
</body>
</html>
