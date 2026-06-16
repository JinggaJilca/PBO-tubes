<%-- Document : notification Description: Halaman notifikasi threshold budget FinTrack --%>

    <%@ page isELIgnored="false" %>
        <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
            <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
                <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                    <!DOCTYPE html>
                    <html lang="id">

                    <head>
                        <meta charset="UTF-8">

                        <meta name="viewport" content="width=device-width, initial-scale=1.0">

                        <title>FinTrack - Notifications</title>

                        <!-- Favicon -->
                        <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/images/favicon.png">

                        <!-- Bootstrap -->
                        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                            rel="stylesheet">

                        <!-- Bootstrap Icons -->
                        <link rel="stylesheet"
                            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

                        <!-- Google Font -->
                        <link
                            href="https://fonts.googleapis.com/css2?family=Instrument+Sans:wght@400;500;600;700&display=swap"
                            rel="stylesheet">

                        <!-- FinTrack CSS -->
                        <link rel="stylesheet" type="text/css"
                            href="<%= request.getContextPath() %>/css/style.css?v=20260613-5">
                    </head>

                    <body class="notification-page">

                        <!-- Navbar -->
                        <jsp:include page="navbar.jsp" />

                        <!-- =====================================
         HEADER
    ====================================== -->
                        <header class="notification-header">

                            <div class="container">

                                <div class="notification-header-content">

                                    <div class="notification-header-text">

                                        <p class="notification-subtitle">
                                            Budget monitoring
                                        </p>

                                        <h1 class="notification-title">
                                            Notifications
                                        </h1>

                                        <p class="notification-description">
                                            Notifications appear after your spending reaches
                                            or passes the warning threshold of a budget category.
                                        </p>

                                    </div>

                                    <form action="${pageContext.request.contextPath}/notification/read-all"
                                        method="POST" class="m-0">

                                        <button type="submit" class="btn-mark-all" id="markAllReadButton">

                                            <i class="bi bi-check2-all"></i>
                                            Mark All as Read

                                        </button>
                                    </form>

                                </div>

                            </div>

                        </header>

                        <!-- =====================================
         MAIN CONTENT
    ====================================== -->
                        <main class="notification-content">

                            <div class="container">

                                <!-- Summary -->
                                <section class="notification-summary">

                                    <div class="notification-summary-text">

                                        <h2>Threshold Warnings</h2>

                                        <p>
                                            You have
                                            <span id="unreadCount">${unreadCount != null ? unreadCount : 0}</span>
                                            unread notifications.
                                        </p>

                                    </div>

                                    <!-- Filter -->
                                    <div class="notification-filter">

                                        <button type="button" class="notification-filter-button active"
                                            data-filter="all">

                                            All
                                        </button>

                                        <button type="button" class="notification-filter-button" data-filter="unread">

                                            Unread
                                        </button>

                                        <button type="button" class="notification-filter-button" data-filter="read">

                                            Read
                                        </button>

                                    </div>

                                </section>

                                <!-- =====================================
                 NOTIFICATION LIST
            ====================================== -->
                                <section class="notification-list" id="notificationList">

                                    <c:if test="${not empty notifications}">
                                        <c:forEach var="notif" items="${notifications}">

                                            <article class="notification-card ${notif.read ? '' : 'unread'}"
                                                data-status="${notif.read ? 'read' : 'unread'}">

                                                <div class="notification-icon">
                                                    <i class="bi bi-exclamation-triangle"></i>
                                                </div>

                                                <div class="notification-card-content">

                                                    <div class="notification-card-header">

                                                        <div class="notification-card-title-wrapper">

                                                            <h3>
                                                                ${notif.categoryName} Threshold Reached
                                                            </h3>

                                                            <span class="notification-status">
                                                                New
                                                            </span>

                                                        </div>

                                                        <time>
                                                            <fmt:formatDate value="${notif.notificationDate}"
                                                                pattern="dd MMM yyyy, HH:mm" />
                                                        </time>

                                                    </div>

                                                    <p class="notification-message">
                                                        Your ${notif.categoryName} spending has reached
                                                        Rp
                                                        <fmt:formatNumber value="${notif.currentSpending}" type="number"
                                                            groupingUsed="true" maxFractionDigits="0" />
                                                        and has passed the warning threshold of
                                                        Rp
                                                        <fmt:formatNumber value="${notif.warningThreshold}"
                                                            type="number" groupingUsed="true" maxFractionDigits="0" />.
                                                    </p>

                                                    <div class="notification-threshold-information">

                                                        <div class="notification-threshold-row">
                                                            <span>Current Spending</span>

                                                            <strong>
                                                                Rp
                                                                <fmt:formatNumber value="${notif.currentSpending}"
                                                                    type="number" groupingUsed="true"
                                                                    maxFractionDigits="0" />
                                                            </strong>
                                                        </div>

                                                        <div class="notification-threshold-row">
                                                            <span>Warning Threshold</span>

                                                            <strong>
                                                                Rp
                                                                <fmt:formatNumber value="${notif.warningThreshold}"
                                                                    type="number" groupingUsed="true"
                                                                    maxFractionDigits="0" />
                                                            </strong>
                                                        </div>

                                                        <div class="notification-threshold-row">
                                                            <span>Threshold Difference</span>

                                                            <strong class="threshold-difference">
                                                                Rp
                                                                <fmt:formatNumber value="${notif.difference}"
                                                                    type="number" groupingUsed="true"
                                                                    maxFractionDigits="0" />
                                                            </strong>
                                                        </div>

                                                    </div>

                                                    <div class="notification-card-actions">

                                                        <a href="${pageContext.request.contextPath}/budget"
                                                            class="notification-detail-link">

                                                            View Budget

                                                            <i class="bi bi-arrow-right"></i>

                                                        </a>

                                                        <div class="notification-action-buttons">

                                                            <c:if test="${!notif.read}">
                                                                <form
                                                                    action="${pageContext.request.contextPath}/notification/read"
                                                                    method="POST" class="m-0">

                                                                    <input type="hidden" name="notificationId"
                                                                        value="${notif.notificationId}">

                                                                    <button type="submit"
                                                                        class="notification-action-button"
                                                                        title="Mark as read">

                                                                        <i class="bi bi-check2"></i>

                                                                    </button>
                                                                </form>
                                                            </c:if>

                                                            <form
                                                                action="${pageContext.request.contextPath}/notification/delete"
                                                                method="POST" class="m-0">

                                                                <input type="hidden" name="notificationId"
                                                                    value="${notif.notificationId}">

                                                                <button type="submit"
                                                                    class="notification-action-button delete-notification-button"
                                                                    title="Delete notification">

                                                                    <i class="bi bi-trash3"></i>

                                                                </button>

                                                            </form>

                                                        </div>

                                                    </div>

                                                </div>

                                            </article>

                                        </c:forEach>
                                    </c:if>

                                </section>
                                <!-- =====================================
                 EMPTY STATE
            ====================================== -->
                                <section class="notification-empty" id="notificationEmpty">

                                    <div class="notification-empty-icon">

                                        <i class="bi bi-shield-check"></i>

                                    </div>

                                    <h3>No Threshold Warnings</h3>

                                    <p>
                                        None of your budget categories have reached
                                        their warning threshold.
                                    </p>

                                </section>

                            </div>

                        </main>

                        <!-- Bootstrap JavaScript -->
                        <script
                            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

                        <!-- =====================================
         NOTIFICATION JAVASCRIPT
    ====================================== -->
                        <script>
                            const filterButtons =
                                document.querySelectorAll(".notification-filter-button");

                            const unreadCountElement =
                                document.getElementById("unreadCount");

                            const notificationEmpty =
                                document.getElementById("notificationEmpty");

                            let activeFilter = "all";

                            function updateUnreadCount() {
                                const unreadNotifications =
                                    document.querySelectorAll(
                                        ".notification-card[data-status='unread']"
                                    );

                                if (unreadCountElement) {
                                    unreadCountElement.textContent = unreadNotifications.length;
                                }
                            }

                            function applyNotificationFilter() {
                                const notificationCards =
                                    document.querySelectorAll(".notification-card");

                                let visibleNotifications = 0;

                                notificationCards.forEach(function (card) {
                                    const notificationStatus =
                                        card.getAttribute("data-status");

                                    const shouldDisplay =
                                        activeFilter === "all" ||
                                        activeFilter === notificationStatus;

                                    card.style.display =
                                        shouldDisplay ? "flex" : "none";

                                    if (shouldDisplay) {
                                        visibleNotifications++;
                                    }
                                });

                                if (notificationEmpty) {
                                    if (visibleNotifications === 0) {
                                        notificationEmpty.classList.add("show");
                                    } else {
                                        notificationEmpty.classList.remove("show");
                                    }
                                }
                            }

                            filterButtons.forEach(function (button) {
                                button.addEventListener("click", function () {

                                    filterButtons.forEach(function (item) {
                                        item.classList.remove("active");
                                    });

                                    button.classList.add("active");

                                    activeFilter =
                                        button.getAttribute("data-filter");

                                    applyNotificationFilter();
                                });
                            });

                            updateUnreadCount();
                            applyNotificationFilter();
                        </script>
                    </body>

                    </html>