<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 19804925
  Date: 17.09.2022
  Time: 18:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
<head>
    <title>Fight</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <link rel="canonical" href="https://getbootstrap.com/docs/4.0/components/buttons/">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</head>
<body>
<h1 style="text-align: center">Fighting</h1>
<div style="display: flex;
  justify-content: space-between;
  background-color: gray; margin-left: 10px; margin-right: 10px">
    <div style="width: 50%">
        <div style="width: calc(100%/3); float: left">
            <h2 style="text-align: center">${sessionScope.user.getUsername()}</h2>
            <p style="background-color: #8fb938; color: white; text-align: center">
                Health: ${sessionScope.user.getHealth()}/100</p>
            <p style="background-color: #c50808; color: white; text-align: center">
                Strength: ${sessionScope.user.getStrength()}</p>
            <p style="background-color: #19429d; color: white; text-align: center">
                Adroitness: ${sessionScope.user.getAdroitness()}</p>
            <c:forEach items="${sessionScope.user.getItems()}" var="item">
                <c:if test="${item.startsWith(\"Potion Health\")}">
                    <button type="button" class="w-auto btn btn-sm btn-primary">${item}</button>
                </c:if>
            </c:forEach>
        </div>
        <div style="width: calc(100%/3); float: left; text-align: center">
            <h5>Block</h5>
            <%--            <button type="button" class="button w-50 btn btn-sm btn-primary">Head</button>--%>
            <%--            <button type="button" class="w-50 btn btn-sm btn-primary" style="margin-top: 10px">Body</button>--%>
            <%--            <button type="button" class="w-50 btn btn-sm btn-primary" style="margin-top: 10px">Legs</button>--%>
            <div class="btn-group-vertical btn-group-toggle" data-toggle="buttons">
                <label class="btn btn-primary active">
                    <input type="radio" name="options" id="option1" autocomplete="off" checked> Head
                </label>
                <label class="btn btn-primary">
                    <input type="radio" name="options" id="option2" autocomplete="off"> Body
                </label>
                <label class="btn btn-primary">
                    <input type="radio" name="options" id="option3" autocomplete="off"> Legs
                </label>
            </div>
        </div>
        <div style="width: calc(100%/3); float: right; text-align: center">
            <h5>Attack</h5>
            <%--            <button type="button" class="w-50 btn btn-sm btn-primary">Head</button>--%>
            <%--            <button type="button" class="w-50 btn btn-sm btn-primary" style="margin-top: 10px">Body</button>--%>
            <%--            <button type="button" class="w-50 btn btn-sm btn-primary" style="margin-top: 10px">Legs</button>--%>
            <div class="btn-group-vertical btn-group-toggle" data-toggle="buttons">
                <label class="btn btn-primary active">
                    <input type="radio" name="options1" id="option4" autocomplete="off" checked> Head
                </label>
                <label class="btn btn-primary">
                    <input type="radio" name="options1" id="option5" autocomplete="off"> Body
                </label>
                <label class="btn btn-primary">
                    <input type="radio" name="options1" id="option6" autocomplete="off"> Legs
                </label>
            </div>
        </div>
    </div>
    <div style="width: 50%; text-align: center">
        <h2>${sessionScope.user.getOpponent().getName()}</h2>
        <div style="width: 50%; float: left">
            <img src="${sessionScope.user.getOpponent().getImg()}">
        </div>
        <div style="width: 50%; float: right">
            <p style="background-color: #8fb938; color: white; text-align: center">
                Health: ${sessionScope.user.getOpponent().getHealth()}/100</p>
            <p style="background-color: #c50808; color: white; text-align: center">
                Strength: ${sessionScope.user.getOpponent().getStrength()}</p>
            <p style="background-color: #19429d; color: white; text-align: center">
                Adroitness: ${sessionScope.user.getOpponent().getAdroitness()}</p>
        </div>
    </div>
</div>
<form action="${pageContext.request.contextPath}/hit" method="get">
    <div style="text-align: center">
        <button type="submit" class="w-auto btn btn-lg btn-primary" style="margin-top: 10px">Attack</button>
    </div>
</form>
</body>
</html>
