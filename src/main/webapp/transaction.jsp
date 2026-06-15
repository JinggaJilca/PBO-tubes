<%@ page isELIgnored="false" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <title>FinTrack - Transaction</title>

                <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png">
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
                <link href="https://fonts.googleapis.com/css2?family=Instrument+Sans:wght@400;600;700&display=swap"
                    rel="stylesheet">
                <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
            </head>

            <body>

                <!-- NAVBAR -->
                <jsp:include page="navbar.jsp" />

                <!-- TRANSACTION HEADER -->
                <div class="trx-header">
                    <div class="container">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <p class="mb-1 text-light-teal">Manage your finances,</p>
                                <h2 class="fw-bold mb-0">Transaction</h2>
                            </div>
                            <div class="d-flex align-items-center gap-3">
                                <button class="btn-eye-trx" id="toggleBalance" onclick="toggleBalances()"
                                    title="Hide/Show amounts">
                                    <i class="bi bi-eye-fill" id="eyeIcon"></i>
                                </button>
                                <button class="btn-add-trx" data-bs-toggle="modal"
                                    data-bs-target="#addTransactionModal">
                                    <i class="bi bi-plus-lg"></i> Add Transaction
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- MAIN CONTENT -->
                <div class="container trx-overlap-container mb-5">

                    <!-- SUMMARY STRIP -->
                    <div class="row g-3 mb-4">

                        <div class="col-12 col-md-4">
                            <div class="trx-summary-card">
                                <div class="trx-summary-icon income-icon-bg">
                                    <i class="bi bi-arrow-up-circle-fill"></i>
                                </div>
                                <p class="trx-summary-label">Total Income</p>
                                <p class="trx-summary-value">
                                    Rp.
                                    <fmt:formatNumber value="${totalIncome != null ? totalIncome : 0}" type="number"
                                        groupingUsed="true" maxFractionDigits="2" minFractionDigits="2" />
                                </p>
                                <p class="trx-summary-sub">
                                    Last month : Rp.
                                    <fmt:formatNumber value="${lastMonthEarnings != null ? lastMonthEarnings : 0}"
                                        type="number" groupingUsed="true" maxFractionDigits="2" minFractionDigits="2" />
                                </p>
                            </div>
                        </div>

                        <div class="col-12 col-md-4">
                            <div class="trx-summary-card">
                                <div class="trx-summary-icon expense-icon-bg">
                                    <i class="bi bi-arrow-down-circle-fill"></i>
                                </div>
                                <p class="trx-summary-label">Total Expense</p>
                                <p class="trx-summary-value">
                                    Rp.
                                    <fmt:formatNumber value="${totalExpense != null ? totalExpense : 0}" type="number"
                                        groupingUsed="true" maxFractionDigits="2" minFractionDigits="2" />
                                </p>
                                <p class="trx-summary-sub">
                                    Last month : Rp.
                                    <fmt:formatNumber value="${lastMonthSpending != null ? lastMonthSpending : 0}"
                                        type="number" groupingUsed="true" maxFractionDigits="2" minFractionDigits="2" />
                                </p>
                            </div>
                        </div>

                        <div class="col-12 col-md-4">
                            <div class="trx-summary-card">
                                <div class="trx-summary-icon balance-icon-bg">
                                    <i class="bi bi-wallet2"></i>
                                </div>
                                <p class="trx-summary-label">Net This Month</p>
                                <p class="trx-summary-value">
                                    Rp.
                                    <fmt:formatNumber value="${netBalance != null ? netBalance : 0}" type="number"
                                        groupingUsed="true" maxFractionDigits="2" minFractionDigits="2" />
                                </p>
                                <p class="trx-summary-sub">
                                    Last month : Rp.
                                    <fmt:formatNumber value="${lastMonthBalance != null ? lastMonthBalance : 0}"
                                        type="number" groupingUsed="true" maxFractionDigits="2" minFractionDigits="2" />
                                </p>
                            </div>
                        </div>

                    </div>

                    <!-- HISTORY TABLE CARD -->
                    <div class="trx-table-card">

                        <!-- FILTER BAR -->
                        <div class="trx-filter-bar">
                            <span class="trx-filter-bar-title">Transaction History</span>

                            <div class="d-flex align-items-center gap-2 flex-wrap">
                                <div class="trx-search-wrap">
                                    <i class="bi bi-search trx-search-icon"></i>
                                    <input type="text" class="trx-search-input" id="searchInput"
                                        placeholder="Search transactions...">
                                </div>

                                <div class="trx-filter-tabs">
                                    <button class="trx-filter-tab active" data-filter="all">All</button>
                                    <button class="trx-filter-tab" data-filter="income">Income</button>
                                    <button class="trx-filter-tab" data-filter="expense">Expense</button>
                                </div>

                                <select class="trx-select" id="sortSelect">
                                    <option value="newest">Newest</option>
                                    <option value="oldest">Oldest</option>
                                    <option value="highest">Highest Amount</option>
                                    <option value="lowest">Lowest Amount</option>
                                </select>
                            </div>
                        </div>

                        <!-- TABLE -->
                        <div class="table-responsive px-2 pb-2">
                            <table class="trx-table" id="trxTable">
                                <thead>
                                    <tr>
                                        <th>Date</th>
                                        <th>Transaction Name</th>
                                        <th>Category</th>
                                        <th>Wallet</th>
                                        <th>Type</th>
                                        <th>Amount</th>
                                        <th>Note</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody id="trxBody">
                                    <c:choose>
                                        <c:when test="${not empty transactions}">
                                            <c:forEach var="trx" items="${transactions}">
                                                <tr data-type="${trx.transactionType}" data-amount="${trx.amount}"
                                                    data-date="${trx.transactionDate}">
                                                    <td style="color:#6b7280; font-size:0.8rem;">
                                                        <fmt:formatDate value="${trx.transactionDate}"
                                                            pattern="dd MMM yyyy" />
                                                    </td>

                                                    <td class="fw-semibold">${trx.transactionName}</td>

                                                    <td>
                                                        <span class="trx-badge-category">${trx.categoryName}</span>
                                                    </td>

                                                    <td style="color:#6b7280;">${trx.walletName}</td>

                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${trx.transactionType == 'income'}">
                                                                <span class="trx-type-badge type-income">
                                                                    <i class="bi bi-arrow-up"></i> Income
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="trx-type-badge type-expense">
                                                                    <i class="bi bi-arrow-down"></i> Expense
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>

                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${trx.transactionType == 'income'}">
                                                                <span class="trx-amount income-amount">
                                                                    + Rp.
                                                                    <fmt:formatNumber value="${trx.amount}"
                                                                        type="number" groupingUsed="true"
                                                                        maxFractionDigits="2" minFractionDigits="2" />
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="trx-amount expense-amount">
                                                                    - Rp.
                                                                    <fmt:formatNumber value="${trx.amount}"
                                                                        type="number" groupingUsed="true"
                                                                        maxFractionDigits="2" minFractionDigits="2" />
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>

                                                    <td style="color:#9ca3af; font-size:0.8rem;">${trx.note}</td>

                                                    <td>
                                                        <div class="d-flex gap-2">
                                                            <button class="btn-trx-action btn-delete"
                                                                onclick="confirmDelete(${trx.transactionId})"
                                                                title="Delete">
                                                                <i class="bi bi-trash-fill"></i>
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>

                                        <c:otherwise>
                                            <tr>
                                                <td colspan="8" class="text-center py-4" style="color:#9ca3af;">
                                                    No transactions yet
                                                </td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>

                        <!-- EMPTY STATE -->
                        <div class="trx-empty" id="emptyState" style="display:none;">
                            <i class="bi bi-inbox"></i>
                            <p>No transactions found</p>
                        </div>

                    </div>
                </div>


                <!-- ADD TRANSACTION MODAL -->
                <div class="modal fade" id="addTransactionModal" tabindex="-1" aria-labelledby="addTrxLabel"
                    aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered modal-lg">
                        <div class="modal-content trx-modal-content">

                            <div class="modal-header trx-modal-header">
                                <h5 class="modal-title" id="addTrxLabel">
                                    <i class="bi bi-plus-circle me-2"></i>Add Transaction
                                </h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>

                            <form action="${pageContext.request.contextPath}/AddTransactionServlet" method="POST">
                                <input type="hidden" name="redirectTo" value="transaction">

                                <div class="modal-body trx-modal-body">

                                    <!-- TYPE TOGGLE -->
                                    <div class="trx-type-toggle">
                                        <input type="radio" name="transactionType" id="typeIncome" value="income"
                                            checked>
                                        <label for="typeIncome" class="trx-toggle-label">
                                            <i class="bi bi-arrow-up-circle"></i> Income
                                        </label>

                                        <input type="radio" name="transactionType" id="typeExpense" value="expense">
                                        <label for="typeExpense" class="trx-toggle-label">
                                            <i class="bi bi-arrow-down-circle"></i> Expense
                                        </label>
                                    </div>

                                    <div class="row g-3">
                                        <div class="col-12 col-md-6">
                                            <label class="trx-label">Transaction Name</label>
                                            <input type="text" class="trx-input" name="transactionName"
                                                placeholder="e.g. Salary, Lunch" required>
                                        </div>

                                        <div class="col-12 col-md-6">
                                            <label class="trx-label">Amount</label>
                                            <div class="trx-input-group">
                                                <span class="trx-input-prefix">Rp</span>
                                                <input type="number" class="trx-input trx-input-suffix" name="amount"
                                                    placeholder="0" min="0" required>
                                            </div>
                                        </div>

                                        <div class="col-12 col-md-6">
                                            <label class="trx-label">Date</label>
                                            <input type="date" class="trx-input" name="transactionDate" required>
                                        </div>

                                        <div class="col-12 col-md-6">
                                            <label class="trx-label">Wallet / Account</label>
                                            <select class="trx-input" name="accountId" required>
                                                <option value="" disabled selected>Select wallet...</option>

                                                <c:choose>
                                                    <c:when test="${not empty wallets}">
                                                        <c:forEach var="wallet" items="${wallets}">
                                                            <option value="${wallet.accountId}">
                                                                ${wallet.accountName}
                                                            </option>
                                                        </c:forEach>
                                                    </c:when>

                                                    <c:otherwise>
                                                        <option value="" disabled>No wallet available</option>
                                                    </c:otherwise>
                                                </c:choose>
                                            </select>
                                        </div>

                                        <div class="col-12 col-md-6">
                                            <label class="trx-label">Category</label>
                                            <select class="trx-input" name="categoryId" required>
                                                <option value="" disabled selected>Select category...</option>

                                                <c:choose>
                                                    <c:when test="${not empty categories}">
                                                        <c:forEach var="cat" items="${categories}">
                                                            <option value="${cat.categoryID}">
                                                                ${cat.name}
                                                            </option>
                                                        </c:forEach>
                                                    </c:when>

                                                    <c:otherwise>
                                                        <option value="" disabled>No category available</option>
                                                    </c:otherwise>
                                                </c:choose>
                                            </select>
                                        </div>

                                        <div class="col-12 col-md-6">
                                            <label class="trx-label">
                                                Note <span style="color:#aaa; font-weight:400;">(optional)</span>
                                            </label>
                                            <input type="text" class="trx-input" name="note"
                                                placeholder="Add a note...">
                                        </div>
                                    </div>
                                </div>

                                <div class="modal-footer trx-modal-footer">
                                    <button type="button" class="btn-trx-cancel" data-bs-dismiss="modal">Cancel</button>
                                    <button type="submit" class="btn-trx-submit">
                                        <i class="bi bi-check-lg me-1"></i> Save Transaction
                                    </button>
                                </div>
                            </form>

                        </div>
                    </div>
                </div>


                <!-- DELETE CONFIRM MODAL -->
                <div class="modal fade" id="deleteModal" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered modal-sm">
                        <div class="modal-content" style="border-radius:20px; border:none;">
                            <div class="modal-body text-center p-4">
                                <div style="width:56px;height:56px;border-radius:50%;background:#fee2e2;
                                display:flex;align-items:center;justify-content:center;margin:0 auto 16px;">
                                    <i class="bi bi-trash3-fill text-danger fs-4"></i>
                                </div>
                                <h6 class="fw-bold mb-2">Delete Transaction?</h6>
                                <p style="font-size:0.85rem; color:#888; margin-bottom:20px;">
                                    This transaction will be permanently deleted and cannot be recovered.
                                </p>
                                <div class="d-flex gap-2 justify-content-center">
                                    <button class="btn-trx-cancel" data-bs-dismiss="modal">Cancel</button>
                                    <form id="deleteForm" action="${pageContext.request.contextPath}/transaction/delete"
                                        method="POST">
                                        <input type="hidden" name="transactionId" id="deleteTrxId">
                                        <button type="submit" class="btn-trx-delete-confirm">Delete</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- TOAST NOTIFICATION -->
                <div class="toast-container position-fixed bottom-0 end-0 p-3" style="z-index: 9999;">
                    <c:if test="${param.success == 'add'}">
                        <div id="transactionToast" class="toast align-items-center text-bg-success border-0"
                            role="alert">
                            <div class="d-flex">
                                <div class="toast-body">
                                    <i class="bi bi-check-circle-fill me-2"></i>
                                    Transaction added successfully.
                                </div>
                                <button type="button" class="btn-close btn-close-white me-2 m-auto"
                                    data-bs-dismiss="toast"></button>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${param.success == 'delete'}">
                        <div id="transactionToast" class="toast align-items-center text-bg-success border-0"
                            role="alert">
                            <div class="d-flex">
                                <div class="toast-body">
                                    <i class="bi bi-check-circle-fill me-2"></i>
                                    Transaction deleted successfully.
                                </div>
                                <button type="button" class="btn-close btn-close-white me-2 m-auto"
                                    data-bs-dismiss="toast"></button>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${param.error == 'add'}">
                        <div id="transactionToast" class="toast align-items-center text-bg-danger border-0"
                            role="alert">
                            <div class="d-flex">
                                <div class="toast-body">
                                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                                    Failed to add transaction.
                                </div>
                                <button type="button" class="btn-close btn-close-white me-2 m-auto"
                                    data-bs-dismiss="toast"></button>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${param.error == 'invalid'}">
                        <div id="transactionToast" class="toast align-items-center text-bg-warning border-0"
                            role="alert">
                            <div class="d-flex">
                                <div class="toast-body">
                                    <i class="bi bi-exclamation-circle-fill me-2"></i>
                                    Invalid transaction data.
                                </div>
                                <button type="button" class="btn-close me-2 m-auto" data-bs-dismiss="toast"></button>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${param.error == 'delete'}">
                        <div id="transactionToast" class="toast align-items-center text-bg-danger border-0"
                            role="alert">
                            <div class="d-flex">
                                <div class="toast-body">
                                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                                    Failed to delete transaction.
                                </div>
                                <button type="button" class="btn-close btn-close-white me-2 m-auto"
                                    data-bs-dismiss="toast"></button>
                            </div>
                        </div>
                    </c:if>

                </div>


                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

                <script>
                    // Set today as default date
                    document.addEventListener('DOMContentLoaded', function () {
                        const today = new Date().toISOString().split('T')[0];
                        const dateInput = document.querySelector('#addTransactionModal input[type="date"]');
                        if (dateInput) dateInput.value = today;
                        const toastElement = document.getElementById('transactionToast');

                        if (toastElement) {
                            const toast = new bootstrap.Toast(toastElement, {
                                delay: 3000
                            });
                            toast.show();
                            window.history.replaceState({}, document.title, window.location.pathname);
                        }
                    });

                    // Filter tabs
                    const filterTabs = document.querySelectorAll('.trx-filter-tab');
                    let currentFilter = 'all';

                    filterTabs.forEach(tab => {
                        tab.addEventListener('click', function () {
                            filterTabs.forEach(t => t.classList.remove('active'));
                            this.classList.add('active');
                            currentFilter = this.dataset.filter;
                            applyFilters();
                        });
                    });

                    // Search
                    const searchInput = document.getElementById('searchInput');
                    if (searchInput) {
                        searchInput.addEventListener('input', applyFilters);
                    }

                    // Sort
                    const sortSelect = document.getElementById('sortSelect');
                    if (sortSelect) {
                        sortSelect.addEventListener('change', applySort);
                    }

                    function applyFilters() {
                        const search = document.getElementById('searchInput').value.toLowerCase();
                        const rows = document.querySelectorAll('#trxBody tr');
                        let visibleCount = 0;

                        rows.forEach(row => {
                            const type = row.dataset.type;
                            const text = row.textContent.toLowerCase();
                            const matchType = currentFilter === 'all' || type === currentFilter;
                            const matchSearch = text.includes(search);

                            if (matchType && matchSearch) {
                                row.style.display = '';
                                visibleCount++;
                            } else {
                                row.style.display = 'none';
                            }
                        });

                        document.getElementById('emptyState').style.display =
                            visibleCount === 0 ? 'flex' : 'none';
                    }

                    function applySort() {
                        const val = document.getElementById('sortSelect').value;
                        const tbody = document.getElementById('trxBody');
                        const rows = Array.from(tbody.querySelectorAll('tr'));

                        rows.sort((a, b) => {
                            if (val === 'newest' || val === 'oldest') {
                                const da = new Date(a.dataset.date || 0);
                                const db = new Date(b.dataset.date || 0);
                                return val === 'newest' ? db - da : da - db;
                            } else {
                                const aa = parseFloat(a.dataset.amount || 0);
                                const ab = parseFloat(b.dataset.amount || 0);
                                return val === 'highest' ? ab - aa : aa - ab;
                            }
                        });

                        rows.forEach(r => tbody.appendChild(r));
                    }

                    // Delete modal
                    function confirmDelete(id) {
                        document.getElementById('deleteTrxId').value = id;
                        new bootstrap.Modal(document.getElementById('deleteModal')).show();
                    }

                    // Toggle balance visibility
                    let balanceVisible = true;

                    function toggleBalances() {
                        balanceVisible = !balanceVisible;
                        const icon = document.getElementById('eyeIcon');

                        if (icon) {
                            icon.className = balanceVisible ? 'bi bi-eye-fill' : 'bi bi-eye-slash-fill';
                        }

                        // Summary card values
                        document.querySelectorAll('.trx-summary-value').forEach(el => {
                            if (!balanceVisible) {
                                el.dataset.original = el.textContent;
                                el.textContent = '****';
                            } else {
                                if (el.dataset.original) el.textContent = el.dataset.original;
                            }
                        });

                        // Amount in table
                        document.querySelectorAll('.trx-amount').forEach(el => {
                            if (!balanceVisible) {
                                el.dataset.original = el.textContent;
                                el.textContent = '****';
                            } else {
                                if (el.dataset.original) el.textContent = el.dataset.original;
                            }
                        });
                    }
                </script>

            </body>

            </html>