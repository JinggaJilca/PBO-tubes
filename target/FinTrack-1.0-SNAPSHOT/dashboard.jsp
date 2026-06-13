<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@page import="java.text.NumberFormat" %>
        <%@page import="java.util.Locale" %>
            <%@page import="java.util.List" %>
                <%@page import="model.DashboardSummary" %>
                    <%@page import="model.RecentActivity" %>
                        <%@page import="model.CategorySpendingSummary" %>

                            <% String username=(String) request.getAttribute("username"); DashboardSummary
                                summary=(DashboardSummary) request.getAttribute("summary"); List<RecentActivity>
                                recentActivities =
                                (List<RecentActivity>) request.getAttribute("recentActivities");

                                    List<CategorySpendingSummary> spendingOverview =
                                        (List<CategorySpendingSummary>) request.getAttribute("spendingOverview");

                                        String monthlyLabelsJson = (String)
                                        request.getAttribute("monthlyLabelsJson");
                                        String monthlyIncomeJson = (String)
                                        request.getAttribute("monthlyIncomeJson");
                                        String monthlyExpenseJson = (String)
                                        request.getAttribute("monthlyExpenseJson");

                                        String categoryLabelsJson = (String)
                                        request.getAttribute("categoryLabelsJson");
                                        String categoryAmountJson = (String)
                                        request.getAttribute("categoryAmountJson");

                                        if (username == null || username.trim().isEmpty()) {
                                        username = "User";
                                        }

                                        if (monthlyLabelsJson == null || monthlyLabelsJson.trim().isEmpty()) {
                                        monthlyLabelsJson = "[]";
                                        }

                                        if (monthlyIncomeJson == null || monthlyIncomeJson.trim().isEmpty()) {
                                        monthlyIncomeJson = "[]";
                                        }

                                        if (monthlyExpenseJson == null || monthlyExpenseJson.trim().isEmpty()) {
                                        monthlyExpenseJson = "[]";
                                        }

                                        if (categoryLabelsJson == null || categoryLabelsJson.trim().isEmpty()) {
                                        categoryLabelsJson = "[]";
                                        }

                                        if (categoryAmountJson == null || categoryAmountJson.trim().isEmpty()) {
                                        categoryAmountJson = "[]";
                                        }

                                        Locale indonesia = new Locale("id", "ID");
                                        NumberFormat rupiah = NumberFormat.getCurrencyInstance(indonesia);
                                        rupiah.setMaximumFractionDigits(0);
                                        rupiah.setMinimumFractionDigits(0);

                                        double balance = 0;
                                        double totalIncome = 0;
                                        double totalExpense = 0;
                                        double lastMonthBalance = 0;
                                        double lastMonthIncome = 0;
                                        double lastMonthExpense = 0;

                                        if (summary != null) {
                                        balance = summary.getTotalBalance();
                                        totalIncome = summary.getTotalEarnings();
                                        totalExpense = summary.getTotalSpending();
                                        lastMonthBalance = summary.getLastMonthBalance();
                                        lastMonthIncome = summary.getLastMonthEarnings();
                                        lastMonthExpense = summary.getLastMonthSpending();
                                        }
                                        %>

                                        <!DOCTYPE html>
                                        <html lang="id">

                                        <head>
                                            <meta charset="UTF-8">
                                            <title>FinTrack - Dashboard</title>

                                            <link rel="icon" type="image/png"
                                                href="<%= request.getContextPath() %>/images/favicon.png">

                                            <!-- Bootstrap CSS -->
                                            <link
                                                href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css"
                                                rel="stylesheet">

                                            <!-- Bootstrap Icons -->
                                            <link rel="stylesheet"
                                                href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

                                            <!-- Font -->
                                            <link
                                                href="https://fonts.googleapis.com/css2?family=Instrument+Sans:wght@400;600;700&display=swap"
                                                rel="stylesheet">

                                            <!-- CSS project kamu -->
                                            <link rel="stylesheet" type="text/css"
                                                href="<%= request.getContextPath() %>/css/style.css">

                                            <script>
                                                window.setTransactionType = function (type) {
                                                    const transactionType = document.getElementById("transactionType");
                                                    const modalLabel = document.getElementById("addTransactionModalLabel");

                                                    if (transactionType) {
                                                        transactionType.value = type;
                                                    }

                                                    if (modalLabel) {
                                                        modalLabel.innerText = type === "income"
                                                            ? "Tambah Pemasukan"
                                                            : "Tambah Pengeluaran";
                                                    }
                                                };
                                            </script>

                                            <!-- <style>
                                                    body {
                                                        background-color: #f5f7f6;
                                                        font-family: "Instrument Sans", Arial, sans-serif;
                                                    }

                                                    .navbar-custom {
                                                        background-color: #073f31;
                                                    }

                                                    .navbar-logo {
                                                        height: 42px;
                                                        max-width: 150px;
                                                        object-fit: contain;
                                                    }

                                                    .icon-circle,
                                                    .profile-circle {
                                                        width: 42px;
                                                        height: 42px;
                                                        border-radius: 50%;
                                                        background-color: rgba(255, 255, 255, 0.14);
                                                        color: white;
                                                        display: flex;
                                                        justify-content: center;
                                                        align-items: center;
                                                    }

                                                    .dashboard-header {
                                                        background-color: #073f31;
                                                        color: white;
                                                        padding: 28px 0 90px;
                                                    }

                                                    .text-light-teal {
                                                        color: #cde7dd;
                                                    }

                                                    .overlap-container {
                                                        margin-top: -60px;
                                                    }

                                                    .fintrack-card {
                                                        border: none;
                                                        border-radius: 22px;
                                                        box-shadow: 0 6px 18px rgba(15, 23, 42, 0.08);
                                                    }

                                                    
                                                </style> -->
                                        </head>

                                    <body>

                                        <!-- NAVBAR -->
                                        <jsp:include page="navbar.jsp" />

                                        <!-- DASHBOARD HEADER -->
                                        <div class="dashboard-header">
                                            <div class="container">
                                                <div
                                                    class="d-flex justify-content-between align-items-end flex-wrap gap-3">
                                                    <div>
                                                        <p class="mb-1 text-light-teal">Good Morning,</p>
                                                        <h2 class="fw-bold mb-0 fs-1">
                                                            <%= username %>
                                                        </h2>
                                                    </div>

                                                    <form
                                                        action="<%= request.getContextPath() %>/DashboardExportServlet"
                                                        method="GET" class="m-0">
                                                        <button type="submit"
                                                            class="btn btn-date d-flex align-items-center gap-2">
                                                            <i class="bi bi-download"></i>
                                                            Export Data
                                                        </button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- DASHBOARD CONTENT -->
                                        <div class="container overlap-container mb-5">

                                            <!-- SUMMARY CARD -->
                                            <div class="row g-4 mb-4">

                                                <!-- BALANCE -->
                                                <div class="col-12 col-md-6 col-lg-3">
                                                    <div class="card fintrack-card summary-card p-3">
                                                        <div class="card-body">
                                                            <h6 class="fw-bold text-dark mb-3">Balance</h6>

                                                            <div class="summary-value">
                                                                <%= rupiah.format(balance) %>
                                                            </div>

                                                            <hr>

                                                            <small class="text-muted">
                                                                Last month : <%= rupiah.format(lastMonthBalance) %>
                                                            </small>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- EARNINGS -->
                                                <div class="col-12 col-md-6 col-lg-3">
                                                    <div class="card fintrack-card summary-card p-3">
                                                        <div class="card-body">
                                                            <div
                                                                class="d-flex justify-content-between align-items-start mb-3">
                                                                <h6 class="fw-bold text-dark mb-1">Earnings</h6>

                                                                <button type="button"
                                                                    class="btn p-0 border-0 bg-transparent"
                                                                    data-bs-toggle="modal"
                                                                    data-bs-target="#addTransactionModal"
                                                                    onclick="setTransactionType('income')">
                                                                    <i
                                                                        class="bi bi-plus-circle-fill fs-5 text-success"></i>
                                                                </button>
                                                            </div>

                                                            <div class="summary-value">
                                                                <%= rupiah.format(totalIncome) %>
                                                            </div>

                                                            <hr>

                                                            <small class="text-muted">
                                                                Last month : <%= rupiah.format(lastMonthIncome) %>
                                                            </small>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- SPENDING -->
                                                <div class="col-12 col-md-6 col-lg-3">
                                                    <div class="card fintrack-card summary-card p-3">
                                                        <div class="card-body">
                                                            <div
                                                                class="d-flex justify-content-between align-items-start mb-3">
                                                                <h6 class="fw-bold text-dark mb-1">Spending</h6>

                                                                <button type="button"
                                                                    class="btn p-0 border-0 bg-transparent"
                                                                    data-bs-toggle="modal"
                                                                    data-bs-target="#addTransactionModal"
                                                                    onclick="setTransactionType('expense')">
                                                                    <i
                                                                        class="bi bi-plus-circle-fill fs-5 text-success"></i>
                                                                </button>
                                                            </div>

                                                            <div class="summary-value">
                                                                <%= rupiah.format(totalExpense) %>
                                                            </div>

                                                            <hr>

                                                            <small class="text-muted">
                                                                Last month : <%= rupiah.format(lastMonthExpense) %>
                                                            </small>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- SPENDING OVERVIEW MINI -->
                                                <div class="col-12 col-md-6 col-lg-3">
                                                    <div class="card fintrack-card summary-card p-3">
                                                        <div class="card-body">
                                                            <h6 class="fw-bold text-dark mb-1">Spending Overview
                                                            </h6>

                                                            <div class="summary-value">
                                                                <%= rupiah.format(totalExpense) %>
                                                            </div>

                                                            <small class="text-muted">
                                                                From <%= rupiah.format(totalIncome) %>
                                                            </small>

                                                            <div class="mini-chart-wrapper">
                                                                <canvas id="categorySpendingChart"></canvas>
                                                            </div>

                                                            <div class="spending-mini-list">
                                                                <% if (spendingOverview !=null &&
                                                                    !spendingOverview.isEmpty()) { int max=Math.min(3,
                                                                    spendingOverview.size()); for (int i=0; i < max;
                                                                    i++) { CategorySpendingSummary
                                                                    category=spendingOverview.get(i); String
                                                                    dotClass="legend-olive" ; if (i==0) {
                                                                    dotClass="legend-orange" ; } else if (i==1) {
                                                                    dotClass="legend-yellow" ; } %>
                                                                    <div class="spending-mini-item">
                                                                        <div class="spending-mini-left">
                                                                            <span
                                                                                class="legend-dot <%= dotClass %>"></span>
                                                                            <span>
                                                                                <%= category.getCategoryName() %>
                                                                            </span>
                                                                        </div>

                                                                        <span>
                                                                            <%= rupiah.format(category.getTotalAmount())
                                                                                %>
                                                                        </span>
                                                                    </div>
                                                                    <% } } else { %>
                                                                        <div class="spending-mini-item">
                                                                            <span class="text-muted">Belum ada
                                                                                data spending.</span>
                                                                        </div>
                                                                        <% } %>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>

                                            </div>

                                            <!-- MAIN CHART + RECENT ACTIVITY -->
                                            <div class="row g-4">

                                                <!-- TRANSACTIONS OVERVIEW -->
                                                <div class="col-12 col-lg-7">
                                                    <div
                                                        class="card fintrack-card activity-card p-4 activity-card-compact">
                                                        <div
                                                            class="d-flex justify-content-between align-items-start mb-3 flex-wrap gap-2">
                                                            <div>
                                                                <h6 class="fw-bold text-dark mb-1">Transactions
                                                                    Overview</h6>

                                                                <h3 class="chart-card-title">
                                                                    <%= rupiah.format(totalExpense) %>
                                                                </h3>
                                                            </div>

                                                            <a href="<%= request.getContextPath() %>/DashboardExportServlet"
                                                                class="btn btn-date-light d-flex align-items-center gap-2">
                                                                <i class="bi bi-download"></i>
                                                                Export This Month
                                                            </a>
                                                        </div>

                                                        <div class="legend-inline">
                                                            <span><span
                                                                    class="legend-dot legend-green"></span>Spending</span>
                                                            <span><span
                                                                    class="legend-dot legend-gray"></span>Earnings</span>
                                                        </div>

                                                        <div class="chart-wrapper">
                                                            <canvas id="monthlyTransactionChart"></canvas>
                                                        </div>

                                                        <div id="monthlyChartInfo" class="text-muted small mt-2"></div>
                                                    </div>
                                                </div>

                                                <!-- RECENT ACTIVITY TABLE -->
                                                <div class="col-12 col-lg-5">
                                                    <div
                                                        class="card fintrack-card activity-card p-4 activity-card-compact">
                                                        <div
                                                            class="d-flex justify-content-between align-items-center mb-4">
                                                            <h6 class="fw-bold text-dark mb-0">Recent Activity
                                                            </h6>

                                                            <button type="button"
                                                                class="btn btn-date-light d-flex align-items-center gap-2">
                                                                <i class="bi bi-filter"></i>
                                                                Sort by
                                                                <i class="bi bi-chevron-down"></i>
                                                            </button>
                                                        </div>

                                                        <div class="table-responsive">
                                                            <table class="table activity-table align-middle">
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
                                                                    <% if (recentActivities !=null &&
                                                                        !recentActivities.isEmpty()) { for
                                                                        (RecentActivity activity : recentActivities) {
                                                                        boolean isIncome="income"
                                                                        .equalsIgnoreCase(activity.getTransactionType());
                                                                        %>
                                                                        <tr>
                                                                            <td>
                                                                                <%= activity.getCategoryName() %>
                                                                            </td>

                                                                            <td>
                                                                                <% if (isIncome) { %>
                                                                                    <span class="text-success">
                                                                                        + <%=
                                                                                            rupiah.format(activity.getAmount())
                                                                                            %>
                                                                                    </span>
                                                                                    <% } else { %>
                                                                                        <span class="text-danger">
                                                                                            - <%=
                                                                                                rupiah.format(activity.getAmount())
                                                                                                %>
                                                                                        </span>
                                                                                        <% } %>
                                                                            </td>

                                                                            <td>
                                                                                <%= activity.getDate() %>
                                                                            </td>
                                                                            <td>
                                                                                <%= activity.getTime() %>
                                                                            </td>
                                                                            <td>
                                                                                <%= activity.getTransactionName() %>
                                                                            </td>
                                                                        </tr>
                                                                        <% } } else { %>
                                                                            <tr>
                                                                                <td colspan="5" class="empty-data">
                                                                                    Belum ada transaksi terbaru.
                                                                                </td>
                                                                            </tr>
                                                                            <% } %>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>

                                            <!-- SPENDING DETAIL -->
                                            <div class="row g-4 mt-1">
                                                <div class="col-12">
                                                    <div class="card fintrack-card activity-card p-4">
                                                        <h6 class="fw-bold text-dark mb-3">Spending Detail by
                                                            Category</h6>

                                                        <div class="table-responsive">
                                                            <table class="table activity-table align-middle">
                                                                <thead>
                                                                    <tr>
                                                                        <th>No</th>
                                                                        <th>Category</th>
                                                                        <th>Total Amount</th>
                                                                        <th>Percentage</th>
                                                                    </tr>
                                                                </thead>

                                                                <tbody>
                                                                    <% if (spendingOverview !=null &&
                                                                        !spendingOverview.isEmpty()) { int no=1; for
                                                                        (CategorySpendingSummary category :
                                                                        spendingOverview) { %>
                                                                        <tr>
                                                                            <td>
                                                                                <%= no++ %>
                                                                            </td>
                                                                            <td>
                                                                                <%= category.getCategoryName() %>
                                                                            </td>
                                                                            <td>
                                                                                <%= rupiah.format(category.getTotalAmount())
                                                                                    %>
                                                                            </td>
                                                                            <td>
                                                                                <%= String.format("%.2f",
                                                                                    category.getPercentage()) %>
                                                                                    %
                                                                            </td>
                                                                        </tr>
                                                                        <% } } else { %>
                                                                            <tr>
                                                                                <td colspan="4" class="empty-data">
                                                                                    Belum ada data pengeluaran
                                                                                    per kategori.
                                                                                </td>
                                                                            </tr>
                                                                            <% } %>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>

                                        <!-- MODAL ADD TRANSACTION -->
                                        <div class="modal fade" id="addTransactionModal" tabindex="-1"
                                            aria-labelledby="addTransactionModalLabel" aria-hidden="true">

                                            <div class="modal-dialog modal-dialog-centered">
                                                <form action="<%= request.getContextPath() %>/AddTransactionServlet"
                                                    method="POST" class="modal-content">

                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="addTransactionModalLabel">
                                                            Tambah Transaksi
                                                        </h5>

                                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                            aria-label="Close"></button>
                                                    </div>

                                                    <div class="modal-body">

                                                        <input type="hidden" name="transactionType"
                                                            id="transactionType">

                                                        <div class="mb-3">
                                                            <label class="form-label">Nama Transaksi</label>
                                                            <input type="text" name="transactionName"
                                                                class="form-control" required>
                                                        </div>

                                                        <div class="mb-3">
                                                            <label class="form-label">Nominal</label>
                                                            <input type="number" step="0.01" name="amount"
                                                                class="form-control" min="1" required>
                                                        </div>

                                                        <div class="mb-3">
                                                            <label class="form-label">Wallet ID</label>
                                                            <input type="number" name="accountId" class="form-control"
                                                                placeholder="Contoh: 1" required>
                                                        </div>

                                                        <div class="mb-3">
                                                            <label class="form-label">Category ID</label>
                                                            <input type="number" name="categoryId" class="form-control"
                                                                placeholder="Contoh: 1" required>
                                                        </div>

                                                        <div class="mb-3">
                                                            <label class="form-label">Catatan</label>
                                                            <textarea name="note" class="form-control"
                                                                rows="3"></textarea>
                                                        </div>

                                                    </div>

                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary"
                                                            data-bs-dismiss="modal">
                                                            Batal
                                                        </button>

                                                        <button type="submit" class="btn btn-success">
                                                            Simpan Transaksi
                                                        </button>
                                                    </div>

                                                </form>
                                            </div>
                                        </div>

                                        <!-- Bootstrap JS: pakai cdnjs, bukan jsDelivr -->
                                        <script
                                            src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

                                        <!-- Chart.js: pakai cdnjs, bukan jsDelivr -->
                                        <script
                                            src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.1/chart.umd.min.js"></script>

                                        <!-- DATA JSON DARI SERVLET -->
                                        <script type="application/json"
                                            id="monthlyLabelsData"><%= monthlyLabelsJson %></script>
                                        <script type="application/json"
                                            id="monthlyIncomeData"><%= monthlyIncomeJson %></script>
                                        <script type="application/json"
                                            id="monthlyExpenseData"><%= monthlyExpenseJson %></script>
                                        <script type="application/json"
                                            id="categoryLabelsData"><%= categoryLabelsJson %></script>
                                        <script type="application/json"
                                            id="categoryAmountsData"><%= categoryAmountJson %></script>

                                        <script>
                                            function parseJsonData(id) {
                                                const element = document.getElementById(id);

                                                if (!element) {
                                                    return [];
                                                }

                                                const text = element.textContent.trim();

                                                if (!text || text === "null") {
                                                    return [];
                                                }

                                                try {
                                                    return JSON.parse(text);
                                                } catch (error) {
                                                    console.error("Gagal parse JSON:", id, text, error);
                                                    return [];
                                                }
                                            }

                                            function normalizeMonthlyData(labels, income, expense) {
                                                if (!labels || labels.length === 0) {
                                                    labels = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
                                                }

                                                while (income.length < labels.length) {
                                                    income.push(0);
                                                }

                                                while (expense.length < labels.length) {
                                                    expense.push(0);
                                                }

                                                return {
                                                    labels: labels,
                                                    income: income,
                                                    expense: expense
                                                };
                                            }

                                            document.addEventListener("DOMContentLoaded", function () {
                                                console.log("Bootstrap:", typeof bootstrap);
                                                console.log("Chart:", typeof Chart);

                                                const monthlyLabels = parseJsonData("monthlyLabelsData");
                                                const monthlyIncome = parseJsonData("monthlyIncomeData");
                                                const monthlyExpense = parseJsonData("monthlyExpenseData");

                                                let categoryLabels = parseJsonData("categoryLabelsData");
                                                let categoryAmounts = parseJsonData("categoryAmountsData");

                                                const monthlyData = normalizeMonthlyData(monthlyLabels, monthlyIncome, monthlyExpense);

                                                const monthlyCanvas = document.getElementById("monthlyTransactionChart");
                                                const categoryCanvas = document.getElementById("categorySpendingChart");

                                                if (typeof Chart === "undefined") {
                                                    const info = document.getElementById("monthlyChartInfo");

                                                    if (info) {
                                                        info.innerText = "Chart.js tidak terbaca. Cek koneksi internet atau CDN.";
                                                    }

                                                    return;
                                                }

                                                if (monthlyCanvas) {
                                                    const currentMonthIndex = new Date().getMonth();

                                                    const expenseBarColors = monthlyData.expense.map(function (value, index) {
                                                        return index === currentMonthIndex ? "#9ACD32" : "#D9D9D9";
                                                    });

                                                    new Chart(monthlyCanvas, {
                                                        data: {
                                                            labels: monthlyData.labels,
                                                            datasets: [
                                                                {
                                                                    type: "bar",
                                                                    label: "Spending",
                                                                    data: monthlyData.expense,
                                                                    backgroundColor: expenseBarColors,
                                                                    borderRadius: 6,
                                                                    borderSkipped: false,
                                                                    barThickness: 24
                                                                },
                                                                {
                                                                    type: "line",
                                                                    label: "Earnings",
                                                                    data: monthlyData.income,
                                                                    borderColor: "#B7D86A",
                                                                    backgroundColor: "#B7D86A",
                                                                    pointRadius: 0,
                                                                    borderDash: [4, 4],
                                                                    tension: 0.35,
                                                                    fill: false
                                                                }
                                                            ]
                                                        },
                                                        options: {
                                                            responsive: true,
                                                            maintainAspectRatio: false,
                                                            plugins: {
                                                                legend: {
                                                                    display: false
                                                                },
                                                                tooltip: {
                                                                    callbacks: {
                                                                        label: function (context) {
                                                                            return context.dataset.label + ": Rp " +
                                                                                Number(context.raw).toLocaleString("id-ID");
                                                                        }
                                                                    }
                                                                }
                                                            },
                                                            scales: {
                                                                x: {
                                                                    grid: {
                                                                        display: false
                                                                    },
                                                                    ticks: {
                                                                        color: "#111827"
                                                                    }
                                                                },
                                                                y: {
                                                                    beginAtZero: true,
                                                                    grid: {
                                                                        color: "#E5E7EB"
                                                                    },
                                                                    ticks: {
                                                                        callback: function (value) {
                                                                            if (value >= 1000000) {
                                                                                return (value / 1000000) + " M";
                                                                            }

                                                                            return value;
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    });
                                                }

                                                if (categoryCanvas) {
                                                    if (!categoryLabels || categoryLabels.length === 0) {
                                                        categoryLabels = ["Belum ada data"];
                                                        categoryAmounts = [1];
                                                    }

                                                    if (!categoryAmounts || categoryAmounts.length === 0) {
                                                        categoryAmounts = [1];
                                                    }

                                                    const categoryColors = ["#D98C5F", "#D9A441", "#A8BE84", "#88A97D", "#C8D5B9"];

                                                    const stackedDatasets = categoryAmounts.map(function (amount, index) {
                                                        return {
                                                            label: categoryLabels[index] || "Kategori",
                                                            data: [amount],
                                                            backgroundColor: categoryColors[index % categoryColors.length],
                                                            borderWidth: 0,
                                                            borderRadius: 3,
                                                            barThickness: 18
                                                        };
                                                    });

                                                    new Chart(categoryCanvas, {
                                                        type: "bar",
                                                        data: {
                                                            labels: [""],
                                                            datasets: stackedDatasets
                                                        },
                                                        options: {
                                                            indexAxis: "y",
                                                            responsive: true,
                                                            maintainAspectRatio: false,
                                                            plugins: {
                                                                legend: {
                                                                    display: false
                                                                },
                                                                tooltip: {
                                                                    callbacks: {
                                                                        label: function (context) {
                                                                            return context.dataset.label + ": Rp " +
                                                                                Number(context.raw).toLocaleString("id-ID");
                                                                        }
                                                                    }
                                                                }
                                                            },
                                                            scales: {
                                                                x: {
                                                                    stacked: true,
                                                                    display: false
                                                                },
                                                                y: {
                                                                    stacked: true,
                                                                    display: false
                                                                }
                                                            }
                                                        }
                                                    });
                                                }
                                            });
                                        </script>

                                    </body>

                                    </html>