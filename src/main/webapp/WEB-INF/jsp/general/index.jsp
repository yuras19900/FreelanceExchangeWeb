<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<body>
<h2>Main page</h2>
<sec:authorize access="isAnonymous()">
    Чтобы иметь доступ ко всему функционалу <a href="/login">войдите</a> в систему.
</sec:authorize>
<sec:authorize access="isAuthenticated()">
    <a href="aboutUs">About us</a>
</sec:authorize>
<br>

<a href="/test">Тестовая страница</a>
<sec:authorize access="isAuthenticated()">
    <form action="/logout" method="post">
        <input type="submit" value="Sign Out"/>
    </form>
</sec:authorize>

</body>
</html>
