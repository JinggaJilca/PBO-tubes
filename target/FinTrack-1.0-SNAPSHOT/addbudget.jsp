<%@ page isELIgnored="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FinTrack - Add New Budget</title>

    <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/images/favicon.png">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Instrument+Sans:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/style.css?v=10">
</head>

<body class="add-budget-page">

    <jsp:include page="navbar.jsp" />
    
    <div class="trx-header mb-3">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h2>Add New Budget</h2>
                </div>
            </div>
        </div>
    </div>

    <main class="container form-wrapper">
        <div class="card budget-form-card">
            
            <form action="<%= request.getContextPath() %>/budget" method="post" id="addBudgetForm">
                
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="threshold" id="thresholdHidden">

                <h2 class="form-title mb-4">Budget Information</h2>

                <div class="form-group mb-4">
                    <label for="category" class="form-label">Budget Category</label>
                    <select class="form-control" id="category" name="categoryId" required>
                        <option value="" disabled selected>-- Select a Category --</option>
                        <c:forEach var="cat" items="${categoryList}">
                            <option value="${cat.categoryID}">${cat.name}</option>
                        </c:forEach>
                    </select>
                    <p class="helper-text mt-1">Select the expense category for this budget.</p>
                </div>

                <div class="form-group mb-4">
                    <label for="amount" class="form-label">Budget Amount</label>
                    <div class="input-group">
                        <span class="input-group-text">Rp</span>
                        <input type="text" class="form-control" id="amount" name="amount"
                            placeholder="Example: 5000000" inputmode="numeric" pattern="[0-9]+" required>
                    </div>
                    <p class="helper-text mt-1">Enter the maximum budget for this category.</p>
                </div>

                <div class="form-group mb-4">
                    <div class="threshold-heading d-flex justify-content-between align-items-center mb-2">
                        <label for="thresholdSlider" class="form-label mb-0">Warning Threshold</label>
                        <span class="threshold-value fw-bold" style="color: #083F36;" id="thresholdValue">Rp0</span>
                    </div>

                    <input type="range" class="threshold-slider w-100" id="thresholdSlider" min="0" max="0" step="1000" value="0" disabled>

                    <div class="threshold-limits d-flex justify-content-between small text-muted mt-1">
                        <span>Rp0</span>
                        <span id="thresholdMaximum">Rp0</span>
                    </div>
                    <p class="helper-text mt-2">The maximum warning threshold follows the budget amount.</p>
                </div>

                <div class="form-action d-flex justify-content-end gap-3 mt-4">
                    <a href="<%= request.getContextPath() %>/budget" class="btn btn-light rounded-pill px-4">Cancel</a>
                    <button type="submit" class="btn btn-success rounded-pill px-4" style="background-color: #083F36; border: none;">
                        <i class="bi bi-check-circle me-2"></i> Save Budget
                    </button>
                </div>
                
            </form>
        </div>
    </main>

    <script src="https://code.iconify.design/iconify-icon/1.0.7/iconify-icon.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const amountInput = document.getElementById("amount");
            const thresholdSlider = document.getElementById("thresholdSlider");
            const thresholdValue = document.getElementById("thresholdValue");
            const thresholdMaximum = document.getElementById("thresholdMaximum");
            const thresholdHidden = document.getElementById("thresholdHidden"); 

            function formatRupiah(value) {
                return new Intl.NumberFormat("id-ID", { style: "currency", currency: "IDR", maximumFractionDigits: 0 }).format(value);
            }

            function updateHiddenPercentage() {
                const amount = Number(amountInput.value.replace(/\D/g, "")) || 0;
                const sliderVal = Number(thresholdSlider.value) || 0;
                let percent = amount > 0 ? (sliderVal / amount) * 100 : 0;
                thresholdHidden.value = Math.round(percent);
            }

            function updateThresholdFromBudget() {
                const budgetAmount = Number(amountInput.value.replace(/\D/g, ""));
                if (budgetAmount > 0) {
                    thresholdSlider.disabled = false;
                    thresholdSlider.max = budgetAmount;
                    thresholdSlider.step = Math.max(1000, Math.round(budgetAmount / 100));

                    if (Number(thresholdSlider.value) > budgetAmount || Number(thresholdSlider.value) === 0) {
                        thresholdSlider.value = Math.round(budgetAmount * 0.8);
                    }

                    thresholdMaximum.textContent = formatRupiah(budgetAmount);
                    thresholdValue.textContent = formatRupiah(Number(thresholdSlider.value));
                } else {
                    thresholdSlider.disabled = true;
                    thresholdSlider.max = 0;
                    thresholdSlider.value = 0;
                    thresholdMaximum.textContent = formatRupiah(0);
                    thresholdValue.textContent = formatRupiah(0);
                }
                updateHiddenPercentage();
            }

            amountInput.addEventListener("input", function () {
                this.value = this.value.replace(/\D/g, "");
                updateThresholdFromBudget();
            });

            thresholdSlider.addEventListener("input", function () {
                thresholdValue.textContent = formatRupiah(Number(this.value));
                updateHiddenPercentage();
            });
        });
    </script>
</body>

</html>