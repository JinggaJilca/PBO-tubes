<%@ page import="java.util.List" %>
    <%@ page import="model.Category" %>
        <% String successMessage=(String) session.getAttribute("successMessage"); String errorMessage=(String)
            session.getAttribute("errorMessage"); session.removeAttribute("successMessage");
            session.removeAttribute("errorMessage"); %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
                <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

                    <!DOCTYPE html>
                    <html lang="id">

                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>Budget - FinTrack</title>

                        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png">
                        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                            rel="stylesheet">
                        <link rel="stylesheet"
                            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
                        <link rel="stylesheet"
                            href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
                        <link
                            href="https://fonts.googleapis.com/css2?family=Instrument+Sans:wght@400;600;700&display=swap"
                            rel="stylesheet">
                        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
                    </head>

                    <body>
                        <jsp:include page="navbar.jsp" />
                        <!-- [START] MODAL DELETE -->
                        <div class="modal fade" id="deleteModal" data-bs-backdrop="static" data-bs-keyboard="false"
                            tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content trx-modal-content">
                                    <form action="category" method="POST">
                                        <div class="modal-header trx-modal-header">
                                            <h1 class="modal-title fs-5 fw-bold" id="deleteModalLabel">Delete Category
                                            </h1>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                aria-label="Close"></button>
                                        </div>

                                        <div class="modal-body trx-modal-body">
                                            <p class="mb-3">Are you sure delete this data? <br>Category details:</p>

                                            <div class="card border-0 mb-3 bg-light">
                                                <div class="card-body p-3 bg-white">
                                                    <table class="table table-sm table-borderless mb-0">
                                                        <tr>
                                                            <td class="text-muted fw-semibold" width="45%">Category Name
                                                            </td>
                                                            <td class="align-middle" width="5%">:</td>
                                                            <td id="detailName" class="fw-bold text-dark" width="50%">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="text-muted fw-semibold align-middle">Type</td>
                                                            <td class="align-middle">:</td>
                                                            <td id="detailType"></td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>

                                            <p class="text-danger small mb-0 fw-medium">
                                                <i class="bi bi-exclamation-triangle-fill me-1"></i> Deleted data cannot
                                                be recovered.
                                            </p>

                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id" id="kategoriIdInput" value="">
                                        </div>

                                        <div class="modal-footer trx-modal-footer">
                                            <button type="button" class="btn btn-trx-cancel rounded-pill"
                                                data-bs-dismiss="modal">Cancel</button>
                                            <button type="submit" class="btn btn-trx-delete-confirm rounded-pill">Yes,
                                                delete this</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <!-- [END] MODAL DELETE -->

                        <!-- [START] MODAL ADD CATEGORY -->
                        <div class="modal fade" id="addModal" data-bs-backdrop="static" data-bs-keyboard="false"
                            tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content trx-modal-content">
                                    <form action="category" method="POST">
                                        <div class="modal-header trx-modal-header">
                                            <h1 class="modal-title fs-5 fw-bold" id="addModalLabel">Add New Category
                                            </h1>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                aria-label="Close"></button>
                                        </div>

                                        <div class="modal-body trx-modal-body">
                                            <input type="hidden" name="action" value="add">

                                            <div class="mb-4">
                                                <label class="trx-label" for="categoryNameInput">Category Name <span
                                                        class="text-danger">*</span></label>
                                                <input type="text" class="trx-input" id="categoryNameInput" name="name"
                                                    placeholder="Example: Fee, Food, Groceries..." required>
                                            </div>

                                            <div class="mb-2">
                                                <label class="trx-label">Type Category <span
                                                        class="text-danger">*</span></label>
                                                <div class="trx-type-toggle">
                                                    <input type="radio" id="typeIncome" name="type" value="Income"
                                                        required>
                                                    <label class="trx-toggle-label" for="typeIncome">
                                                        <i class="bi bi-arrow-up-circle"></i> Income
                                                    </label>

                                                    <input type="radio" id="typeExpense" name="type" value="Expense"
                                                        required>
                                                    <label class="trx-toggle-label" for="typeExpense">
                                                        <i class="bi bi-arrow-down-circle"></i> Expense
                                                    </label>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="modal-footer trx-modal-footer">
                                            <button type="button" class="btn btn-trx-cancel rounded-pill"
                                                data-bs-dismiss="modal">Cancel</button>
                                            <button type="submit" class="btn btn-trx-submit rounded-pill">Add
                                                Category</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <!-- [END] MODAL ADD CATEGORY -->

                        <!-- [START] MODAL EDIT CATEGORY -->
                        <div class="modal fade" id="editModal" data-bs-backdrop="static" data-bs-keyboard="false"
                            tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content trx-modal-content">
                                    <form action="category" method="POST">
                                        <input type="hidden" name="action" value="edit">
                                        <input type="hidden" name="id" id="editCategoryIdInput">

                                        <div class="modal-header trx-modal-header">
                                            <h1 class="modal-title fs-5 fw-bold" id="editModalLabel">Edit Category</h1>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                aria-label="Close"></button>
                                        </div>

                                        <div class="modal-body trx-modal-body">
                                            <div class="mb-4">
                                                <label class="trx-label">Category Name <span
                                                        class="text-danger">*</span></label>
                                                <input type="text" class="trx-input" id="editNameInput" name="name"
                                                    required>
                                            </div>
                                            <div class="mb-2">
                                                <label class="trx-label">Type Category <span
                                                        class="text-danger">*</span></label>
                                                <div class="trx-type-toggle">
                                                    <input type="radio" id="editTypeIncome" name="type" value="Income">
                                                    <label class="trx-toggle-label" for="editTypeIncome"><i
                                                            class="bi bi-arrow-up-circle"></i> Income</label>

                                                    <input type="radio" id="editTypeExpense" name="type"
                                                        value="Expense">
                                                    <label class="trx-toggle-label" for="editTypeExpense"><i
                                                            class="bi bi-arrow-down-circle"></i> Expense</label>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="modal-footer trx-modal-footer">
                                            <button type="button" class="btn btn-trx-cancel rounded-pill"
                                                data-bs-dismiss="modal">Cancel</button>
                                            <button type="submit" class="btn btn-trx-submit rounded-pill">Save
                                                Changes</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <!-- [END] MODAL EDIT CATEGORY -->
                        <!-- HEADER -->
                        <div class="trx-header mb-3">
                            <div class="container">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h2>Manage Your Budget</h2>
                                    </div>
               
                                </div>

                                <!-- ALL BUDGET PROGRESS -->
                                <div class="mt-4">
                                    <div class="budget-container">
                                        <div class="mb-3">
                                            <h5 class="mb-1">Total Budget for this month</h5>
                                            <h1 class="fw-bold">
                                                Rp.
                                                <fmt:formatNumber value="${totalBudget}" type="number"
                                                    minFractionDigits="2" />
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

                                            <h2 class="fw-bold" style="min-width: 45px; text-align: right;">
                                                ${percentage}%
                                            </h2>

                                        </div>
                                        <div class="d-flex justify-content-between budget-stats mt-2">
                                            <span>
                                                Rp.
                                                <fmt:formatNumber value="${spentAmount}" type="number"
                                                    minFractionDigits="2" /> Spend
                                            </span>
                                            <span>
                                                Rp.
                                                <fmt:formatNumber value="${remainingAmount}" type="number"
                                                    minFractionDigits="2" /> Remaining
                                            </span>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- ISI  -->
                        <main class="container budget-card-container">
                            <div class="row g-4">

                                <c:forEach var="item" items="${budgetCards}">
                                    <div class="col-12 col-md-6 col-lg-4">
                                        <div class="card budget-card h-100 d-flex flex-column">

                                            <div class="budget-card-top">
                                                <div class="budget-category">
                                                    ${item.categoryName}
                                                </div>
                                            </div>

                                            <div class="budget-card-middle">
                                                <h3 class="budget-amount">
                                                    Rp.
                                                    <fmt:formatNumber value="${item.categoryBudget}" type="number"
                                                        minFractionDigits="0" />
                                                </h3>
                                            </div>

                                            <div class="budget-card-bottom">
                                                <div class="remaining-text">
                                                    Rp.
                                                    <fmt:formatNumber value="${item.remainingAmount}" type="number"
                                                        minFractionDigits="0" /> Remaining
                                                </div>

                                                <div class="category-progress">
                                                    <c:choose>
                                                        <c:when test="${item.percentage >= item.threshold}">
                                                            <div class="category-progress-fill"
                                                                style="width: ${item.percentage > 100 ? 100 : item.percentage}%; background-color: #FF0000;">
                                                            </div>
                                                            <span class="category-status text-white">
                                                                WARNING!
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="category-progress-fill"
                                                                style="width: ${item.percentage}%; background-color: #9EDE04;">
                                                            </div>
                                                            <span class="category-status text-dark">
                                                                SAFE
                                                            </span>
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
                                        onclick="window.location.href='<%= request.getContextPath() %>/add-budget'">

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


                        <script src="https://code.iconify.design/iconify-icon/1.0.7/iconify-icon.min.js"></script>
                        <script
                            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>


                    </body>

                    </html>