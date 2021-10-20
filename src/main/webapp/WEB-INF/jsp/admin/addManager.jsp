<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Регистрация менеджера</title>
</head>
<body>
<form:form method="post" modelAttribute="managerForm" action="/admin/add-manager">
    <h2>Регистрация нового пользователя</h2>
    <div>
        <form:input type="text" path="username" placeholder="Логин" required="true"
                    autofocus="true"></form:input>
        <form:errors path="username"></form:errors>
            ${managerUsernameError}
    </div>
    <div>
        <form:input type="password" path="password" placeholder="Пароль" required="true"></form:input>
    </div>
    <div>
        <form:input type="password" path="passwordConfirm"
                    placeholder="Подтвердите пароль" required="true"></form:input>
        <form:errors path="password"></form:errors>
            ${managerPasswordError}
    </div>
    <button type="submit">Зарегистрироваться</button>
</form:form>
</body>
</html>
