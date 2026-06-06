
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

                            <link rel="icon" type="image/png"
                                href="${pageContext.request.contextPath}/images/favicon.png">
                            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                                rel="stylesheet">
                            <link rel="stylesheet"
                                href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
                            <link rel="stylesheet"
                                href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
                            <link
                                href="https://fonts.googleapis.com/css2?family=Instrument+Sans:wght@400;600;700&display=swap"
                                rel="stylesheet">
                            <link rel="stylesheet" type="text/css"
                                href="${pageContext.request.contextPath}/css/style.css">
                        </head>

                        <body>
                            <jsp:include page="navbar.jsp" />
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
                                                        aria-valuenow="${percentage}" aria-valuemin="0"
                                                        aria-valuemax="100">
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