<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<body>
<h2>Main page</h2>
<sec:authorize access="isAnonymous()">
    Чтобы иметь доступ ко всему функционалу <a href="/login">войдите</a> в систему.
</sec:authorize>

<sec:authorize access="hasRole('USER')">
    <a href="/my-orders">Мои заказы</a>
</sec:authorize>
<br>

<sec:authorize access="hasRole('EMPLOYEE')">
    <a href="/employee/vacant-orders">Свободные заказы</a>
    <a href="/employee/my-active-orders">Мои активные заказы</a>
</sec:authorize>

<sec:authorize access="hasRole('MANAGER')">
    <a href="/manager/issue-orders">Просмотр заказов с жалобами</a>
</sec:authorize>

<sec:authorize access="hasRole('ADMIN')">
    <a href="/admin/add-manager">Регистрация менеджера</a>
    <a href="/admin/all-users">Просмотр всех пользователей</a>
</sec:authorize>

<sec:authorize access="isAuthenticated()">
    <form action="/logout" method="post">
        <input type="submit" value="Sign Out"/>
    </form>
</sec:authorize>

<sec:authorize access="isAuthenticated()">
    <a href="/about-us">О нас</a>
</sec:authorize>
</body>
</html>
