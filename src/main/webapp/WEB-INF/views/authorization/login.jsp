<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><html>
<head>
    <title>Вход в личный кабинет</title>
</head>
<body>
<p>Вход в личный кабинет</p>
<form action="/login" method="post">
    <div><label> Username : <input type="text" name="login"/> </label></div>
    <div><label> Password: <input type="password" name="password"/> </label></div>
    <div><input type="submit" value="Войти"/></div>
    <br>
    <a href="/registration">Зарегистрироваться</a>
</form>
</body>
</html>
