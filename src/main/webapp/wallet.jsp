<%@ page isELIgnored="false" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <title>FinTrack - Wallet</title>

    <link rel="icon" type="image/png"
        href="${pageContext.request.contextPath}/images/favicon.png">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <link href="https://fonts.googleapis.com/css2?family=Instrument+Sans:wght@400;600;700&display=swap"
        rel="stylesheet">

    <link rel="stylesheet" type="text/css"
        href="${pageContext.request.contextPath}/css/style.css">
</head>

<body>

    <!-- NAVBAR -->
    <nav class="navbar navbar-expand-lg navbar-custom py-3 text-white">
        <div class="container">

            <a class="navbar-brand" href="${pageContext.request.contextPath}/dashboard">
                <img src="${pageContext.request.contextPath}/images/FLogo.png"
                    class="navbar-logo" alt="FinTrack Logo">
            </a>

            <button class="navbar-toggler text-white border-0" type="button"
                data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <i class="bi bi-list fs-1"></i>
            </button>

            <div class="collapse navbar-collapse justify-content-center" id="navbarNav">
                <ul class="navbar-nav gap-5 align-items-center">

                    <li class="nav-item">
                        <a class="nav-link active-nav text-white px-3 d-flex align-items-center gap-2"
                            href="wallet.jsp">
                            <i class="bi bi-wallet2"></i>
                            Wallet
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link text-white px-3 d-flex align-items-center gap-2"
                            href="transaction.jsp">
                            <i class="bi bi-cash-coin"></i>
                            Transaction
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link text-white px-3 d-flex align-items-center gap-2"
                            href="budget.jsp">
                            <i class="bi bi-piggy-bank"></i>
                            Budget
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
                        href="#" data-bs-toggle="dropdown">

                        <div class="profile-circle">
                            <i class="bi bi-person-fill fs-4"></i>
                        </div>

                        <span class="fw-semibold text-white">
                            Julio Tanlain
                        </span>
                    </a>
                </div>

            </div>

        </div>
    </nav>

    <!-- HEADER HIJAU -->
    <div class="dashboard-header">
        <div class="container">

            <div class="d-flex justify-content-between align-items-center">

                <div>
                    <h2 class="fw-bold mb-0 fs-1">
                        Wallet Overview
                    </h2>

                    <p class="text-light-teal mb-0">
                        Thursday, 16 April 2026
                    </p>
                </div>

                <div class="d-flex gap-3">

                    <button class="btn btn-eye-wallet">
                        <i class="bi bi-eye-fill"></i>
                    </button>

                    <button class="btn btn-refresh-wallet">
                        <i class="bi bi-arrow-clockwise"></i>
                        Refresh Data
                    </button>

                </div>

            </div>

        </div>
    </div>

    <!-- CONTENT -->
    <div class="container overlap-container mb-5">

        <div class="row g-4">

            <!-- PAYPAL -->
            <div class="col-lg-3 col-md-6">
                <div class="wallet-card">

                    <div class="wallet-card-top">
                        <i class="bi bi-wallet2"></i>

                        <div class="wallet-info">
                            <h6>Paypal Wallet</h6>
                            <h5>4532 1845 7821 6394</h5>
                        </div>
                    </div>

                    <div class="wallet-card-bottom">
                        Rp.2.975.290,99
                    </div>

                </div>
            </div>

            <!-- MASTERCARD -->
            <div class="col-lg-3 col-md-6">
                <div class="wallet-card">

                    <div class="wallet-card-top">
                        <i class="bi bi-credit-card"></i>

                        <div class="wallet-valid">
                            VALID THRU<br>01/26
                        </div>

                        <div class="wallet-info">
                            <h6>Mastercard Credit Card</h6>
                            <h5>4532 1845 7821 6394</h5>
                        </div>
                    </div>

                    <div class="wallet-card-bottom">
                        Rp.13.890.000,99
                    </div>

                </div>
            </div>

            <!-- MAESTRO -->
            <div class="col-lg-3 col-md-6">
                <div class="wallet-card">

                    <div class="wallet-card-top">
                        <i class="bi bi-credit-card"></i>

                        <div class="wallet-valid">
                            VALID THRU<br>10/35
                        </div>

                        <div class="wallet-info">
                            <h6>Maestro Debit Card</h6>
                            <h5>5348 7765 1289 4432</h5>
                        </div>
                    </div>

                    <div class="wallet-card-bottom">
                        Rp.133.997.877,19
                    </div>

                </div>
            </div>

            <!-- GOPAY -->
            <div class="col-lg-3 col-md-6">
                <div class="wallet-card">

                    <div class="wallet-card-top">
                        <i class="bi bi-wallet2"></i>

                        <div class="wallet-info">
                            <h6>Gopay Wallet</h6>
                            <h5>+62 812 3456 7890</h5>
                        </div>
                    </div>

                    <div class="wallet-card-bottom">
                        Rp.133.997.877,19
                    </div>

                </div>
            </div>

            <!-- MANDIRI -->
            <div class="col-lg-3 col-md-6">
                <div class="wallet-card">

                    <div class="wallet-card-top">
                        <i class="bi bi-credit-card"></i>

                        <div class="wallet-valid">
                            VALID THRU<br>09/29
                        </div>

                        <div class="wallet-info">
                            <h6>Mandiri Debit Card</h6>
                            <h5>+62 812 3456 7890</h5>
                        </div>
                    </div>

                    <div class="wallet-card-bottom">
                        Rp.2.533.117.867,19
                    </div>

                </div>
            </div>

            <!-- ADD WALLET -->
            <div class="col-lg-3 col-md-6">
                <div class="add-wallet-card">

                    <div class="add-wallet-icon">
                        <i class="bi bi-plus-lg"></i>
                    </div>

                    <h4>Add New Wallet</h4>

                </div>
            </div>

        </div>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>