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

                                            if (username == null) username = "User";

                                            if (monthlyLabelsJson == null) monthlyLabelsJson = "[]";
                                            if (monthlyIncomeJson == null) monthlyIncomeJson = "[]";
                                            if (monthlyExpenseJson == null) monthlyExpenseJson = "[]";
                                            if (categoryLabelsJson == null) categoryLabelsJson = "[]";
                                            if (categoryAmountJson == null) categoryAmountJson = "[]";

                                            Locale indonesia = new Locale("id", "ID");
                                            NumberFormat rupiah = NumberFormat.getCurrencyInstance(indonesia);
                                            rupiah.setMaximumFractionDigits(2);
                                            rupiah.setMinimumFractionDigits(2);

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
                                            <html>

                                            <head>
                                                <meta charset="UTF-8">
                                                <title>FinTrack - Dashboard</title>

                                                <link rel="icon" type="image/png"
                                                    href="<%= request.getContextPath() %>/images/favicon.png">

                                                <link
                                                    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                                                    rel="stylesheet">

                                                <link rel="stylesheet"
                                                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

                                                <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

                                                <style>
                                                    body {
                                                        background-color: #f5f7f6;
                                                        font-family: Arial, sans-serif;
                                                    }

                                                    .top-section {
                                                        background-color: #073f31;
                                                        color: white;
                                                        padding: 30px 40px 90px 40px;
                                                    }

                                                    .dashboard-content {
                                                        margin-top: -60px;
                                                        padding: 0 40px 40px 40px;
                                                    }

                                                    .card-box {
                                                        background: white;
                                                        border-radius: 16px;
                                                        padding: 24px;
                                                        box-shadow: 0 3px 8px rgba(0, 0, 0, 0.12);
                                                        height: 100%;
                                                    }

                                                    .card-title-small {
                                                        font-size: 16px;
                                                        font-weight: bold;
                                                        color: #222;
                                                    }

                                                    .money-value {
                                                        font-size: 24px;
                                                        font-weight: bold;
                                                        margin-top: 8px;
                                                        word-break: break-word;
                                                    }

                                                    .last-month {
                                                        font-size: 14px;
                                                        color: #777;
                                                        margin-top: 12px;
                                                        border-top: 1px solid #ddd;
                                                        padding-top: 12px;
                                                    }

                                                    .section-title {
                                                        font-size: 20px;
                                                        font-weight: bold;
                                                        margin-bottom: 16px;
                                                    }

                                                    .chart-container {
                                                        height: 320px;
                                                    }

                                                    .small-chart-container {
                                                        height: 180px;
                                                    }

                                                    table {
                                                        font-size: 14px;
                                                    }

                                                    thead {
                                                        background-color: #e5e5e5;
                                                    }

                                                    .empty-data {
                                                        text-align: center;
                                                        color: #777;
                                                        padding: 20px;
                                                    }

                                                    .btn-green {
                                                        background-color: #073f31;
                                                        color: white;
                                                    }

                                                    .btn-green:hover {
                                                        background-color: #0b5945;
                                                        color: white;
                                                    }

                                                    @media (max-width: 768px) {
                                                        .top-section {
                                                            padding: 24px 20px 80px 20px;
                                                        }

                                                        .dashboard-content {
                                                            padding: 0 20px 30px 20px;
                                                        }

                                                        .money-value {
                                                            font-size: 20px;
                                                        }
                                                    }
                                                </style>
                                            </head>

                                            <body>

                                                <div class="top-section">
                                                    <div
                                                        class="d-flex justify-content-between align-items-start flex-wrap gap-3">
                                                        <div>
                                                            <div style="font-size: 18px;">Good Morning,</div>
                                                            <h1 class="fw-bold mt-1">
                                                                <%= username %>
                                                            </h1>
                                                        </div>

                                                        <div class="d-flex gap-2 flex-wrap">

                                                            <a href="<%= request.getContextPath() %>/profile"
                                                                class="btn btn-outline-light rounded-pill">
                                                                <i class="bi bi-person-circle"></i>
                                                                Profile
                                                            </a>

                                                            <a href="<%= request.getContextPath() %>/DashboardExportServlet"
                                                                class="btn btn-light rounded-pill">
                                                                <i class="bi bi-download"></i>
                                                                Export
                                                            </a>

                                                            <a href="<%= request.getContextPath() %>/logout"
                                                                class="btn btn-outline-light rounded-pill">
                                                                <i class="bi bi-box-arrow-right"></i>
                                                                Logout
                                                            </a>

                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="dashboard-content">

                                                    <div class="row g-4 mb-4">

                                                        <div class="col-lg-3 col-md-6">
                                                            <div class="card-box">
                                                                <div class="card-title-small">Balance</div>
                                                                <div class="money-value">
                                                                    <%= rupiah.format(balance) %>
                                                                </div>
                                                                <div class="last-month">
                                                                    Last month: <%= rupiah.format(lastMonthBalance) %>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-lg-3 col-md-6">
                                                            <div class="card-box">
                                                                <div
                                                                    class="d-flex justify-content-between align-items-center">
                                                                    <div class="card-title-small">Earnings</div>
                                                                    <button class="btn btn-sm btn-green rounded-circle"
                                                                        data-bs-toggle="modal"
                                                                        data-bs-target="#addTransactionModal">
                                                                        <i class="bi bi-plus"></i>
                                                                    </button>
                                                                </div>
                                                                <div class="money-value">
                                                                    <%= rupiah.format(totalIncome) %>
                                                                </div>
                                                                <div class="last-month">
                                                                    Last month: <%= rupiah.format(lastMonthIncome) %>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-lg-3 col-md-6">
                                                            <div class="card-box">
                                                                <div
                                                                    class="d-flex justify-content-between align-items-center">
                                                                    <div class="card-title-small">Spending</div>
                                                                    <button class="btn btn-sm btn-green rounded-circle"
                                                                        data-bs-toggle="modal"
                                                                        data-bs-target="#addTransactionModal">
                                                                        <i class="bi bi-plus"></i>
                                                                    </button>
                                                                </div>
                                                                <div class="money-value">
                                                                    <%= rupiah.format(totalExpense) %>
                                                                </div>
                                                                <div class="last-month">
                                                                    Last month: <%= rupiah.format(lastMonthExpense) %>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-lg-3 col-md-6">
                                                            <div class="card-box">
                                                                <div class="card-title-small">Spending Overview</div>
                                                                <div class="money-value" style="font-size: 22px;">
                                                                    <%= rupiah.format(totalExpense) %>
                                                                </div>

                                                                <div class="small-chart-container mt-3">
                                                                    <canvas id="categoryChart"></canvas>
                                                                </div>
                                                            </div>
                                                        </div>

                                                    </div>

                                                    <div class="row g-4">

                                                        <div class="col-lg-8">
                                                            <div class="card-box">
                                                                <div
                                                                    class="d-flex justify-content-between align-items-start flex-wrap gap-2 mb-3">
                                                                    <div>
                                                                        <div class="section-title mb-1">Transactions
                                                                            Overview</div>
                                                                        <div class="money-value"
                                                                            style="font-size: 24px;">
                                                                            <%= rupiah.format(totalExpense) %>
                                                                        </div>
                                                                    </div>

                                                                    <a href="<%= request.getContextPath() %>/DashboardExportServlet"
                                                                        class="btn btn-outline-success rounded-pill">
                                                                        <i class="bi bi-download"></i>
                                                                        Export This Month
                                                                    </a>
                                                                </div>

                                                                <div class="chart-container">
                                                                    <canvas id="monthlyChart"></canvas>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-lg-4">
                                                            <div class="card-box">
                                                                <div
                                                                    class="d-flex justify-content-between align-items-center mb-3">
                                                                    <div class="section-title mb-0">Recent Activity
                                                                    </div>

                                                                    <button
                                                                        class="btn btn-outline-success btn-sm rounded-pill"
                                                                        data-bs-toggle="modal"
                                                                        data-bs-target="#addTransactionModal">
                                                                        <i class="bi bi-filter"></i>
                                                                        Sort
                                                                    </button>
                                                                </div>

                                                                <div class="table-responsive">
                                                                    <table
                                                                        class="table table-bordered table-hover align-middle">
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
                                                                                (RecentActivity activity :
                                                                                recentActivities) { %>
                                                                                <tr>
                                                                                    <td>
                                                                                        <%= activity.getCategoryName()
                                                                                            %>
                                                                                    </td>
                                                                                    <td>
                                                                                        <%= rupiah.format(activity.getAmount())
                                                                                            %>
                                                                                    </td>
                                                                                    <td>
                                                                                        <%= activity.getDate() %>
                                                                                    </td>
                                                                                    <td>
                                                                                        <%= activity.getTime() %>
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
                                                                                            Belum ada aktivitas
                                                                                            transaksi.
                                                                                        </td>
                                                                                    </tr>
                                                                                    <% } %>
                                                                        </tbody>
                                                                    </table>
                                                                </div>
                                                            </div>
                                                        </div>

                                                    </div>

                                                    <div class="row g-4 mt-1">

                                                        <div class="col-lg-12">
                                                            <div class="card-box">
                                                                <div class="section-title">Spending Detail by Category
                                                                </div>

                                                                <div class="table-responsive">
                                                                    <table
                                                                        class="table table-bordered table-hover align-middle">
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
                                                                                !spendingOverview.isEmpty()) { int no=1;
                                                                                for (CategorySpendingSummary category :
                                                                                spendingOverview) { %>
                                                                                <tr>
                                                                                    <td>
                                                                                        <%= no++ %>
                                                                                    </td>
                                                                                    <td>
                                                                                        <%= category.getCategoryName()
                                                                                            %>
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
                                                                                        <td colspan="4"
                                                                                            class="empty-data">
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
                                                <!-- Modal Add Transaction -->
                                                <div class="modal fade" id="addTransactionModal" tabindex="-1"
                                                    aria-labelledby="addTransactionModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <form
                                                            action="<%= request.getContextPath() %>/AddTransactionServlet"
                                                            method="post" class="modal-content">

                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="addTransactionModalLabel">
                                                                    Add Transaction</h5>
                                                                <button type="button" class="btn-close"
                                                                    data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>

                                                            <div class="modal-body">

                                                                <div class="mb-3">
                                                                    <label class="form-label">Account ID</label>
                                                                    <input type="number" name="accountId"
                                                                        class="form-control" required>
                                                                </div>

                                                                <div class="mb-3">
                                                                    <label class="form-label">Category ID</label>
                                                                    <input type="number" name="categoryId"
                                                                        class="form-control" required>
                                                                </div>

                                                                <div class="mb-3">
                                                                    <label class="form-label">Transaction Name</label>
                                                                    <input type="text" name="transactionName"
                                                                        class="form-control" required>
                                                                </div>

                                                                <div class="mb-3">
                                                                    <label class="form-label">Amount</label>
                                                                    <input type="number" step="0.01" name="amount"
                                                                        class="form-control" required>
                                                                </div>

                                                                <div class="mb-3">
                                                                    <label class="form-label">Transaction Type</label>
                                                                    <select name="transactionType" class="form-select"
                                                                        required>
                                                                        <option value="">-- Select Type --</option>
                                                                        <option value="income">Income</option>
                                                                        <option value="expense">Expense</option>
                                                                    </select>
                                                                </div>

                                                                <div class="mb-3">
                                                                    <label class="form-label">Note</label>
                                                                    <textarea name="note" class="form-control"
                                                                        rows="3"></textarea>
                                                                </div>

                                                            </div>

                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary"
                                                                    data-bs-dismiss="modal">Cancel</button>
                                                                <button type="submit" class="btn btn-success">Save
                                                                    Transaction</button>
                                                            </div>

                                                        </form>
                                                    </div>
                                                </div>
                                                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

                                                <script>
                                                    const monthlyLabels = <%= monthlyLabelsJson %>;
                                                    const monthlyIncome = <%= monthlyIncomeJson %>;
                                                    const monthlyExpense = <%= monthlyExpenseJson %>;

                                                    const categoryLabels = <%= categoryLabelsJson %>;
                                                    const categoryAmount = <%= categoryAmountJson %>;

                                                    const monthlyCanvas = document.getElementById('monthlyChart');

                                                    new Chart(monthlyCanvas, {
                                                        type: 'bar',
                                                        data: {
                                                            labels: monthlyLabels,
                                                            datasets: [
                                                                {
                                                                    label: 'Earnings',
                                                                    data: monthlyIncome,
                                                                    backgroundColor: '#198754',
                                                                    borderRadius: 6
                                                                },
                                                                {
                                                                    label: 'Spending',
                                                                    data: monthlyExpense,
                                                                    backgroundColor: '#dc3545',
                                                                    borderRadius: 6
                                                                }
                                                            ]
                                                        },
                                                        options: {
                                                            responsive: true,
                                                            maintainAspectRatio: false,
                                                            plugins: {
                                                                legend: {
                                                                    position: 'top'
                                                                },
                                                                tooltip: {
                                                                    callbacks: {
                                                                        label: function (context) {
                                                                            return context.dataset.label + ': Rp ' + Number(context.raw).toLocaleString('id-ID');
                                                                        }
                                                                    }
                                                                }
                                                            },
                                                            scales: {
                                                                y: {
                                                                    beginAtZero: true,
                                                                    ticks: {
                                                                        callback: function (value) {
                                                                            if (value >= 1000000) {
                                                                                return value / 1000000 + ' Jt';
                                                                            }
                                                                            return value;
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    });

                                                    const categoryCanvas = document.getElementById('categoryChart');

                                                    new Chart(categoryCanvas, {
                                                        type: 'doughnut',
                                                        data: {
                                                            labels: categoryLabels,
                                                            datasets: [
                                                                {
                                                                    label: 'Spending',
                                                                    data: categoryAmount,
                                                                    backgroundColor: [
                                                                        '#198754',
                                                                        '#0dcaf0',
                                                                        '#ffc107',
                                                                        '#dc3545',
                                                                        '#6f42c1',
                                                                        '#fd7e14',
                                                                        '#20c997'
                                                                    ]
                                                                }
                                                            ]
                                                        },
                                                        options: {
                                                            responsive: true,
                                                            maintainAspectRatio: false,
                                                            plugins: {
                                                                legend: {
                                                                    position: 'bottom'
                                                                },
                                                                tooltip: {
                                                                    callbacks: {
                                                                        label: function (context) {
                                                                            return context.label + ': Rp ' + Number(context.raw).toLocaleString('id-ID');
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    });
                                                </script>

                                            </body>

                                            </html>