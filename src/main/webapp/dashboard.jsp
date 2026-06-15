<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@page import="java.text.NumberFormat" %>
        <%@page import="java.util.Locale" %>
            <%@page import="java.util.List" %>
                <%@page import="model.DashboardSummary" %>
                    <%@page import="model.RecentActivity" %>
                        <%@page import="model.CategorySpendingSummary" %>
                            <%@page import="model.Wallet" %>
                                <%@page import="model.Category" %>

                                    <% String username=(String) request.getAttribute("username"); List<Wallet> wallets =
                                        (List<Wallet>) request.getAttribute("wallets");
                                            List<Category> categories = (List<Category>)
                                                    request.getAttribute("categories");
                                                    DashboardSummary summary = (DashboardSummary)
                                                    request.getAttribute("summary");
                                                    List<RecentActivity> recentActivities = (List<RecentActivity>)
                                                            request.getAttribute("recentActivities");
                                                            List<CategorySpendingSummary> spendingOverview = (List
                                                                <CategorySpendingSummary>)
                                                                    request.getAttribute("spendingOverview");
                                                                    CategorySpendingSummary largestCategory =
                                                                    (CategorySpendingSummary)
                                                                    request.getAttribute("largestCategory");
                                                                    Double averageExpenseObject = (Double)
                                                                    request.getAttribute("averageExpense");
                                                                    double averageExpense = 0;
                                                                    if (averageExpenseObject != null) averageExpense =
                                                                    averageExpenseObject;

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

                                                                    if (username == null || username.trim().isEmpty())
                                                                    username = "User";
                                                                    if (monthlyLabelsJson == null ||
                                                                    monthlyLabelsJson.trim().isEmpty())
                                                                    monthlyLabelsJson = "[]";
                                                                    if (monthlyIncomeJson == null ||
                                                                    monthlyIncomeJson.trim().isEmpty())
                                                                    monthlyIncomeJson = "[]";
                                                                    if (monthlyExpenseJson == null ||
                                                                    monthlyExpenseJson.trim().isEmpty())
                                                                    monthlyExpenseJson = "[]";
                                                                    if (categoryLabelsJson == null ||
                                                                    categoryLabelsJson.trim().isEmpty())
                                                                    categoryLabelsJson = "[]";
                                                                    if (categoryAmountJson == null ||
                                                                    categoryAmountJson.trim().isEmpty())
                                                                    categoryAmountJson = "[]";

                                                                    Locale indonesia = new Locale("id", "ID");
                                                                    NumberFormat rupiah =
                                                                    NumberFormat.getCurrencyInstance(indonesia);
                                                                    rupiah.setMaximumFractionDigits(0);
                                                                    rupiah.setMinimumFractionDigits(0);

                                                                    double balance = 0, totalIncome = 0, totalExpense =
                                                                    0;
                                                                    double lastMonthBalance = 0, lastMonthIncome = 0,
                                                                    lastMonthExpense = 0;
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
                                                                    <html lang="en">

                                                                    <head>
                                                                        <meta charset="UTF-8">
                                                                        <title>FinTrack - Dashboard</title>
                                                                        <link rel="icon" type="image/png"
                                                                            href="<%= request.getContextPath() %>/images/favicon.png">
                                                                        <link
                                                                            href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css"
                                                                            rel="stylesheet">
                                                                        <link rel="stylesheet"
                                                                            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
                                                                        <link
                                                                            href="https://fonts.googleapis.com/css2?family=Instrument+Sans:wght@400;600;700&display=swap"
                                                                            rel="stylesheet">
                                                                        <link rel="stylesheet" type="text/css"
                                                                            href="<%= request.getContextPath() %>/css/style.css">

                                                                        <script>
                                                                            window.setTransactionType = function (type) {
                                                                                const incomeRadio = document.getElementById('typeIncome');
                                                                                const expenseRadio = document.getElementById('typeExpense');
                                                                                if (type === 'income' && incomeRadio) incomeRadio.checked = true;
                                                                                if (type === 'expense' && expenseRadio) expenseRadio.checked = true;
                                                                            };
                                                                        </script>
                                                                    </head>

                                                                    <body>

                                                                        <jsp:include page="navbar.jsp" />

                                                                        <!-- DASHBOARD HEADER -->
                                                                        <div class="dashboard-header">
                                                                            <div class="container">
                                                                                <div
                                                                                    class="d-flex justify-content-between align-items-center flex-wrap gap-3">
                                                                                    <div>
                                                                                        <p class="mb-1 text-light-teal">
                                                                                            Good Morning,</p>
                                                                                        <h2 class="fw-bold mb-0 fs-1">
                                                                                            <%= username %>
                                                                                        </h2>
                                                                                    </div>

                                                                                    <div
                                                                                        class="d-flex align-items-center gap-2 flex-wrap">
                                                                                        <!-- EYE TOGGLE -->
                                                                                        <button class="btn-eye-dash"
                                                                                            id="btnToggleDash"
                                                                                            title="Toggle visibility">
                                                                                            <i class="bi bi-eye-fill"
                                                                                                id="eyeIconDash"></i>
                                                                                        </button>

                                                                                        <!-- EXPORT -->
                                                                                        <form
                                                                                            action="<%= request.getContextPath() %>/DashboardExportServlet"
                                                                                            method="GET" class="m-0">
                                                                                            <button type="submit"
                                                                                                class="btn-date d-flex align-items-center gap-2">
                                                                                                <i
                                                                                                    class="bi bi-download"></i>
                                                                                                Export Data
                                                                                            </button>
                                                                                        </form>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <!-- DASHBOARD CONTENT -->
                                                                        <div class="container overlap-container mb-5">

                                                                            <!-- ROW 1: SUMMARY CARDS -->
                                                                            <div class="row g-4 mb-4">

                                                                                <!-- BALANCE -->
                                                                                <div class="col-12 col-md-6 col-lg-3">
                                                                                    <div
                                                                                        class="card fintrack-card summary-card p-3">
                                                                                        <div class="card-body">
                                                                                            <h6
                                                                                                class="fw-bold text-dark mb-3">
                                                                                                Balance</h6>
                                                                                            <div
                                                                                                class="summary-value maskable">
                                                                                                <%= rupiah.format(balance)
                                                                                                    %>
                                                                                            </div>
                                                                                            <hr>
                                                                                            <small
                                                                                                class="text-muted">Last
                                                                                                month : <span
                                                                                                    class="maskable">
                                                                                                    <%= rupiah.format(lastMonthBalance)
                                                                                                        %>
                                                                                                </span></small>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>

                                                                                <!-- EARNINGS -->
                                                                                <div class="col-12 col-md-6 col-lg-3">
                                                                                    <div
                                                                                        class="card fintrack-card summary-card p-3">
                                                                                        <div class="card-body">
                                                                                            <div
                                                                                                class="d-flex justify-content-between align-items-start mb-3">
                                                                                                <h6
                                                                                                    class="fw-bold text-dark mb-1">
                                                                                                    Earnings</h6>
                                                                                                <button type="button"
                                                                                                    class="btn p-0 border-0 bg-transparent"
                                                                                                    data-bs-toggle="modal"
                                                                                                    data-bs-target="#addTransactionModal"
                                                                                                    onclick="setTransactionType('income')">
                                                                                                    <i
                                                                                                        class="bi bi-plus-circle-fill fs-5 text-success"></i>
                                                                                                </button>
                                                                                            </div>
                                                                                            <div
                                                                                                class="summary-value maskable">
                                                                                                <%= rupiah.format(totalIncome)
                                                                                                    %>
                                                                                            </div>
                                                                                            <hr>
                                                                                            <small
                                                                                                class="text-muted">Last
                                                                                                month : <span
                                                                                                    class="maskable">
                                                                                                    <%= rupiah.format(lastMonthIncome)
                                                                                                        %>
                                                                                                </span></small>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>

                                                                                <!-- SPENDING -->
                                                                                <div class="col-12 col-md-6 col-lg-3">
                                                                                    <div
                                                                                        class="card fintrack-card summary-card p-3">
                                                                                        <div class="card-body">
                                                                                            <div
                                                                                                class="d-flex justify-content-between align-items-start mb-3">
                                                                                                <h6
                                                                                                    class="fw-bold text-dark mb-1">
                                                                                                    Spending</h6>
                                                                                                <button type="button"
                                                                                                    class="btn p-0 border-0 bg-transparent"
                                                                                                    data-bs-toggle="modal"
                                                                                                    data-bs-target="#addTransactionModal"
                                                                                                    onclick="setTransactionType('expense')">
                                                                                                    <i
                                                                                                        class="bi bi-plus-circle-fill fs-5 text-success"></i>
                                                                                                </button>
                                                                                            </div>
                                                                                            <div
                                                                                                class="summary-value maskable">
                                                                                                <%= rupiah.format(totalExpense)
                                                                                                    %>
                                                                                            </div>
                                                                                            <hr>
                                                                                            <small
                                                                                                class="text-muted">Last
                                                                                                month : <span
                                                                                                    class="maskable">
                                                                                                    <%= rupiah.format(lastMonthExpense)
                                                                                                        %>
                                                                                                </span></small>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>

                                                                                <!-- SPENDING OVERVIEW MINI -->
                                                                                <div class="col-12 col-md-6 col-lg-3">
                                                                                    <div class="card fintrack-card summary-card p-3"
                                                                                        style="overflow:hidden;">
                                                                                        <div class="card-body">
                                                                                            <h6
                                                                                                class="fw-bold text-dark mb-1">
                                                                                                Spending Overview</h6>
                                                                                            <div
                                                                                                class="summary-value maskable">
                                                                                                <%= rupiah.format(totalExpense)
                                                                                                    %>
                                                                                            </div>
                                                                                            <small
                                                                                                class="text-muted">From
                                                                                                <span class="maskable">
                                                                                                    <%= rupiah.format(totalIncome)
                                                                                                        %>
                                                                                                </span></small>

                                                                                            <div
                                                                                                class="mini-chart-wrapper">
                                                                                                <canvas
                                                                                                    id="categorySpendingChart"></canvas>
                                                                                            </div>

                                                                                            <div
                                                                                                class="spending-mini-list">
                                                                                                <% if (spendingOverview
                                                                                                    !=null &&
                                                                                                    !spendingOverview.isEmpty())
                                                                                                    { int
                                                                                                    max=Math.min(3,
                                                                                                    spendingOverview.size());
                                                                                                    for (int i=0; i <
                                                                                                    max; i++) {
                                                                                                    CategorySpendingSummary
                                                                                                    category=spendingOverview.get(i);
                                                                                                    String
                                                                                                    dotClass="legend-olive"
                                                                                                    ; if (i==0)
                                                                                                    dotClass="legend-orange"
                                                                                                    ; else if (i==1)
                                                                                                    dotClass="legend-yellow"
                                                                                                    ; %>
                                                                                                    <div
                                                                                                        class="spending-mini-item">
                                                                                                        <div
                                                                                                            class="spending-mini-left">
                                                                                                            <span
                                                                                                                class="legend-dot <%= dotClass %>"></span>
                                                                                                            <span>
                                                                                                                <%= category.getCategoryName()
                                                                                                                    %>
                                                                                                            </span>
                                                                                                        </div>
                                                                                                        <span
                                                                                                            class="maskable">
                                                                                                            <%= rupiah.format(category.getTotalAmount())
                                                                                                                %>
                                                                                                        </span>
                                                                                                    </div>
                                                                                                    <% } } else { %>
                                                                                                        <div
                                                                                                            class="spending-mini-item">
                                                                                                            <span
                                                                                                                class="text-muted">No
                                                                                                                spending
                                                                                                                data
                                                                                                                yet.</span>
                                                                                                        </div>
                                                                                                        <% } %>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>

                                                                            </div>

                                                                            <!-- ROW 2: CHART + RECENT ACTIVITY -->
                                                                            <div class="row g-4 mb-4">

                                                                                <!-- TRANSACTIONS OVERVIEW CHART -->
                                                                                <div class="col-12 col-lg-7">
                                                                                    <div
                                                                                        class="card fintrack-card activity-card p-4 activity-card-compact">
                                                                                        <div
                                                                                            class="d-flex justify-content-between align-items-start mb-3 flex-wrap gap-2">
                                                                                            <div>
                                                                                                <h6
                                                                                                    class="fw-bold text-dark mb-1">
                                                                                                    Transactions
                                                                                                    Overview</h6>
                                                                                                <h3
                                                                                                    class="chart-card-title maskable">
                                                                                                    <%= rupiah.format(totalExpense)
                                                                                                        %>
                                                                                                </h3>
                                                                                            </div>
                                                                                            <div
                                                                                                class="d-flex align-items-center gap-3 flex-wrap">
                                                                                                <div
                                                                                                    class="legend-inline mb-0">
                                                                                                    <span><span
                                                                                                            class="legend-dot legend-green"></span>
                                                                                                        Spending</span>
                                                                                                    <span><span
                                                                                                            class="legend-dot legend-gray"></span>
                                                                                                        Earnings</span>
                                                                                                </div>
                                                                                                <a href="<%= request.getContextPath() %>/DashboardExportServlet"
                                                                                                    class="btn btn-date-light d-flex align-items-center gap-2">
                                                                                                    <i
                                                                                                        class="bi bi-download"></i>
                                                                                                    Export
                                                                                                </a>
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="chart-wrapper">
                                                                                            <canvas
                                                                                                id="monthlyTransactionChart"></canvas>
                                                                                        </div>
                                                                                        <div id="monthlyChartInfo"
                                                                                            class="text-muted small mt-2">
                                                                                        </div>
                                                                                    </div>
                                                                                </div>

                                                                                <!-- RECENT ACTIVITY -->
                                                                                <div class="col-12 col-lg-5">
                                                                                    <div
                                                                                        class="card fintrack-card activity-card p-4 activity-card-compact">
                                                                                        <div
                                                                                            class="d-flex justify-content-between align-items-center mb-3">
                                                                                            <h6
                                                                                                class="fw-bold text-dark mb-0">
                                                                                                Recent Activity</h6>
                                                                                            <button type="button"
                                                                                                class="btn-sortby">
                                                                                                <i
                                                                                                    class="bi bi-filter"></i>
                                                                                                Sort by <i
                                                                                                    class="bi bi-chevron-down"></i>
                                                                                            </button>
                                                                                        </div>
                                                                                        <div class="table-responsive">
                                                                                            <table
                                                                                                class="activity-table w-100">
                                                                                                <thead>
                                                                                                    <tr>
                                                                                                        <th>Category
                                                                                                        </th>
                                                                                                        <th>Nominal</th>
                                                                                                        <th>Date</th>
                                                                                                        <th>Time</th>
                                                                                                        <th>Details</th>
                                                                                                    </tr>
                                                                                                </thead>
                                                                                                <tbody>
                                                                                                    <% if
                                                                                                        (recentActivities
                                                                                                        !=null &&
                                                                                                        !recentActivities.isEmpty())
                                                                                                        { for
                                                                                                        (RecentActivity
                                                                                                        activity :
                                                                                                        recentActivities)
                                                                                                        { boolean
                                                                                                        isIncome="income"
                                                                                                        .equalsIgnoreCase(activity.getTransactionType());
                                                                                                        %>
                                                                                                        <tr>
                                                                                                            <td>
                                                                                                                <%= activity.getCategoryName()
                                                                                                                    %>
                                                                                                            </td>
                                                                                                            <td>
                                                                                                                <% if
                                                                                                                    (isIncome)
                                                                                                                    { %>
                                                                                                                    <span
                                                                                                                        class="income-amount maskable">+
                                                                                                                        <%= rupiah.format(activity.getAmount())
                                                                                                                            %>
                                                                                                                    </span>
                                                                                                                    <% } else
                                                                                                                        {
                                                                                                                        %>
                                                                                                                        <span
                                                                                                                            class="expense-amount maskable">-
                                                                                                                            <%= rupiah.format(activity.getAmount())
                                                                                                                                %>
                                                                                                                        </span>
                                                                                                                        <% }
                                                                                                                            %>
                                                                                                            </td>
                                                                                                            <td>
                                                                                                                <%= activity.getDate()
                                                                                                                    %>
                                                                                                            </td>
                                                                                                            <td>
                                                                                                                <%= activity.getTime()
                                                                                                                    %>
                                                                                                            </td>
                                                                                                            <td>
                                                                                                                <%= activity.getTransactionName()
                                                                                                                    %>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                        <% } } else { %>
                                                                                                            <tr>
                                                                                                                <td colspan="5"
                                                                                                                    class="empty-data">
                                                                                                                    No
                                                                                                                    recent
                                                                                                                    transactions.
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                            <% } %>
                                                                                                </tbody>
                                                                                            </table>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>

                                                                            </div>

                                                                            <!-- ROW 3: ANALYSIS CARDS -->
                                                                            <div class="row g-4 align-items-stretch">

                                                                                <!-- HIGHEST SPENDING CATEGORY -->
                                                                                <div class="col-12 col-md-4">
                                                                                    <div
                                                                                        class="card fintrack-card p-4 h-100">
                                                                                        <div
                                                                                            class="d-flex align-items-center gap-2 mb-3">
                                                                                            <div
                                                                                                style="width:32px;height:32px;border-radius:10px;background:#fee2e2;display:flex;align-items:center;justify-content:center;">
                                                                                                <i class="bi bi-trophy-fill"
                                                                                                    style="color:#dc2626;font-size:0.9rem;"></i>
                                                                                            </div>
                                                                                            <h6
                                                                                                class="fw-bold text-dark mb-0">
                                                                                                Highest Spending
                                                                                                Category</h6>
                                                                                        </div>

                                                                                        <% if (largestCategory !=null) {
                                                                                            %>
                                                                                            <div
                                                                                                class="summary-value mb-1 maskable">
                                                                                                <%= largestCategory.getCategoryName()
                                                                                                    %>
                                                                                            </div>
                                                                                            <p class="mb-1 text-muted"
                                                                                                style="font-size:0.82rem;">
                                                                                                Total expense</p>
                                                                                            <h5
                                                                                                class="fw-bold mb-2 maskable">
                                                                                                <%= rupiah.format(largestCategory.getTotalAmount())
                                                                                                    %>
                                                                                            </h5>
                                                                                            <div class="progress"
                                                                                                style="height:8px;border-radius:999px;background:#f3f4f6;">
                                                                                                <div class="progress-bar"
                                                                                                    role="progressbar"
                                                                                                    style="width:<%= largestCategory.getPercentage() %>%;background:#dc2626;border-radius:999px;">
                                                                                                </div>
                                                                                            </div>
                                                                                            <small
                                                                                                class="text-muted mt-1 d-block">
                                                                                                <span class="maskable">
                                                                                                    <%= String.format("%.1f",
                                                                                                        largestCategory.getPercentage())
                                                                                                        %>%
                                                                                                </span>
                                                                                                of total spending this
                                                                                                month.
                                                                                            </small>
                                                                                            <% } else { %>
                                                                                                <div class="empty-data">
                                                                                                    No spending data
                                                                                                    this month.</div>
                                                                                                <% } %>
                                                                                    </div>
                                                                                </div>

                                                                                <!-- AVERAGE EXPENSE -->
                                                                                <div class="col-12 col-md-4">
                                                                                    <div
                                                                                        class="card fintrack-card p-4 h-100">
                                                                                        <div
                                                                                            class="d-flex align-items-center gap-2 mb-3">
                                                                                            <div
                                                                                                style="width:32px;height:32px;border-radius:10px;background:#dbeafe;display:flex;align-items:center;justify-content:center;">
                                                                                                <i class="bi bi-graph-up"
                                                                                                    style="color:#2563eb;font-size:0.9rem;"></i>
                                                                                            </div>
                                                                                            <h6
                                                                                                class="fw-bold text-dark mb-0">
                                                                                                Average Expense</h6>
                                                                                        </div>
                                                                                        <div
                                                                                            class="summary-value mb-2 maskable">
                                                                                            <%= rupiah.format(averageExpense)
                                                                                                %>
                                                                                        </div>
                                                                                        <small
                                                                                            class="text-muted">Average
                                                                                            amount per expense
                                                                                            transaction this
                                                                                            month.</small>

                                                                                        <div class="mt-3 pt-3"
                                                                                            style="border-top:1px solid #f3f4f6;">
                                                                                            <div
                                                                                                class="d-flex justify-content-between align-items-center mb-1">
                                                                                                <small
                                                                                                    class="text-muted">vs
                                                                                                    Total Income</small>
                                                                                                <small
                                                                                                    class="fw-semibold maskable">
                                                                                                    <%= totalIncome> 0 ?
                                                                                                        String.format("%.1f",
                                                                                                        (totalExpense /
                                                                                                        totalIncome) *
                                                                                                        100) : "0.0" %>%
                                                                                                </small>
                                                                                            </div>
                                                                                            <div class="progress"
                                                                                                style="height:6px;border-radius:999px;background:#f3f4f6;">
                                                                                                <div class="progress-bar"
                                                                                                    role="progressbar"
                                                                                                    style="width:<%= totalIncome > 0 ? Math.min((totalExpense / totalIncome) * 100, 100) : 0 %>%;background:#2563eb;border-radius:999px;">
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>

                                                                                <!-- CATEGORY PERCENTAGE -->
                                                                                <div class="col-12 col-md-4">
                                                                                    <div
                                                                                        class="card fintrack-card p-4 h-100">
                                                                                        <div
                                                                                            class="d-flex align-items-center gap-2 mb-3">
                                                                                            <div
                                                                                                style="width:32px;height:32px;border-radius:10px;background:#dcfce7;display:flex;align-items:center;justify-content:center;">
                                                                                                <i class="bi bi-pie-chart-fill"
                                                                                                    style="color:#16a34a;font-size:0.9rem;"></i>
                                                                                            </div>
                                                                                            <h6
                                                                                                class="fw-bold text-dark mb-0">
                                                                                                Category Breakdown</h6>
                                                                                        </div>

                                                                                        <% if (spendingOverview !=null
                                                                                            &&
                                                                                            !spendingOverview.isEmpty())
                                                                                            { String[]
                                                                                            barColors={"#e05c3a","#d9a441","#8aab99","#2563eb","#9EDE04"};
                                                                                            int maxCat=Math.min(4,
                                                                                            spendingOverview.size());
                                                                                            for (int i=0; i < maxCat;
                                                                                            i++) {
                                                                                            CategorySpendingSummary
                                                                                            category=spendingOverview.get(i);
                                                                                            String color=barColors[i %
                                                                                            barColors.length]; %>
                                                                                            <div class="mb-3">
                                                                                                <div
                                                                                                    class="d-flex justify-content-between align-items-center mb-1">
                                                                                                    <span
                                                                                                        style="font-size:0.82rem;font-weight:600;color:#333;">
                                                                                                        <%= category.getCategoryName()
                                                                                                            %>
                                                                                                    </span>
                                                                                                    <span
                                                                                                        style="font-size:0.78rem;color:#888;"
                                                                                                        class="maskable">
                                                                                                        <%= String.format("%.1f",
                                                                                                            category.getPercentage())
                                                                                                            %>%
                                                                                                    </span>
                                                                                                </div>
                                                                                                <div class="progress"
                                                                                                    style="height:7px;border-radius:999px;background:#f3f4f6;">
                                                                                                    <div class="progress-bar"
                                                                                                        role="progressbar"
                                                                                                        style="width:<%= category.getPercentage() %>%;background:<%= color %>;border-radius:999px;">
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                            <% } } else { %>
                                                                                                <div class="empty-data">
                                                                                                    No category data
                                                                                                    yet.</div>
                                                                                                <% } %>
                                                                                    </div>
                                                                                </div>

                                                                            </div>

                                                                        </div>

                                                                        <!-- ADD TRANSACTION MODAL (dari transaction.jsp) -->
                                                                        <div class="modal fade" id="addTransactionModal"
                                                                            tabindex="-1" aria-labelledby="addTrxLabel"
                                                                            aria-hidden="true">
                                                                            <div
                                                                                class="modal-dialog modal-dialog-centered modal-lg">
                                                                                <div
                                                                                    class="modal-content trx-modal-content">

                                                                                    <div
                                                                                        class="modal-header trx-modal-header">
                                                                                        <h5 class="modal-title"
                                                                                            id="addTransactionModalLabel">
                                                                                            <i
                                                                                                class="bi bi-plus-circle me-2"></i>Add
                                                                                            Transaction
                                                                                        </h5>
                                                                                        <button type="button"
                                                                                            class="btn-close"
                                                                                            data-bs-dismiss="modal"></button>
                                                                                    </div>

                                                                                    <form
                                                                                        action="<%= request.getContextPath() %>/AddTransactionServlet"
                                                                                        method="POST">
                                                                                        <input type="hidden"
                                                                                            name="redirectTo"
                                                                                            value="dashboard">

                                                                                        <div
                                                                                            class="modal-body trx-modal-body">

                                                                                            <!-- TYPE TOGGLE -->
                                                                                            <div
                                                                                                class="trx-type-toggle">
                                                                                                <input type="radio"
                                                                                                    name="transactionType"
                                                                                                    id="typeIncome"
                                                                                                    value="income"
                                                                                                    checked>
                                                                                                <label for="typeIncome"
                                                                                                    class="trx-toggle-label">
                                                                                                    <i
                                                                                                        class="bi bi-arrow-up-circle"></i>
                                                                                                    Income
                                                                                                </label>
                                                                                                <input type="radio"
                                                                                                    name="transactionType"
                                                                                                    id="typeExpense"
                                                                                                    value="expense">
                                                                                                <label for="typeExpense"
                                                                                                    class="trx-toggle-label">
                                                                                                    <i
                                                                                                        class="bi bi-arrow-down-circle"></i>
                                                                                                    Expense
                                                                                                </label>
                                                                                            </div>

                                                                                            <div class="row g-3">
                                                                                                <div
                                                                                                    class="col-12 col-md-6">
                                                                                                    <label
                                                                                                        class="trx-label">Transaction
                                                                                                        Name</label>
                                                                                                    <input type="text"
                                                                                                        class="trx-input"
                                                                                                        name="transactionName"
                                                                                                        placeholder="e.g. Salary, Lunch"
                                                                                                        required>
                                                                                                </div>

                                                                                                <div
                                                                                                    class="col-12 col-md-6">
                                                                                                    <label
                                                                                                        class="trx-label">Amount</label>
                                                                                                    <div
                                                                                                        class="trx-input-group">
                                                                                                        <span
                                                                                                            class="trx-input-prefix">Rp</span>
                                                                                                        <input
                                                                                                            type="number"
                                                                                                            class="trx-input trx-input-suffix"
                                                                                                            name="amount"
                                                                                                            placeholder="0"
                                                                                                            min="0"
                                                                                                            required>
                                                                                                    </div>
                                                                                                </div>

                                                                                                <div
                                                                                                    class="col-12 col-md-6">
                                                                                                    <label
                                                                                                        class="trx-label">Date</label>
                                                                                                    <input type="date"
                                                                                                        class="trx-input"
                                                                                                        name="transactionDate"
                                                                                                        required>
                                                                                                </div>

                                                                                                <div
                                                                                                    class="col-12 col-md-6">
                                                                                                    <label
                                                                                                        class="trx-label">Wallet
                                                                                                        /
                                                                                                        Account</label>
                                                                                                    <select
                                                                                                        class="trx-input"
                                                                                                        name="accountId"
                                                                                                        required>
                                                                                                        <option value=""
                                                                                                            disabled
                                                                                                            selected>
                                                                                                            Select
                                                                                                            wallet...
                                                                                                        </option>
                                                                                                        <% if (wallets
                                                                                                            !=null) {
                                                                                                            for (Wallet
                                                                                                            w : wallets)
                                                                                                            { %>
                                                                                                            <option
                                                                                                                value="<%= w.getAccountId() %>">
                                                                                                                <%= w.getAccountName()
                                                                                                                    %>
                                                                                                            </option>
                                                                                                            <% } } %>
                                                                                                    </select>
                                                                                                </div>

                                                                                                <div
                                                                                                    class="col-12 col-md-6">
                                                                                                    <label
                                                                                                        class="trx-label">Category</label>
                                                                                                    <select class="trx-input" name="categoryId" required>
    <option value="" disabled selected>Select category...</option>
    <% 
        // Debugging: Cek apakah list null
        if (categories == null) {
            out.println("<option disabled>Error: List is null</option>");
        } else if (categories.isEmpty()) {
            out.println("<option disabled>No categories found</option>");
        } else {
            for (Category c : categories) { 
    %>
        <option value="<%= c.getCategoryID() %>"><%= c.getName() %></option>
    <% 
            }
        } 
    %>
