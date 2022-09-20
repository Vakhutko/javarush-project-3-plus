<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 19804925
  Date: 11.09.2022
  Time: 17:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
<head>
    <title>User</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</head>
<body>
<div style="background-color: #8fb938; text-align: center; color: white">
    Health: ${sessionScope.user.getHealth()}/100
</div>
<div style="background-color: #d02122; text-align: center; color: white">
    Strength: ${sessionScope.user.getStrength()}
</div>
<div style="background-color: #0c49b6; text-align: center; color: white">
    Adroitness: ${sessionScope.user.getAdroitness()}
</div>
<h1>User info</h1>
<h2>User win: ${sessionScope.user.isWin()}</h2>
<h3>Username: <c:out value="${sessionScope.user.getUsername()}"/></h3>
<div>
    <button type="button" class="btn btn-success btn-lg" data-bs-toggle="modal"
            data-bs-target="#quests">Quests
    </button>
    <div class="modal fade" id="quests" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Quests:</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <ul>
                        <c:forEach items="${sessionScope.user.getQuests()}" var="quest">
                            <li>
                                <div>
                                    <p>Quest info: ${quest.getText()}</p>
                                    <p>Quest done: ${quest.isDone()}</p>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<div>
    <button type="button" class="btn btn-success btn-lg" data-bs-toggle="modal"
            data-bs-target="#items">Items
    </button>
    <div class="modal fade" id="items" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel1">Items:</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <ul>
                        <c:forEach items="${sessionScope.user.getItems()}" var="item">
                            <li>
                                <div>
                                    <p>Item info: ${item}</p>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<hr>
</html>
