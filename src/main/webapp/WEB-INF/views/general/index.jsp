<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<body>
<h2>Hello, world!</h2>
<a href="aboutUs">About us</a>

<a href="/test">Тестовая страница</a>

<form action="/logout" method="post">
    <input type="submit" value="Sign Out"/>
</form>
</body>
</html>
