<<<<<<< HEAD
<%@ page import="java.util.List" %>
<%@ page import="model.Category" %>
<% 
    // Menangkap pesan sukses atau error dari Session Servlet 
    String successMessage = (String) session.getAttribute("successMessage"); 
    String errorMessage = (String) session.getAttribute("errorMessage");
    
    // Wajib: Langsung hapus dari session agar toast tidak muncul berulang
    session.removeAttribute("successMessage"); 
    session.removeAttribute("errorMessage"); 
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
=======
<%--
    Document   : testMisawel
    Created on : 5 Jun 2026
    Author     : Lenovo
--%>

<%@ page isELIgnored="false" %>
<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
>>>>>>> origin/main

<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
<<<<<<< HEAD
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Budget - FinTrack</title>

    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Instrument+Sans:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>

<body>
    <jsp:include page="navbar.jsp" />
    
    <div class="modal fade" id="deleteModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content trx-modal-content">
                <form action="<%= request.getContextPath() %>/budget" method="POST">
                    <div class="modal-header trx-modal-header border-0 pb-0">
                        <h1 class="modal-title fs-5 fw-bold" id="deleteModalLabel">Delete Budget</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>

                    <div class="modal-body trx-modal-body pb-4">
                        <p class="text-dark mb-1">
                            Are you sure you want to delete the budget for <strong id="deleteCategoryNameDisplay" class="text-danger"></strong>?
                        </p>
                        <p class="text-danger small mb-4 fw-medium">
                            <i class="bi bi-exclamation-triangle-fill me-1"></i> Deleted data cannot be recovered.
                        </p>

                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="budgetId" id="deleteBudgetIdInput" value="">

                        <div class="d-flex justify-content-center gap-3 mt-4">
                            <button type="button" class="btn btn-light rounded-pill px-4 py-2" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-danger rounded-pill px-4 py-2">Yes, Delete</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="modal fade" id="editModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content trx-modal-content">
                <form action="<%= request.getContextPath() %>/budget" method="POST" id="editBudgetForm">
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" name="budgetId" id="editBudgetIdInput">
                    <input type="hidden" name="threshold" id="editThresholdHidden">

                    <div class="modal-header trx-modal-header">
                        <h1 class="modal-title fs-5 fw-bold" id="editModalLabel">Edit Budget</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>

                    <div class="modal-body trx-modal-body">
                        <div class="form-group mb-3">
                            <label class="form-label">Budget Category</label>
                            <input type="text" class="form-control bg-light" id="editCategoryNameDisplay" readonly>
                        </div>

                        <div class="form-group mb-3">
                            <label for="editAmountInput" class="form-label">Budget Amount</label>
                            <div class="input-group">
                                <span class="input-group-text">Rp</span>
                                <input type="text" class="form-control" id="editAmountInput" name="amount" inputmode="numeric" pattern="[0-9]+" required>
                            </div>
                            <p class="helper-text">Enter the maximum budget for this category.</p>
                        </div>

                        <div class="form-group mb-3">
                            <div class="threshold-heading d-flex justify-content-between align-items-center mb-2">
                                <label for="editThresholdSlider" class="form-label mb-0">Warning Threshold</label>
                                <span class="threshold-value fw-bold" style="color: #083F36;" id="editThresholdValue">Rp0</span>
                            </div>

                            <input type="range" class="threshold-slider w-100" id="editThresholdSlider" min="0" max="0" step="1000" value="0">

                            <div class="threshold-limits d-flex justify-content-between mt-1">
                                <span class="small text-muted">Rp0</span>
                                <span class="small text-muted" id="editThresholdMaximum">Rp0</span>
                            </div>
                            <p class="helper-text mt-2">The maximum warning threshold follows the budget amount.</p>
                        </div>
                    </div>

                    <div class="modal-footer trx-modal-footer">
                        <button type="button" class="btn btn-trx-cancel rounded-pill px-4" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-trx-submit rounded-pill px-4">
                            <i class="bi bi-check-circle me-2"></i> Save Changes
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="trx-header mb-3">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h2>Manage Your Budget</h2>
                </div>
            </div>

            <div class="mt-4">
                <div class="budget-container">
                    <div class="mb-3">
                        <h5 class="mb-1">Total Budget for this month</h5>
                        <h1 class="fw-bold">
                            Rp. <fmt:formatNumber value="${totalBudget}" type="number" minFractionDigits="2" />
                        </h1>
                    </div>

                    <div class="d-flex align-items-center mb-2">
                        <div class="progress flex-grow-1 me-3">
                            <div class="progress-bar ${percentage > 100 ? 'bg-danger' : 'budget-progress-bar'}"
                                role="progressbar"
                                style="width: ${percentage > 100 ? 100 : percentage}%"
                                aria-valuenow="${percentage}" aria-valuemin="0" aria-valuemax="100">
                            </div>
                        </div>
                        <h2 class="fw-bold" style="min-width: 45px; text-align: right;">${percentage}%</h2>
                    </div>

                    <div class="d-flex justify-content-between budget-stats mt-2">
                        <span>
                            Rp. <fmt:formatNumber value="${spentAmount}" type="number" minFractionDigits="2" /> Spend
                        </span>
                        <span>
                            Rp. <fmt:formatNumber value="${remainingAmount}" type="number" minFractionDigits="2" /> Remaining
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <main class="container budget-card-container mb-5">
        <div class="row g-4">

            <c:forEach var="item" items="${budgetCards}">
                <div class="col-12 col-md-6 col-lg-4">
                    <div class="card budget-card h-100 d-flex flex-column">

                        <div class="budget-card-top d-flex justify-content-between align-items-center">
                            <div class="budget-category">${item.categoryName}</div>

                            <div class="d-flex gap-1">
                                <button type="button" class="btn-set-budget"
                                    data-bs-toggle="modal" data-bs-target="#editModal"
                                    data-id="${item.budgetId}" data-name="${item.categoryName}"
                                    data-amount="${item.categoryBudget}" data-threshold="${item.threshold}">
                                    <i class="bi bi-pencil-fill"></i>
                                </button>

                                <button type="button" class="btn-set-budget"
                                    data-bs-toggle="modal" data-bs-target="#deleteModal"
                                    data-id="${item.budgetId}" data-name="${item.categoryName}">
                                    <i class="bi bi-trash-fill"></i>
                                </button>
                            </div>
                        </div>

                        <div class="budget-card-middle">
                            <h3 class="budget-amount">
                                Rp. <fmt:formatNumber value="${item.categoryBudget}" type="number" minFractionDigits="0" />
                            </h3>
                        </div>

                        <div class="budget-card-bottom">
                            <div class="remaining-text">
                                Rp. <fmt:formatNumber value="${item.remainingAmount}" type="number" minFractionDigits="0" /> Remaining
                            </div>

                            <div class="category-progress">
                                <c:choose>
                                    <c:when test="${item.percentage >= item.threshold}">
                                        <div class="category-progress-fill"
                                            style="width: ${item.percentage > 100 ? 100 : item.percentage}%; background-color: #FF0000;">
                                        </div>
                                        <span class="category-status text-white">WARNING!</span>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="category-progress-fill"
                                            style="width: ${item.percentage}%; background-color: #9EDE04;">
                                        </div>
                                        <span class="category-status text-dark">SAFE</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                    </div>
                </div>
            </c:forEach>

            <div class="col-12 col-md-6 col-lg-4">
                <button type="button"
                    class="add-budget-button d-flex flex-column align-items-center justify-content-center gap-2"
                    onclick="window.location.href='<%= request.getContextPath() %>/addbudget'">
                    <span class="add-budget-icon"><i class="bi bi-plus"></i></span>
                    <span>Add New Budget</span>
                </button>
            </div>

        </div>
    </main>

    <div class="toast-container position-fixed bottom-0 end-0 p-4" style="z-index: 1055;">
        <% if (successMessage != null) { %>
            <div id="liveToastSuccess" class="toast align-items-center text-bg-success border-0 shadow-lg" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="d-flex">
                    <div class="toast-body fw-medium">
                        <i class="bi bi-check-circle-fill me-2"></i> <%= successMessage %>
                    </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
            </div>
        <% } %>

        <% if (errorMessage != null) { %>
            <div id="liveToastError" class="toast align-items-center text-bg-danger border-0 shadow-lg" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="d-flex">
                    <div class="toast-body fw-medium">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i> <%= errorMessage %>
                    </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
            </div>
        <% } %>
    </div>

    <script src="https://code.iconify.design/iconify-icon/1.0.7/iconify-icon.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        document.addEventListener('DOMContentLoaded', function () {

            // --- 1. TOAST HANDLER ---
            var toastElSuccess = document.getElementById('liveToastSuccess');
            if (toastElSuccess) {
                var toastSuccess = new bootstrap.Toast(toastElSuccess, { delay: 3000 });
                toastSuccess.show();
            }

            var toastElError = document.getElementById('liveToastError');
            if (toastElError) {
                var toastError = new bootstrap.Toast(toastElError, { delay: 4000 });
                toastError.show();
            }

            // --- 2. FORMAT RUPIAH HELPER ---
            function formatRupiahModal(value) {
                return new Intl.NumberFormat("id-ID", {
                    style: "currency",
                    currency: "IDR",
                    maximumFractionDigits: 0
                }).format(value);
            }

            // --- 3. MODAL EDIT HANDLER ---
            const editModal = document.getElementById('editModal');
            const editAmountInput = document.getElementById('editAmountInput');
            const editThresholdSlider = document.getElementById('editThresholdSlider');
            const editThresholdValue = document.getElementById('editThresholdValue');
            const editThresholdMaximum = document.getElementById('editThresholdMaximum');
            const editThresholdHidden = document.getElementById('editThresholdHidden');

            if (editModal) {
                function updateEditHiddenPercentage() {
                    const amount = Number(editAmountInput.value.replace(/\D/g, "")) || 0;
                    const sliderVal = Number(editThresholdSlider.value) || 0;
                    let percent = amount > 0 ? (sliderVal / amount) * 100 : 0;
                    editThresholdHidden.value = Math.round(percent);
                }

                editModal.addEventListener('show.bs.modal', function (event) {
                    var button = event.relatedTarget;
                    var id = button.getAttribute('data-id');
                    var name = button.getAttribute('data-name');
                    var amount = Math.round(parseFloat(button.getAttribute('data-amount')));
                    var thresholdPercent = parseFloat(button.getAttribute('data-threshold'));

                    var thresholdRupiah = Math.round(amount * (thresholdPercent / 100));

                    document.getElementById('editBudgetIdInput').value = id;
                    document.getElementById('editCategoryNameDisplay').value = name;
                    editAmountInput.value = amount;

                    editThresholdSlider.max = amount;
                    editThresholdSlider.step = Math.max(1000, Math.round(amount / 100));
                    editThresholdSlider.value = thresholdRupiah;
                    editThresholdSlider.disabled = false;

                    editThresholdValue.textContent = formatRupiahModal(thresholdRupiah);
                    editThresholdMaximum.textContent = formatRupiahModal(amount);

                    updateEditHiddenPercentage();
                });

                editAmountInput.addEventListener("input", function () {
                    this.value = this.value.replace(/\D/g, "");
                    const currentAmount = Number(this.value) || 0;

                    if (currentAmount > 0) {
                        editThresholdSlider.disabled = false;
                        editThresholdSlider.max = currentAmount;
                        editThresholdSlider.step = Math.max(1000, Math.round(currentAmount / 100));

                        if (Number(editThresholdSlider.value) > currentAmount) {
                            editThresholdSlider.value = Math.round(currentAmount * 0.8);
                        }

                        editThresholdMaximum.textContent = formatRupiahModal(currentAmount);
                        editThresholdValue.textContent = formatRupiahModal(Number(editThresholdSlider.value));
                    } else {
                        editThresholdSlider.disabled = true;
                        editThresholdSlider.max = 0;
                        editThresholdSlider.value = 0;
                        editThresholdMaximum.textContent = formatRupiahModal(0);
                        editThresholdValue.textContent = formatRupiahModal(0);
                    }
                    updateEditHiddenPercentage();
                });

                editThresholdSlider.addEventListener("input", function () {
                    editThresholdValue.textContent = formatRupiahModal(Number(this.value));
                    updateEditHiddenPercentage();
                });
            }

            // --- 4. MODAL DELETE HANDLER ---
            const deleteModal = document.getElementById('deleteModal');
            if (deleteModal) {
                deleteModal.addEventListener('show.bs.modal', function (event) {
                    var button = event.relatedTarget;
                    var id = button.getAttribute('data-id');
                    var name = button.getAttribute('data-name');

                    if (id) {
                        deleteModal.querySelector('#deleteBudgetIdInput').value = id;
                        deleteModal.querySelector('#deleteCategoryNameDisplay').textContent = name;
                    } else {
                        console.error("ID Budget tidak ditemukan pada tombol!");
                    }
                });
            }
            
        });
    </script>
