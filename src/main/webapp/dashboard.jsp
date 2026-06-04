<%@ page isELIgnored="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="id">

    <head>
        <meta charset="UTF-8">
        <title>FinTrack - Dashboard</title>

        
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
        <link href="https://fonts.googleapis.com/css2?family=Instrument+Sans:wght@400;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    </head>

    <body>
        <jsp:include page="navbar.jsp" />

        <div class="dashboard-header">
            <div class="container">
                <div class="d-flex justify-content-between align-items-end">
                    <div>
                        <p class="mb-1 text-light-teal">Good Morning,</p>
                        <h2 class="fw-bold mb-0 fs-1">Kite ade gaye</h2>
                    </div>
                    <div class="d-flex align-items-center gap-2">
                        <button class="btn btn-date d-flex align-items-center gap-2">
                            <iconify-icon icon="solar:calendar-bold-duotone" width="20"></iconify-icon>
                            June 2026
                            <iconify-icon icon="solar:alt-arrow-down-bold" width="16"></iconify-icon>
                        </button>
                        <button class="btn btn-date d-flex align-items-center gap-2">
                            <iconify-icon icon="material-symbols:download" width="20"></iconify-icon>
                            Export Data
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <div class="container overlap-container mb-5">

            <div class="row g-4 mb-4">

                <div class="col-12 col-md-6 col-lg-3">
                    <div class="card fintrack-card summary-card p-3">
                        <div class="card-body">
                            <h6 class="fw-bold text-dark">Card 1: Total Saldo<br>(Total Balance)</h6>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-md-6 col-lg-3">
                    <div class="card fintrack-card summary-card p-3">
                        <div class="card-body">
                            <h6 class="fw-bold text-dark">Card 2: Pemasukan<br>Bulan Ini (Monthly Income)</h6>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-md-6 col-lg-3">
                    <div class="card fintrack-card summary-card p-3">
                        <div class="card-body">
                            <h6 class="fw-bold text-dark">Card 3: Pengeluaran<br>Bulan Ini (Monthly Expense)</h6>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-md-6 col-lg-3">
                    <div class="card fintrack-card summary-card p-3">
                        <div class="card-body">
                            <h6 class="fw-bold text-dark">Card 4: Sisa<br>Anggaran (Remaining Budget)</h6>
                        </div>
                    </div>
                </div>

            </div>
            <div class="row">
                <div class="col-6">
                    <div class="card fintrack-card activity-card p-4">
                        <h6 class="fw-bold text-dark mb-4">Recent Activity</h6>
                    </div>
                </div>
                <div class="col-6">
                    <div class="card fintrack-card activity-card p-4">
                        <h6 class="fw-bold text-dark mb-4">Statistic</h6>
                    </div>
                </div>
            </div>

        </div>
        <script src="https://code.iconify.design/iconify-icon/1.0.7/iconify-icon.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    </body>

    </html>