<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <title>Title</title>
</head>
<body>
<div class="container-fluid">
    <nav class="navbar navbar-expand-lg navbar-light sticky-top"
         style="justify-content: space-between; background-color: green; border-radius: 10px">
        <ul class="navbar-nav">
            <li class="navbar-brand">
                <a href="/" class="navbar-brad"><img src="/img/logo.png"></a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="/"><spring:message code="navbar.main"/><span class="sr-only">(current)</span></a>
            </li>
            <sec:authorize access="isAnonymous()">
                <li class="nav-item">
                    <a class="nav-link disabled" href="/my-orders"><spring:message code="navbar.section.one.user"/></a>
                </li>
            </sec:authorize>
            <sec:authorize access="hasRole('USER')">
                <li class="nav-item">
                    <a class="nav-link active" href="/my-orders"><spring:message code="navbar.section.one.user"/></a>
                </li>
            </sec:authorize>
            <sec:authorize access="hasRole('EMPLOYEE')">
                <li class="nav-item">
                    <a class="nav-link" href="/employee/vacant-orders"><spring:message
                            code="navbar.section.one.employee"/></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/employee/my-active-orders"><spring:message
                            code="navbar.section.two.employee"/></a>
                </li>
            </sec:authorize>
            <sec:authorize access="hasRole('MANAGER')">
                <li class="nav-item">
                    <a class="nav-link active" href="/manager/issue-orders"><spring:message
                            code="navbar.section.one.manager"/></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="/manager/view-orders"><spring:message
                            code="navbar.section.two.manager"/></a>
                </li>
            </sec:authorize>
            <sec:authorize access="hasRole('ADMIN')">
                <li class="nav-item">
                    <a class="nav-link" href="/admin/add-manager"><spring:message
                            code="navbar.section.two.admin"/></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/admin/all-users"><spring:message
                            code="navbar.section.one.admin"/></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/manager/issue-orders"><spring:message
                            code="navbar.section.one.manager"/></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="/manager/view-orders"><spring:message
                            code="navbar.section.two.manager"/></a>
                </li>
            </sec:authorize>
            <li class="nav-item active">
                <a class="nav-link" href="/about-us"><spring:message code="navbar.aboutus"/></a>
            </li>
        </ul>
        <ul class="navbar-nav">
            <li class="nav-item active" style="margin-right: 10px">
                <sec:authorize access="isAnonymous()">
                    <form action="/login" method="get">
                        <button class="btn btn-outline-success" type="submit"><spring:message
                                code="navbar.login"/></button>
                    </form>
                </sec:authorize>
                <sec:authorize access="isAuthenticated()">
                    <form action="/logout" method="post">
                        <button class="btn btn-outline-success" type="submit"><spring:message
                                code="navbar.logout"/></button>
                    </form>
                </sec:authorize>
            </li>
            <li class="nav-item active" style="margin-right: 10px">
                <a href="?lang=en"><img src="/img/great-britain.png" alt="English" height="40"
                                        width="40"></a>
            </li>
            <li class="nav-item active">
                <a href="?lang=ru"><img src="/img/russian-federation.png" alt="Русский" height="40"
                                        width="40"></a>
            </li>
        </ul>
    </nav>
</div>
</body>
</html>
