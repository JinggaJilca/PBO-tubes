<%@ page isELIgnored="false" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <title>FinTrack - Dashboard</title>

    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Instrument+Sans:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>

<body>

    <!-- NAVBAR -->
    <nav class="navbar navbar-expand-lg navbar-custom py-3 text-white">
        <div class="container">

            <a class="navbar-brand" href="${pageContext.request.contextPath}/dashboard">
                <img src="${pageContext.request.contextPath}/images/FLogo.png" class="navbar-logo" alt="FinTrack Logo">
            </a>

            <button class="navbar-toggler text-white border-0" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false"
                aria-label="Toggle navigation">
                <i class="bi bi-list fs-1"></i>
            </button>

            <div class="collapse navbar-collapse justify-content-center" id="navbarNav">
                <ul class="navbar-nav gap-5 align-items-center">
                    <li class="nav-item">
                        <a class="nav-link text-white px-3 d-flex align-items-center gap-2" href="wallet.jsp">
                            <i class="bi bi-wallet2 fs-4"></i> Wallet
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white px-3 d-flex align-items-center gap-2" href="transaction.jsp">
                            <i class="bi bi-cash-coin fs-4"></i> Transaction
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white px-3 d-flex align-items-center gap-2" href="budget.jsp">
                            <i class="bi bi-piggy-bank fs-4"></i> Budget
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
                                <c:when test="${not empty requestScope.username}">${requestScope.username}</c:when>
                                <c:otherwise>Julio Tanlain</c:otherwise>
                            </c:choose>
                        </span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2">
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/profile">
                                <i class="bi bi-person me-2"></i>Profile
                            </a>
                        </li>
                        <li><hr class="dropdown-divider"></li>
                        <li>
                            <form action="${pageContext.request.contextPath}/logout" method="POST" class="m-0">
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
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <p class="mb-1 text-light-teal">Good Morning,</p>
                    <h2 class="fw-bold mb-0 fs-1">
                        <c:choose>
                            <c:when test="${not empty requestScope.username}">${requestScope.username}</c:when>
                            <c:otherwise>Julio Tanlain</c:otherwise>
                        </c:choose>
                    </h2>
                </div>

                <div class="d-flex align-items-center gap-3">
                    <button class="btn-eye-dash" id="btnToggleDash" title="Toggle visibility">
                        <i class="bi bi-eye-fill" id="eyeIconDash"></i>
                    </button>

                    <button class="btn-date-dash">
                        <i class="bi bi-calendar3"></i>
                        <c:choose>
                            <c:when test="${not empty selectedMonth}">${selectedMonth} ${selectedYear}</c:when>
                            <c:otherwise>June 2026</c:otherwise>
                        </c:choose>
                        <i class="bi bi-chevron-down"></i>
                    </button>

                    <button class="btn-date-dash">
                        <i class="bi bi-calendar3"></i>
                        <c:choose>
                            <c:when test="${not empty selectedMonth}">${selectedMonth} ${selectedYear}</c:when>
                            <c:otherwise>June 2026</c:otherwise>
                        </c:choose>
                        <i class="bi bi-chevron-down"></i>
                    </button>

                    <button class="btn-date-dash">
                        <i class="bi bi-download"></i>
                        Export Data
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- DASHBOARD CONTENT -->
    <div class="container overlap-container mb-5">

        <!-- ROW 1: SUMMARY CARDS -->
        <div class="row g-3 mb-4">

            <!-- BALANCE -->
            <div class="col-12 col-md-6 col-lg-3">
                <div class="dash-card">
                    <h6>Balance</h6>
                    <p class="amount" id="valBalance">
                        Rp.<fmt:formatNumber
                            value="${summary.totalBalance != null ? summary.totalBalance : 944810111.99}"
                            type="number" groupingUsed="true" maxFractionDigits="2" minFractionDigits="2"/>
                    </p>
                    <p class="last-month">
                        Last month : <span id="valBalanceLast">
                            Rp. <fmt:formatNumber
                                value="${summary.lastMonthBalance != null ? summary.lastMonthBalance : 769998245.19}"
                                type="number" groupingUsed="true" maxFractionDigits="2" minFractionDigits="2"/>
                        </span>
                    </p>
                </div>
            </div>

            <!-- EARNINGS -->
            <div class="col-12 col-md-6 col-lg-3">
                <div class="dash-card">
                    <button class="btn-add-card"><i class="bi bi-plus"></i></button>
                    <h6>Earnings</h6>
                    <p class="amount" id="valEarnings">
                        Rp.<fmt:formatNumber
                            value="${summary.totalEarnings != null ? summary.totalEarnings : 97453753.88}"
                            type="number" groupingUsed="true" maxFractionDigits="2" minFractionDigits="2"/>
                    </p>
                    <p class="last-month">
                        Last month : <span id="valEarningsLast">
                            Rp. <fmt:formatNumber
                                value="${summary.lastMonthEarnings != null ? summary.lastMonthEarnings : 456986245.19}"
                                type="number" groupingUsed="true" maxFractionDigits="2" minFractionDigits="2"/>
                        </span>
                    </p>
                </div>
            </div>

            <!-- SPENDING -->
            <div class="col-12 col-md-6 col-lg-3">
                <div class="dash-card">
                    <button class="btn-add-card"><i class="bi bi-plus"></i></button>
                    <h6>Spending</h6>
                    <p class="amount" id="valSpending">
                        Rp.<fmt:formatNumber
                            value="${summary.totalSpending != null ? summary.totalSpending : 13890000.99}"
                            type="number" groupingUsed="true" maxFractionDigits="2" minFractionDigits="2"/>
                    </p>
                    <p class="last-month">
                        Last month : <span id="valSpendingLast">
                            Rp. <fmt:formatNumber
                                value="${summary.lastMonthSpending != null ? summary.lastMonthSpending : 67998245.19}"
                                type="number" groupingUsed="true" maxFractionDigits="2" minFractionDigits="2"/>
                        </span>
                    </p>
                </div>
            </div>

            <!-- SPENDING OVERVIEW -->
            <div class="col-12 col-md-6 col-lg-3">
                <div class="dash-card">
                    <h6>Spending Overview</h6>
                    <p class="amount" id="valSpendOverview">Rp.13.890.000,99</p>
                    <p class="from-label">From <span id="valSpendFrom">Rp.20.000.000,00</span></p>

                    <div class="spending-bar-wrap" id="spendBar">
                        <div class="seg seg-food"  style="width:48%"></div>
                        <div class="seg seg-shop"  style="width:30%"></div>
                        <div class="seg seg-trans" style="width:22%"></div>
                    </div>

                    <div class="spending-legend">
                        <div class="legend-row">
                            <div class="d-flex align-items-center">
                                <div class="legend-dot seg-food"></div> Food & Drinks
                            </div>
                            <span id="legFood">Rp6.250.500</span>
                        </div>
                        <div class="legend-row">
                            <div class="d-flex align-items-center">
                                <div class="legend-dot seg-shop"></div> Shopping
                            </div>
                            <span id="legShop">Rp4.028.100</span>
                        </div>
                        <div class="legend-row">
                            <div class="d-flex align-items-center">
                                <div class="legend-dot seg-trans"></div> Transportation
                            </div>
                            <span id="legTrans">Rp2.361.401</span>
                        </div>
                    </div>

                    <hr>

                    <small class="text-muted">
                        Last month : <%= rupiah.format(lastMonthIncome) %>
                    </small>
                </div>
            </div>

        </div>

        <!-- ROW 2: CHART + RECENT ACTIVITY -->
        <div class="row g-3">

            <!-- CHART -->
            <div class="col-12 col-lg-6">
                <div class="chart-card">
                    <div class="d-flex justify-content-between align-items-start mb-3 flex-wrap gap-2">
                        <div>
                            <h6>Transactions Overview</h6>
                            <p class="chart-amount" id="valChartAmount">Rp.13.890.000,99</p>
                        </div>
                        <div class="d-flex align-items-center gap-3 flex-wrap">
                            <div class="chart-legend-item">
                                <span class="chart-legend-dot" style="background:#9EDE04;"></span>
                                Total Transaction
                            </div>
                            <div class="chart-legend-item">
                                <span class="chart-legend-dot" style="background:#d0d0d0;"></span>
                                Earnings
                            </div>
                            <button class="btn-date-dash btn-date-sm">
                                <i class="bi bi-calendar3"></i> June 2026 <i class="bi bi-chevron-down"></i>
                            </button>
                        </div>
                    </div>
                    <canvas id="txChart" height="180"></canvas>
                </div>
            </div>

            <!-- RECENT ACTIVITY -->
            <div class="col-12 col-lg-6">
                <div class="activity-card">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h6 class="mb-0">Recent Activity</h6>
                        <button class="btn-sortby">
                            <i class="bi bi-filter-left"></i> Sort by <i class="bi bi-chevron-down"></i>
                        </button>
                    </div>

                    <div style="overflow-x:auto;">
                        <table class="activity-table">
                            <thead>
                                <tr>
                                    <th>Category</th>
                                    <th>Nominal</th>
                                    <th>Date</th>
                                    <th>Time</th>
                                    <th>Details</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${not empty recentActivities}">
                                        <c:forEach var="activity" items="${recentActivities}">
                                            <tr>
                                                <td>${activity.categoryName}</td>
                                                <td class="nominal-val">
                                                    Rp.<fmt:formatNumber value="${activity.amount}"
                                                        type="number" groupingUsed="true"
                                                        maxFractionDigits="2" minFractionDigits="2"/>
                                                </td>
                                                <td><fmt:formatDate value="${activity.transactionDate}" pattern="dd MMM, yyyy"/></td>
                                                <td><fmt:formatDate value="${activity.transactionDate}" pattern="hh:mm a"/></td>
                                                <td>${activity.transactionName}</td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach begin="1" end="10">
                                            <tr>
                                                <td>Transportation</td>
                                                <td class="nominal-val">Rp.10.250.000,00</td>
                                                <td>14 Apr, 2026</td>
                                                <td>10:30 AM</td>
                                                <td>Tiket Pesawat</td>
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

    <script>
        // =============================================
        // CHART SETUP
        // =============================================
        const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Des'];

        const realData = [
            <c:choose>
                <c:when test="${not empty monthlySummary}">
                    <c:forEach var="m" items="${monthlySummary}" varStatus="st">
                        ${m.totalIncome}<c:if test="${!st.last}">,</c:if>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    5000000, 15000000, 8000000, 32000000, 25000000, 13890000,
                    35000000, 28000000, 42000000, 20000000, 10000000, 30000000
                </c:otherwise>
            </c:choose>
        ];

        const flatData = new Array(12).fill(0);
        let chartHidden = false;

        const ctx = document.getElementById('txChart').getContext('2d');

        const txChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: months,
                datasets: [
                    {
                        label: 'Total Transaction',
                        data: [...realData],
                        backgroundColor: months.map((_, i) => i === 5 ? '#9EDE04' : '#d8d8d8'),
                        borderRadius: 6,
                        barPercentage: 0.6
                    },
                    {
                        label: 'Earnings',
                        data: [...realData].map(v => v * 0.4),
                        backgroundColor: 'transparent',
                        borderColor: '#c8e6c9',
                        borderWidth: 2,
                        type: 'line',
                        tension: 0.4,
                        pointRadius: 0
                    }
                ]
            },
            options: {
                responsive: true,
                plugins: { legend: { display: false } },
                scales: {
                    x: { grid: { display: false }, border: { display: false } },
                    y: {
                        grid: { color: '#f0f0f0' },
                        border: { display: false },
                        ticks: {
                            callback: v => (v / 1000000) + ' M'
                        }
                    }
                }
            }
        });

        // =============================================
        // EYE TOGGLE
        // =============================================
        const MASK = '****';

        const sensitiveEls = [
            { id: 'valBalance' },
            { id: 'valBalanceLast' },
            { id: 'valEarnings' },
            { id: 'valEarningsLast' },
            { id: 'valSpending' },
            { id: 'valSpendingLast' },
            { id: 'valSpendOverview' },
            { id: 'valSpendFrom' },
            { id: 'valChartAmount' },
            { id: 'legFood' },
            { id: 'legShop' },
            { id: 'legTrans' }
        ];

        // Nominal table cells
        const nominalCells = document.querySelectorAll('.nominal-val');
        const originalNominals = Array.from(nominalCells).map(el => el.textContent.trim());

        // Store originals
        sensitiveEls.forEach(item => {
            const el = document.getElementById(item.id);
            if (el) item.original = el.textContent.trim();
        });

        let hidden = false;

        document.getElementById('btnToggleDash').addEventListener('click', function () {
            hidden = !hidden;

            // Toggle text values
            sensitiveEls.forEach(item => {
                const el = document.getElementById(item.id);
                if (el) el.textContent = hidden ? MASK : item.original;
            });

            // Toggle table nominals
            nominalCells.forEach((el, i) => {
                el.textContent = hidden ? MASK : originalNominals[i];
            });

            // Toggle chart
            if (hidden) {
                txChart.data.datasets[0].data = flatData;
                txChart.data.datasets[1].data = flatData;
            } else {
                txChart.data.datasets[0].data = [...realData];
                txChart.data.datasets[1].data = [...realData].map(v => v * 0.4);
            }
            txChart.update();

            // Toggle eye icon
            document.getElementById('eyeIconDash').className =
                hidden ? 'bi bi-eye-slash-fill' : 'bi bi-eye-fill';
        });
    </script>

</body>
</html>