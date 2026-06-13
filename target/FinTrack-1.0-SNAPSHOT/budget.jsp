<%--
    Document   : testMisawel
    Created on : 5 Jun 2026
    Author     : Lenovo
--%>

<%@ page isELIgnored="false" %>
<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">

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

    <!-- Iconify -->
    <script src="https://code.iconify.design/iconify-icon/1.0.7/iconify-icon.min.js"></script>

    <!-- Bootstrap JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>