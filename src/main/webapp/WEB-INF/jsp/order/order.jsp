<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <title><spring:message code="order.browse.title"/> №${order.id}</title>
</head>
<body>
<jsp:include page="../navbar.jsp"/>
<div class="container" style="background-color: #c4f2ce; border-radius: 10px; padding: 10px">
    <c:if test="${order.locked == false}">
        <h2><spring:message code="order.number"/>${order.id}</h2>
        <p><spring:message code="order.name"/>:<br> ${order.name} ${order.dateTime}</p>
        <p><spring:message code="order.description"/>:<br> ${order.description}</p>
        <p><spring:message code="order.tag"/>:<br> ${order.tag}</p>

        <c:if test="${order.vacant == true}">
            <h3><spring:message code="order.proposals"/></h3>
            <c:if test="${proposals == null}">
                <p><spring:message code="order.no.proposals"/></p>
            </c:if>
            <c:forEach var="proposal" items="${proposals}">
                <p>${proposal.dateTime}</p>
                <p><spring:message code="order.proposal.sender"/>${proposal.user.username}</p>
                <p><spring:message code="order.proposal.description"/>${proposal.description}</p>
                <p><spring:message code="order.proposal.cost"/>: ${proposal.cost} BYN</p>
                <form method="post" action="accept-proposal">
                    <input type="number" name="orderId" hidden  value="${order.id}">
                    <input type="number" name="proposalId" hidden  value="${proposal.id}">
                    <button type="submit"><spring:message code="order.proposal.accept.href"/></button>
                </form>
            </c:forEach>
        </c:if>
        <c:if test="${order.vacant == false}">
            <c:if test="${order.ready == false}">
                <h3><spring:message code="order.proposal.accepted"/></h3>
                <p><spring:message code="order.proposal.info"/></p>
                <p><spring:message code="order.proposal.info.price"/>${acceptedProposal.cost}</p>
                <p><spring:message code="order.proposal.info.description"/>${acceptedProposal.description}</p>
            </c:if>
            <c:if test="${order.ready == true}">
                <c:if test="${order.paid == false}">
                    <p><spring:message code="order.ready.pay"/></p>
                    <form method="post" action="payOrder">
                        <input type="number" name="orderId" hidden  value="${order.id}">
                        <button type="submit"><spring:message code="order.pay.submit"/></button>
                    </form>
                </c:if>
            </c:if>
            <c:if test="${order.paid == true}">
                <p><spring:message code="order.ready"/></p>
                <c:forEach var="result" items="${results}">
                    <div style="border-radius: 5px; border: 1px solid black; padding: 10px">
                        <p>${result.dateTime}</p>
                        <p><spring:message code="order.ready.description"/>${result.description}</p>
                        <p><a href="/download/${result.filename}" download><spring:message
                                code="order.ready.download"/></a>
                        </p>
                    </div>
                    <br>
                </c:forEach>

                <c:if test="${order.closed == false}">
                    <c:if test="${order.issue == false}">
                        <c:if test="${order.ready == true}">
                            <p><spring:message code="order.satisfied"/></p>
                            <form method="post" action="close-order">
                                <input type="number" name="orderId" hidden  value="${order.id}">
                                <button type="submit"><spring:message code="order.satisfied.close.submit"/></button>
                            </form>
                            <p><spring:message code="order.not.satisfied"/></p>
                            <div>
                                <form:form method="post" modelAttribute="reportForm" action="new-report">
                                    <p><spring:message code="order.not.satisfied.complaint"/></p>
                                    <div>
                                        <input type="number" name="orderId" hidden  value="${order.id}">
                                        <form:input type="text" path="description" required="true"
                                                    placeholder="Описание жалобы"></form:input>
                                    </div>
                                    <button type="submit"><spring:message
                                            code="order.not.satisfied.complaint.submit"/></button>
                                </form:form>
                            </div>
                        </c:if>
                    </c:if>
                </c:if>
                <c:if test="${order.issue == true}"><spring:message code="order.complaint.succesfull"/></c:if>
            </c:if>
        </c:if>
        <c:forEach var="anwser" items="${answers}">
            <div style="border-radius: 5px; border: 1px solid black; padding: 10px">
                <p><spring:message code="order.complaint.anwser"/></p>
                    ${anwser.dateTime}
                    ${anwser.description}
            </div>
            <br>
        </c:forEach>
        <c:if test="${order.closed == true}">
            <p><spring:message code="order.closed"/></p>
        </c:if>
    </c:if>
    <c:if test="${order.locked==true}"><h2>Заказ заблокирован. Обратитесь к администрации</h2></c:if>
</div>
</body>
</html>
