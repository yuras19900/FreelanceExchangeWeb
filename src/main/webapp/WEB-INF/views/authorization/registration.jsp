<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Регистрация нового пользователя</title>
</head>
<body>
New User Registration
<form action="/registration" method="post">
    <div><label> User Name : <input type="text" name="login"/> </label></div>
    <div><label> Password: <input type="password" name="password"/> </label></div>
    <div><input type="submit" value="Зарегистрироваться"/></div>
</form>
<h2>${message}</h2>
</body>
</html>
