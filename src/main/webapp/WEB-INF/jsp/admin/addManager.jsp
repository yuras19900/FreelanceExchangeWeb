<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <meta charset="utf-8">
    <title><spring:message code="addManager.title"/></title>
</head>
<body>
<div class="container-fluid" style="background-color: aliceblue; height: 100vh;">
    <jsp:include page="../navbar.jsp"/>
    <div class="container" style="background-color: #c4f2ce; padding: 10px; border-radius: 10px">
<form:form method="post" modelAttribute="managerForm" action="/admin/add-manager">
    <h2><spring:message code="addManager.title"/></h2>
    <div>
        <spring:message code="login.login"/>:<br>
        <form:input type="text" path="username" required="true" autofocus="true" cssStyle="border-radius: 5px"></form:input>
        <form:errors path="username"></form:errors>
            ${managerUsernameError}
    </div>
    <div>
        <spring:message code="login.password"/>:<br>
        <form:input type="password" path="password" required="true" cssStyle="border-radius: 5px"></form:input>
    </div>
    <div>
        <spring:message code="registration.repeat.password"/>:<br>
        <form:input type="password" path="passwordConfirm" required="true" cssStyle="border-radius: 5px"></form:input>
        <form:errors path="password"></form:errors>
            ${managerPasswordError}
    </div><br>
    <button type="submit" style="border-radius: 5px"><spring:message code="addManager.submit"/></button>
</form:form>
    </div>
</div>
</body>
</html>
