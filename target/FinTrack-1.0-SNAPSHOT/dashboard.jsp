<%@ page isELIgnored="false" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="id">

            <head>
                <meta charset="UTF-8">
                <title>Dashboard - FinTrack</title>

                <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png">

                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

                <link href="https://fonts.googleapis.com/css2?family=Instrument+Sans:wght@400;600;700&display=swap"
                    rel="stylesheet">

                <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">

                <style>
                    .summary-value {
                        font-size: 24px;
                        font-weight: 700;
                        color: #0f172a;
                    }

                    .summary-label {
                        color: #64748b;
                        font-size: 14px;
                    }

                    .activity-item {
                        border-bottom: 1px solid #e5e7eb;
                        padding: 12px 0;
                    }

                    .activity-item:last-child {
                        border-bottom: none;
                    }

                    .activity-icon {
                        width: 42px;
                        height: 42px;
                        border-radius: 50%;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                    }

                    .income-icon {
                        background-color: #dcfce7;
                        color: #16a34a;
                    }

                    .expense-icon {
                        background-color: #fee2e2;
                        color: #dc2626;
                    }

                    .category-row {
                        margin-bottom: 16px;
                    }

                    .progress {
                        height: 8px;
                        border-radius: 999px;
                    }

                    .progress-bar {
                        width: 100%;
                    }
                </style>
            </head>

            <body>

                <!-- NAVBAR LANGSUNG DIGABUNG DI SINI -->
                <nav class="navbar navbar-expand-lg navbar-custom py-3 text-white">
                    <div class="container">

                        <a class="navbar-brand" href="${pageContext.request.contextPath}/dashboard">
                            <img src="${pageContext.request.contextPath}/images/FLogo.png" class="navbar-logo"
                                alt="FinTrack Logo">
                        </a>

                        <button class="navbar-toggler text-white border-0" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false"
                            aria-label="Toggle navigation">
                            <i class="bi bi-list fs-1"></i>
                        </button>

                        <div class="collapse navbar-collapse justify-content-center" id="navbarNav">
                            <ul class="navbar-nav gap-5 align-items-center">

                                <li class="nav-item">
                                    <a class="nav-link text-white px-3 d-flex align-items-center gap-2"
                                        href="wallet.jsp">
                                        <i class="bi bi-wallet2 fs-4"></i>
                                        Wallet
                                    </a>
                                </li>

                                <li class="nav-item">
                                    <a class="nav-link text-white px-3 d-flex align-items-center gap-2"
                                        href="transaction.jsp">
                                        <i class="bi bi-cash-coin fs-4"></i>
                                        Transaction
                                    </a>
                                </li>

                                <li class="nav-item">
                                    <a class="nav-link text-white px-3 d-flex align-items-center gap-2"
                                        href="budget.jsp">
                                        <i class="bi bi-piggy-bank fs-4"></i>
                                        Budget
                                    </a>
                                </li>

                            </ul>
                        </div>

                        <div class="d-flex align-items-center gap-3">

                            <a href="#" class="text-decoration-none">
                                <div class="icon-circle">
                                    <i class="bi bi-bell-fill fs-5"></i>
                                </div>
                            </a>

                            <div class="dropdown">
                                <a class="text-white text-decoration-none dropdown-toggle d-flex align-items-center gap-2"
                                    href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">

                                    <div class="profile-circle">
                                        <i class="bi bi-person-fill fs-4"></i>
                                    </div>

                                    <span class="fw-semibold text-white">
                                        <c:choose>
                                            <c:when test="${not empty sessionScope.username}">
                                                ${sessionScope.username}
                                            </c:when>
                                            <c:otherwise>
                                                Julio Tanlain
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                </a>

                                <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2">
                                    <li>
                                        <a class="dropdown-item" href="profile.jsp">
                                            <i class="bi bi-person me-2"></i>Profile
                                        </a>
                                    </li>

                                    <li>
                                        <hr class="dropdown-divider">
                                    </li>

                                    <li>
                                        <form action="${pageContext.request.contextPath}/logout" method="POST"
                                            class="m-0">
                                            <button type="submit" class="dropdown-item text-danger">
                                                <i class="bi bi-box-arrow-right me-2"></i>Logout
                                            </button>
                                        </form>
                                    </li>
                                </ul>
                            </div>

                        </div>

                    </div>
                </nav>

                <!-- DASHBOARD HEADER -->
                <div class="dashboard-header">
                    <div class="container">
                        <div class="d-flex justify-content-between align-items-end">
                            <div>
                                <p class="mb-1 text-light-teal">Good Morning,</p>

                                <h2 class="fw-bold mb-0 fs-1">
                                    <c:choose>
                                        <c:when test="${not empty requestScope.username}">
                                            ${requestScope.username}
                                        </c:when>
                                        <c:otherwise>
                                            Bambang
                                        </c:otherwise>
                                    </c:choose>
                                </h2>
                            </div>
                            <div class="d-flex align-items-center gap-2">
                                <button class="btn btn-date d-flex align-items-center gap-2">
                                    <i class="bi bi-calendar"></i>

                                    <c:choose>
                                        <c:when test="${not empty selectedMonth}">
                                            ${selectedMonth} ${selectedYear}
                                        </c:when>
                                        <c:otherwise>
                                            Bulan Ini
                                        </c:otherwise>
                                    </c:choose>
                                </button>

                                <button class="btn btn-date d-flex align-items-center gap-2">
                                    <i class="bi bi-download"></i>
                                    Export Data
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- DASHBOARD CONTENT -->
                <div class="container overlap-container mb-5">

                    <!-- SUMMARY CARD -->
                    <div class="row g-4 mb-4">

                        <div class="col-12 col-md-6 col-lg-3">
                            <div class="card fintrack-card summary-card p-3">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-start mb-3">
                                        <div>
                                            <h6 class="fw-bold text-dark mb-1">Total Saldo</h6>
                                            <p class="summary-label mb-0">Total Balance</p>
                                        </div>

                                        <i class="bi bi-wallet2 fs-2"></i>
                                    </div>

                                    <div class="summary-value">
                                        Rp
                                        <fmt:formatNumber value="${summary.totalBalance}" type="number"
                                            groupingUsed="true" maxFractionDigits="0" />
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-12 col-md-6 col-lg-3">
                            <div class="card fintrack-card summary-card p-3">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-start mb-3">
                                        <div>
                                            <h6 class="fw-bold text-dark mb-1">Pemasukan</h6>
                                            <p class="summary-label mb-0">Bulan Ini</p>
                                        </div>

                                        <i class="bi bi-arrow-up-circle fs-2"></i>
                                    </div>

                                    <div class="summary-value">
                                        Rp
                                        <fmt:formatNumber value="${summary.totalEarnings}" type="number"
                                            groupingUsed="true" maxFractionDigits="0" />
                                    </div>

                                    <small class="text-muted">
                                        Bulan lalu:
                                        Rp
                                        <fmt:formatNumber value="${summary.lastMonthEarnings}" type="number"
                                            groupingUsed="true" maxFractionDigits="0" />
                                    </small>
                                </div>
                            </div>
                        </div>

                        <div class="col-12 col-md-6 col-lg-3">
                            <div class="card fintrack-card summary-card p-3">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-start mb-3">
                                        <div>
                                            <h6 class="fw-bold text-dark mb-1">Pengeluaran</h6>
                                            <p class="summary-label mb-0">Bulan Ini</p>
                                        </div>

                                        <i class="bi bi-arrow-down-circle fs-2"></i>
                                    </div>

                                    <div class="summary-value">
                                        Rp
                                        <fmt:formatNumber value="${summary.totalSpending}" type="number"
                                            groupingUsed="true" maxFractionDigits="0" />
                                    </div>

                                    <small class="text-muted">
                                        Bulan lalu:
                                        Rp
                                        <fmt:formatNumber value="${summary.lastMonthSpending}" type="number"
                                            groupingUsed="true" maxFractionDigits="0" />
                                    </small>
                                </div>
                            </div>
                        </div>

                        <div class="col-12 col-md-6 col-lg-3">
                            <div class="card fintrack-card summary-card p-3">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-start mb-3">
                                        <div>
                                            <h6 class="fw-bold text-dark mb-1">Sisa Bulan Ini</h6>
                                            <p class="summary-label mb-0">Income - Expense</p>
                                        </div>

                                        <i class="bi bi-graph-up fs-2"></i>
                                    </div>

                                    <div class="summary-value">
                                        Rp
                                        <fmt:formatNumber value="${summary.totalEarnings - summary.totalSpending}"
                                            type="number" groupingUsed="true" maxFractionDigits="0" />
                                    </div>

                                    <small class="text-muted">
                                        Saldo bulan lalu:
                                        Rp
                                        <fmt:formatNumber value="${summary.lastMonthBalance}" type="number"
                                            groupingUsed="true" maxFractionDigits="0" />
                                    </small>
                                </div>
                            </div>
                        </div>

                    </div>

                    <!-- RECENT ACTIVITY & SPENDING OVERVIEW -->
                    <div class="row g-4 mb-4">

                        <!-- RECENT ACTIVITY -->
                        <div class="col-12 col-lg-6">
                            <div class="card fintrack-card activity-card p-4">
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <h6 class="fw-bold text-dark mb-0">Recent Activity</h6>
                                    <small class="text-muted">Transaksi terbaru</small>
                                </div>

                                <c:choose>
                                    <c:when test="${empty recentActivities}">
                                        <div class="text-center text-muted py-4">
                                            Belum ada transaksi terbaru.
                                        </div>
                                    </c:when>

                                    <c:otherwise>
                                        <c:forEach var="activity" items="${recentActivities}">
                                            <div
                                                class="activity-item d-flex align-items-center justify-content-between">
                                                <div class="d-flex align-items-center gap-3">

                                                    <c:choose>
                                                        <c:when test="${activity.transactionType == 'income'}">
                                                            <div class="activity-icon income-icon">
                                                                <i class="bi bi-arrow-up"></i>
                                                            </div>
                                                        </c:when>

                                                        <c:otherwise>
                                                            <div class="activity-icon expense-icon">
                                                                <i class="bi bi-arrow-down"></i>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>

                                                    <div>
                                                        <h6 class="mb-1 fw-semibold">
                                                            ${activity.transactionName}
                                                        </h6>

                                                        <small class="text-muted">
                                                            ${activity.categoryName}
                                                        </small>

                                                        <c:if test="${not empty activity.note}">
                                                            <br>
                                                            <small class="text-muted">
                                                                ${activity.note}
                                                            </small>
                                                        </c:if>
                                                    </div>
                                                </div>

                                                <div class="text-end">
                                                    <c:choose>
                                                        <c:when test="${activity.transactionType == 'income'}">
                                                            <span class="fw-bold text-success">
                                                                + Rp
                                                                <fmt:formatNumber value="${activity.amount}"
                                                                    type="number" groupingUsed="true"
                                                                    maxFractionDigits="0" />
                                                            </span>
                                                        </c:when>

                                                        <c:otherwise>
                                                            <span class="fw-bold text-danger">
                                                                - Rp
                                                                <fmt:formatNumber value="${activity.amount}"
                                                                    type="number" groupingUsed="true"
                                                                    maxFractionDigits="0" />
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <!-- SPENDING OVERVIEW -->
                        <div class="col-12 col-lg-6">
                            <div class="card fintrack-card activity-card p-4">
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <h6 class="fw-bold text-dark mb-0">Spending Overview</h6>
                                    <small class="text-muted">Pengeluaran per kategori</small>
                                </div>

                                <c:choose>
                                    <c:when test="${empty spendingOverview}">
                                        <div class="text-center text-muted py-4">
                                            Belum ada data pengeluaran bulan ini.
                                        </div>
                                    </c:when>

                                    <c:otherwise>
                                        <c:forEach var="category" items="${spendingOverview}">
                                            <div class="category-row">
                                                <div class="d-flex justify-content-between mb-2">
                                                    <span class="fw-semibold">
                                                        ${category.categoryName}
                                                    </span>

                                                    <span class="text-muted">
                                                        Rp
                                                        <fmt:formatNumber value="${category.totalAmount}" type="number"
                                                            groupingUsed="true" maxFractionDigits="0" />
                                                    </span>
                                                </div>

                                                <div class="progress">
                                                    <div class="progress-bar" role="progressbar"
                                                        aria-valuenow="${category.percentage}" aria-valuemin="0"
                                                        aria-valuemax="100">
                                                    </div>
                                                </div>

                                                <small class="text-muted">
                                                    <fmt:formatNumber value="${category.percentage}" type="number"
                                                        maxFractionDigits="1" />%
                                                </small>
                                            </div>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                    </div>

                    <!-- STATISTIC -->
                    <div class="row g-4">
                        <div class="col-12">
                            <div class="card fintrack-card activity-card p-4">
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <h6 class="fw-bold text-dark mb-0">Statistic</h6>
                                    <small class="text-muted">Ringkasan pemasukan dan pengeluaran tahunan</small>
                                </div>

                                <div class="table-responsive">
                                    <table class="table align-middle">
                                        <thead>
                                            <tr>
                                                <th>Bulan</th>
                                                <th>Pemasukan</th>
                                                <th>Pengeluaran</th>
                                                <th>Sisa</th>
                                            </tr>
                                        </thead>

                                        <tbody>
                                            <c:choose>
                                                <c:when test="${empty monthlySummary}">
                                                    <tr>
                                                        <td colspan="4" class="text-center text-muted py-4">
                                                            Belum ada data statistik.
                                                        </td>
                                                    </tr>
                                                </c:when>

                                                <c:otherwise>
                                                    <c:forEach var="monthly" items="${monthlySummary}">
                                                        <tr>
                                                            <td>Bulan ${monthly.month}</td>

                                                            <td class="text-success fw-semibold">
                                                                Rp
                                                                <fmt:formatNumber value="${monthly.totalIncome}"
                                                                    type="number" groupingUsed="true"
                                                                    maxFractionDigits="0" />
                                                            </td>

                                                            <td class="text-danger fw-semibold">
                                                                Rp
                                                                <fmt:formatNumber value="${monthly.totalExpense}"
                                                                    type="number" groupingUsed="true"
                                                                    maxFractionDigits="0" />
                                                            </td>

                                                            <td class="fw-semibold">
                                                                Rp
                                                                <fmt:formatNumber
                                                                    value="${monthly.totalIncome - monthly.totalExpense}"
                                                                    type="number" groupingUsed="true"
                                                                    maxFractionDigits="0" />
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:otherwise>
                                            </c:choose>
                                        </tbody>
                                    </table>
                                </div>

                            </div>
                        </div>
                    </div>

                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                
            </body>

            </html>