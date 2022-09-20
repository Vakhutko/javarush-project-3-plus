<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 19804925
  Date: 11.09.2022
  Time: 17:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Room</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</head>
<body>
<%--<jsp:include page="user.jsp"/>--%>
<div style="display: flex;
  justify-content: space-between;
  background-color: #ffe14e; height: 100%; width: 100%">
    <div style="width: 25%; text-align: center">
        <div style="height: 10%; text-align: center">
            <h2>Statistic</h2>
        </div>
        <c:forEach items="${sessionScope.user.getRooms()}" var="rm">
            <c:if test="${rm.getName() == sessionScope.user.getCurrentRoom()}">
                <div style="background-color: #ffc107">
                    <h3>Characters on location</h3>
                    <c:forEach items="${rm.getNpcs()}" var="npc">
                        <!-- Button trigger modal -->
                        <div style="flex: fit-content">
                            <button type="button" class="btn btn-success btn-lg" data-bs-toggle="modal"
                                    data-bs-target="#${npc.getName().replace(' ', '_')}" style="margin-top: 10px">${npc.getName()}</button>
                        </div>

                        <!-- Modal -->
                        <div class="modal fade" id="${npc.getName().replace(' ', '_')}" tabindex="-1"
                             aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLabel">NPC dialog</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <img src="${npc.getImg()}">
                                        <br>
                                        Do you want talk with ${npc.getName()}?
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-primary" data-bs-toggle="modal"
                                                data-bs-target="#${npc.getName().replace(' ', '_')}_1">Talk
                                        </button>
                                        <form action="${pageContext.request.contextPath}/fight" method="get">
                                            <button type="submit" class="btn btn-warning" data-bs-dismiss="modal"
                                                    name="npc" value="${npc.getName()}">Fight
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Modal -->
                        <div class="modal fade" id="${npc.getName().replace(' ', '_')}_1" tabindex="-1"
                             aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLabel1">NPC dialog</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <img src="${npc.getImg()}">
                                        <br>
                                        Take quest or give an item to ${npc.getName()}?
                                    </div>
                                    <div class="modal-footer">
                                        <form action="${pageContext.request.contextPath}/add_quest" method="post">
                                            <button class="btn btn-primary" data-bs-dismiss="modal"
                                                    name="npc" value="${npc.getName()}" type="submit"
                                                    data-bs-toggle="modal"
                                                    data-bs-target="#${npc.getName().replace(' ', '_')}">Take quest
                                            </button>
                                        </form>
                                        <form action="${pageContext.request.contextPath}/pass_quest" method="post">
                                            <button class="btn btn-primary" data-bs-dismiss="modal"
                                                    name="npc" value="${npc.getName()}" type="submit"
                                                    data-bs-toggle="modal"
                                                    data-bs-target="#${npc.getName().replace(' ', '_')}">Give item
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
        </c:forEach>
    </div>
    <div style="width: 50%; text-align: center">
        <div style="height: 10%">
            <h2><c:out value="${sessionScope.user.getCurrentRoom()}"/></h2>
        </div>
        <div style="width: 100%">
            <c:forEach items="${sessionScope.user.getRooms()}" var="rm">
                <c:if test="${rm.getName() == sessionScope.user.getCurrentRoom()}">
                    <img src="${rm.getImg()}" width="100%" height="50%">
                </c:if>
            </c:forEach>
        </div>
        <c:forEach items="${sessionScope.user.getRooms()}" var="rm">
            <c:if test="${rm.getName() == sessionScope.user.getCurrentRoom()}">
                <c:forEach items="${rm.getNextRooms()}" var="rmm">
                    <c:if test="${sessionScope.user.getRooms().stream().filter(o -> o.getName() == rmm).findFirst().get().isOpen()}">
                        <form action="${pageContext.request.contextPath}/room" method="get">
                            <button class="w-auto btn btn-lg btn-primary" name="room" value="${rmm}"
                                    type="submit" style="margin-top: 10px">${rmm}</button>
                        </form>
                    </c:if>
                </c:forEach>
            </c:if>
        </c:forEach>
    </div>
    <div style="width: 25%; text-align: center">
        <div style="height: 10%">
            <p style="background-color: #8fb938; text-align: center; color: white; width: 70%; margin-left: 15%">
                Health: ${sessionScope.user.getHealth()}/100</p>
            <div>
                <div>
                    <button type="button" class="btn btn-success btn" data-bs-toggle="modal"
                            data-bs-target="#quests" style="float: left">Quests
                    </button>
                    <div class="modal fade" id="quests" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel2">Quests:</h5>
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
                    <button type="button" class="btn btn-success btn" data-bs-toggle="modal"
                            data-bs-target="#items" style="float: right">Items
                    </button>
                    <div class="modal fade" id="items" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel3">Items:</h5>
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
            </div>
        </div>
        <c:forEach items="${sessionScope.user.getRooms()}" var="rm">
            <c:if test="${rm.getName() == sessionScope.user.getCurrentRoom()}">
                <div style="background-color: #ffc107">
                    <h3>Items on location</h3>
                    <c:forEach items="${rm.getItems()}" var="item">
                        <div style="flex: fit-content">
                            <button type="button" class="btn btn-info" data-bs-toggle="modal"
                                    data-bs-target="#${item.replace(' ', '_')}" style="margin-top: 10px">${item}</button>
                        </div>
                        <!-- Modal -->
                        <div class="modal fade" id="${item.replace(' ', '_')}" role="dialog">
                            <div class="modal-dialog">
                                <!-- Modal content-->
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h4 class="modal-title">Modal Header</h4>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                aria-label="Close">
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <p>Do you need a ${item}?</p>
                                    </div>
                                    <div class="modal-footer">
                                        <form action="${pageContext.request.contextPath}/add_item" method="post">
                                            <button type="submit" class="btn btn-primary" data-bs-dismiss="modal"
                                                    data-bs-toggle="modal" data-bs-target="#${item.replace(' ', '_')}"
                                                    name="item"
                                                    value="${item}">Yes
                                            </button>
                                        </form>
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
        </c:forEach>
    </div>
    <%--    <h1>Current room: <c:out value="${sessionScope.user.getCurrentRoom()}"/></h1>--%>
    <%--    <h3>Go to:</h3>--%>
    <%--    <c:forEach items="${sessionScope.user.getRooms()}" var="rm">--%>
    <%--        <c:if test="${rm.getName() == sessionScope.user.getCurrentRoom()}">--%>
    <%--            <ul>--%>
    <%--                <c:forEach items="${rm.getNextRooms()}" var="rmm">--%>
    <%--                    <c:if test="${sessionScope.user.getRooms().stream().filter(o -> o.getName() == rmm).findFirst().get().isOpen()}">--%>
    <%--                        <li>--%>
    <%--                            <form action="${pageContext.request.contextPath}/room" method="get">--%>
    <%--                                <button class="w-auto btn btn-sm btn-primary" name="room" value="${rmm}"--%>
    <%--                                        type="submit">${rmm}</button>--%>
    <%--                            </form>--%>
    <%--                        </li>--%>
    <%--                    </c:if>--%>
    <%--&lt;%&ndash;                    <li>&ndash;%&gt;--%>
    <%--&lt;%&ndash;                        <form action="${pageContext.request.contextPath}/room" method="get">&ndash;%&gt;--%>
    <%--&lt;%&ndash;                            <button class="w-auto btn btn-sm btn-primary" name="room" value="${rmm}"&ndash;%&gt;--%>
    <%--&lt;%&ndash;                                    type="submit">${rmm}</button>&ndash;%&gt;--%>
    <%--&lt;%&ndash;                        </form>&ndash;%&gt;--%>
    <%--&lt;%&ndash;                    </li>&ndash;%&gt;--%>
    <%--                </c:forEach>--%>
    <%--            </ul>--%>
    <%--            <hr>--%>
    <%--            <ul>--%>
    <%--                <h3>Npc:</h3>--%>
    <%--                <c:forEach items="${rm.getNpcs()}" var="npc">--%>
    <%--                    &lt;%&ndash;                    <li>&ndash;%&gt;--%>
    <%--                    &lt;%&ndash;                        <div class="container">&ndash;%&gt;--%>
    <%--                    &lt;%&ndash;                            <h2>NPC</h2>&ndash;%&gt;--%>
    <%--                    <!-- Button trigger modal -->--%>
    <%--                    <button type="button" class="btn btn-success btn-lg" data-bs-toggle="modal"--%>
    <%--                            data-bs-target="#${npc.getName().replace(' ', '_')}">${npc.getName()}</button>--%>

    <%--                    <!-- Modal -->--%>
    <%--                    <div class="modal fade" id="${npc.getName().replace(' ', '_')}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">--%>
    <%--                        <div class="modal-dialog">--%>
    <%--                            <div class="modal-content">--%>
    <%--                                <div class="modal-header">--%>
    <%--                                    <h5 class="modal-title" id="exampleModalLabel">NPC dialog</h5>--%>
    <%--                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>--%>
    <%--                                </div>--%>
    <%--                                <div class="modal-body">--%>
    <%--                                    <img src="${npc.getImg()}">--%>
    <%--                                    <br>--%>
    <%--                                    Do you want talk with ${npc.getName()}?--%>
    <%--                                </div>--%>
    <%--                                <div class="modal-footer">--%>
    <%--                                    <button type="button" class="btn btn-primary" data-bs-toggle="modal"--%>
    <%--                                            data-bs-target="#${npc.getName().replace(' ', '_')}_1">Talk</button>--%>
    <%--                                    <form action="${pageContext.request.contextPath}/fight" method="get">--%>
    <%--                                        <button type="submit" class="btn btn-warning" data-bs-dismiss="modal" name="npc" value="${npc.getName()}">Fight</button>--%>
    <%--                                    </form>--%>
    <%--                                </div>--%>
    <%--                            </div>--%>
    <%--                        </div>--%>
    <%--                    </div>--%>
    <%--                    <!-- Modal -->--%>
    <%--                    <div class="modal fade" id="${npc.getName().replace(' ', '_')}_1" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">--%>
    <%--                        <div class="modal-dialog">--%>
    <%--                            <div class="modal-content">--%>
    <%--                                <div class="modal-header">--%>
    <%--                                    <h5 class="modal-title" id="exampleModalLabel1">NPC dialog</h5>--%>
    <%--                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>--%>
    <%--                                </div>--%>
    <%--                                <div class="modal-body">--%>
    <%--                                    <img src="${npc.getImg()}">--%>
    <%--                                    <br>--%>
    <%--                                    Take quest or give an item to ${npc.getName()}?--%>
    <%--                                </div>--%>
    <%--                                <div class="modal-footer">--%>
    <%--                                    <form action="${pageContext.request.contextPath}/add_quest" method="post">--%>
    <%--                                        <button class="btn btn-primary" data-bs-dismiss="modal"--%>
    <%--                                                name="npc" value="${npc.getName()}" type="submit" data-bs-toggle="modal"--%>
    <%--                                                data-bs-target="#${npc.getName().replace(' ', '_')}">Take quest--%>
    <%--                                        </button>--%>
    <%--                                    </form>--%>
    <%--                                    <form action="${pageContext.request.contextPath}/pass_quest" method="post">--%>
    <%--                                        <button class="btn btn-primary" data-bs-dismiss="modal"--%>
    <%--                                                name="npc" value="${npc.getName()}" type="submit" data-bs-toggle="modal"--%>
    <%--                                                data-bs-target="#${npc.getName().replace(' ', '_')}">Give item--%>
    <%--                                        </button>--%>
    <%--                                    </form>--%>
    <%--                                </div>--%>
    <%--                            </div>--%>
    <%--                        </div>--%>
    <%--                    </div>--%>
    <%--                    &lt;%&ndash;                        </div>&ndash;%&gt;--%>
    <%--                    &lt;%&ndash;                    </li>&ndash;%&gt;--%>
    <%--                </c:forEach>--%>
    <%--            </ul>--%>
    <%--            <hr>--%>
    <%--            <ul>--%>
    <%--                <h3>Item:</h3>--%>
    <%--                <c:forEach items="${rm.getItems()}" var="item">--%>
    <%--                    &lt;%&ndash;                    <li>&ndash;%&gt;--%>
    <%--                    &lt;%&ndash;                        <div class="container">&ndash;%&gt;--%>
    <%--                    &lt;%&ndash;                            <h2>NPC</h2>&ndash;%&gt;--%>
    <%--                    <button type="button" class="btn btn-info btn-lg" data-bs-toggle="modal"--%>
    <%--                            data-bs-target="#${item.replace(' ', '_')}">${item}</button>--%>
    <%--                    <!-- Modal -->--%>
    <%--                    <div class="modal fade" id="${item.replace(' ', '_')}" role="dialog">--%>
    <%--                        <div class="modal-dialog">--%>
    <%--                            <!-- Modal content-->--%>
    <%--                            <div class="modal-content">--%>
    <%--                                <div class="modal-header">--%>
    <%--                                    <h4 class="modal-title">Modal Header</h4>--%>
    <%--                                    <button type="button" class="btn-close" data-bs-dismiss="modal"--%>
    <%--                                            aria-label="Close">--%>
    <%--                                    </button>--%>
    <%--                                </div>--%>
    <%--                                <div class="modal-body">--%>
    <%--                                    <p>Do you need a ${item}?</p>--%>
    <%--                                </div>--%>
    <%--                                <div class="modal-footer">--%>
    <%--                                    <form action="${pageContext.request.contextPath}/add_item" method="post">--%>
    <%--                                        <button type="submit" class="btn btn-primary" data-bs-dismiss="modal"--%>
    <%--                                                data-bs-toggle="modal" data-bs-target="#${item.replace(' ', '_')}"--%>
    <%--                                                name="item"--%>
    <%--                                                value="${item}">Yes--%>
    <%--                                        </button>--%>
    <%--                                    </form>--%>
    <%--                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No--%>
    <%--                                    </button>--%>
    <%--                                </div>--%>
    <%--                            </div>--%>
    <%--                        </div>--%>
    <%--                    </div>--%>
    <%--                    &lt;%&ndash;                        </div>&ndash;%&gt;--%>
    <%--                    &lt;%&ndash;                    </li>&ndash;%&gt;--%>
    <%--                </c:forEach>--%>
    <%--            </ul>--%>
    <%--        </c:if>--%>
    <%--    </c:forEach>--%>
</div>
</body>
</html>
