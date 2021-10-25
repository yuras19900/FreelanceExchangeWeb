<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <meta charset="utf-8">
    <title><spring:message code="registration.title"/></title>
</head>
<body>
<jsp:include page="../navbar.jsp" />
<div class="container-fluid" style="background-color: aliceblue; height: 100vh">
    <div class="container" style="background-color: #c4f2ce; height: 100vh; border-radius: 10px">
        <form:form method="post" modelAttribute="userForm">
            <h2><spring:message code="registration.title"/></h2>
            <div><p><spring:message code="login.login"/>:</p>
                <form:input type="text" path="username" autofocus="true" cssStyle="border-radius: 5px"></form:input>
                <form:errors path="username"></form:errors>
                    ${usernameError}
            </div>
            <div><p><spring:message code="login.password"/>:</p>
                <form:input type="password" path="password" cssStyle="border-radius: 5px"></form:input>
            </div>
            <div>
                <p><spring:message code="registration.repeat.password"/>:</p>
                <form:input type="password" path="passwordConfirm" cssStyle="border-radius: 5px"></form:input>
                <form:errors path="password"></form:errors>
                    ${passwordError}
            </div>
            <div>
                <input type="radio" id="user" name="role" value="ROLE_USER" checked>
                <label for="user"><spring:message code="registration.user"/></label>
            </div>
            <div>
                <input type="radio" id="employee" name="role" value="ROLE_EMPLOYEE">
                <label for="employee"><spring:message code="registration.employee"/></label>
            </div>
            <button type="submit" style="border-radius: 5px"><spring:message code="login.registration"/></button>
        </form:form>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
        integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
        crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>
</body>
</html>