</select>
                                                                                                </div>

                                                                                                <div
                                                                                                    class="col-12 col-md-6">
                                                                                                    <label
                                                                                                        class="trx-label">
                                                                                                        Note <span
                                                                                                            style="color:#aaa; font-weight:400;">(optional)</span>
                                                                                                    </label>
                                                                                                    <input type="text"
                                                                                                        class="trx-input"
                                                                                                        name="note"
                                                                                                        placeholder="Add a note...">
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>

                                                                                        <div
                                                                                            class="modal-footer trx-modal-footer">
                                                                                            <button type="button"
                                                                                                class="btn-trx-cancel"
                                                                                                data-bs-dismiss="modal">Cancel</button>
                                                                                            <button type="submit"
                                                                                                class="btn-trx-submit">
                                                                                                <i
                                                                                                    class="bi bi-check-lg me-1"></i>
                                                                                                Save Transaction
                                                                                            </button>
                                                                                        </div>
                                                                                    </form>

                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <script
                                                                            src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
                                                                        <script
                                                                            src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.1/chart.umd.min.js"></script>

                                                                        <!-- JSON DATA FROM SERVLET (tidak diubah) -->
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
                                                                            // ========================
                                                                            // PARSE JSON
                                                                            // ========================
                                                                            function parseJsonData(id) {
                                                                                const el = document.getElementById(id);
                                                                                if (!el) return [];
                                                                                const text = el.textContent.trim();
                                                                                if (!text || text === "null") return [];
                                                                                try { return JSON.parse(text); } catch (e) { return []; }
                                                                            }

                                                                            function normalizeMonthlyData(labels, income, expense) {
                                                                                if (!labels || labels.length === 0) {
                                                                                    labels = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
                                                                                }
                                                                                while (income.length < labels.length) income.push(0);
                                                                                while (expense.length < labels.length) expense.push(0);
                                                                                return { labels, income, expense };
                                                                            }

                                                                            // ========================
                                                                            // EYE TOGGLE
                                                                            // ========================
                                                                            const btnToggle = document.getElementById('btnToggleDash');
                                                                            const eyeIcon = document.getElementById('eyeIconDash');
                                                                            const maskables = document.querySelectorAll('.maskable');
                                                                            let hidden = false;
                                                                            const originals = Array.from(maskables).map(el => el.textContent.trim());

                                                                            btnToggle.addEventListener('click', function () {
                                                                                hidden = !hidden;
                                                                                maskables.forEach((el, i) => {
                                                                                    el.textContent = hidden ? '****' : originals[i];
                                                                                });
                                                                                eyeIcon.className = hidden ? 'bi bi-eye-slash-fill' : 'bi bi-eye-fill';
                                                                            });

                                                                            // ========================
                                                                            // CHARTS
                                                                            // ========================
                                                                            document.addEventListener("DOMContentLoaded", function () {

                                                                                // Tambahan 
                                                                                const today = new Date().toISOString().split('T')[0];
                                                                                const dateInput = document.querySelector('#addTransactionModal input[type="date"]');
                                                                                if (dateInput) dateInput.value = today;

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
                                                                                    if (info) info.innerText = "Chart.js could not be loaded.";
                                                                                    return;
                                                                                }

                                                                                // BAR + LINE CHART
                                                                                if (monthlyCanvas) {
                                                                                    const currentMonthIndex = new Date().getMonth();
                                                                                    const expenseBarColors = monthlyData.expense.map((v, i) =>
                                                                                        i === currentMonthIndex ? "#9ACD32" : "#D9D9D9"
                                                                                    );

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
                                                                                                    data: (function () {
                                                                                                        const currentVal = monthlyData.expense[new Date().getMonth()] || 0;
                                                                                                        return new Array(monthlyData.labels.length).fill(currentVal);
                                                                                                    })(),
                                                                                                    borderColor: "#B7D86A",
                                                                                                    backgroundColor: "#B7D86A",
                                                                                                    pointRadius: 0,
                                                                                                    borderDash: [4, 4],
                                                                                                    tension: 0,
                                                                                                    fill: false
                                                                                                }

                                                                                            ]
                                                                                        },
                                                                                        options: {
                                                                                            responsive: true,
                                                                                            maintainAspectRatio: false,
                                                                                            plugins: {
                                                                                                legend: { display: false },
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
                                                                                                x: { grid: { display: false }, ticks: { color: "#111827" } },
                                                                                                y: {
                                                                                                    beginAtZero: true,
                                                                                                    grid: { color: "#E5E7EB" },
                                                                                                    ticks: {
                                                                                                        callback: function (value) {
                                                                                                            if (value >= 1000000) return (value / 1000000) + " M";
                                                                                                            return value;
                                                                                                        }
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    });
                                                                                }

                                                                                // MINI DONUT / STACKED BAR CHART
                                                                                if (categoryCanvas) {
                                                                                    if (!categoryLabels || categoryLabels.length === 0) {
                                                                                        categoryLabels = ["No data"];
                                                                                        categoryAmounts = [1];
                                                                                    }
                                                                                    if (!categoryAmounts || categoryAmounts.length === 0) {
                                                                                        categoryAmounts = [1];
                                                                                    }

                                                                                    const categoryColors = ["#D98C5F", "#D9A441", "#A8BE84", "#88A97D", "#C8D5B9"];

                                                                                    const stackedDatasets = categoryAmounts.map(function (amount, index) {
                                                                                        return {
                                                                                            label: categoryLabels[index] || "Category",
                                                                                            data: [amount],
                                                                                            backgroundColor: categoryColors[index % categoryColors.length],
                                                                                            borderWidth: 0,
                                                                                            borderRadius: 3,
                                                                                            barThickness: 18
                                                                                        };
                                                                                    });

                                                                                    new Chart(categoryCanvas, {
                                                                                        type: "bar",
                                                                                        data: { labels: [""], datasets: stackedDatasets },
                                                                                        options: {
                                                                                            indexAxis: "y",
                                                                                            responsive: true,
                                                                                            maintainAspectRatio: false,
                                                                                            plugins: {
                                                                                                legend: { display: false },
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
                                                                                                x: { stacked: true, display: false },
                                                                                                y: { stacked: true, display: false }
                                                                                            }
                                                                                        }
                                                                                    });
                                                                                }
                                                                            });
                                                                        </script>

                                                                    </body>

                                                                    </html>