<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

</body>
</html>
