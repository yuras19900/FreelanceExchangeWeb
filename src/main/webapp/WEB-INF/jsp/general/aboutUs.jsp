<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
    <meta charset="utf-8">
    <title><spring:message code="navbar.aboutus"/></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</head>
<body>
<jsp:include page="../navbar.jsp"/>
<div class="container-fluid" style="background-color: aliceblue; height: 100vh">
    <div class="container" style="background-color: #c4f2ce; height: 100vh; border-radius: 10px">
        <div class="container" style="padding: 10px">
        <p style="font-size: 22px"><spring:message code="about.us"/> </p>
        <p style="font-size: 22px">Viber: +375-44-xxx-xx-xx</p>
        <p style="font-size: 22px">Telegram: +375-44-xxx-xx-xx</p>
        <p style="font-size: 22px">Instagram: @FreelanceExchange</p>
        </div>
    </div>
</div>

</body>
</html>
