<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <meta charset="utf-8">
    <title><spring:message code="forbidden.main"/></title>
</head>
<body>
<jsp:include page="../navbar.jsp" />
<div class="container" style="background-color: #c4f2ce;border-radius: 10px">
    <div class="container">
        <div class="container" style="padding: 10px">
<p style="font-size: 22px"><spring:message code="forbidden.main"/></p>
        </div>
    </div>
</div>

</body>
</html>
