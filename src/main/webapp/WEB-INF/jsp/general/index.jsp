<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <meta charset="utf-8">
    <title>Главная</title>
</head>
<body>
<div class="container-fluid" style="background-color: aliceblue" >
    <jsp:include page="../navbar.jsp"/>
    <div class="container" style="background-color: #c4f2ce;border-radius: 10px">
        <br>
        <div class="container">
        <a href="/"><img src="/img/logo.png"></a>
        </div>
        <br>
        <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img class="d-block w-100" src="/img/photo1.jpg">
                </div>
                <div class="carousel-item">
                    <img class="d-block w-100" src="/img/photo2.jpg">
                </div>
                <div class="carousel-item">
                    <img class="d-block w-100" src="/img/photo3.jpg">
                </div>
            </div>
            <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
            <br>

            <p style="font-size: 18px"><spring:message code="welcome.main"/></p>

            <p style="font-size: 24px"> </b><spring:message code="welcome.user"/>:</p>
            <spring:message code="welcome.user.description"/><br>

            <p style="font-size: 24px"><spring:message code="welcome.employee"/>:</p>
                <spring:message code="welcome.employee.description"/><br>

            <p style="font-size: 24px"><spring:message code="welcome.manager"/>:</p>
                <spring:message code="welcome.manager.description"/><br>

            <p style="font-size: 24px"><spring:message code="welcome.admin"/>:</p>
                <spring:message code="welcome.admin.description"/>
        </div>
        <br>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </div>
</div>
<br>
</body>
</html>
