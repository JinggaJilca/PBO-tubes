<%--
    Document   : notification
    Description: Halaman notifikasi threshold budget FinTrack
--%>

<%@ page isELIgnored="false" %>
<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>FinTrack - Notifications</title>

    <!-- Favicon -->
    <link rel="icon"
          type="image/png"
          href="<%= request.getContextPath() %>/images/favicon.png">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Instrument+Sans:wght@400;500;600;700&display=swap"
          rel="stylesheet">

    <!-- FinTrack CSS -->
    <link rel="stylesheet"
          type="text/css"
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

                <button type="button"
                        class="btn-mark-all"
                        id="markAllReadButton">

                    <i class="bi bi-check2-all"></i>

                    Mark All as Read
                </button>

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
                        <span id="unreadCount">3</span>
                        unread notifications.
                    </p>

                </div>

                <!-- Filter -->
                <div class="notification-filter">

                    <button type="button"
                            class="notification-filter-button active"
                            data-filter="all">

                        All
                    </button>

                    <button type="button"
                            class="notification-filter-button"
                            data-filter="unread">

                        Unread
                    </button>

                    <button type="button"
                            class="notification-filter-button"
                            data-filter="read">

                        Read
                    </button>

                </div>

            </section>

            <!-- =====================================
                 NOTIFICATION LIST
            ====================================== -->
            <section class="notification-list"
                     id="notificationList">

                <!-- =====================================
                     FOOD AND DRINKS
                ====================================== -->
                <article class="notification-card unread"
                         data-status="unread">

                    <div class="notification-icon">
                        <i class="bi bi-exclamation-triangle"></i>
                    </div>

                    <div class="notification-card-content">

                        <div class="notification-card-header">

                            <div class="notification-card-title-wrapper">

                                <h3>
                                    Food and Drinks Threshold Reached
                                </h3>

                                <span class="notification-status">
                                    New
                                </span>

                            </div>

                            <time datetime="2026-06-13T10:30">
                                Today, 10:30
                            </time>

                        </div>

                        <p class="notification-message">
                            Your Food and Drinks spending has reached
                            Rp1.600.000 and has passed the warning threshold
                            of Rp1.500.000.
                        </p>

                        <div class="notification-threshold-information">

                            <div class="notification-threshold-row">

                                <span>Current Spending</span>

                                <strong>Rp1.600.000</strong>

                            </div>

                            <div class="notification-threshold-row">

                                <span>Warning Threshold</span>

                                <strong>Rp1.500.000</strong>

                            </div>

                            <div class="notification-threshold-row">

                                <span>Threshold Difference</span>

                                <strong class="threshold-difference">
                                    Rp100.000
                                </strong>

                            </div>

                        </div>

                        <div class="notification-card-actions">

                            <a href="<%= request.getContextPath() %>/budget"
                               class="notification-detail-link">

                                View Budget

                                <i class="bi bi-arrow-right"></i>

                            </a>

                            <div class="notification-action-buttons">

                                <button type="button"
                                        class="notification-action-button mark-read-button"
                                        title="Mark as read">

                                    <i class="bi bi-check2"></i>

                                </button>

                                <button type="button"
                                        class="notification-action-button delete-notification-button"
                                        title="Delete notification">

                                    <i class="bi bi-trash3"></i>

                                </button>

                            </div>

                        </div>

                    </div>

                </article>

                <!-- =====================================
                     SHOPPING
                ====================================== -->
                <article class="notification-card unread"
                         data-status="unread">

                    <div class="notification-icon">
                        <i class="bi bi-exclamation-triangle"></i>
                    </div>

                    <div class="notification-card-content">

                        <div class="notification-card-header">

                            <div class="notification-card-title-wrapper">

                                <h3>
                                    Shopping Threshold Reached
                                </h3>

                                <span class="notification-status">
                                    New
                                </span>

                            </div>

                            <time datetime="2026-06-13T08:15">
                                Today, 08:15
                            </time>

                        </div>

                        <p class="notification-message">
                            Your Shopping spending has reached Rp900.000
                            and has passed the warning threshold of Rp800.000.
                        </p>

                        <div class="notification-threshold-information">

                            <div class="notification-threshold-row">

                                <span>Current Spending</span>

                                <strong>Rp900.000</strong>

                            </div>

                            <div class="notification-threshold-row">

                                <span>Warning Threshold</span>

                                <strong>Rp800.000</strong>

                            </div>

                            <div class="notification-threshold-row">

                                <span>Threshold Difference</span>

                                <strong class="threshold-difference">
                                    Rp100.000
                                </strong>

                            </div>

                        </div>

                        <div class="notification-card-actions">

                            <a href="<%= request.getContextPath() %>/budget"
                               class="notification-detail-link">

                                View Budget

                                <i class="bi bi-arrow-right"></i>

                            </a>

                            <div class="notification-action-buttons">

                                <button type="button"
                                        class="notification-action-button mark-read-button"
                                        title="Mark as read">

                                    <i class="bi bi-check2"></i>

                                </button>

                                <button type="button"
                                        class="notification-action-button delete-notification-button"
                                        title="Delete notification">

                                    <i class="bi bi-trash3"></i>

                                </button>

                            </div>

                        </div>

                    </div>

                </article>

                <!-- =====================================
                     TRANSPORTATION
                ====================================== -->
                <article class="notification-card unread"
                         data-status="unread">

                    <div class="notification-icon">
                        <i class="bi bi-exclamation-triangle"></i>
                    </div>

                    <div class="notification-card-content">

                        <div class="notification-card-header">

                            <div class="notification-card-title-wrapper">

                                <h3>
                                    Transportation Threshold Reached
                                </h3>

                                <span class="notification-status">
                                    New
                                </span>

                            </div>

                            <time datetime="2026-06-12T19:40">
                                Yesterday, 19:40
                            </time>

                        </div>

                        <p class="notification-message">
                            Your Transportation spending has reached
                            Rp1.300.000 and has passed the warning threshold
                            of Rp1.200.000.
                        </p>

                        <div class="notification-threshold-information">

                            <div class="notification-threshold-row">

                                <span>Current Spending</span>

                                <strong>Rp1.300.000</strong>

                            </div>

                            <div class="notification-threshold-row">

                                <span>Warning Threshold</span>

                                <strong>Rp1.200.000</strong>

                            </div>

                            <div class="notification-threshold-row">

                                <span>Threshold Difference</span>

                                <strong class="threshold-difference">
                                    Rp100.000
                                </strong>

                            </div>

                        </div>

                        <div class="notification-card-actions">

                            <a href="<%= request.getContextPath() %>/budget"
                               class="notification-detail-link">

                                View Budget

                                <i class="bi bi-arrow-right"></i>

                            </a>

                            <div class="notification-action-buttons">

                                <button type="button"
                                        class="notification-action-button mark-read-button"
                                        title="Mark as read">

                                    <i class="bi bi-check2"></i>

                                </button>

                                <button type="button"
                                        class="notification-action-button delete-notification-button"
                                        title="Delete notification">

                                    <i class="bi bi-trash3"></i>

                                </button>

                            </div>

                        </div>

                    </div>

                </article>

                <!-- =====================================
                     READ NOTIFICATION
                ====================================== -->
                <article class="notification-card"
                         data-status="read">

                    <div class="notification-icon">
                        <i class="bi bi-exclamation-triangle"></i>
                    </div>

                    <div class="notification-card-content">

                        <div class="notification-card-header">

                            <div class="notification-card-title-wrapper">

                                <h3>
                                    Entertainment Threshold Reached
                                </h3>

                            </div>

                            <time datetime="2026-06-11T14:20">
                                11 June 2026
                            </time>

                        </div>

                        <p class="notification-message">
                            Your Entertainment spending has reached
                            Rp650.000 and has passed the warning threshold
                            of Rp600.000.
                        </p>

                        <div class="notification-threshold-information">

                            <div class="notification-threshold-row">

                                <span>Current Spending</span>

                                <strong>Rp650.000</strong>

                            </div>

                            <div class="notification-threshold-row">

                                <span>Warning Threshold</span>

                                <strong>Rp600.000</strong>

                            </div>

                            <div class="notification-threshold-row">

                                <span>Threshold Difference</span>

                                <strong class="threshold-difference">
                                    Rp50.000
                                </strong>

                            </div>

                        </div>

                        <div class="notification-card-actions">

                            <a href="<%= request.getContextPath() %>/budget"
                               class="notification-detail-link">

                                View Budget

                                <i class="bi bi-arrow-right"></i>

                            </a>

                            <div class="notification-action-buttons">

                                <button type="button"
                                        class="notification-action-button delete-notification-button"
                                        title="Delete notification">

                                    <i class="bi bi-trash3"></i>

                                </button>

                            </div>

                        </div>

                    </div>

                </article>

            </section>

            <!-- =====================================
                 EMPTY STATE
            ====================================== -->
            <section class="notification-empty"
                     id="notificationEmpty">

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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- =====================================
         NOTIFICATION JAVASCRIPT
    ====================================== -->
    <script>
        const filterButtons =
            document.querySelectorAll(".notification-filter-button");

        const markAllReadButton =
            document.getElementById("markAllReadButton");

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

            unreadCountElement.textContent =
                unreadNotifications.length;
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

            if (visibleNotifications === 0) {
                notificationEmpty.classList.add("show");
            } else {
                notificationEmpty.classList.remove("show");
            }
        }

        function markNotificationAsRead(card) {
            card.classList.remove("unread");
            card.setAttribute("data-status", "read");

            const notificationStatus =
                card.querySelector(".notification-status");

            const markReadButton =
                card.querySelector(".mark-read-button");

            if (notificationStatus) {
                notificationStatus.remove();
            }

            if (markReadButton) {
                markReadButton.remove();
            }

            updateUnreadCount();
            applyNotificationFilter();
        }

        document.addEventListener("click", function (event) {

            const markReadButton =
                event.target.closest(".mark-read-button");

            const deleteButton =
                event.target.closest(
                    ".delete-notification-button"
                );

            if (markReadButton) {
                const notificationCard =
                    markReadButton.closest(".notification-card");

                markNotificationAsRead(notificationCard);
            }

            if (deleteButton) {
                const notificationCard =
                    deleteButton.closest(".notification-card");

                notificationCard.remove();

                updateUnreadCount();
                applyNotificationFilter();
            }

        });

        markAllReadButton.addEventListener("click", function () {

            const unreadNotifications =
                document.querySelectorAll(
                    ".notification-card[data-status='unread']"
                );

            unreadNotifications.forEach(function (card) {
                card.classList.remove("unread");
                card.setAttribute("data-status", "read");

                const notificationStatus =
                    card.querySelector(".notification-status");

                const markReadButton =
                    card.querySelector(".mark-read-button");

                if (notificationStatus) {
                    notificationStatus.remove();
                }

                if (markReadButton) {
                    markReadButton.remove();
                }
            });

            updateUnreadCount();
            applyNotificationFilter();
        });

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