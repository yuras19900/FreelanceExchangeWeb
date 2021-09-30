<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>Работа с заказом №${order.id}</title>
</head>
<body>
<p>Заказчик: ${order.user}</p>
<p>Название заказа: ${order.name}
</p>
<p>Описание заказа: ${order.description}
</p>
<p>Стоимость заказа: ${proposal.cost}
</p>
<c:if test="${order.ready == true}">
    <c:forEach var="result" items="${results}">

    </c:forEach>
</c:if>

<c:if test="${order.ready == false}">
<div>
    <form:form method="post" modelAttribute="resultForm" action="/employee/addResult${order.id}" enctype="multipart/form-data">
        <h2>Отправка результата</h2>
        <div>
            <form:input type="text" path="description" required="true" placeholder="Описание итоговой работы"
                        autofocus="true"></form:input>
        </div>
        <div>
            <input type="file" name="file" required>
        </div>
        <button type="submit">Отправить результат</button>
    </form:form>
    <h4>${emptyFileError}</h4>
</div>
</c:if>
</body>
</html>