=======

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>FinTrack - Budget</title>

    <!-- Favicon -->
    <link rel="icon"
          type="image/png"
          href="<%= request.getContextPath() %>/images/favicon.png">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Instrument+Sans:wght@400;600;700&display=swap"
          rel="stylesheet">

    <!-- CSS utama -->
    <!-- Diletakkan setelah Bootstrap agar style.css dapat menimpa Bootstrap -->
    <link rel="stylesheet"
          type="text/css"
          href="<%= request.getContextPath() %>/css/style.css?v=2">

</head>

<body class="bg-light">

    <!-- Navbar -->
    <jsp:include page="navbar.jsp" />

    <!-- ======================================
         HEADER BUDGET
    ======================================= -->
    <div class="dashboard-header budget-page-header">

        <div class="container">

            <div class="budget-header-content d-flex justify-content-between align-items-end">

                <!-- Judul sebelah kiri -->
                <div>

                    <h1 class="budget-title">
                        Total Budget for this month
                    </h1>

                    <h2 class="budget-total">
                        Rp.20.000.000,00
                    </h2>

                </div>

                <!-- Tombol tanggal dan export -->
                <div class="budget-header-buttons d-flex align-items-center gap-2">

                    <!-- Tombol tanggal -->
                    <button type="button"
                            class="btn btn-date-dash">

                        <iconify-icon
                            icon="solar:calendar-bold-duotone"
                            width="20">
                        </iconify-icon>

                        <span>
                            June 2026
                        </span>

                        <iconify-icon
                            icon="solar:alt-arrow-down-bold"
                            width="16">
                        </iconify-icon>

                    </button>

                    <!-- Tombol export -->
                    <button type="button"
                            class="btn btn-date-dash">

                        <iconify-icon
                            icon="material-symbols:download"
                            width="20">
                        </iconify-icon>

                        <span>
                            Export Data
                        </span>

                    </button>

                </div>

            </div>

            <!-- Progress budget utama -->
            <div class="main-progress-wrapper">

                <div class="main-progress"
                     role="progressbar"
                     aria-label="Budget usage"
                     aria-valuenow="67"
                     aria-valuemin="0"
                     aria-valuemax="100">

                    <div class="main-progress-bar">
                        67%
                    </div>

                </div>

                <div class="main-progress-information">

                    <span>
                        Rp.13.890.000,99 Spend
                    </span>

                    <span>
                        Rp.6.110.000,01 Remaining
                    </span>

                </div>

            </div>

        </div>

    </div>

    <!-- ======================================
         DAFTAR CARD BUDGET
    ======================================= -->
    <main class="container budget-card-container">

        <div class="row g-4">

            <!-- Food and Drinks -->
            <div class="col-12 col-md-6 col-lg-4">

                <div class="card budget-card h-100 d-flex flex-column">

                    <!-- Bagian atas -->
                    <div class="budget-card-top">

                        <div class="budget-category">
                            Food and Drinks
                        </div>

                    </div>

                    <!-- Bagian tengah -->
                    <div class="budget-card-middle">

                        <h3 class="budget-amount">
                            Rp.6.250.500
                        </h3>

                    </div>

                    <!-- Bagian bawah -->
                    <div class="budget-card-bottom">

                        <div class="remaining-text">
                            Rp.249.500 Remaining
                        </div>

                        <div class="category-progress">

                            <div class="category-progress-fill"
                                 style="width: 91%; background-color: #FF0000;">
                            </div>

                            <span class="category-status text-white">
                                WARNING!
                            </span>

                        </div>

                    </div>

                </div>

            </div>

            <!-- Shopping -->
            <div class="col-12 col-md-6 col-lg-4">

                <div class="card budget-card h-100 d-flex flex-column">

                    <!-- Bagian atas -->
                    <div class="budget-card-top">

                        <div class="budget-category">
                            Shopping
                        </div>

                    </div>

                    <!-- Bagian tengah -->
                    <div class="budget-card-middle">

                        <h3 class="budget-amount">
                            Rp.4.028.100
                        </h3>

                    </div>

                    <!-- Bagian bawah -->
                    <div class="budget-card-bottom">

                        <div class="remaining-text">
                            Rp.1.971.900 Remaining
                        </div>

                        <div class="category-progress">

                            <div class="category-progress-fill"
                                 style="width: 67%; background-color: #9EDE04;">
                            </div>

                            <span class="category-status text-dark">
                                SAFE
                            </span>

                        </div>

                    </div>

                </div>

            </div>

            <!-- Transportation -->
            <div class="col-12 col-md-6 col-lg-4">

                <div class="card budget-card h-100 d-flex flex-column">

                    <!-- Bagian atas -->
                    <div class="budget-card-top">

                        <div class="budget-category">
                            Transportation
                        </div>

                    </div>

                    <!-- Bagian tengah -->
                    <div class="budget-card-middle">

                        <h3 class="budget-amount">
                            Rp.2.361.401
                        </h3>

                    </div>

                    <!-- Bagian bawah -->
                    <div class="budget-card-bottom">

                        <div class="remaining-text">
                            Rp.6.138.599 Remaining
                        </div>

                        <div class="category-progress">

                            <div class="category-progress-fill"
                                 style="width: 28%; background-color: #9EDE04;">
                            </div>

                            <span class="category-status text-dark">
                                SAFE
                            </span>

                        </div>

                    </div>

                </div>

            </div>

            <!-- Add New Budget -->
            <div class="col-12 col-md-6 col-lg-4">

                <button type="button"
                        class="add-budget-button d-flex flex-column align-items-center justify-content-center gap-2"
                        onclick="window.location.href='<%= request.getContextPath() %>/addbudget.jsp'">

                    <span class="add-budget-icon">
                        <i class="bi bi-plus"></i>
                    </span>

                    <span>
                        Add New Budget
                    </span>

                </button>

            </div>

        </div>

    </main>

    <!-- Iconify -->
    <script src="https://code.iconify.design/iconify-icon/1.0.7/iconify-icon.min.js"></script>

    <!-- Bootstrap JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

>>>>>>> origin/main
</body>

</html>