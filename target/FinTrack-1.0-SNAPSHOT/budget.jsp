<%@ page import="java.util.List" %>
<%@ page import="model.Category" %>
<% 
    String successMessage = (String) session.getAttribute("successMessage"); 
    String errorMessage = (String) session.getAttribute("errorMessage");
    session.removeAttribute("successMessage"); 
    session.removeAttribute("errorMessage"); 
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Budget - FinTrack</title>

    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Instrument+Sans:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">

</head>

<body>
    <jsp:include page="navbar.jsp" />

    <!-- DELETE MODAL -->
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
                            Are you sure you want to delete the budget for
                            <strong id="deleteCategoryNameDisplay" class="text-danger"></strong>?
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

    <!-- EDIT MODAL -->
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
                                <input type="text" class="form-control" id="editAmountInput" name="amount"
                                    inputmode="numeric" pattern="[0-9]+" required>
                            </div>
                            <p class="helper-text">Enter the maximum budget for this category.</p>
                        </div>
                        <div class="form-group mb-3">
                            <div class="threshold-heading d-flex justify-content-between align-items-center mb-2">
                                <label for="editThresholdSlider" class="form-label mb-0">Warning Threshold</label>
                                <span class="threshold-value fw-bold" style="color:#083F36;" id="editThresholdValue">Rp0</span>
                            </div>
                            <input type="range" class="threshold-slider w-100" id="editThresholdSlider"
                                min="0" max="0" step="1000" value="0">
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

    <!-- HEADER -->
    <div class="budget-header mb-3">
        <div class="container">
            <p class="mb-1 text-light-teal">Manage your budget,</p>
            <h2 class="fw-bold mb-0">Budget</h2>
        </div>
    </div>

    <main class="container budget-card-container mb-5">

        <!-- SUMMARY KOTAK PANJANG -->
        <div class="budget-summary-box">
            <div class="bs-top">
                <span class="bs-label">Total Budget for this month</span>
                <span class="bs-amount">
                    Rp. <fmt:formatNumber value="${totalBudget}" type="number" minFractionDigits="2" />
                </span>
            </div>
            <div class="bs-prog-wrap">
                <div class="bs-prog">
                    <div class="bs-prog-fill"
                        style="width:${percentage > 100 ? 100 : percentage}%;
                               background:${percentage > 100 ? '#ef4444' : '#9EDE04'};">
                    </div>
                </div>
                <span class="bs-pct" style="color:${percentage > 100 ? '#dc2626' : '#111827'};">
                    ${percentage}%
                </span>
            </div>
            <div class="bs-stats">
                <span>
                    Rp. <fmt:formatNumber value="${spentAmount}" type="number" minFractionDigits="2" /> Spent
                </span>
                <span style="color:${remainingAmount < 0 ? '#dc2626' : '#9ca3af'};">
                    Rp. <fmt:formatNumber value="${remainingAmount}" type="number" minFractionDigits="2" /> Remaining
                </span>
            </div>
        </div>

        <!-- BUDGET PER CATEGORY -->
        <p class="section-hd">Budget per Category</p>
        <div class="row g-4">

            <c:forEach var="item" items="${budgetCards}">
                <div class="col-12 col-md-6 col-lg-4">
                    <div class="bic">
                        <div class="bic-accent"
                            style="background:${item.percentage >= item.threshold ? '#ef4444' : '#9EDE04'};"></div>
                        <div class="bic-main">
                            <div class="bic-head">
                                <span class="cat-name">${item.categoryName}</span>
                                <div class="d-flex gap-1">
                                    <button type="button" class="act-btn"
                                        data-bs-toggle="modal" data-bs-target="#editModal"
                                        data-id="${item.budgetId}" data-name="${item.categoryName}"
                                        data-amount="${item.categoryBudget}" data-threshold="${item.threshold}">
                                        <i class="bi bi-pencil-fill"></i>
                                    </button>
                                    <button type="button" class="act-btn"
                                        data-bs-toggle="modal" data-bs-target="#deleteModal"
                                        data-id="${item.budgetId}" data-name="${item.categoryName}">
                                        <i class="bi bi-trash-fill"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="bic-body">
                                <div>
                                    <p class="micro-lbl">Budget</p>
                                    <div class="b-amt">
                                        Rp <fmt:formatNumber value="${item.categoryBudget}" type="number" minFractionDigits="0" />
                                    </div>
                                </div>
                                <p class="rem-lbl">
                                    Rp <fmt:formatNumber value="${item.remainingAmount}" type="number" minFractionDigits="0" /> remaining
                                </p>
                                <div>
                                    <div class="b-prog">
                                        <div class="b-prog-fill ${item.percentage >= item.threshold ? 'fill-warn' : 'fill-safe'}"
                                            style="width:${item.percentage > 100 ? 100 : item.percentage}%;"></div>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center mt-2">
                                        <c:choose>
                                            <c:when test="${item.percentage >= item.threshold}">
                                                <span class="st-badge st-warn">
                                                    <i class="bi bi-exclamation-triangle-fill"></i> WARNING
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="st-badge st-safe">
                                                    <i class="bi bi-check-circle-fill"></i> SAFE
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                        <span class="pct-txt">${item.percentage}%</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <!-- ADD NEW BUDGET -->
            <div class="col-12 col-md-6 col-lg-4">
                <button type="button" class="add-bud-btn"
                    onclick="window.location.href='<%= request.getContextPath() %>/addbudget'">
                    <span class="add-bud-ico"><i class="bi bi-plus"></i></span>
                    <span>Add New Budget</span>
                </button>
            </div>

        </div>
    </main>

    <!-- TOAST -->
    <div class="toast-container position-fixed bottom-0 end-0 p-4" style="z-index:1055;">
        <% if (successMessage != null) { %>
        <div id="liveToastSuccess" class="toast align-items-center text-bg-success border-0 shadow-lg" role="alert">
            <div class="d-flex">
                <div class="toast-body fw-medium">
                    <i class="bi bi-check-circle-fill me-2"></i> <%= successMessage %>
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
            </div>
        </div>
        <% } %>
        <% if (errorMessage != null) { %>
        <div id="liveToastError" class="toast align-items-center text-bg-danger border-0 shadow-lg" role="alert">
            <div class="d-flex">
                <div class="toast-body fw-medium">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i> <%= errorMessage %>
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
            </div>
        </div>
        <% } %>
    </div>

    <script src="https://code.iconify.design/iconify-icon/1.0.7/iconify-icon.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        document.addEventListener('DOMContentLoaded', function () {

            var toastElSuccess = document.getElementById('liveToastSuccess');
            if (toastElSuccess) new bootstrap.Toast(toastElSuccess, { delay: 3000 }).show();

            var toastElError = document.getElementById('liveToastError');
            if (toastElError) new bootstrap.Toast(toastElError, { delay: 4000 }).show();

            function formatRupiahModal(value) {
                return new Intl.NumberFormat("id-ID", {
                    style: "currency", currency: "IDR", maximumFractionDigits: 0
                }).format(value);
            }

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
                    editThresholdHidden.value = amount > 0 ? Math.round((sliderVal / amount) * 100) : 0;
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
                        if (Number(editThresholdSlider.value) > currentAmount)
                            editThresholdSlider.value = Math.round(currentAmount * 0.8);
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

            const deleteModal = document.getElementById('deleteModal');
            if (deleteModal) {
                deleteModal.addEventListener('show.bs.modal', function (event) {
                    var button = event.relatedTarget;
                    deleteModal.querySelector('#deleteBudgetIdInput').value = button.getAttribute('data-id');
                    deleteModal.querySelector('#deleteCategoryNameDisplay').textContent = button.getAttribute('data-name');
                });
            }
        });
    </script>

</body>
</html>