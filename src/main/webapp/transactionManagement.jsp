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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Instrument+Sans:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>

<body>

    <!-- NAVBAR -->
     <jsp:include page="navbar.jsp" />
    <!-- <nav class="navbar navbar-expand-lg navbar-custom py-3 text-white">
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
                        <a class="nav-link text-white px-3 d-flex align-items-center gap-2"
                            href="${pageContext.request.contextPath}/wallet">
                            <i class="bi bi-wallet2 fs-4"></i> Wallet
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white px-3 d-flex align-items-center gap-2 active-nav"
                            href="${pageContext.request.contextPath}/transaction">
                            <i class="bi bi-cash-coin fs-4"></i> Transaction
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white px-3 d-flex align-items-center gap-2"
                            href="${pageContext.request.contextPath}/budget">
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
    </nav> -->

    <!-- TRANSACTION HEADER -->
    <div class="trx-header">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <p class="mb-1 text-light-teal">Manage your finances,</p>
                    <h2 class="fw-bold mb-0">Transaction</h2>
                </div>
                <button class="btn-add-trx" data-bs-toggle="modal" data-bs-target="#addTransactionModal">
                    <i class="bi bi-plus-lg"></i> Add Transaction
                </button>
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
                        Rp.<fmt:formatNumber
                            value="${totalIncome != null ? totalIncome : 97453753.88}"
                            type="number" groupingUsed="true" maxFractionDigits="2" minFractionDigits="2"/>
                    </p>
                    <p class="trx-summary-sub">Last month : Rp. 0,00</p>
                </div>
            </div>

            <div class="col-12 col-md-4">
                <div class="trx-summary-card">
                    <div class="trx-summary-icon expense-icon-bg">
                        <i class="bi bi-arrow-down-circle-fill"></i>
                    </div>
                    <p class="trx-summary-label">Total Expense</p>
                    <p class="trx-summary-value">
                        Rp.<fmt:formatNumber
                            value="${totalExpense != null ? totalExpense : 13890000.99}"
                            type="number" groupingUsed="true" maxFractionDigits="2" minFractionDigits="2"/>
                    </p>
                    <p class="trx-summary-sub">Last month : Rp. 0,00</p>
                </div>
            </div>

            <div class="col-12 col-md-4">
                <div class="trx-summary-card">
                    <div class="trx-summary-icon balance-icon-bg">
                        <i class="bi bi-wallet2"></i>
                    </div>
                    <p class="trx-summary-label">Net This Month</p>
                    <p class="trx-summary-value">
                        Rp.<fmt:formatNumber
                            value="${netBalance != null ? netBalance : 83563752.89}"
                            type="number" groupingUsed="true" maxFractionDigits="2" minFractionDigits="2"/>
                    </p>
                    <p class="trx-summary-sub">Last month : Rp. 0,00</p>
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
                        <input type="text" class="trx-search-input" id="searchInput" placeholder="Search transactions...">
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
                                    <tr data-type="${trx.transactionType}"
                                        data-amount="${trx.amount}"
                                        data-date="${trx.transactionDate}">
                                        <td style="color:#6b7280; font-size:0.8rem;"><fmt:formatDate value="${trx.transactionDate}" pattern="dd MMM yyyy"/></td>
                                        <td class="fw-semibold">${trx.transactionName}</td>
                                        <td><span class="trx-badge-category">${trx.categoryName}</span></td>
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
                                                        + Rp.<fmt:formatNumber value="${trx.amount}"
                                                            type="number" groupingUsed="true"
                                                            maxFractionDigits="2" minFractionDigits="2"/>
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="trx-amount expense-amount">
                                                        - Rp.<fmt:formatNumber value="${trx.amount}"
                                                            type="number" groupingUsed="true"
                                                            maxFractionDigits="2" minFractionDigits="2"/>
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td style="color:#9ca3af; font-size:0.8rem;">${trx.note}</td>
                                        <td>
                                            <div class="d-flex gap-2">
                                                <button class="btn-trx-action btn-edit"
                                                    onclick="openEditModal(${trx.transactionId})" title="Edit">
                                                    <i class="bi bi-pencil-fill"></i>
                                                </button>
                                                <button class="btn-trx-action btn-delete"
                                                    onclick="confirmDelete(${trx.transactionId})" title="Delete">
                                                    <i class="bi bi-trash-fill"></i>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr data-type="income" data-amount="10250000" data-date="2026-06-14">
                                    <td style="color:#6b7280; font-size:0.8rem;">14 Jun 2026</td>
                                    <td class="fw-semibold">Monthly Salary</td>
                                    <td><span class="trx-badge-category">Salary</span></td>
                                    <td style="color:#6b7280;">BCA Savings</td>
                                    <td><span class="trx-type-badge type-income"><i class="bi bi-arrow-up"></i> Income</span></td>
                                    <td><span class="trx-amount income-amount">+ Rp.10.250.000,00</span></td>
                                    <td style="color:#9ca3af; font-size:0.8rem;">Bank transfer</td>
                                    <td>
                                        <div class="d-flex gap-2">
                                            <button class="btn-trx-action btn-edit" title="Edit"><i class="bi bi-pencil-fill"></i></button>
                                            <button class="btn-trx-action btn-delete" title="Delete"><i class="bi bi-trash-fill"></i></button>
                                        </div>
                                    </td>
                                </tr>
                                <tr data-type="expense" data-amount="350000" data-date="2026-06-13">
                                    <td style="color:#6b7280; font-size:0.8rem;">13 Jun 2026</td>
                                    <td class="fw-semibold">Lunch</td>
                                    <td><span class="trx-badge-category">Food & Drinks</span></td>
                                    <td style="color:#6b7280;">Gopay</td>
                                    <td><span class="trx-type-badge type-expense"><i class="bi bi-arrow-down"></i> Expense</span></td>
                                    <td><span class="trx-amount expense-amount">- Rp.350.000,00</span></td>
                                    <td style="color:#9ca3af; font-size:0.8rem;">Warung near office</td>
                                    <td>
                                        <div class="d-flex gap-2">
                                            <button class="btn-trx-action btn-edit" title="Edit"><i class="bi bi-pencil-fill"></i></button>
                                            <button class="btn-trx-action btn-delete" title="Delete"><i class="bi bi-trash-fill"></i></button>
                                        </div>
                                    </td>
                                </tr>
                                <tr data-type="expense" data-amount="750000" data-date="2026-06-12">
                                    <td style="color:#6b7280; font-size:0.8rem;">12 Jun 2026</td>
                                    <td class="fw-semibold">Flight Ticket</td>
                                    <td><span class="trx-badge-category">Transportation</span></td>
                                    <td style="color:#6b7280;">Mastercard</td>
                                    <td><span class="trx-type-badge type-expense"><i class="bi bi-arrow-down"></i> Expense</span></td>
                                    <td><span class="trx-amount expense-amount">- Rp.750.000,00</span></td>
                                    <td style="color:#9ca3af; font-size:0.8rem;">Jakarta - Surabaya</td>
                                    <td>
                                        <div class="d-flex gap-2">
                                            <button class="btn-trx-action btn-edit" title="Edit"><i class="bi bi-pencil-fill"></i></button>
                                            <button class="btn-trx-action btn-delete" title="Delete"><i class="bi bi-trash-fill"></i></button>
                                        </div>
                                    </td>
                                </tr>
                                <tr data-type="expense" data-amount="500000" data-date="2026-06-11">
                                    <td style="color:#6b7280; font-size:0.8rem;">11 Jun 2026</td>
                                    <td class="fw-semibold">Monthly Groceries</td>
                                    <td><span class="trx-badge-category">Shopping</span></td>
                                    <td style="color:#6b7280;">Mandiri Debit</td>
                                    <td><span class="trx-type-badge type-expense"><i class="bi bi-arrow-down"></i> Expense</span></td>
                                    <td><span class="trx-amount expense-amount">- Rp.500.000,00</span></td>
                                    <td style="color:#9ca3af; font-size:0.8rem;">Indomaret</td>
                                    <td>
                                        <div class="d-flex gap-2">
                                            <button class="btn-trx-action btn-edit" title="Edit"><i class="bi bi-pencil-fill"></i></button>
                                            <button class="btn-trx-action btn-delete" title="Delete"><i class="bi bi-trash-fill"></i></button>
                                        </div>
                                    </td>
                                </tr>
                                <tr data-type="income" data-amount="5000000" data-date="2026-06-10">
                                    <td style="color:#6b7280; font-size:0.8rem;">10 Jun 2026</td>
                                    <td class="fw-semibold">Freelance Project</td>
                                    <td><span class="trx-badge-category">Freelance</span></td>
                                    <td style="color:#6b7280;">Gopay</td>
                                    <td><span class="trx-type-badge type-income"><i class="bi bi-arrow-up"></i> Income</span></td>
                                    <td><span class="trx-amount income-amount">+ Rp.5.000.000,00</span></td>
                                    <td style="color:#9ca3af; font-size:0.8rem;">Website client</td>
                                    <td>
                                        <div class="d-flex gap-2">
                                            <button class="btn-trx-action btn-edit" title="Edit"><i class="bi bi-pencil-fill"></i></button>
                                            <button class="btn-trx-action btn-delete" title="Delete"><i class="bi bi-trash-fill"></i></button>
                                        </div>
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
    <div class="modal fade" id="addTransactionModal" tabindex="-1" aria-labelledby="addTrxLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content trx-modal-content">

                <div class="modal-header trx-modal-header">
                    <h5 class="modal-title" id="addTrxLabel">
                        <i class="bi bi-plus-circle me-2"></i>Add Transaction
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <form action="${pageContext.request.contextPath}/transaction/add" method="POST">
                    <div class="modal-body trx-modal-body">

                        <!-- TYPE TOGGLE -->
                        <div class="trx-type-toggle">
                            <input type="radio" name="transactionType" id="typeIncome" value="income" checked>
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
                                    <input type="number" class="trx-input trx-input-suffix"
                                        name="amount" placeholder="0" min="0" required>
                                </div>
                            </div>

                            <div class="col-12 col-md-6">
                                <label class="trx-label">Date</label>
                                <input type="date" class="trx-input" name="transactionDate" required>
                            </div>

                            <div class="col-12 col-md-6">
                                <label class="trx-label">Wallet / Account</label>
                                <select class="trx-input" name="walletId" required>
                                    <option value="" disabled selected>Select wallet...</option>
                                    <c:choose>
                                        <c:when test="${not empty wallets}">
                                            <c:forEach var="wallet" items="${wallets}">
                                                <option value="${wallet.walletId}">${wallet.walletName}</option>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="1">BCA Savings</option>
                                            <option value="2">Gopay</option>
                                            <option value="3">Mastercard</option>
                                            <option value="4">Mandiri Debit</option>
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
                                                <option value="${cat.categoryId}">${cat.categoryName}</option>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="1">Food & Drinks</option>
                                            <option value="2">Transportation</option>
                                            <option value="3">Shopping</option>
                                            <option value="4">Entertainment</option>
                                            <option value="5">Health</option>
                                            <option value="6">Salary</option>
                                            <option value="7">Freelance</option>
                                            <option value="8">Investment</option>
                                        </c:otherwise>
                                    </c:choose>
                                </select>
                            </div>

                            <div class="col-12 col-md-6">
                                <label class="trx-label">Note <span style="color:#aaa; font-weight:400;">(optional)</span></label>
                                <input type="text" class="trx-input" name="note" placeholder="Add a note...">
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


    <!-- EDIT TRANSACTION MODAL -->
    <div class="modal fade" id="editTransactionModal" tabindex="-1" aria-labelledby="editTrxLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content trx-modal-content">

                <div class="modal-header trx-modal-header">
                    <h5 class="modal-title" id="editTrxLabel">
                        <i class="bi bi-pencil-square me-2"></i>Edit Transaction
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <form action="${pageContext.request.contextPath}/transaction/edit" method="POST">
                    <input type="hidden" name="transactionId" id="editTrxId">
                    <div class="modal-body trx-modal-body">

                        <div class="trx-type-toggle">
                            <input type="radio" name="transactionType" id="editTypeIncome" value="income">
                            <label for="editTypeIncome" class="trx-toggle-label">
                                <i class="bi bi-arrow-up-circle"></i> Income
                            </label>
                            <input type="radio" name="transactionType" id="editTypeExpense" value="expense">
                            <label for="editTypeExpense" class="trx-toggle-label">
                                <i class="bi bi-arrow-down-circle"></i> Expense
                            </label>
                        </div>

                        <div class="row g-3">
                            <div class="col-12 col-md-6">
                                <label class="trx-label">Transaction Name</label>
                                <input type="text" class="trx-input" name="transactionName" id="editTrxName" required>
                            </div>
                            <div class="col-12 col-md-6">
                                <label class="trx-label">Amount</label>
                                <div class="trx-input-group">
                                    <span class="trx-input-prefix">Rp</span>
                                    <input type="number" class="trx-input trx-input-suffix"
                                        name="amount" id="editTrxAmount" min="0" required>
                                </div>
                            </div>
                            <div class="col-12 col-md-6">
                                <label class="trx-label">Date</label>
                                <input type="date" class="trx-input" name="transactionDate" id="editTrxDate" required>
                            </div>
                            <div class="col-12 col-md-6">
                                <label class="trx-label">Wallet / Account</label>
                                <select class="trx-input" name="walletId" id="editTrxWallet" required>
                                    <c:choose>
                                        <c:when test="${not empty wallets}">
                                            <c:forEach var="wallet" items="${wallets}">
                                                <option value="${wallet.walletId}">${wallet.walletName}</option>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="1">BCA Savings</option>
                                            <option value="2">Gopay</option>
                                            <option value="3">Mastercard</option>
                                            <option value="4">Mandiri Debit</option>
                                        </c:otherwise>
                                    </c:choose>
                                </select>
                            </div>
                            <div class="col-12 col-md-6">
                                <label class="trx-label">Category</label>
                                <select class="trx-input" name="categoryId" id="editTrxCategory" required>
                                    <c:choose>
                                        <c:when test="${not empty categories}">
                                            <c:forEach var="cat" items="${categories}">
                                                <option value="${cat.categoryId}">${cat.categoryName}</option>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="1">Food & Drinks</option>
                                            <option value="2">Transportation</option>
                                            <option value="3">Shopping</option>
                                            <option value="4">Entertainment</option>
                                            <option value="5">Health</option>
                                            <option value="6">Salary</option>
                                            <option value="7">Freelance</option>
                                            <option value="8">Investment</option>
                                        </c:otherwise>
                                    </c:choose>
                                </select>
                            </div>
                            <div class="col-12 col-md-6">
                                <label class="trx-label">Note</label>
                                <input type="text" class="trx-input" name="note" id="editTrxNote"
                                    placeholder="Add a note...">
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer trx-modal-footer">
                        <button type="button" class="btn-trx-cancel" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn-trx-submit">
                            <i class="bi bi-check-lg me-1"></i> Save Changes
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
                        <form id="deleteForm"
                            action="${pageContext.request.contextPath}/transaction/delete" method="POST">
                            <input type="hidden" name="transactionId" id="deleteTrxId">
                            <button type="submit" class="btn-trx-delete-confirm">Delete</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // Set today as default date
        document.addEventListener('DOMContentLoaded', function () {
            const today = new Date().toISOString().split('T')[0];
            const dateInput = document.querySelector('#addTransactionModal input[type="date"]');
            if (dateInput) dateInput.value = today;
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
        document.getElementById('searchInput').addEventListener('input', applyFilters);

        // Sort
        document.getElementById('sortSelect').addEventListener('change', applySort);

        function applyFilters() {
            const search = document.getElementById('searchInput').value.toLowerCase();
            const rows = document.querySelectorAll('#trxBody tr');
            let visibleCount = 0;

            rows.forEach(row => {
                const type = row.dataset.type;
                const text = row.textContent.toLowerCase();
                const matchType   = currentFilter === 'all' || type === currentFilter;
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

        // Edit modal
        function openEditModal(id) {
            document.getElementById('editTrxId').value = id;
            new bootstrap.Modal(document.getElementById('editTransactionModal')).show();
        }

        // Delete modal
        function confirmDelete(id) {
            document.getElementById('deleteTrxId').value = id;
            new bootstrap.Modal(document.getElementById('deleteModal')).show();
        }
    </script>

</body>
</html>
